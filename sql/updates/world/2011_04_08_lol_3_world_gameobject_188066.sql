-- Quest 11879 'Kaw the Mammoth Destroyer' spawn Kaw's War Halberd (188066) after Kaws Dead
-- use SmartAI instead of EventAI
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 25802;
DELETE FROM creature_ai_scripts WHERE creature_id = 25802;
-- create SmartAI
DELETE FROM smart_scripts WHERE entryorguid = 25802;
INSERT INTO smart_scripts VALUES
(25802, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 46310, 0x02, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'on death cast spell');