-- Runecarver
DELETE FROM `gossip_menu` WHERE (`MenuID`=25682 AND `TextID`=40538);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) VALUES
(25682, 40538, 38556); -- 164937

DELETE FROM `gossip_menu_option` WHERE (`MenuID`=25682 AND `OptionID` IN (3,2));
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `OptionType`, `OptionNpcFlag`, `Language`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(25682, 3, 44, 'Me gustaría mejorar mi objeto legendario.', 0, 1, 1, 0, 0, 0, 0, 0, NULL, 0, 38556),
(25682, 2, 42, 'Quisiera crear un objeto legendario.', 0, 1, 1, 0, 0, 0, 0, 0, NULL, 0, 38556);

UPDATE `creature_template` SET `ScriptName`= 'npc_runecarver_open_npc' WHERE `ENTRY` = 164937;
