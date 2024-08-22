local playerGUID = UnitGUID("player")
local SOUND_PATH = "Interface\\AddOns\\TomeOfUnstableOwens\\Sounds\\";
local SOUND_CHANNEL = "Master";

-- IDs for the summon events
local unstableImages = {
	[433915] = true,
	[433954] = true,
	[433956] = true,
	[433957] = true,
	[433958] = true,
}
local TOME_ITEM_ID = 212685

local isTomeEquipped = false

local frame = CreateFrame("FRAME", "TomeOfUnstableOwens")
frame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_ENTERING_WORLD" then
        local playerEquippedTome = false
        for i = 13, 14 do
            local trinketItemID = GetInventoryItemID("player", i)
            
            if trinketItemID == TOME_ITEM_ID then
                playerEquippedTome = true
                break
            end
        end

        if playerEquippedTome then
            frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        else
            if isTomeEquipped then
                if UnitLevel("player") > 70 then
                    print("|cffffa500[TomeOfUnstableOwens]|r |cFFFF3030Consider removing this AddOn, since it is now deprecated.|r")
                end
            end

            frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
        end
        
        isTomeEquipped = playerEquippedTome
        return
    end

	local _, subevent, _, sourceGUID = CombatLogGetCurrentEventInfo()
	if (sourceGUID ~= playerGUID or subevent ~= "SPELL_SUMMON") then
		return
	end

	local spellId = select(12, CombatLogGetCurrentEventInfo())

	if unstableImages[spellId] == nil then
		return false
	end

	local owen = SOUND_PATH .. math.random(1, 16) .. ".mp3"
	PlaySoundFile(owen, SOUND_CHANNEL);
end)
