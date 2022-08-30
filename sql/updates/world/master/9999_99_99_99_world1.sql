<<<<<<< HEAD
-- Update table `gossip_menu_option`
ALTER TABLE `gossip_menu_option` DROP `OptionType`;

-- Update default option
DELETE FROM `gossip_menu_option` WHERE `MenuID`=0;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionNpcFlag`, `Language`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(0, 1 , 1 , 'I want to browse your goods.', 3370, 128, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 2 , 2 , 'I''d like to travel by air.', 53141, 8192, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 3 , 3 , 'Train me.', 3266, 16, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 4 , 4 , 'Return me to life.', 2547, 16384, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 5 , 5 , 'I''d like to make this my home.', 50234, 65536, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 6 , 6 , 'Visit a bank.', 35513, 131072, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 7 , 7 , 'How do I form a guild?', 3413, 262144, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 8 , 8 , 'I want to create a guild crest.', 3415, 524288, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 9,  9 , 'I would like to go to the battleground.', 10355, 1048576, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 10, 10, 'I''d like to browse the items up for auction.', 52635, 2097152, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 12, 12, 'I''d like to stable my pet here.', 30181, 4194304, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 18, 18, 'I''d like to check my mail.', 146045, 67108864, 0, 0, 0, 0, 0, NULL, 0, 0),
(0, 34, 34, 'I want to transmogrify my gear.', 130510, 268435456, 0, 0, 0, 0, 0, NULL, 0, 0);

-- Drop "npc_experience" script use
UPDATE `creature_template` SET `ScriptName`='' WHERE `entry` IN (35364, 35365);
=======
-- 
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_zm_field_scout' WHERE `entry` IN(18581, 18564);
UPDATE `gossip_menu_option` SET `OptionNpcFlag`=1 WHERE `MenuID`=7724 AND `OptionID`=0;

DELETE FROM `gossip_menu_option` WHERE (`MenuID`=7722 AND `OptionID`=0);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `Language`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(7722, 0, 0, 'Give me a battle standard. I will take control of Twin Spire Ruins.', 15537, 1, 1, 0, 0, 0, 0, 0, NULL, 0, 45114); -- OptionBroadcastTextID: 15537 - 15539

UPDATE `gossip_menu_option` SET `VerifiedBuild`=45114 WHERE (`MenuID`=7722 AND `OptionID`=1);
>>>>>>> pr/12
