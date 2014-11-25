function is_sudo(msg)
     local var = false
     -- Check users id in config 
     for v,user in pairs(config.sudo_users) do 
        if user == msg.from.id then 
           var = true 
        end
     end
     if var==false then
      local receiver=get_receiver(msg)
      send_msg(receiver,"You are not sudo, this will be reported, and you will be banned, user: "..msg.from.id,ok_cb,false)
     end
     return var
end

function run_sh(msg)
     name = get_name(msg)
     text = ''
     if config.sh_enabled == false then 
        text = '!sh command is disabled'
     else
        if is_sudo(msg) then
           bash = msg.text:sub(4,-1)
           text = run_bash(bash)
        else
           text = name .. ' you have no power here!'
        end
     end
     return text
end

function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    cmd:close()
    return result
end

function on_getting_dialogs(cb_extra,success,result)
  if success then
    local dialogs={}
    for key,value in pairs(result) do 
      for chatkey, chat in pairs(value.peer) do
        print(chatkey,chat)
        if chatkey=="id" then
          table.insert(dialogs,chat.."\n")
        end
        if chatkey=="print_name" then
          table.insert(dialogs,chat..": ")
        end
      end 
    end

    send_msg(cb_extra[1],table.concat(dialogs),ok_cb,false)
  end
end

function run(msg, matches)
  local receiver = get_receiver(msg)
  if string.starts(msg.text, '!sh') then
    text = run_sh(msg)
    send_msg(receiver, text, ok_cb, false)
    return
  end

  if string.starts(msg.text, '!cpu') then
    text = run_bash('uname -snr') .. ' ' .. run_bash('whoami')
    text = text .. '\n' .. run_bash('top -b |head -2')
    send_msg(receiver, text, ok_cb, false)
    return
  end

  if matches[1]=="Get dialogs" then
    get_dialog_list(on_getting_dialogs,{get_receiver(msg)})
    return
  end
end

return {
    description = "shows cpuinfo", 
    usage = "!cpu",
    patterns = {"^!cpu", "^!sh","^Get dialogs$"}, 
    run = run 
}

