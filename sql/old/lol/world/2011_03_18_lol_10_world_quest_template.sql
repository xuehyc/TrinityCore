-- Quest Fix 12988 Destroy the forges
UPDATE quest_template SET ReqSpellCast1 = 56275, ReqSpellCast2 = 56275, ReqSpellCast3 = 56275 WHERE entry = 12988;