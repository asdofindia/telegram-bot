function run(msg, matches)
  if matches[1] == 'reload' then
    _config = load_config()
  end
  if matches[1] == 'allow' then
    table.insert(_config.allowed_chats, tonumber(matches[2]))
    save_config()
  end
end

return {
  description = "Config manager",
  usage = "!config reload",
  patterns = {
    "^!config (reload)$",
    "^!config (allow) (.*)$"
    },
    run = run,
    privileged = true
  }
