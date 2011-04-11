-- Fix Item Brann's Communicator #40971
DELETE FROM spell_linked_spell WHERE spell_trigger = 61122;
INSERT INTO spell_linked_spell VALUES
(61122,55038,0,'summon Brann Bronzebeard on item use');
-- Update unit_flags of Brann
UPDATE creature_template SET unit_flags = unit_flags | 518 WHERE entry = 29579;