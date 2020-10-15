		  if i == 1 then
			  button:SetSize(cfg.size *0.8, cfg.size *0.8)
			  button:SetPoint("LEFT", frame, padding, 0)
			elseif i == 2 then
			  button:SetSize(cfg.size *0.8, cfg.size *0.8)
			  button:SetPoint("TOPLEFT", _G["ActionButton1"], "BOTTOMLEFT", 0, -margin)
		  elseif i == 3 then
			  button:SetSize(cfg.size *0.8, cfg.size *0.8)
			  button:SetPoint("TOPLEFT", _G["ActionButton2"], "BOTTOMLEFT", 0, -margin)
			elseif i == 4 then
			  button:SetSize(cfg.size *1.2, cfg.size *1.2)
			  button:SetPoint("TOPLEFT", _G["ActionButton1"], "TOPRIGHT", margin, 0)
		  elseif i == 7 then
			  button:SetSize(cfg.size *1.2, cfg.size *1.2)
			  button:SetPoint("TOPLEFT", _G["ActionButton4"], "BOTTOMLEFT", 0, -margin)
			elseif i == 10 then
			  button:SetSize(cfg.size *0.8, cfg.size *0.8)
			  button:SetPoint("TOPLEFT", _G["ActionButton6"], "TOPRIGHT", margin, 0)
		  elseif i == 11 then
			  button:SetSize(cfg.size *0.8, cfg.size *0.8)
			  button:SetPoint("TOPLEFT", _G["ActionButton10"], "BOTTOMLEFT", 0, -margin)
			elseif i == 12 then
			  button:SetSize(cfg.size *0.8, cfg.size *0.8)
			  button:SetPoint("TOPLEFT", _G["ActionButton11"], "BOTTOMLEFT", 0, -margin)
			else
			  button:SetSize(cfg.size *1.2, cfg.size*1.2)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			end
		  if i == 1 then
			  button:SetSize(cfg.size *1.1, cfg.size *1.1)
			  button:SetPoint("LEFT", frame, padding, 0)
			elseif i == 2 then
			  button:SetSize(cfg.size *1.1, cfg.size *1.1)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 1, 0)
		  elseif i == 3 then
			  button:SetSize(cfg.size *1.1, cfg.size *1.1)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 1, 0)
			elseif i == 4 then
			  button:SetSize(cfg.size *1.1, cfg.size *1.1)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 1, 0)
		  elseif i == 5 then
			  button:SetSize(cfg.size *1.1, cfg.size *1.1)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 1, 0)
			elseif i == 6 then
			  button:SetSize(cfg.size *0.8, cfg.size*0.8)
			  button:SetPoint("TOPLEFT", _G["ActionButton1"], "BOTTOMLEFT", 0, -margin)
			else
			  button:SetSize(cfg.size *0.8, cfg.size*0.8)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			end
		  if i == 1 then
			  button:SetSize(cfg.size *1.15, cfg.size *0.9)
			  button:SetPoint("TOPLEFT", frame, padding, -padding)
			elseif i == 7 then
			  button:SetSize(cfg.size *1.15, cfg.size *0.9)
			  button:SetPoint("TOPLEFT", _G["ActionButton1"], "BOTTOMLEFT", 0, -margin)
			else
			  button:SetSize(cfg.size *1.15, cfg.size *0.9)
			  button:SetPoint("LEFT", _G["ActionButton"..i-1], "RIGHT", 0, 0)
			end