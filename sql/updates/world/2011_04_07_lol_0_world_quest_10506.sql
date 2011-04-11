-- Fix Quest 'A Dire Situation' #10506
UPDATE quest_template SET ReqCreatureOrGOId1 = 20058, ReqCreatureOrGOCount1 = 5, ReqSpellCast1=36310 WHERE entry = 10506;