DELETE FROM `spell_script_names` WHERE ABS(`spell_id`) IN (66903, 67680);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(67680, 'spell_eadric_hoj'), -- Eadric's Hammer of Justice
(66903, 'spell_eadric_hoj');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 66905;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(66905, -66904, 0, 'Unflip HOJ Bar when Hammer was thrown');