-- Fix quests 10011 Konstruktionslager: zerstört / Forge Camp: Annihilated, 11585 Höllschreis Wacht / Hellscream's Vigil
-- it does not make sense, that these quests block each other, remove exclusive group there
UPDATE `quest_template` SET `ExclusiveGroup` = 0 WHERE `ExclusiveGroup` = 10011;