--[[
    Uninstall script for YC-Client-Fork
]]

local function question(message)
    term.write(message .. " [y/n] ")
    return read():lower() == "y"
end

if not question("Are you sure you want to uninstall YC-Client-Fork?") then
    print("Uninstall cancelled.")
    return
end

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
