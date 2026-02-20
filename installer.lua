--[[
_ _  _ ____ ___ ____ _    _    ____ ____
| |\ | [__   |  |__| |    |    |___ |__/
| | \| ___]  |  |  | |___ |___ |___ |  \

Github Repository: https://github.com/CC-YouCube
Homepage: https://youcube.madefor.cc/
License: GPL-3.0
]]
-- OpenInstaller v1.0.0 (based on wget)

local BASE_URL = "https://raw.githubusercontent.com/YC-Fork/YC-Client-Fork/main/src/"

local files = {
    ["./Yc-Fork-Client.lua"] = BASE_URL .. "Yc-Fork-Client.lua",
    ["./Yc-Fork-Client-Libs/youcubeapi.lua"] = BASE_URL .. "Yc-Fork-Client-Libs/youcubeapi.lua",
    ["./Yc-Fork-Client-Libs/numberformatter.lua"] = BASE_URL .. "Yc-Fork-Client-Libs/numberformatter.lua",
    ["./Yc-Fork-Client-Libs/semver.lua"] = BASE_URL .. "Yc-Fork-Client-Libs/semver.lua",
    ["./Yc-Fork-Client-Libs/argparse.lua"] = BASE_URL .. "Yc-Fork-Client-Libs/argparse.lua",
    ["./Yc-Fork-Client-Libs/string_pack.lua"] = BASE_URL .. "Yc-Fork-Client-Libs/string_pack.lua",
}

if not http then
    printError("OpenInstaller requires the http API")
    printError("Set http.enabled to true in the ComputerCraft config")
    return
end

local function tableContains(_table, element)
    for _, value in pairs(_table) do
        if value == element then
            return true
        end
    end
    return false
end

local function writeColoured(text, colour)
    term.setTextColour(colour)
    term.write(text)
end

local function question(message)
    local previous_colour = term.getTextColour()

    writeColoured(message .. "? [", colors.orange)
    writeColoured("Y", colors.lime)
    writeColoured("/", colors.orange)
    writeColoured("n", colors.red)
    writeColoured("] ", colors.orange)

    -- Reset colour
    term.setTextColour(previous_colour)

    local input_char = read():sub(1, 1):lower()
    local accept_chars = { "o", "k", "y", "j", "" }

    if tableContains(accept_chars, input_char) then
        return true
    end

    return false
end

local unknown_error = "Unknown error"

local function http_get(url)
    local valid_url, error_message = http.checkURL(url)
    if not valid_url then
        printError(('"%s" %s.'):format(url, error_message or "Invalid URL"))
        return
    end

    local response, http_error_message = http.get(url, nil, true)
    if not response then
        printError(('Failed to download "%s" (%s).'):format(url, http_error_message or unknown_error))
        return
    end

    local response_body = response.readAll()
    response.close()

    if not response_body then
        printError(('Failed to download "%s" (Empty response).'):format(url))
    end

    return response_body
end

for path, download_url in pairs(files) do
    local resolved_path = shell.resolve(path)
    if fs.exists(resolved_path) then
        if not question(('"%s" already exists. Override'):format(path)) then
            return
        end
    end

    local response_body = http_get(download_url)

    local file, file_open_error_message = fs.open(resolved_path, "wb")
    if not file then
        printError(('Failed to save "%s" (%s).'):format(path, file_open_error_message or unknown_error))
        return
    end

    file.write(response_body)
    file.close()

    term.setTextColour(colors.lime)
    print(('Downloaded "%s"'):format(path))
end

