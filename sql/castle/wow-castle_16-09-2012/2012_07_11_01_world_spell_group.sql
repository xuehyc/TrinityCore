DELETE FROM spell_ranks WHERE first_spell_id = 57658;
INSERT INTO spell_ranks (first_spell_id, spell_id, rank) VALUES
(57658, 57658, 1), -- Totem of Wrath
(57658, 57660, 2), 
(57658, 57662, 3),
(57658, 57663, 4);

DELETE FROM spell_group WHERE id = 1120;
INSERT INTO spell_group (id, spell_id) VALUES
(1120, 57658), -- Totem of Wrath (Spellpower Part)
(1120, 48090); -- Demonic Pact

DELETE FROM spell_group_stack_rules WHERE group_id = 1120;
INSERT INTO spell_group_stack_rules (group_id, stack_rule) VALUES
(1120, 1); -- Exclusive, Same Effect doesn't work :(