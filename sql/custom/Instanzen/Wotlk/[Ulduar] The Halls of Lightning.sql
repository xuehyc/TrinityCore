## Set Emblem of Heroism Badges
SET @lootid_bjarngrim = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28586));
SET @lootid_volkhan   = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28587));
SET @lootid_ionar     = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28546));
SET @lootid_loken     = (SELECT lootid FROM creature_template WHERE entry = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28923));

UPDATE creature_loot_template SET item = 40752 WHERE item = 47241 AND entry IN (@lootid_bjarngrim,@lootid_volkhan,@lootid_ionar,@lootid_loken);

## EventAI for Slag
-- Non-Heroic NPCs
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2858501, 28585, 1, 0, 100, 1|2, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61509, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning - Slag - Melt Armor OOC');
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2858502, 28585, 0, 0, 100, 1|2, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61509, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning - Slag - Melt Armor');
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment) VALUES 
(2858599, 28585, 6, 0, 100, 2, 
-- event: EVENT_T_DEATH
0, 0, 0, 0, 
-- action1: ACTION_T_CAST 
11, 23113, 0, 1, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning - Slag - Blast Wave on Death');

-- Heroic NPCs
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment)
VALUES 
(2858503, 28585, 1, 0, 100, 1|4, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61510, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning Heroic - Slag - Melt Armor OOC');
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment)
VALUES 
(2858504, 28585, 0, 0, 100, 1|4, 
-- event: EVENT_T_SPAWNED
0, 0, 5000, 5000, 
-- action1: ACTION_T_CAST 
11, 61510, 0, 0, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning Heroic - Slag - Melt Armor');
REPLACE INTO creature_ai_scripts (id, creature_id, event_type, event_inverse_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action1_type, action1_param1, action1_param2, action1_param3, action2_type, action2_param1, action2_param2, action2_param3, action3_type, action3_param1, action3_param2, action3_param3, comment)
VALUES 
(2858598, 28585, 6, 0, 100, 4, 
-- event: EVENT_T_DEATH
0, 0, 0, 0, 
-- action1: ACTION_T_CAST 
11, 22424, 0, 1, 
-- action2: NO_ACTION
0, 0, 0, 0, 
-- action3: NO_ACTION
0, 0, 0, 0,
-- Comment
'Halls of Lightning Heroic - Slag - Blast Wave on Death');

CALL sp_set_npc_eventai(28585);

## Get a bit more damage from Bosses :)
SET @boss_bjarngrim = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28586);
SET @boss_volkhan   = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28587);
SET @boss_ionar     = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28546);
SET @boss_loken     = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28923);
UPDATE creature_template SET dmg_multiplier = 20 WHERE entry IN (@boss_bjarngrim, @boss_volkhan, @boss_ionar, @boss_loken);

## Add Some damage for whole Instance (heroic)
UPDATE creature_template SET dmg_multiplier = dmg_multiplier + 2 WHERE entry IN (31537, 30979, 30967, 30966, 30968, 30977, 30974, 30964, 30983, 30970, 31533, 31536, 30969, 30965, 30978, 30971, 30975, 30976, 30981, 30972, 31538, 31867, 30980, 30982, 30973);

## Correct Faction für Heroic Sparks and Molten Golems
SET @28695_h = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28695);
CALL sp_set_npc_faction(@28695_h,16,16);
SET @28926_h = (SELECT difficulty_entry_1 FROM creature_template WHERE entry = 28926);
CALL sp_set_npc_faction(@28926_h,14,14);

## Trigger Static Overload Final Damage & Knockback
INSERT IGNORE INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) 
VALUES
('-52658','53337','0','Static Overload'),
('-59795','59798','0','Static Overload');
