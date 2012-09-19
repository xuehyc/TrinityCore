SET @boss_immunities := 650854399;
SET @respawn_time := 6*60*60; -- 6 hours

-- boss templates, increase damage, set immunities and scripts, custom upscaling
UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_magni_bronzebeard' WHERE entry = 2784;
UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_high_tinker_mekkatorque' WHERE entry = 7937;
UPDATE creature_template SET Mana_mod = 300, mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_prophet_velen' WHERE entry = 17468;
UPDATE creature_template SET Mana_mod = 400, mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_tyrande_whisperwind_darnassus' WHERE entry = 7999;
UPDATE creature_template SET Mana_mod = 188, mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_fandral_staghelm' WHERE entry = 3516;
UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_varian_wrynn' WHERE entry = 29611;
UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_lady_jaina_proudmoore' WHERE entry = 4968;

UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_lorthemar_theron' WHERE entry = 16802;
UPDATE creature_template SET Mana_mod = 160, mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_voljin' WHERE entry = 10540;
UPDATE creature_template SET Mana_mod = 300, mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_thrall_warchief' WHERE entry = 4949; 
UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_cairne_bloodhoof' WHERE entry = 3057;
UPDATE creature_template SET mechanic_immune_mask = @boss_immunities, dmg_multiplier = 50, ScriptName = 'npc_lady_sylvanas_windrunner' WHERE entry = 10181;

-- summoned minions, custom upscaling [damage upscaling does not work yet for some reason...)
UPDATE creature_template SET minLevel = 80, maxLevel = 80, exp = 2, rank = 1, mindmg = 422, maxdmg = 586, attackpower = 642, dmg_multiplier = 4.6, resistance2 = 50, resistance3 = 150, resistance4 = 50, resistance5 = 50, resistance6 = 150, mingold = 210, maxgold =279, Health_mod = 2 WHERE entry = 31802; -- Treant Ally (Fandral, Nature&Arcane Resistance improved)
UPDATE creature_template SET minLevel = 80, maxLevel = 80, exp = 2, rank = 1, mindmg = 422, maxdmg = 586, attackpower = 642, dmg_multiplier = 4.6, resistance2 = 60, resistance3 = 60, resistance4 = 200, resistance5 = 60, resistance6 = 60, mingold = 210, maxgold =279, Health_mod = 2 WHERE entry = 31802; -- Water Elemental (Jaina, Frost Resistance improved)
UPDATE creature_template SET minLevel = 80, maxLevel = 80, exp = 2, rank = 1, mindmg = 422, maxdmg = 586, attackpower = 642, dmg_multiplier = 4.6, resistance2 = 60, resistance3 = 60, resistance4 = 60, resistance5 = 200, resistance6 = 60, mingold = 210, maxgold =279, Health_mod = 2 WHERE entry = 6412; -- Skeleton (Sylvanas, Shadow Resistance improved)

-- custom respawn time
UPDATE creature SET spawntimesecs = @respawn_time WHERE id IN (2784, 7937, 17468, 7999, 3516, 29611, 4968, 16802, 10540, 4949, 3057, 10181);

-- creature texts (TODO: HOW TO SYNC RANDOM TXT ON AGGRO WITH RANDOM SOUND?)
DELETE FROM creature_text WHERE entry = 2784;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(2784, 0, 0, 'For Khaz''Modan!', 14, 0, 100, 0, 0, 5896, 'King Magni Bronzebeard - On Aggro'),
(2784, 0, 1, 'Feel the fury of the mountain!', 14, 0, 100, 0, 0, 5896, 'King Magni Bronzebeard - On Aggro');

-- srsly how can varian have no aggro text?
-- DELETE FROM creature_text WHERE entry = 29611;
-- INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
-- (29611, 0, 0, '???', 14, 0, 100, 0, 0, 0, 'Varian Wrynn - On Aggro');

DELETE FROM creature_text WHERE entry = 7937;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(7937, 0, 0, 'I won''t stand for that!', 14, 0, 100, 0, 0, 5897, 'Gelbin Mekkatorgue - On Aggro'),
(7937, 1, 0, 'Pick on someone your own size!', 14, 0, 100, 0, 0, 7255, 'Gelbin Mekkatorgue - Player killed');

DELETE FROM creature_text WHERE entry = 7999;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(7999, 0, 0, 'Anu''dora!', 14, 0, 100, 0, 0, 5885, 'Tyrande Whisperwind - On Aggro'),
(7999, 0, 1, 'For Kalimdor!', 14, 0, 100, 0, 0, 5885, 'Tyrande Whisperwind - On Aggro'),
(7999, 0, 2, 'Endu''di Rifa!', 14, 0, 100, 0, 0, 5885, 'Tyrande Whisperwind - On Aggro');

DELETE FROM creature_text WHERE entry = 17468;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(17468, 0, 0, 'An unwise decision.', 14, 0, 100, 0, 0, 10154, 'Prophet Velen - On Aggro'),
(17468, 0, 1, 'I foresaw this. ', 14, 0, 100, 0, 0, 10154, 'Prophet Velen - On Aggro'),
(17468, 0, 2, 'How unfortunate...for you.', 14, 0, 100, 0, 0, 10154, 'Prophet Velen - On Aggro');

DELETE FROM creature_text WHERE entry = 4968;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(4968, 0, 0, 'You asked for it.', 14, 0, 100, 0, 0, 5882, 'Jaina Proudmoore - On Aggro'),
(4968, 0, 1, 'I hate resorting to violence!', 14, 0, 100, 0, 0, 5882, 'Jaina Proudmoore - Player killed');

