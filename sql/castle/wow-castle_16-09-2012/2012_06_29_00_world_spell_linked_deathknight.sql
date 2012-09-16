-- Fix damage calculations for Deathknight / Todesritter talents Crypt Fever / Ebon Plaugebringer / Schwarzer Seuchenbringer / Gruftfieber
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 65142;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
(65142, -65142, 2, 'Deathknight trigger spell for talents Crypt Fever / Ebon Plaguebringer - only stack once');