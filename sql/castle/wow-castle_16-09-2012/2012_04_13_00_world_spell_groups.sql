-- fix stacking of cryptfever.
-- currently it stacks multiplicative with each dk (30%, 69% 120%, ....) 
-- while it should only provide a 30% bonus.
SET @group := 1118;

DELETE FROM spell_group WHERE id = @group AND spell_id = 49032;
INSERT INTO spell_group (id, spell_id) VALUES
(@group, 49032); -- cryptfever

DELETE FROM spell_group_stack_rules WHERE group_id = @group;
INSERT INTO spell_group_stack_rules (group_id, stack_rule) VALUES
(@group, 3); -- exclusive, same effect
