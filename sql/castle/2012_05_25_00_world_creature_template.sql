UPDATE creature_template SET ScriptName = 'npc_argent_combatant' WHERE entry IN (33448, 33707);
UPDATE creature_template SET ScriptName = 'npc_argent_squire' WHERE entry IN (33447, 33518, 33522);

-- add mount for argent champion
DELETE FROM creature_template_addon WHERE entry = 33707;
INSERT INTO creature_template_addon (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(33707, 0, 28919, 0, 0, 0, '');