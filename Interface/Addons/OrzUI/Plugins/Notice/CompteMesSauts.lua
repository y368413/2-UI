-- Crée un cadre pour l'addon ## Version: 1.0.2 ## Author: Brox ## SavedVariables: NbreSaut ## SavedVariablesPerCharacter: NbreSautPerCharacter
local frame = CreateFrame("Frame", "CMSFrame", UIParent);
frame:SetSize(150, 20);
frame:SetPoint("TOP", -120, 0);
frame:SetMovable(true);
frame:EnableMouse(true);
frame:RegisterForDrag("LeftButton");
frame:SetScript("OnDragStart", frame.StartMoving);
frame:SetScript("OnDragStop", frame.StopMovingOrSizing);

-- Initialise le compteur de sauts spécifique au personnage
if not NbreSautPerCharacter then NbreSautPerCharacter = {}; end
local playerName = UnitName("player");
if not NbreSautPerCharacter[playerName] then NbreSautPerCharacter[playerName] = 0; end

-- Créer le texte pour afficher le nombre de sauts
local CMSText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
CMSText:SetPoint("CENTER", frame, "CENTER");

-- Fonction pour mettre à jour le texte du nombre de sauts
local function UpdateJumpCount() CMSText:SetText(NbreSautPerCharacter[playerName]); end

-- Liste des sons à jouer aléatoirement
local jumpSounds = {
    "Interface\\AddOns\\CMS\\sounds\\jump1.mp3",
    "Interface\\AddOns\\CMS\\sounds\\jump2.mp3",
    "Interface\\AddOns\\CMS\\sounds\\jump3.mp3",
    "Interface\\AddOns\\CMS\\sounds\\jump4.mp3",
}

-- Sons pour les paliers
local specialSounds = {
    [500] = "Interface\\AddOns\\CMS\\sounds\\500.mp3",
    [1000] = "Interface\\AddOns\\CMS\\sounds\\1000.mp3",
    [2000] = "Interface\\AddOns\\CMS\\sounds\\2000.mp3",
    [10000] = "Interface\\AddOns\\CMS\\sounds\\10000.mp3",
    [200000] = "Interface\\AddOns\\CMS\\sounds\\20000.mp3",
}

hooksecurefunc("JumpOrAscendStart", function()
    if not IsFalling() then
        NbreSautPerCharacter[playerName] = NbreSautPerCharacter[playerName] + 1;
        UpdateJumpCount();

        -- Sons aléatoires (1 chance sur 4)
        --if math.random(1, 4) == 1 then
            --local sound = jumpSounds[math.random(#jumpSounds)]
            --PlaySoundFile(sound, "Master")
        --end

        -- Sons spéciaux
        --local currentCount = NbreSautPerCharacter[playerName]
        --if specialSounds[currentCount] then
            --PlaySoundFile(specialSounds[currentCount], "Master")
        --end
    end
end)

-- Événement de chargement de l'addon
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        UpdateJumpCount();
    end
end);