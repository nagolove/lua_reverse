#!/usr/bin/env lua5.1

local inspect = require 'inspect'
local ansicolors = require "ansicolors2"
print('ansicolors', inspect(ansicolors))
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

--[[
Возможно лучшей идеей будет сделать программу интерактивного режима.
--]]
local sources = {
    -- {{{
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
        return 1
        end
        ]],

        [[
        local experimentObject = function()
        end
        ]],
    },
    -- }}}
}

local function tobin(x: string): string
	local t = {}
	for i=0, #x - 1 do
		local c = x:byte(i + 1)
		for j=0, 7 do
			t[i *8+j+1] = (c & 0x80) ~= 0 and "1" or "0"
			c = c << 1
		end
	end
	return table.concat(t)
end

local colorize = ansicolors.ansicolors

-- Возвращает строку с отчетом сравнив две строчки байткода
local function diff(a: string, b: string): string
    local ahex, bhex = tohex(a), tohex(b)
    local longest, shortest: string, string
    if #a > #b then
        longest = a
        shortest = b
    else
        longest = b
        shortest = a
    end
    --print('ahex, #ahex', #ahex, ahex)
    --print('bhex, #bhex', #bhex, bhex)
    local i = 1
    local out = ""
    longest = tobin(longest)
    shortest = tobin(longest)
    --out = colorize("%{red}" .. longest .. "\n%{white}" .. shortest .. "\n")
    for char1 in string.gmatch(shortest, '.') do
        local char2 = string.sub(longest, i, i + 1)
        --print('char1', #char1, '|', tohex(char1), '|')
        --print('char2', #char2, '|', tohex(char2), '|')
        --local b1, b2 = string.byte(char1, 1), string.byte(char2, 1)
        --local d: integer = math.ceil(math.abs(b2 - b1))
        if char1 == char2 then
            --print('1')
            --out = out .. colorize('%{white}' .. char1 .. '%{reset}')
        else
            --print('2')
            --print('should be' .. ansicolors.ansicolors('%{red}red%{reset}') .. ' default')
            --local s = tostring(d)
            --out = out .. colorize('%{red}' .. char1 .. '%{reset}' ) as string
        end
        i = i + 1
    end
    --]]
    return out
end

local function analyze(src: {string})
    local code1 = load(src[1]) as function()
    local code2 = load(src[2]) as function()
    local code1dump = string.dump(code1)
    local code2dump = string.dump(code2)
    print(colorize("%{green}source one:\n%{white}" .. src[1]))
    print(colorize("%{green}bytecode (hex):\n%{white}" .. tohex(src[1])))
    print(colorize("%{green}source two:\n%{white}" .. src[2]))
    print(colorize("%{green}bytecode (hex):\n%{white}" .. tohex(src[2])))
    print(colorize("%{green}diff:\n%{white}" .. diff(code1dump, code2dump)))
    print(colorize("%{magenta}" .. string.rep("-", 120)))
end

for _, src in ipairs(sources) do
    analyze(src)
end

--local ok, errstr = pcall(function()
    --code()
--end)

local experimentObject = function()
end

print(string.dump(experimentObject))
