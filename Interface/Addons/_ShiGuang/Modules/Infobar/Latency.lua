﻿local _, ns = ...
local M, R, U, I = unpack(ns)
if not R.Infobar.Latency then return end

local module = M:GetModule("Infobar")
local info = module:RegisterInfobar("Ping", R.Infobar.LatencyPos)

local max, format = max, format
local GetNetStats, GetNetIpTypes, GetCVarBool = GetNetStats, GetNetIpTypes, GetCVarBool
local GetAvailableBandwidth, GetDownloadedPercentage = GetAvailableBandwidth, GetDownloadedPercentage
local GetFileStreamingStatus, GetBackgroundLoadingStatus = GetFileStreamingStatus, GetBackgroundLoadingStatus
local UNKNOWN = UNKNOWN
local entered

local function colorLatency(latency)
	if latency < 250 then
		return "|cff0CD809"..latency
	elseif latency < 500 then
		return "|cffE8DA0F"..latency
	else
		return "|cffD80909"..latency
	end
end

local function setLatency(self)
	local _, _, latencyHome, latencyWorld = GetNetStats()
	local latency = max(latencyHome, latencyWorld)
	self.text:SetText(colorLatency(latency).."|rMs")
end

info.onUpdate = function(self, elapsed)
	self.timer = (self.timer or 0) + elapsed
	if self.timer > 1 then
		setLatency(self)
		if entered then self:onEnter() end

		self.timer = 0
	end
end

local ipTypes = {"IPv4", "IPv6"}
info.onEnter = function(self)
	entered = true

	local _, anchor, offset = module:GetTooltipAnchor(info)
	GameTooltip:SetOwner(self, "ANCHOR_"..anchor, 0, offset)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(U["Latency"], 0,.6,1)
	GameTooltip:AddLine(" ")

	local _, _, latencyHome, latencyWorld = GetNetStats()
	GameTooltip:AddDoubleLine(U["Home Latency"], colorLatency(latencyHome).."|r ms", .6,.8,1, 1,1,1)
	GameTooltip:AddDoubleLine(U["World Latency"], colorLatency(latencyWorld).."|r ms", .6,.8,1, 1,1,1)

	if GetCVarBool("useIPv6") then
		local ipTypeHome, ipTypeWorld = GetNetIpTypes()
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(U["Home Protocol"], ipTypes[ipTypeHome or 0] or UNKNOWN, .6,.8,1, 1,1,1)
		GameTooltip:AddDoubleLine(U["World Protocol"], ipTypes[ipTypeWorld or 0] or UNKNOWN, .6,.8,1, 1,1,1)
	end

	local downloading = GetFileStreamingStatus() ~= 0 or GetBackgroundLoadingStatus() ~= 0
	if downloading then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(U["Bandwidth"], format("%.2f Mbps", GetAvailableBandwidth()), .6,.8,1, 1,1,1)
		GameTooltip:AddDoubleLine(U["Download"], format("%.2f%%", GetDownloadedPercentage()*100), .6,.8,1, 1,1,1)
	end

	GameTooltip:Show()
end

info.onLeave = function()
	entered = false
	GameTooltip:Hide()
end
