UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_steelforged_defender' WHERE `entry`=33236;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ironwork_cannon' WHERE `entry`=33264;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_corrupted_servitor' WHERE `entry`=33354;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_misguided_nymph' WHERE `entry`=33355;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_guardian_lasher' WHERE `entry`=33430;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_forest_swarmer' WHERE `entry`=33431;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_mangrove_ent' WHERE `entry`=33525;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_ironroot_lasher' WHERE `entry`=33526;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_natures_blade' WHERE `entry`=33527;  
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_guardian_of_life' WHERE `entry`=33528; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_storm_tempered_keeper' WHERE `entry` IN (33699, 33722); 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_charged_sphere' WHERE `entry`=33715;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_dark_rune_thunderer' WHERE `entry`=33754; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_dark_rune_ravager' WHERE `entry`=33755; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_faceless_horror' WHERE `entry`=33772; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_adherent' WHERE `entry`=33818; 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_frost_mage' WHERE `entry`=33819;  
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_pyromancer' WHERE `entry`=33820;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_enslaved_fire_elemental' WHERE `entry`=33838;  
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_guardian' WHERE `entry`=33822;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_slayer' WHERE `entry`=33823;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_twilight_shadowblade' WHERE `entry`=33824;
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_molten_colossus' WHERE `entry`=34069;  

DELETE FROM `spell_script_names` WHERE `spell_id`=63059;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (63059, 'spell_pollinate');

DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=62317 AND `spell_effect`=57807 AND `type`=1;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (62317, 57807, 1, 'Twilight Guardian - Link Devastate to Sunder Armor');

-- Other stuff
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~(33554432|262144) WHERE `entry`=34184;