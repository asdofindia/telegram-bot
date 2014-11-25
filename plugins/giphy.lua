function get_giphy()
   b = http.request("http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat")
   local gag = json:decode(b)
   return gag.data.image_url
end

function run(msg, matches)
    file = download_to_file(get_giphy(matches[1]))
    send_document(get_receiver(msg), file, ok_cb, false)
    return "preparing to make you laugh"
end

return {
    description = "Sends you a laughable gif", 
    usage = "Make me laugh",
    patterns = {
        "^[M|m]ake me laugh",
    }, 
    run = run 
}