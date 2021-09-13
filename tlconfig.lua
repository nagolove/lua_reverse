local file = io.popen("uname -a")
local is_windows = false
local is_linux = false
if file then
    if file:read("*a"):match("Linux.*") then
        is_linux = true
        is_window = false
    else
        is_linux = false
        is_windows = false
    end
else
    error("No file opened.")
end
print("is_linux", is_linux)
print("is_windows", is_windows)

function getAutomatoFiles()
    local files = {
        "asm.tl",           -- движок ассемблера для клеток
    }
    for k, v in pairs(files) do
        if is_windows then
            files[k] = "scenes\\automato\\" .. v
        else
            files[k] = "scenes/automato/" .. v
        end
    end
    return files
end

print("is_linux", is_linux)

local files = nil
if is_windows then
    files = getAutomatoFiles()
end

print("files", files)

return {
    --include_dir = {
        --"src",
    --},
    include = {
        "*.tl",
    },
    exclude = {
    }
}
