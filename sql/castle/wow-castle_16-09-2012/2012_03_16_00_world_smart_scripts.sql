-- Bugfix for quest 11658 (Plan B).
-- @DorianGrey: Based upon clean TDB46. Any modifications on the parameters below should be checked before using this fix.
-- Steps 1 and 2 are _not_ necessary for our database, but are useful for later updates (since the diff is smaller than before).

-- Step 1: Use the same gossip for Workers and Guards - doe not require more complex things...
-- Besides, gossip 9156 (previously used) is somehow contradicted in the conditions-table.
UPDATE `creature_template` SET `gossip_menu_id`=9155 WHERE `entry`=25343;

-- Step 2: Update smart_scripts - table due to the change above.
UPDATE `smart_scripts` SET `event_param1`=9155 WHERE  `entryorguid`=25343 AND `source_type`=0 AND `id`=0 AND `link`=1;

-- Step 3: Create access - condition. 
-- Automatically deletes the "only show for up to 10 items"-condition, which simply does not work - it ends up with an entry shown when all items are already in the players inventory...
DELETE FROM `conditions` WHERE `SourceGroup`=9155;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES (15, 9155, 0, 0, 9, 11658, 0, 0, 0, '', 'Quest 11658 - Gossip should only be accessible for players having this quest');
