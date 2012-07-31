-- Yes, I know this is hack-like, but as long as it works.... :D
DELETE FROM `spell_group` WHERE `id`=64381;
DELETE FROM `spell_group_stack_rules` WHERE `group_id`=64381;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES (64381, 64381);
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES (64381, 1);