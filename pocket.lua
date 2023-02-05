speaker = peripheral.find("speaker")
local connectionURL = "ws://localhost:8080"
local ws, err = http.websocket(connectionURL)
if not ws then
  return printError(err)
end


function split(str)
    local t = {}
    local t2 = {}
    for str in string.gmatch(str, "([^%s]+)") do
        table.insert(t, str)
    end

    for str in string.gmatch(t[2], "([^/]+)") do
        table.insert(t2, str)
    end
    return t2
end

while true do
  local _, url, response, isBinary = os.pullEvent("websocket_message")
    if response then
        local vars = split(response)
        speaker.playNote(vars[1], tonumber(vars[2]), tonumber(vars[3]:sub(1, -2)))
    end
end