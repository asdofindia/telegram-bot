local f = io.open('./res/values.json', "r+")
if f == nil then
  f = io.open('./res/values.json', "w+")
  f:write("{}") -- Write empty table
  f:close()
  _values = {}
else
  local c = f:read "*a"
  f:close()
  _values = json:decode(c)
end


function get_value( value_name )
  local value = _values[string.lower(value_name)]
  if ( value == nil) then
    return "I don't know what "..value_name.." is. Can you tell me?"
  end
  return value_name.." is "..value
end

function run(msg, matches)
   return get_value(matches[1])
end

 return {
    description = "Tells you what X is", 
    usage = "What is X?",
    patterns = {"^[W|w]h?at is ([^%?]+)%??$"},
    run = run 
}
