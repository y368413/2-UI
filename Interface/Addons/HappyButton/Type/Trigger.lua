---@alias TriggerType  -- 触发器类型
--- | "self"
--- | "aura"
--- | "item"

---@alias TriggerTarget  -- 触发器目标
--- | "player"
--- | "target"

---@alias AuraType -- 光环类型
--- | "buff"
--- | "defbuff"

---@alias CondOperator -- 触发器条件运算符
--- | "="
--- | "!="
--- | ">"
--- | ">="
--- | "<"
--- | "<="


---@alias CondExpr  --- 条件表达式
--- | "%cond.1"
--- | "%cond.1 and %cond.2"
--- | "%cond.1 or %cond.2"
--- | "%cond.1 and %cond.2 and %cond.3"
--- | "%cond.1 or %cond.2 or %cond.3"
--- | "(%cond.1 and %cond.2) or %cond.3"
--- | "(%cond.1 or %cond.2) and %cond.3"


---@alias EffectType
--- | "borderGlow"  -- 边框发光
--- | "btnHide"  -- 按钮隐藏
--- | "btnDesaturate"  -- 按钮褪色
--- | "btnVertexColor"  -- 按钮顶点上色
--- | "btnAlpha"  -- 按钮透明


----------------------------------------------
--- 自身物品触发器条件
----------------------------------------------
---@alias SelfTriggerCond
--- | "count"
--- | "isLearned"
--- | "isUsable"
--- | "isCooldown"

----------------------------------------------
--- 物品触发器条件
----------------------------------------------
---@alias ItemTriggerCond
--- | "count"
--- | "isLearned"
--- | "isUsable"
--- | "isCooldown"

----------------------------------------------
--- 光环触发器条件
----------------------------------------------
---@alias AuraTriggerCond
--- | "remainingTime"
--- | "targetIsEnemy"
--- | "targetCanAttack"
--- | "exist"