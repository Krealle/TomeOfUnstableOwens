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

local frame = CreateFrame("FRAME", "TomeOfUnstableOwens")

frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

frame:SetScript("OnEvent", function(self, event, ...)
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
