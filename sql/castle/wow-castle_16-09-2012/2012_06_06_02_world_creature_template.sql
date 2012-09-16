-- add creature script to wg champions, necessary for combat unstuck ability
UPDATE creature_template SET ScriptName = 'npc_wg_guard', AIName = '' WHERE entry IN (30740, 30739);
DELETE FROM smart_scripts WHERE entryorguid IN (30740, 30739) and source_type = 0;