-- Add additional target selection script, i.e. a SpellScript that is used aside the AuraScript that already got attached to
-- these spells.
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_xt002_gravity_bomb_aura_target';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(63024, 'spell_xt002_gravity_bomb_aura_target'), 
(64234, 'spell_xt002_gravity_bomb_aura_target');

-- Remove unconfirmed flag.
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~32768 WHERE `entry` IN (33329, 33995);