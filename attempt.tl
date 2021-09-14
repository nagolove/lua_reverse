#!/usr/bin/env lua5.1

local hx = require 'hex'
local data, err: string, boolean
data, err = hx.encode("edfwfef123")
print('encode data, err', data, err)
--data, err = hx.decode("3")

data, err = hx.decode("202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e5f606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e")
print('decode data, err', data, err)

data, err = hx.decode("12")
print('decode data, err', data, err)

data, err = hx.decode("ba")
print('decode data, err', data, err)

function fromhex(str: string): string
    return string.gsub(str, '..', function(cc: string): string
        return string.char(tonumber(cc, 16))
    end) as string
end

function tohex(str: string): string
    return string.gsub(str, '.', function (c: string): string
        return string.format('%02X', string.byte(c))
    end) as string
end

print('fromhex', fromhex("abdce"))
print('tohex', tohex("12525125"))

--local a: any
--local b: {any}
--local c: {any:any}

global c: integer = 0
local c2: integer = 0

--local type Func = function(string): number|string

function returnCouple(): (number, number)
    -- нет возврата из функцци, но нет предупреждения об ошибке
    --return "s"
    return 1, 1
end

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
