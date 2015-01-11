local lgi = require ('lgi')
local notify = lgi.require('Notify')
notify.init ("Telegram updates")
local icon = os.getenv("HOME") .. "/.telegram-cli/t_icon.png"

function get_title (P, Q)
  if (Q.type == 'user') then
    return P.first_name .. " " .. P.last_name
  elseif (Q.type == 'chat') then
    return Q.title
  elseif (Q.type == 'encr_chat') then
    return 'Secret chat with ' .. P.first_name .. ' ' .. P.last_name
  else
    return ''
  end
end

function do_notify (user, msg)
  local n = notify.Notification.new(user, msg, icon)
  n:show ()
end

local function run(msg, matches)
  do_notify (get_title (msg.from, msg.to), msg.text)
end

return {
  description = "Desktop notification",
  usage = "Notifies on Desktop",
  patterns = {
    ".*"
    },
    run = run
  }
