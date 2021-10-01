local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local load = _tl_compat and _tl_compat.load or load; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table

local inspect = require('inspect')
local ansicolors = require("ansicolors2")
print('ansicolors', inspect(ansicolors))
local hx = require('hex')
local data, err
data, err = hx.encode("edfwfef123")
print('encode data, err', data, err)


data, err = hx.decode("202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e5f606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e")
print('decode data, err', data, err)

data, err = hx.decode("12")
print('decode data, err', data, err)

data, err = hx.decode("ba")
print('decode data, err', data, err)

function fromhex(str)
   return string.gsub(str, '..', function(cc)
      return string.char(tonumber(cc, 16))
   end)
end

function tohex(str)
   return string.gsub(str, '.', function(c)
      return string.format('%02X', string.byte(c))
   end)
end

print('fromhex', fromhex("abdce"))
print('tohex', tohex("12525125"))




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
        return 1
        end
        ]],

      [[
        local experimentObject = function()
        end
        ]],
   },

}

local function tobin(x)
   local t = {}
   for i = 0, #x - 1 do
      local c = x:byte(i + 1)
      for j = 0, 7 do
         t[i * 8 + j + 1] = (c & 0x80) ~= 0 and "1" or "0"
         c = c << 1
      end
   end
   return table.concat(t)
end

local colorize = ansicolors.ansicolors


local function diff(a, b)
   local ahex, bhex = tohex(a), tohex(b)
   local longest, shortest
   if #a > #b then
      longest = a
      shortest = b
   else
      longest = b
      shortest = a
   end


   local i = 1
   local out = ""
   longest = tobin(longest)
   shortest = tobin(longest)

   for char1 in string.gmatch(shortest, '.') do
      local char2 = string.sub(longest, i, i + 1)




      if char1 == char2 then


      else




      end
      i = i + 1
   end

   return out
end

local function analyze(src)
   local code1 = load(src[1])
   local code2 = load(src[2])
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





local experimentObject = function()
end

print(string.dump(experimentObject))
