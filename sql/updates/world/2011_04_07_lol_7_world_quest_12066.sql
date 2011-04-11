-- Workaround for Quest 12066 The Focus on the Beach
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 47374; 
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES (47374, 47391, 'Ley Line Information');