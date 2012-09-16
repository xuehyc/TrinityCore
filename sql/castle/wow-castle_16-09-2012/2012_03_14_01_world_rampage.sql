-- Fix spell 29801 Rampage / Toben warrior ability - clear buffs of other warriors on apply, fixes double buff on talent spec switch
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 29801;
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(29801, -29801, 2, 'Rampage');