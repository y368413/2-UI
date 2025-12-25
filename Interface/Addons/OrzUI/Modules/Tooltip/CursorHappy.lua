local _, ns = ...
local M, R, U, I = unpack(ns)

local MAX_SPEED = 1024;
local SPEED_DECAY = 2048;
local SIZE_MODIFIER = 12;
local MIN_SIZE = 16;
local x, y, speed = 0, 0, 0;
x, y = GetCursorPosition(); -- Initialize with current cursor position
speed = 0; -- Initialize speed to 0
local function isnan(value) return value ~= value end
local lastUpdate = 0
local colorTime, speed = 0, 0;
-- 呼吸灯效果参数
local BREATH_SPEED = 0.375       -- 呼吸周期速度
local BREATH_MIN_SCALE = 0.6 -- 最小缩放比例
local BREATH_MAX_SCALE = 1.2 -- 最大缩放比例
local STATIC_THRESHOLD = 1   -- 判定为静止的速度阈值
local breathTime = 0         -- 呼吸计时器

local CursorHappy = CreateFrame("Frame", nil, UIParent);
CursorHappy:SetFrameStrata("FULLSCREEN_DIALOG"); -- The strata as FULLSCREEN_DIALOG or DIALOG
CursorHappy.texture = CursorHappy:CreateTexture();
CursorHappy.texture:SetTexture([[Interface\Cooldown\star4]]);  
CursorHappy.texture:SetBlendMode("ADD");
CursorHappy.texture:Show(); -- Ensure the texture is not hidden by default
CursorHappy:SetScript("OnUpdate", function(_, elapsed)
  if not R.db["Tooltip"]["CursorHappy"] then return end
  lastUpdate = lastUpdate + elapsed
  if lastUpdate < 0.01 then return end -- Update every 0.01 seconds
  lastUpdate = 0

  if isnan(speed) then speed = 0; end
  if isnan(x) then x = 0; end
  if isnan(y) then y = 0; end

  local prevX, prevY = x, y;
  local cursorX, cursorY = GetCursorPosition();
  local scale = UIParent:GetEffectiveScale();
  x = cursorX / scale;
  y = cursorY / scale;
  local dX, dY = x - prevX, y - prevY;

  local distance = math.sqrt(dX * dX + dY * dY);
  local decayFactor = SPEED_DECAY ^ -elapsed;
  speed = math.min(decayFactor * speed + (1 - decayFactor) * distance / elapsed, MAX_SPEED);

  -- 初始化颜色循环变量
  local COLOR_SPEED = 0.3  -- 降低颜色变化速度
  
  -- 更平滑的HSL转RGB函数
  local function hslToRGB(h, s, l)
      h = h * 6
      local c = (1 - math.abs(2 * l - 1)) * s
      local x = c * (1 - math.abs(h % 2 - 1))
      local m = l - c / 2
      local r, g, b = 0, 0, 0
      
      if h < 1 then
          r, g, b = c, x, 0
      elseif h < 2 then
          r, g, b = x, c, 0
      elseif h < 3 then
          r, g, b = 0, c, x
      elseif h < 4 then
          r, g, b = 0, x, c
      elseif h < 5 then
          r, g, b = x, 0, c
      else
          r, g, b = c, 0, x
      end
      
      return r + m, g + m, b + m
  end
  
  -- 计算颜色循环（始终进行）
  colorTime = colorTime + elapsed * COLOR_SPEED
  local hue = (colorTime % 1)
  local r, g, b = hslToRGB(hue, 1, 0.6)
  local size = (speed / SIZE_MODIFIER) + MIN_SIZE
  -- 当速度低于阈值时应用呼吸效果
  if speed < STATIC_THRESHOLD then
      breathTime = breathTime + elapsed * BREATH_SPEED
      local breathScale = BREATH_MIN_SCALE + (BREATH_MAX_SCALE - BREATH_MIN_SCALE) * 
          (math.sin(breathTime * math.pi * 2) * 0.5 + 0.5)
      size = size * breathScale
  else
      breathTime = 0 -- 重置呼吸计时器
  end

  local alpha = math.min(1, size / 100)
  
  if size > 0 then
    CursorHappy.texture:SetHeight(size);
    CursorHappy.texture:SetWidth(size);
    CursorHappy.texture:SetVertexColor(r, g, b, alpha)
    CursorHappy.texture:SetPoint("CENTER", UIParent, "BOTTOMLEFT", x, y);
    CursorHappy.texture:Show();
  else
    CursorHappy.texture:Hide();
  end
end)