local _, ns = ...
local M, R, U, I = unpack(ns)
local oUF = ns.oUF
local UF = M:GetModule("UnitFrames")
local PA = M:GetModule("PrivateAuras")

function UF:CreatePrivateAuras(frame)
	frame.PrivateAuras = CreateFrame("Frame", frame:GetName().."PrivateAuras", frame)
	hooksecurefunc(frame, "UpdateAllElements", UF.UpdatePrivateAuras)
end

function UF.UpdatePrivateAuras(frame)
	if frame.PrivateAuras then
		PA:RemoveAuras(frame.PrivateAuras)

		local db = R.db["UFs"]
		if db then
			PA:SetupPrivateAuras(db, frame.PrivateAuras, frame.unit)
			frame.PrivateAuras:ClearAllPoints()
			frame.PrivateAuras:SetPoint("TOP", frame, "TOP", 0, 0)
			frame.PrivateAuras:SetSize(db.PrivateSize, db.PrivateSize)
		end
	end
end