DELETE FROM `spell_group` WHERE `spell_id` IN (59690,59699);
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (57294,57399);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(57294,59690,2, 'Great Feast - Ranged Attack Power and Healing Power'),
(57399,59699,2, 'Fish Feast - Ranged Attack Power and Healing Power');
