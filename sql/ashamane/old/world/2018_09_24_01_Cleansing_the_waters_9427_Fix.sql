-- Fix Quest cleansing-the-waters - 9427
DELETE FROM `creature` WHERE `id`=17000;

-- displayID original was 299, data1 was 25
UPDATE `gameobject_template` SET  `displayid`='0', `Data1`='50' WHERE  `entry`=300069;

UPDATE `gameobject` SET `spawntimesecs`='300',`position_x`='418.33', `position_y`='3461.26', `position_z`='82.99' WHERE  `guid`=49513;

DELETE FROM `smart_scripts` WHERE `entryorguid`	IN (17000, 1700000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`,`event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`,`action_param4`,`action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(17000, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 80, 1700000, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - Just Created - Cast Spaw'),
(17000, 0, 1, 0, 0, 0, 100, 0, 3000, 5000, 12000, 16000, 0, 11, 22678, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - Cast Fear'),
(1700000, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 11, 24240, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Aggonis - On Script - Cast Lightning'),
(1700000, 9, 1, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,'Script');


DELETE FROM `creature_text` WHERE `creatureID`=17000;
INSERT INTO `creature_text` (`creatureid`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `TextRange`, `comment`) VALUES 
(17000, 0, 0, 'Fools!  You seek to abjure my father\'s presence?  Death awaits you, mortals!', 12, 0, 100, 0, 0, 0, 0, 'Aggonis SAY');