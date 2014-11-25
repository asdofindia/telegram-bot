function save_value( text )
    local startindex
    local endindex
    startindex,endindex=string.find(text, " is ")
    startindex=startindex-1
    endindex=endindex+1
    var_name=string.sub(text,1,startindex)
    var_value=string.sub(text,endindex)
    --var_name, var_value = string.match(text, "^(%a+) is (.+)$")
    if (var_name == nil or var_value == nil) then
        return nil -- "Usage: X is Y, sets X as Y"
    end
    var_name=string.lower(var_name)
    _values[var_name] = var_value

    local json_text = json:encode_pretty(_values) 
    file = io.open ("./res/values.json", "w+")
    file:write(json_text)
    file:close()
    
    return "I see. "..var_name.." is "..var_value
end

function run(msg, matches)
    if string.match(string.lower(matches[1]),"what") then
    else
        local text = save_value(msg.text)
        return text
    end
end

return {
    description = "Sets value of X as Y", 
    usage = "X is Y",
    patterns = {"(.+) is .+$" }, 
    run = run 
}


