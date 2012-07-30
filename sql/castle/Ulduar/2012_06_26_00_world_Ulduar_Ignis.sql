-- Ignis::Spell::Flame_Jets -> Target filtering.
DELETE FROM `spell_script_names` WHERE `spell_id` IN (62680, 63472);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES 
(62680, 'spell_ignis_flame_jets'),
(63472, 'spell_ignis_flame_jets');