DELETE FROM creature_text WHERE entry = 3057;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(3057, 0, 0, 'For honor!', 14, 0, 100, 0, 0, 5884, 'Cairne Bloodhoof - On Aggro'),
(3057, 0, 1, 'Ish-ne-alo por-ah!', 14, 0, 100, 0, 0, 5884, 'Cairne Bloodhoof - On Aggro'),
(3057, 1, 0, 'The attackers have fled! Strength and honor to the Horde! ', 14, 0, 100, 0, 0, 0, 'Cairne Bloodhoof - On Evade');

DELETE FROM creature_text WHERE entry = 4949;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(4949, 0, 0, 'Lok''narosh!', 14, 0, 100, 0, 0, 5880, 'Thrall - On Aggro'),
(4949, 0, 1, 'For Doomhammer!', 14, 0, 100, 0, 0, 5880, 'Thrall - On Aggro'),
(4949, 0, 2, 'Your time has come!', 14, 0, 100, 0, 0, 5880, 'Thrall - On Aggro');

DELETE FROM creature_text WHERE entry = 10540;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(10540, 0, 0, 'For the Darkspear tribe!', 14, 0, 100, 0, 0, 5881, 'Vol''jin - On Aggro'),
(10540, 0, 1, 'Here come the voodoo! ', 14, 0, 100, 0, 0, 5881, 'Vol''jin - On Aggro'),
(10540, 0, 2, 'You make big mistake, mon.', 14, 0, 100, 0, 0, 5881, 'Vol''jin - On Aggro');

DELETE FROM creature_text WHERE entry = 10181;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(10181, 0, 0, 'Let none survive!', 14, 0, 100, 0, 0, 5886, 'Lady Sylvanas Windrunner - On Aggro'),
(10181, 0, 1, 'May my aim be true.', 14, 0, 100, 0, 0, 5886, 'Lady Sylvanas Windrunner - On Aggro');

DELETE FROM creature_text WHERE entry = 16802;
INSERT INTO creature_text (entry, groupid, id, text, type, language, probability, emote, duration, sound, comment) VALUES 
(16802, 0, 0, 'It was inevitable.', 14, 0, 100, 0, 0, 0, 'Lorthemar Theron - On Killed Player'),
(16802, 0, 1, 'You die in vain!', 14, 0, 100, 0, 0, 0, 'Lorthemar Theron - On Killed Player');

-- spells
DELETE FROM spell_target_position WHERE id = 20682;
INSERT INTO spell_target_position (id, target_map, target_position_x, target_position_y, target_position_z, target_orientation) VALUES 
(20682, 1, -3993.81, -4467.281, 14.75, 6.0); -- jainas teleport spell...drops you into the water somewhere at theramore haven

-- custom bonus data (make those spells do alot more of huuuuurt)
DELETE FROM spell_bonus_data WHERE entry IN (20685, 59698, 59703, 59701, 59700, 20698, 20699, 20687, 20690, 20680, 20692, 20679, 59712, 59715, 23931, 17146, 20463, 17289, 16033, 16034);
INSERT INTO spell_bonus_data (entry, direct_bonus, dot_bonus, ap_bonus, ap_dot_bonus, comments) VALUES
-- alliance
(20685, 0, 0, 24, 0, 'Magni Bronzebeard - Storm Bolt'),
(59698, 0, 0, 400.0, 0, 'Prophet Velen - Prayer of Healing'),
(59703, 0, 0, 10, 0, 'Prophet Velen - Holy Smite'),
(59701, 0, 0, 12, 0, 'Prophet Velen - Holy Nova'),
(59700, 0, 0, 8, 0, 'Prophet Velen - Holy Blast'),
(20698, 0, 0, 20, 0, 'Fandral Staghelm - Wrath'),
(20699, 0, 0, 0, 10, 'Fandral Staghelm - Entangling Roots (Dot)'),
(20687, 0, 0, 0, 5, 'Tyrande Whisperwind - Starfall'),
(20690, 0, 0, 0, 4, 'Tyrande Whisperwind - Moonfire (Dot)'),
(20680, 0, 0, 0, 5, 'Jaina Proudmoore - Blizzard'),
(20692, 0, 0, 40, 0, 'Jaina Proudmoore - Fireball'),
(20679, 0, 0, 30, 0, 'Jaina Proudmoore - Fire Blast'),
-- horde
(59712, 0, 0, 0, 12, 'Sylvanas Windrunner - Black Arrow (Dot)'),
(59715, 0, 0, 15, 0, 'Lorthemar''Theron - Arcane Shock'),
(23931, 0, 0, 4, 0, 'Cairne Bloodhoof - Thunderclap'),
(17146, 0, 0, 0, 9, 'Vol''jin - Shadow Word: Pain'),
(20463, 0, 0, 2.5, 0, 'Vol''jin - Shoot'),
(17289, 0, 0, 15, 0, 'Vol''jin - Shadow Shock'),
(16033, 0, 0, 15, 0, 'Thrall - Chain Lightning'),
(16034, 0, 0, 18, 0, 'Thrall - Shock');

-- trinity string for world announce
DELETE FROM trinity_string WHERE entry = 11002;
INSERT INTO trinity_string (entry, content_default, content_loc1, content_loc2, content_loc3, content_loc4, content_loc5, content_loc6, content_loc7, content_loc8) VALUES
(11002, '%s', NULL, NULL, '%s', NULL, NULL, NULL, NULL, NULL);
