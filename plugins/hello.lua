
function run(msg, matches)
  if matches[1] == "me" then
    return "Hello ".. msg.from.first_name .."!"
  else
    return "Hello " .. matches[1].."!"
  end
end

return {
    description = "Says hello to someone", 
    usage = "say hello to [name]",
    patterns = {"^[s|S]ay hello to (.*)$"}, 
    run = run 
}

