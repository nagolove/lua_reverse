local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local load = _tl_compat and _tl_compat.load or load; local string = _tl_compat and _tl_compat.string or string

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
