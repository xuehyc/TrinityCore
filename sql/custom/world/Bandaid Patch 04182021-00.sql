/* Gnome Quest 27635 Decontamination Bandaid fix
https://www.wowhead.com/quest=27635/decontamination
https://www.wowhead.com/npc=46185/sanitron-500
restore original sql:
UPDATE `creature_template` SET `VehicleId`='1172' WHERE  `entry`=46185;
UPDATE `creature_template` SET `ScriptName`='' WHERE  `entry`=46185;
UPDATE `creature_template` SET `npcflag`='0' WHERE  `entry`=46185;
*/

UPDATE `creature_template` SET `VehicleId`='0' WHERE  `entry`=46185;
UPDATE `creature_template` SET `ScriptName`='sanitron500' WHERE  `entry`=46185;
UPDATE `creature_template` SET `npcflag`='1' WHERE  `entry`=46185;