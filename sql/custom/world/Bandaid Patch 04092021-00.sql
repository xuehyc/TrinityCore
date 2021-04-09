-- https://www.wowhead.com/quest=14395 Gasping for air Bandaid script fix for progression 
-- click on the drown men for credit
UPDATE `creature_template` SET `npcflag`='1', `ScriptName`='drowningwatchmen' WHERE  `entry`=36440;
-- https://www.wowhead.com/quest=14416/ The hungery etin Bandaid script fix for progression 
-- bring horse near lornacrowley then dismount and click her for credit.
UPDATE `creature_template` SET `ScriptName`='lornacrowley36457' WHERE  `entry`=36457;
