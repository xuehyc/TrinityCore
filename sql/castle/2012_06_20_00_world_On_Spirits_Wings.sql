-- Remove spell-cast dependency, since the bunny itself is not spawned...
UPDATE `quest_template` SET `RequiredSpellCast1`=0 WHERE `Id`=10714;

-- Add spell-script reference, see corresponding code-change.
DELETE FROM `spell_script_names` WHERE `spell_id`=38173;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (38173, 'spell_gen_summon_spirit_rexxars_whistle');