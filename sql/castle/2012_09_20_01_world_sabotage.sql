SET @go_scourgewagon := 190731;
SET @npc_explosive_charges_bunny := 28780;
SET @npc_scourge_wagon_kc_bunny := 28777;
SET @spell_place_charges := 52315;
SET @spell_explosive_charge_cosmetic := 43418;
SET @npc_drakuru_task_credit := 28786; -- after handing in quest Fuel for the Fire (12690)
SET @npc_drakuru_secret_credit := 28928; -- after handing in quest Disclosure (12710)

-- Explosive Charges grant immediate credit and explode after 4 sec
UPDATE creature_template SET modelid1 = 19595, modelid2 = 0 WHERE entry = 28780;
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = @npc_explosive_charges_bunny;
DELETE FROM `smart_scripts` WHERE `entryorguid` = @npc_explosive_charges_bunny AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@npc_explosive_charges_bunny, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 33, @npc_scourge_wagon_kc_bunny, 0, 0, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 'On Just Summoned - Grant Kill Credit');

-- this is totally incomplete and only giving credit for setting up the explosion, sorry :)

-- do voltarus teleport handling through at_script, because somethimes we need to down, sometimes we need to go up :)
DELETE FROM areatrigger_teleport WHERE id IN (5079, 5080);
DELETE FROM areatrigger_scripts WHERE entry IN (5079, 5080);
INSERT INTO areatrigger_scripts (entry, ScriptName) VALUES
(5079, 'at_voltarus'),
(5080, 'at_voltarus');