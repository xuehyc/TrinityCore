## Blessing of Kings & Blessing of Sanctuary Stack Fix
SET @group = 5000;

-- Insert Spells to Stackrules
DELETE FROM `spell_group` WHERE `id` = @group;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
 (@group, 20911), -- Blessing of Sanctuary
 (@group, 20217), -- Blessing of Kings
 (@group, 25898), -- Greater Blessing of Kings
 (@group, 25899), -- Greater Blessing of Sanctuary
 (@group, 69378); -- Blessing of Forgotten Kings

-- Set stack rule for group
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @group;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
 (@group, 1);