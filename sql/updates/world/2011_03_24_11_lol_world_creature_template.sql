-- Workaround for Quest 11529 'Sorlof`s Booty'
-- SAI
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 24914;
-- spawn GO 187238 'Sorlof´s Booty' after kill at invoker
DELETE FROM smart_scripts WHERE entryorguid = 24914;
INSERT INTO smart_scripts VALUES
(24914, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 45070, 0x02, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'on death cast summon GO');
