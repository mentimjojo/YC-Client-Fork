--[[
    Uninstall script for YC-Client-Fork
]]

local function question(message)
    local old_blink_state = term.getCursorBlink()
    term.setCursorBlink(true) -- Ensure the cursor is visible for input

    term.write(message .. " [y/n] ")
    -- Explicitly provide an empty string as the third argument to ensure input is not hidden.
    local input = read(nil, nil, "")

    term.setCursorBlink(old_blink_state) -- Restore the original cursor state
    print() -- Move to the next line for clean output

    -- Handle cases where the user terminates (Ctrl+T) during input
    if not input then
        return false
    end

    local answer = input:lower()
    return answer == "y" or answer == "yes"
end

if not question("Are you sure you want to uninstall YC-Client-Fork?") then
    print("Uninstall cancelled.")
    return
end

print("Uninstalling YC-Client-Fork...")

local files_to_delete = {
    "./yc-fork-client.lua",
    "./Yc-Fork-Client-Libs/serverapi.lua",
    "./Yc-Fork-Client-Libs/numberformatter.lua",
    "./Yc-Fork-Client-Libs/semver.lua",
    "./Yc-Fork-Client-Libs/argparse.lua",
    "./Yc-Fork-Client-Libs/string_pack.lua",
    "./Yc-Fork-Client-Libs/uninstall.lua",
}

local dirs_to_delete = {
    "./Yc-Fork-Client-Libs",
}

for _, file_path in ipairs(files_to_delete) do
    local resolved_path = shell.resolve(file_path)
    if fs.exists(resolved_path) then
        fs.delete(resolved_path)
        print("Deleted " .. resolved_path)
    end
end

for _, dir_path in ipairs(dirs_to_delete) do
    local resolved_path = shell.resolve(dir_path)
    if fs.exists(resolved_path) and #fs.list(resolved_path) == 0 then
        fs.delete(resolved_path)
        print("Deleted directory " .. resolved_path)
    end
end

print("YC-Client-Fork has been uninstalled.")
