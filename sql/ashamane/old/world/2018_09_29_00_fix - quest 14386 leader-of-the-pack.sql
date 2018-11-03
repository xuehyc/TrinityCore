-- fix - quest 14386 leader-of-the-pack

UPDATE `creature_template` SET `KillCredit1`='14386', `npcflag`='2' WHERE  `entry`='36312';

DELETE FROM `creature` WHERE `guid` IN ('801510', '801700');
DELETE FROM `creature_addon` WHERE `guid`='801700';

DELETE FROM `creature_addon` WHERE `guid` IN (SELECT `guid` FROM `creature` WHERE `id` IN ('36505'));
DELETE FROM `creature` WHERE `id` IN ('36405');
