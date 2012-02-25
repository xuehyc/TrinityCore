-- Fix spell 57934 Trick of the Trade, Schurkenhandel
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (57934, -59628);
INSERT INTO `spell_linked_spell` (spell_trigger, spell_effect, type, comment) VALUES
(57934, 59628, 0, 'Trick of the Trade'),
(57934, 57933, 0, 'Trick of the Trade'),
(-59628, -57934, 0, 'Trick of the Trade');