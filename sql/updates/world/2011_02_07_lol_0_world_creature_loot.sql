-- Item 38551 Drakkari Offerings Dropchance without Quest
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = `ChanceOrQuestChance`*-1 WHERE `item` = 38551;