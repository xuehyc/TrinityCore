-- Quest Fix 12555 A tangled skein
UPDATE `creature_template` SET unit_flags = 4 WHERE entry = 28274; -- don't attack player
UPDATE `quest_template` SET ReqCreatureOrGOId1 = 28274, ReqSpellCast1 = 51165 WHERE entry = 12555;