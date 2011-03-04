-- Sanctuary Linked Spells
DELETE FROM `spell_linked_spell` WHERE `spell_effect` = 54661 AND `spell_trigger` IN (32612, 5215, 1784, 1856);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES
('32612', '54661', '0', 'Invisibility Sanctuary Effect'),
('5215', '54661', '0', 'Prowl Sanctuary Effect'),
('1784', '54661', '0', 'Stealth Sanctuary Effect'),
('1856', '54661', '0', 'Stealth Sanctuary Effect');

