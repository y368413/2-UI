local a_name, a_env = ...

local function GetPreferDevel(addon_name)
   local val = tonumber(GetAddOnMetadata(addon_name, "X-Prefer-Devel"))
   return val and val > 0
end

local is_devel, _, a_basename = a_name:find('^(.+)-devel$')

a_env.basename = a_basename or a_name

if is_devel then
   a_env.is_devel = true
   if GetPreferDevel(a_name) then a_env.load_this = true end
else
   local a_devel = a_name .. '-devel'
   if not GetPreferDevel(a_devel) then
      a_env.load_this = true
   else
      LoadAddOn(a_devel)
   end
end
