--## Author: Vampyr78 ## Version: 3.2.3
local StatPriority = LibStub("AceAddon-3.0"):NewAddon("StatPriority")
if GetLocale() == "zhCN" then
  StatPriorityLocal = "|cff33ff99[三围]|r属性推荐";
elseif GetLocale() == "zhTW" then
  StatPriorityLocal = "|cff33ff99[三围]|r属性推荐";
else
  StatPriorityLocal = "Stat Priority";
end

StatPriority.Stats = {}

StatPriority.Stats["WARRIORArms"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY
StatPriority.Stats["WARRIORFury"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_MASTERY ..">".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. STAT_CRITICAL_STRIKE
StatPriority.Stats["WARRIORProtection"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE .."=".. STAT_VERSATILITY ..">".. STAT_MASTERY

StatPriority.Stats["PALADINHoly"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY
StatPriority.Stats["PALADINProtection"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY .."=".. STAT_CRITICAL_STRIKE
StatPriority.Stats["PALADINRetribution"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_MASTERY .. STAT_CRITICAL_STRIKE .."=".. STAT_HASTE ..">".. STAT_VERSATILITY

StatPriority.Stats["HUNTERBeast Mastery"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_HASTE .."30%" .."=".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY ..">".. STAT_MASTERY
StatPriority.Stats["HUNTERMarksmanship"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_CRITICAL_STRIKE .."54%" ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY ..">".. STAT_HASTE
StatPriority.Stats["HUNTERSurvival"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_MASTERY ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY

StatPriority.Stats["ROGUEAssassination"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_MASTERY ..">".. STAT_HASTE ..">".. STAT_VERSATILITY
StatPriority.Stats["ROGUEOutlaw"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_VERSATILITY ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_MASTERY
StatPriority.Stats["ROGUESubtlety"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE

StatPriority.Stats["PRIESTDiscipline"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE .."20%-25%" ..">".. STAT_CRITICAL_STRIKE .."=".. STAT_MASTERY ..">".. STAT_VERSATILITY
StatPriority.Stats["PRIESTHoly"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_CRITICAL_STRIKE .."=".. STAT_MASTERY ..">".. STAT_VERSATILITY ..">".. STAT_HASTE
StatPriority.Stats["PRIESTShadow"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY

StatPriority.Stats["SHAMANElemental"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_MASTERY .."=".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. STAT_CRITICAL_STRIKE
StatPriority.Stats["SHAMANEnhancement"] = STAT_MASTERY ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY ..">".. SPEC_FRAME_PRIMARY_STAT_AGILITY
StatPriority.Stats["SHAMANRestoration"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE .."=".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY ..">".. STAT_MASTERY

StatPriority.Stats["MAGEArcane"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE
StatPriority.Stats["MAGEFire"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY ..">".. STAT_CRITICAL_STRIKE
StatPriority.Stats["MAGEFrost"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE.."33.34%" ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY

StatPriority.Stats["WARLOCKAffliction"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_MASTERY .."=".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE ..">".. STAT_VERSATILITY
StatPriority.Stats["WARLOCKDemonology"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE .."=".. STAT_CRITICAL_STRIKE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY
StatPriority.Stats["WARLOCKDestruction"] = STAT_HASTE .."=".. STAT_CRITICAL_STRIKE ..">".. SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY

StatPriority.Stats["DRUIDBalance"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_MASTERY ..">".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. STAT_CRITICAL_STRIKE
StatPriority.Stats["DRUIDFeral"] = STAT_MASTERY .."=".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. SPEC_FRAME_PRIMARY_STAT_AGILITY
StatPriority.Stats["DRUIDGuardian"] = STAT_ARMOR .."=".. SPEC_FRAME_PRIMARY_STAT_AGILITY .."=".. STAMINA_COLON ..">".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE
StatPriority.Stats["DRUIDRestoration"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY ..">".. STAT_CRITICAL_STRIKE

StatPriority.Stats["MONKBrewmaster"] = SPEC_FRAME_PRIMARY_STAT_AGILITY .."=".. STAT_ARMOR ..">".. STAT_VERSATILITY .."=".. STAT_MASTERY .."=".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE
StatPriority.Stats["MONKMistweaver"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY .."=".. STAT_MASTERY
StatPriority.Stats["MONKWindwalker"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_MASTERY .."=".. STAT_HASTE ..">".. STAT_VERSATILITY .."=".. STAT_CRITICAL_STRIKE

StatPriority.Stats["DEATHKNIGHTBlood"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE .."=".. STAT_VERSATILITY .."=".. STAT_MASTERY
StatPriority.Stats["DEATHKNIGHTFrost"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE ..">".. STAT_VERSATILITY
StatPriority.Stats["DEATHKNIGHTUnholy"] = SPEC_FRAME_PRIMARY_STAT_STRENGTH ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY

StatPriority.Stats["DEMONHUNTERHavoc"] = STAT_CRITICAL_STRIKE .."=".. STAT_MASTERY ..">".. STAT_HASTE ..">".. STAT_VERSATILITY ..">".. SPEC_FRAME_PRIMARY_STAT_AGILITY
StatPriority.Stats["DEMONHUNTERVengeance"] = SPEC_FRAME_PRIMARY_STAT_AGILITY ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_VERSATILITY ..">".. STAT_MASTERY

StatPriority.Stats["EVOKERAugmentation"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY
StatPriority.Stats["EVOKERDevastation"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_HASTE ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_MASTERY ..">".. STAT_VERSATILITY
StatPriority.Stats["EVOKERPreservation"] = SPEC_FRAME_PRIMARY_STAT_INTELLECT ..">".. STAT_MASTERY ..">".. STAT_CRITICAL_STRIKE ..">".. STAT_HASTE ..">".. STAT_VERSATILITY

function StatPriority:FrameOnEvent(event, arg1)
	if event == "SPELLS_CHANGED" then
		StatPriority:FrameUpdate(statPriorityText, PaperDollFrame, "player")
	end
end

function StatPriority:FrameCreate(frame, text, parent)
	if parent.IsVisible ~= nil and parent:IsVisible() then
		frame:SetBackdrop({--bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
						   --edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
						   tile = true,
						   tileSize = 16,
						   edgeSize = 16, 
						   insets = {left = 1,
									 right = 1,
									 top = 1,
									 bottom = 1}}) 
		frame:SetBackdropColor(0, 0, 0, 1)
		frame:SetFrameStrata("TOOLTIP")
		frame:SetWidth(parent:GetWidth())
		if parent == PaperDollFrame then
			frame:SetHeight(25)
		else
			frame:SetHeight(50)
		end
		text:ClearAllPoints()
		text:SetAllPoints(frame) 
		text:SetJustifyH("CENTER")
		text:SetJustifyV("MIDDLE")
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT",0,0)
		frame:SetPoint("BOTTOMLEFT", parent, "TOPLEFT",0,0)
		frame:SetParent(parent)
		frame:Show()
		return true
	end
	return false
end

function StatPriority:GetSpecializationName(id)
	local spec = ""
	if id == 62 then 
		spec = "Arcane"
	elseif id == 63 then 
		spec = "Fire"
	elseif id == 64 then 
		spec = "Frost"
	elseif id == 65 then 
		spec = "Holy"
	elseif id == 66 then 
		spec = "Protection"
	elseif id == 70 then 
		spec = "Retribution"
	elseif id == 71 then 
		spec = "Arms"
	elseif id == 72 then 
		spec = "Fury"
	elseif id == 73 then 
		spec = "Protection"
	elseif id == 102 then 
		spec = "Balance"
	elseif id == 103 then 
		spec = "Feral"
	elseif id == 104 then 
		spec = "Guardian"
	elseif id == 105 then 
		spec = "Restoration"
	elseif id == 250 then 
		spec = "Blood"
	elseif id == 251 then 
		spec = "Frost"
	elseif id == 252 then 
		spec = "Unholy"
	elseif id == 253 then 
		spec = "Beast Mastery"
	elseif id == 254 then 
		spec = "Marksmanship"
	elseif id == 255 then 
		spec = "Survival"
	elseif id == 256 then 
		spec = "Discipline"
	elseif id == 257 then 
		spec = "Holy"
	elseif id == 258 then 
		spec = "Shadow"
	elseif id == 259 then 
		spec = "Assassination"
	elseif id == 260 then 
		spec = "Outlaw"
	elseif id == 261 then 
		spec = "Subtlety"
	elseif id == 262 then 
		spec = "Elemental"
	elseif id == 263 then 
		spec = "Enhancement"
	elseif id == 264 then 
		spec = "Restoration"
	elseif id == 265 then 
		spec = "Affliction"
	elseif id == 266 then 
		spec = "Demonology"
	elseif id == 267 then 
		spec = "Destruction"
	elseif id == 268 then 
		spec = "Brewmaster"
	elseif id == 269 then 
		spec = "Windwalker"
	elseif id == 270 then 
		spec = "Mistweaver"
	elseif id == 577 then 
		spec = "Havoc"
	elseif id == 581 then 
		spec = "Vengeance"
	elseif id == 1467 then 
		spec = "Devastation"
	elseif id == 1468 then 
		spec = "Preservation"
	elseif id == 1473 then
		spec = "Augmentation"
	end
	return spec
end

function StatPriority:FrameUpdate(frame, frameText, parent, unit)
	if parent ~= nil and self:FrameCreate(frame, frameText, parent) then
		local temp, class = UnitClass(unit)
		local spec
		local text
		if parent == PaperDollFrame then
			spec = GetSpecializationInfo(GetSpecialization())
			spec = StatPriority:GetSpecializationName(spec)
			text = StatPriority.Stats[class .. spec];
			if ShiGuangPerDB[class..spec] == nil then
				text = StatPriority.Stats[class..spec]
			else
				text = ShiGuangPerDB[class..spec]
			end
		else
			spec = StatPriority:GetSpecializationName(GetInspectSpecialization(unit))
			text = StatPriority.Stats[class .. spec];
			if StatPriority.Stats[class..spec] ~= nil and class == UnitClass("player") then
				text = StatPriority.Stats[class..spec]
			end
		end
		frameText:SetText(text)
	end
end

function StatPriority:SetPriority(info, val)
	local _, name = UnitClass("player")
	ShiGuangPerDB[name .. info.option.name] = val
end

function StatPriority:GetPriority(info)
	local _, name = UnitClass("player")
	return ShiGuangPerDB[name .. info.option.name]
end

function StatPriority:OnInitialize()
	self.Frame = CreateFrame("FRAME", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
	self.Text = self.Frame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
	self.Frame:RegisterEvent("SPELLS_CHANGED")
	self.Frame:SetScript("OnEvent", self.FrameOnEvent)
	PaperDollFrame:HookScript("OnShow", function() self:FrameUpdate(self.Frame, self.Text, PaperDollFrame, "player") end)
	local options;
	local _, class = UnitClass("player")
	if class == "WARRIOR" then
		options = {
			name = StatPriorityLocal,
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Arms",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Fury",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Protection",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "PALADIN" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Holy",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Protection",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Retribution",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "HUNTER" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Beast Mastery",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Marksmanship",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Survival",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "ROGUE" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Assassination",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Outlaw",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Subtlety",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "PRIEST" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Discipline",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Holy",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Shadow",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "SHAMAN" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Elemental",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Enhancement",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Restoration",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "MAGE" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Arcane",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Fire",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Frost",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "WARLOCK" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Affliction",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Demonology",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Destruction",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "DRUID" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Balance",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Feral",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Guardian",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec4 = {
							name = "Restoration",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "MONK" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Brewmaster",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Mistweaver",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Windwalker",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "DEATHKNIGHT" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Blood",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Frost",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Unholy",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "DEMONHUNTER" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Havoc",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Vengeance",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	elseif class == "EVOKER" then
		options = {
			name = "属性优先级",
			handler = StatPriority,
			type = "group",
			args = {
				stats = {
					name = "自定义属性优先级",
					type = "group",
					desc = "你可以在这里输入自定义的属性优先级",
					args = {
						spec1 = {
							name = "Devastation",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec2 = {
							name = "Preservation",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						},
						spec3 = {
							name = "Augmentation",
							type = "input",
							width = "full",
							set = "SetPriority",
							get = "GetPriority"
						}
					}
				}
			}
		}
	end
	LibStub("AceConfig-3.0"):RegisterOptionsTable("StatPriority", options, nil)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("StatPriority", StatPriorityLocal)
end