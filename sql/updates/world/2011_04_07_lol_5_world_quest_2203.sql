-- Fix Quest 2203 Badlands Reagent Run II
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 9712; 
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (9712, 21029, 'Thaumaturgy Channel');