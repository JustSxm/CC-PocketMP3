speaker = peripheral.find("speaker")
local connectionURL = "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self"
local ws, err = http.websocket(connectionURL)
if not ws then
  return printError(err)
end


function split(str)
    local t = {}
    for str in string.gmatch(str, "([^/]+)") do
        table.insert(t, str)
    end
    return t
end

while true do
  local _, url, response, isBinary = os.pullEvent("websocket_message")
    if response then
        local vars = split(response)
        speaker.playNote(vars[1], tonumber(vars[2]), tonumber(vars[3]))
    end
end