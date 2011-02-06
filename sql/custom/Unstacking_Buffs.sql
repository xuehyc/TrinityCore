        ##      Unstacking Multiple Buffs       ##


## K'iru's Song of Victory (Isle of Quel'Danas Zone Buff)
## Arcane Intellect/Brilliance
SET @GroupID = 1013;

DELETE FROM `spell_group` WHERE `id` = @GroupID;

INSERT INTO `spell_group` (
`id`,
`spell_id`
)
VALUES (
@GroupID, '46302'		-- K'iru's Song of Victory
), (
@GroupID, '1459'		-- Arcane Intellect (lowest rank, higher ranks via spell_rank)
), (
@GroupID, '23028'		-- Arcane Brilliance (lowest rank, higher ranks via spell_rank)
);

        -- Set Stacking to 1
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @GroupID;

INSERT INTO `spell_group_stack_rules` (
`group_id` ,
`stack_rule` 
)
VALUES (
@GroupID, '1'
);



## K'iru's Song of Victory (Isle of Quel'Danas Zone Buff)
## Power Word: Fortitude / Prayer of Fortitude
SET @GroupID = 1014;

DELETE FROM `spell_group` WHERE `id` = @GroupID;

INSERT INTO `spell_group` (
`id`,
`spell_id`
)
VALUES (
@GroupID, '46302'		-- K'iru's Song of Victory
), (
@GroupID, '1243'		-- Power Word: Fortitude (lowest rank, higher ranks via spell_rank)
), (
@GroupID, '21562'		-- Prayer of Fortitude (lowest rank, higher ranks via spell_rank)
);

        -- Set Stacking to 1
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @GroupID;

INSERT INTO `spell_group_stack_rules` (
`group_id` ,
`stack_rule` 
)
VALUES (
@GroupID, '1'
);


## Replenishment (57669) from multiple sources
## Hunting Party, Judgements of the Wise, Vampiric Touch, Improved Soul Leech, Enduring Winter
SET @GroupID = 1015;

DELETE FROM `spell_group` WHERE `id` = @GroupID;

INSERT INTO `spell_group` (
`id`,
`spell_id`
)
VALUES (
@GroupID, '57669'
);

        -- Set Stacking to 1
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @GroupID;

INSERT INTO `spell_group_stack_rules` (
`groupid`,
`stack_rule`
)
VALUES (
@GroupID, '1'
);