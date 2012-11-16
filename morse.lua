local meta
meta = {
  __index = function(t,k) return setmetatable({t[1]..'.'..k}, meta) end,
  __concat = function(t1, t2) return setmetatable({t1[1]..'..'..t2[1]}, meta) end,
  __div = function(t1, t2) return setmetatable({t1[1]..'/'..t2[1]}, meta) end,
  __tostring = function(t) return t[1] end,
}
_ = setmetatable({'_'}, meta)
__ = setmetatable({'__'}, meta)

local subst = {['-.-']='+', ['-.--']='-', ['-..-']='>', ['--.-']='<', 
	['--..--']='.', ['--..-']=',', ['-.-.-']='[', ['--.-']=']', }
function ___(t) 
	local s = t[1]:gsub("_","-"):gsub("[%.%-]+", subst)
	print(s)
	require('brainfuck').run(s)
end
function tomorse(bf, code)
	local t = {}
	for k,v in pairs(subst) do t[v]=k.."/" end
	local morse = bf:gsub('.', t):sub(1,-2)
	if code then
		morse = '___('..morse:gsub('-','_')..')'
	end
	print(morse)
end
 