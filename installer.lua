-- OpenInstaller v1.0.0 (based on wget) 

local BASE_URL = "https://raw.githubusercontent.com/JustSxm/CC-PocketMP3/master/"

local files = {
    ["./pocket.lua"] = BASE_URL .. "pocket.lua",
    ["./installer.lua"] = BASE_URL .. "installer.lua"
}

if not http then
    printError("OpenInstaller requires the http API")
    printError("Set http.enabled to true in the ComputerCraft config")
    return
end

local function get(sUrl)
    -- Check if the URL is valid
    local ok, err = http.checkURL(sUrl)
    if not ok then
        printError("\"" .. sUrl .. "\" ", err or "Invalid URL.")
        return
    end

    local response, http_err = http.get(sUrl, nil, true)
    if not response then
        printError("Failed to download \"" .. sUrl .. "\" (" .. http_err .. ")")
        return nil
    end

    local sResponse = response.readAll()
    response.close()
    return sResponse or ""
end

for path, dl_link in pairs(files) do
    local sPath = shell.resolve(path)

    local res = get(dl_link)
    if not res then return end

    local file, err = fs.open(sPath, "wb")
    if not file then
        printError("Failed to save \"" .. path .. "\" (" .. err .. ")")
        return
    end

    file.write(res)
    file.close()

    term.setTextColour(colors.lime)
    print("Downloaded \"" .. path .. "\"")
end