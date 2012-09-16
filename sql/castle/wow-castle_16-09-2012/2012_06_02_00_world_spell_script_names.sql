-- @DorianGrey
-- Q9910: Standards and Practices 

-- Register named spell-script; @see spell_generic.cpp
DELETE FROM `spell_script_names` WHERE `spell_id`=32205;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (32205, 'spell_gen_place_maghar_battle_standard');

-- Remove spell-cast-requirement, since this gets handled by the script.
UPDATE `quest_template` SET `RequiredSpellCast1`=0, `RequiredSpellCast2`=0, `RequiredSpellCast3`=0 WHERE `Id`=9910; 