-- Remover Vengeance Feral
-- Remover Vengeance talents
DELETE FROM `spell_linked_spell` WHERE `spell_effect` = -76691;
INSERT INTO spell_linked_spell(spell_trigger, spell_effect,`type`,`comment`) VALUES 
(768, -76691, 0,'Remover Vengeance feral'),
(63644, -76691, 0, 'Vengeance remove when change talents'),
(63645, -76691, 0, 'Vengeance remove when change talents');
