---@class ConditionConfig
---@field leftTriggerId  string | nil -- 左值触发器ID
---@field leftVal string | nil -- 左值对应的变量
---@field operator CondOperator | nil -- 条件运算符
---@field rightTriggerId string | nil -- 右值触发器
---@field rightValue string | number | boolean |nil -- 右值对应的变量或者值


---@class ConditionGroupConfig
---@field conditions ConditionConfig[]
---@field expression CondExpr
---@field effects EffectConfig[]
