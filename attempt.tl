#!/usr/bin/env lua5.1

local sources = {
    {
        [[
        local experimentObject = function()
        end
        ]],

        [[
        local experimentObject = function()
        local a = 0
        end
        ]],
    },
    {
        [[
        local experimentObject = function()
        end
        ]],

        [[
        local experimentObject = function()
        end
        ]],
    },
}

for _, src in ipairs(sources) do
    local code1 = load(src[1]) as function()
    local code2 = load(src[1]) as function()
end

--local ok, errstr = pcall(function()
    --code()
--end)

local experimentObject = function()
end

print(string.dump(experimentObject))
