local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local load = _tl_compat and _tl_compat.load or load; local string = _tl_compat and _tl_compat.string or string

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





c = 0
local c2 = 0



function returnCouple()


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
   local code1 = load(src[1])
   local code2 = load(src[1])
end





local experimentObject = function()
end

print(string.dump(experimentObject))
