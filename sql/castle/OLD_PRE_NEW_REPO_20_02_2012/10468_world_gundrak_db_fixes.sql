-- Fix creature_ai_script for creature 29774, Spitting Cobra; Set correct Venom Spit spell in normal and heroic difficulties
UPDATE `creature_ai_scripts` SET `action1_param1` = 55700 WHERE `id` IN (2977402, 2977403);
UPDATE `creature_ai_scripts` SET `action1_param1` = 59019 WHERE `id` IN (2977404, 2977405);

-- Only spawn Gorloc NPCs to spawn Eck in heroic difficulty
UPDATE `creature` SET `spawnMask` = 2 WHERE `id` = 29920;