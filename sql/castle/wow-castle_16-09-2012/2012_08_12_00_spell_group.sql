-- Mana Spring shouldn't stack with Blessing of Wisdom
DELETE FROM spell_group WHERE spell_id = 5677;
INSERT INTO spell_group (id, spell_id) VALUES
(1005, 5677);