	##	Stacking Curse of Weakness	##
	##	& Demoralizing Roar		##
	##	& Demoralizing Shout		##
	##	& Vindication			##
	
	-- Taking the lowest available Id over 1000 is 1012
	
SET @GroupID = 1012;

DELETE FROM `spell_group` WHERE `id` = @GroupID;

-- Take Spell IDs to one Group
-- We can use the lowest spell-ID for each spell cause ranks are in spell_ranks :)
INSERT INTO `spell_group` (
`id` ,
`spell_id` 
)
VALUES (
@GroupID, '99'		-- Demoralizing Roar
), (
@GroupID, '9452'	-- Vindication
), (
@GroupID, '1160'	-- Demoralizing Shout
), (
@GroupID, '12324'	-- Improved Demoralizing Shout
), (
@GroupID, '702'		-- Curse of Weakness
), (
@GroupID, '18179'	-- Improved Curse of Weakness
);

-- Set how many Spells of these should be stacking
-- in this case 1, only 1 should be active at any given time
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @GroupID;

INSERT INTO `spell_group_stack_rules` (
`group_id` ,
`stack_rule` 
)
VALUES (
@GroupID, '1'
);