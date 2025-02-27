---@meta _
---@class LibCustomGlow
LibCustomGlow = {}

--[[
触发发光函数声明
]]
---@class ProcGlowOptions
---@field key string | nil  唯一标识发光效果的字符串
---@field frameLevel number | nil 层级
---@field xOffset number | nil  X 轴上的偏移量
---@field yOffset number | nil  Y 轴上的偏移量

---@param r any
---@param options ProcGlowOptions
function LibCustomGlow.ProcGlow_Start(r, options) end

---@param r any
---@param key string | nil
function LibCustomGlow.ProcGlow_Stop(r, key) end


--[[
按钮发光函数声明
]]
---@param r any
---@param color RGBAColor | nil
---@param frequency number | nil 发光效果的频率，如果 frequency 大于 0，则使用 0.25/frequency*0.01 作为节流值；否则，使用默认值 0.01。
---@param frameLevel number | nil 层级
function LibCustomGlow.ButtonGlow_Start(r,color,frequency,frameLevel) end

---@param r any
function LibCustomGlow.ButtonGlow_Stop(r) end


--[[
像素发光函数声明
]]
---@param r any
---@param color RGBAColor | nil
---@param N number | nil 一个数字，表示发光效果中的像素数量。默认值为 8，若指定了负值或零则会被重置为 8。
---@param frequency number | any 一个数字，表示发光效果的频率，控制闪烁的速度。
---@param length number | any 表示每个像素的长度。如果未指定，则根据框架的宽度和高度计算得出。
---@param th number | any  表示发光效果的厚度，默认为 1。
---@param xOffset number | any X 方向上的偏移量
---@param yOffset number | any Y 方向上的偏移量
---@param border boolean | any 表示是否绘制边框,如果为 false，则不绘制边框，默认绘制边框。
---@param key string | any 发光效果的唯一标识符
---@param frameLevel number | any 层级
function LibCustomGlow.PixelGlow_Start(r,color,N,frequency,length,th,xOffset,yOffset,border,key,frameLevel) end

---@param r any
---@param key string | any 发光效果的唯一标识符
function LibCustomGlow.PixelGlow_Stop(r,key) end


--[[
自动施法闪烁函数声明
]]
---@param r any
---@param color RGBAColor | nil
---@param N number | nil 一个数字，表示发光效果中的纹理数量。默认值为 4。
---@param frequency number | any 光效果的频率，控制闪烁的速度。如果未指定，则默认周期为 8。
---@param scale number | any 发光效果的缩放比例，默认为 1。
---@param xOffset number | any X 方向上的偏移量
---@param yOffset number | any Y 方向上的偏移量
---@param key string | any 发光效果的唯一标识符
---@param frameLevel number | any 层级
function LibCustomGlow.AutoCastGlow_Start(r,color,N,frequency,scale,xOffset,yOffset,key,frameLevel) end


---@param r any
---@param key string | any 发光效果的唯一标识符
function LibCustomGlow.AutoCastGlow_Stop(r,key) end
