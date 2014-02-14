UPDATE `creature_template` SET `type_flags`=16777216, `unit_class`=8 WHERE  `entry`=31216; -- Mirror Image (Fix Casting problem)

DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=55342 AND `spell_effect`=58832;
INSERT INTO `spell_linked_spell` VALUES (55342, 58832, 0, 'Mirror Image - Summon');
