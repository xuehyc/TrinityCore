UPDATE `creature_template` SET `flags_extra` = '128', `ScriptName` = 'npc_survey_tools_trigger' WHERE `entry` =1455;

DELETE FROM `spell_script_names` WHERE `spell_id` = 80451;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES ('80451', 'spell_gen_archaeology_survey');