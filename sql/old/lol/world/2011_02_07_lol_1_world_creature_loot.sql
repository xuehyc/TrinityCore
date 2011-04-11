-- Item 34815 Vial of Fresh Blood should drop 100% while quest
UPDATE creature_loot_template SET ChanceOrQuestChance = -100 WHERE item = 34815;