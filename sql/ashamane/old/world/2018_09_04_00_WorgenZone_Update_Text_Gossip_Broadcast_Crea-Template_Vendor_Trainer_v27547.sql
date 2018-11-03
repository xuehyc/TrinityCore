-- IN DB

-- text part - TESTED AND IN DB
DELETE FROM `npc_text` WHERE `ID` IN (15443 /*15443*/, 16330 /*16330*/, 14847 /*14847*/);
INSERT INTO `npc_text` (`ID`, `Probability0`, `Probability1`, `Probability2`, `Probability3`, `Probability4`, `Probability5`, `Probability6`, `Probability7`, `BroadcastTextId0`, `BroadcastTextId1`, `BroadcastTextId2`, `BroadcastTextId3`, `BroadcastTextId4`, `BroadcastTextId5`, `BroadcastTextId6`, `BroadcastTextId7`, `VerifiedBuild`) VALUES
(15443, 1, 0, 0, 0, 0, 0, 0, 0, 38799, 0, 0, 0, 0, 0, 0, 0, 27547), -- 15443
(16330, 1, 0, 0, 0, 0, 0, 0, 0, 42896, 0, 0, 0, 0, 0, 0, 0, 27547), -- 16330
(14847, 1, 0, 0, 0, 0, 0, 0, 0, 36075, 0, 0, 0, 0, 0, 0, 0, 27547); -- 14847

-- gossip part

DELETE FROM `gossip_menu` WHERE (`MenuId`=13111 AND `TextId`=18430) OR (`MenuId`=11061 AND `TextId`=15377) OR (`MenuId`=11061 AND `TextId`=15443) OR (`MenuId`=14175 AND `TextId`=15029) OR (`MenuId`=11672 AND `TextId`=16330) OR (`MenuId`=14290 AND `TextId`=14835) OR (`MenuId`=14176 AND `TextId`=14832) OR (`MenuId`=14177 AND `TextId`=14847) OR (`MenuId`=11794 AND `TextId`=16542) OR (`MenuId`=11795 AND `TextId`=16543) OR (`MenuId`=11070 AND `TextId`=15395);
INSERT INTO `gossip_menu` (`MenuId`, `TextId`, `VerifiedBuild`) VALUES
(13111, 18430, 27547), -- 55285 (Astrid Langstrump)
(11061, 15377, 27547), -- 38553 (Krennan Aranas)
(11061, 15443, 27547), -- 38553 (Krennan Aranas)
(14175, 15029, 27547), -- 38467 (Huntsman Blake)
(11672, 16330, 27547), -- 42953 (Benjamin Sykes)
(14290, 14835, 27547), -- 38799 (Celestine of the Harvest)
(14176, 14832, 27547), -- 38793 (Sergeant Cleese)
(14177, 14847, 27547), -- 38797 (Vitus Darkwalker)
(11794, 16542, 27547), -- 44125 (Chris Moller)
(11795, 16543, 27547), -- 44125 (Chris Moller)
(11070, 15395, 27547); -- 34936 (Gwen Armstead)

UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=4302 AND `TextId`=5474); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=6944 AND `TextId`=7778); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=3185 AND `TextId`=5844); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=4302 AND `TextId`=5474); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12609 AND `TextId`=17749); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10837 AND `TextId`=14841); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10838 AND `TextId`=14845); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=11079 AND `TextId`=15408); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10843 AND `TextId`=14843); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5665 AND `TextId`=6961); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10838 AND `TextId`=14845); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10809 AND `TextId`=14986); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10809 AND `TextId`=14986); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10809 AND `TextId`=14986); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10833 AND `TextId`=15025); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10833 AND `TextId`=15025); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10838 AND `TextId`=14845); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10837 AND `TextId`=14841); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10842 AND `TextId`=15035); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `TextId`=7028); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `TextId`=7015); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10833 AND `TextId`=15025); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10843 AND `TextId`=14843); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10827 AND `TextId`=15013); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10827 AND `TextId`=15013); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10827 AND `TextId`=15013); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10773 AND `TextId`=14938); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10773 AND `TextId`=14938); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10827 AND `TextId`=15013); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10773 AND `TextId`=14938); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10773 AND `TextId`=14938); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10838 AND `TextId`=14845); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10842 AND `TextId`=15035); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `TextId`=7028); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `TextId`=7015); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10837 AND `TextId`=14841); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10842 AND `TextId`=15035); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `TextId`=13584); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `TextId`=7028); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `TextId`=7028); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `TextId`=7015); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `TextId`=7021); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10843 AND `TextId`=14843); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10838 AND `TextId`=14845); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10837 AND `TextId`=14841); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10843 AND `TextId`=14843); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12195 AND `TextId`=17134); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `TextId`=17127); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `TextId`=17135); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `TextId`=17131); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `TextId`=17127); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12198 AND `TextId`=17137); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `TextId`=17130); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `TextId`=17130); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `TextId`=17135); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `TextId`=17131); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `TextId`=17130); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `TextId`=17128); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `TextId`=17126); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `TextId`=17125); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=14172 AND `TextId`=14832); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `TextId`=580); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10676 AND `TextId`=14798); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=14172 AND `TextId`=14832); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10698 AND `TextId`=14841); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10700 AND `TextId`=14845); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10699 AND `TextId`=14843); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=14174 AND `TextId`=14839); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `TextId`=15034); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10676 AND `TextId`=14798); -- 0
UPDATE `gossip_menu` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10676 AND `TextId`=14798); -- 0

DELETE FROM `gossip_menu_option` WHERE (`MenuId`=11672 AND `OptionIndex`=0) OR (`MenuId`=12195 AND `OptionIndex`=4) OR (`MenuId`=12195 AND `OptionIndex`=0) OR (`MenuId`=12186 AND `OptionIndex`=4) OR (`MenuId`=12186 AND `OptionIndex`=0) OR (`MenuId`=12196 AND `OptionIndex`=4) OR (`MenuId`=12196 AND `OptionIndex`=0) OR (`MenuId`=12188 AND `OptionIndex`=4) OR (`MenuId`=12188 AND `OptionIndex`=0) OR (`MenuId`=12191 AND `OptionIndex`=0) OR (`MenuId`=12185 AND `OptionIndex`=4) OR (`MenuId`=12185 AND `OptionIndex`=0) OR (`MenuId`=12198 AND `OptionIndex`=4) OR (`MenuId`=12198 AND `OptionIndex`=0) OR (`MenuId`=12190 AND `OptionIndex`=4) OR (`MenuId`=12190 AND `OptionIndex`=0);
INSERT INTO `gossip_menu_option` (`MenuId`, `OptionIndex`, `OptionIcon`, `OptionText`, `OptionBroadcastTextId`, `VerifiedBuild`) VALUES
(11672, 0, 1, 'I would like to buy from you.', 2583, 27547), -- NEED TO CHECK HOW COULD ADD THESE : OptionBroadcastTextID: 6399 - 7142 - 9992 - 14967
(12195, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12195, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12186, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12186, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12196, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12196, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12188, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12188, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12191, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12185, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12185, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12198, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12198, 0, 3, 'Train me in Alchemy.', 47109, 27547),
(12190, 4, 3, 'Train me in Herbalism.', 47112, 27547),
(12190, 0, 3, 'Train me in Alchemy.', 47109, 27547);

UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=4302 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=12271, `VerifiedBuild`=27547 WHERE (`MenuId`=6944 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=13111 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=4302 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12609 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=38484, `VerifiedBuild`=27547 WHERE (`MenuId`=11061 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5665 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10842 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44404, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44403, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44406, `VerifiedBuild`=27547 WHERE (`MenuId`=11795 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44404, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44403, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44406, `VerifiedBuild`=27547 WHERE (`MenuId`=11795 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44404, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44403, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44404, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=44403, `VerifiedBuild`=27547 WHERE (`MenuId`=11794 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10842 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10842 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=64115, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=2);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=56613, `VerifiedBuild`=27547 WHERE (`MenuId`=9821 AND `OptionIndex`=1);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=5853 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12195 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12195 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12195 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12195 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=19);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=18);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=17);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=16);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=19);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=18);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=17);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=16);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12186 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12198 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12198 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12198 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12198 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12196 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47109, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12191 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12190 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=47112, `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=4);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=15);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12188 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=14);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=13);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12185 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=12);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=12180 AND `OptionIndex`=11);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `OptionBroadcastTextId`=2547, `VerifiedBuild`=27547 WHERE (`MenuId`=83 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);
UPDATE `gossip_menu_option` SET `VerifiedBuild`=27547 WHERE (`MenuId`=10841 AND `OptionIndex`=0);

DELETE FROM `gossip_menu_option_action` WHERE (`MenuId`=11795 AND `OptionIndex`=0) OR (`MenuId`=11794 AND `OptionIndex`=1);
INSERT INTO `gossip_menu_option_action` (`MenuId`, `OptionIndex`, `ActionMenuId`, `ActionPoiId`) VALUES
(11795, 0, 11794, 44125),
(11794, 1, 11795, 44125);

DELETE FROM points_of_interest WHERE ID = 44125;
INSERT INTO points_of_interest (ID, PositionX, PositionY, Icon, Flags, Importance, Name, VerifiedBuild) VALUES
(44125, -1884.02, 2244.08, 7, 99, 0, "Chris Moller Pie Vendor", 27547);

DELETE FROM `gossip_menu_option_trainer` WHERE (`MenuId`=12180 AND `OptionIndex`=0) OR (`MenuId`=12180 AND `OptionIndex`=4);
INSERT INTO `gossip_menu_option_trainer` (`MenuId`, `OptionIndex`, `TrainerId`) VALUES
(12180, 0, 59),
(12180, 4, 388);

UPDATE `gossip_menu_option_trainer` SET `TrainerId`=877 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option_trainer` SET `TrainerId`=877 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option_trainer` SET `TrainerId`=877 WHERE (`MenuId`=5855 AND `OptionIndex`=0);
UPDATE `gossip_menu_option_trainer` SET `TrainerId`=877 WHERE (`MenuId`=5855 AND `OptionIndex`=0);

DELETE FROM `trainer` WHERE `Id`=877;
INSERT INTO `trainer` (`Id`, `Type`, `Greeting`, `VerifiedBuild`) VALUES
(877, 2, 'Here, let me show you how to bind those wounds....', 27547);

UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=46;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=59;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=10;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=388;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=136;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=136;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=136;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=136;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=102;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=103;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=390;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=387;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=59;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=390;
UPDATE `trainer` SET `VerifiedBuild`=27547 WHERE `Id`=388;

DELETE FROM `trainer_spell` WHERE (`TrainerId`=59 AND `SpellId`=264212) OR (`TrainerId`=10 AND `SpellId`=271617) OR (`TrainerId`=10 AND `SpellId`=271663) OR (`TrainerId`=10 AND `SpellId`=271673) OR (`TrainerId`=10 AND `SpellId`=271659) OR (`TrainerId`=10 AND `SpellId`=271657) OR (`TrainerId`=10 AND `SpellId`=271661) OR (`TrainerId`=10 AND `SpellId`=271665) OR (`TrainerId`=388 AND `SpellId`=265820) OR (`TrainerId`=877 AND `SpellId`=7928) OR (`TrainerId`=877 AND `SpellId`=7929) OR (`TrainerId`=877 AND `SpellId`=3278) OR (`TrainerId`=877 AND `SpellId`=3277) OR (`TrainerId`=877 AND `SpellId`=3276) OR (`TrainerId`=877 AND `SpellId`=18630) OR (`TrainerId`=877 AND `SpellId`=10840) OR (`TrainerId`=877 AND `SpellId`=10841) OR (`TrainerId`=877 AND `SpellId`=18629) OR (`TrainerId`=102 AND `SpellId`=264478) OR (`TrainerId`=103 AND `SpellId`=264578) OR (`TrainerId`=390 AND `SpellId`=265856) OR (`TrainerId`=387 AND `SpellId`=264495);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(59, 264212, 9, 0, 0, 0, 0, 0, 5, 27547),
(10, 271617, 90, 0, 0, 0, 0, 0, 5, 27547),
(10, 271663, 225000, 356, 1, 0, 0, 0, 78, 27547),
(10, 271673, 360000, 356, 1, 0, 0, 0, 98, 27547),
(10, 271659, 135000, 356, 1, 0, 0, 0, 58, 27547),
(10, 271657, 90000, 356, 1, 0, 0, 0, 58, 27547),
(10, 271661, 180000, 356, 1, 0, 0, 0, 78, 27547),
(10, 271665, 270000, 356, 1, 0, 0, 0, 88, 27547),
(388, 265820, 9, 0, 0, 0, 0, 0, 5, 27547),
(877, 7928, 4750, 2540, 150, 0, 0, 0, 0, 27547),
(877, 7929, 4750, 2540, 180, 0, 0, 0, 0, 27547),
(877, 3278, 950, 2540, 115, 0, 0, 0, 0, 27547),
(877, 3277, 238, 2540, 80, 0, 0, 0, 0, 27547),
(877, 3276, 95, 2540, 40, 0, 0, 0, 0, 27547),
(877, 18630, 19000, 2540, 290, 0, 0, 0, 0, 27547),
(877, 10840, 9500, 2540, 210, 0, 0, 0, 0, 27547),
(877, 10841, 9500, 2540, 240, 0, 0, 0, 0, 27547),
(877, 18629, 19000, 2540, 260, 0, 0, 0, 0, 27547),
(102, 264478, 10, 0, 0, 0, 0, 0, 5, 27547),
(103, 264578, 10, 165, 0, 0, 0, 0, 5, 27547),
(390, 265856, 10, 0, 0, 0, 0, 0, 5, 27547),
(387, 264495, 10, 0, 0, 0, 0, 0, 5, 27547);

UPDATE `trainer_spell` SET `ReqAbility1`=33388, `VerifiedBuild`=27547 WHERE (`TrainerId`=46 AND `SpellId`=33392);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=46 AND `SpellId`=33389);
UPDATE `trainer_spell` SET `MoneyCost`=90, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2331);
UPDATE `trainer_spell` SET `MoneyCost`=225, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2334);
UPDATE `trainer_spell` SET `MoneyCost`=45, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=3170);
UPDATE `trainer_spell` SET `MoneyCost`=900, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2337);
UPDATE `trainer_spell` SET `MoneyCost`=135, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2332);
UPDATE `trainer_spell` SET `MoneyCost`=285000, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264639);
UPDATE `trainer_spell` SET `MoneyCost`=28500, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88015);
UPDATE `trainer_spell` SET `MoneyCost`=33250, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88006);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264633);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6412);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6415);
UPDATE `trainer_spell` SET `MoneyCost`=76, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=93741);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6499);
UPDATE `trainer_spell` SET `MoneyCost`=190, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2544);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2541);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2539);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=37836);
UPDATE `trainer_spell` SET `MoneyCost`=428, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3399);
UPDATE `trainer_spell` SET `MoneyCost`=285, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6500);
UPDATE `trainer_spell` SET `MoneyCost`=142, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2546);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3400);
UPDATE `trainer_spell` SET `MoneyCost`=4750, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18238);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=4094);
UPDATE `trainer_spell` SET `MoneyCost`=3800, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=21175);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46684);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46688);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18244);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18243);
UPDATE `trainer_spell` SET `MoneyCost`=5700, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18240);
UPDATE `trainer_spell` SET `MoneyCost`=285000, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264639);
UPDATE `trainer_spell` SET `MoneyCost`=28500, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88015);
UPDATE `trainer_spell` SET `MoneyCost`=33250, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88006);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264633);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6412);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6415);
UPDATE `trainer_spell` SET `MoneyCost`=76, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=93741);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6499);
UPDATE `trainer_spell` SET `MoneyCost`=190, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2544);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2541);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2539);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=37836);
UPDATE `trainer_spell` SET `MoneyCost`=428, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3399);
UPDATE `trainer_spell` SET `MoneyCost`=285, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6500);
UPDATE `trainer_spell` SET `MoneyCost`=142, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2546);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3400);
UPDATE `trainer_spell` SET `MoneyCost`=4750, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18238);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=4094);
UPDATE `trainer_spell` SET `MoneyCost`=3800, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=21175);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46684);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46688);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18244);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18243);
UPDATE `trainer_spell` SET `MoneyCost`=5700, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18240);
UPDATE `trainer_spell` SET `MoneyCost`=285000, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264639);
UPDATE `trainer_spell` SET `MoneyCost`=28500, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88015);
UPDATE `trainer_spell` SET `MoneyCost`=33250, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88006);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264633);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6412);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6415);
UPDATE `trainer_spell` SET `MoneyCost`=76, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=93741);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6499);
UPDATE `trainer_spell` SET `MoneyCost`=190, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2544);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2541);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2539);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=37836);
UPDATE `trainer_spell` SET `MoneyCost`=428, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3399);
UPDATE `trainer_spell` SET `MoneyCost`=285, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6500);
UPDATE `trainer_spell` SET `MoneyCost`=142, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2546);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3400);
UPDATE `trainer_spell` SET `MoneyCost`=4750, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18238);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=4094);
UPDATE `trainer_spell` SET `MoneyCost`=3800, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=21175);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46684);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46688);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18244);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18243);
UPDATE `trainer_spell` SET `MoneyCost`=5700, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18240);
UPDATE `trainer_spell` SET `MoneyCost`=285000, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264639);
UPDATE `trainer_spell` SET `MoneyCost`=28500, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88015);
UPDATE `trainer_spell` SET `MoneyCost`=33250, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=88006);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=264633);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6412);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6415);
UPDATE `trainer_spell` SET `MoneyCost`=76, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=93741);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6499);
UPDATE `trainer_spell` SET `MoneyCost`=190, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2544);
UPDATE `trainer_spell` SET `MoneyCost`=95, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2541);
UPDATE `trainer_spell` SET `MoneyCost`=48, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2539);
UPDATE `trainer_spell` SET `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=37836);
UPDATE `trainer_spell` SET `MoneyCost`=428, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3399);
UPDATE `trainer_spell` SET `MoneyCost`=285, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=6500);
UPDATE `trainer_spell` SET `MoneyCost`=142, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=2546);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=3400);
UPDATE `trainer_spell` SET `MoneyCost`=4750, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18238);
UPDATE `trainer_spell` SET `MoneyCost`=475, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=4094);
UPDATE `trainer_spell` SET `MoneyCost`=3800, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=21175);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46684);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=46688);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18244);
UPDATE `trainer_spell` SET `MoneyCost`=6175, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18243);
UPDATE `trainer_spell` SET `MoneyCost`=5700, `VerifiedBuild`=27547 WHERE (`TrainerId`=136 AND `SpellId`=18240);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=7430);
UPDATE `trainer_spell` SET `MoneyCost`=238, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=3931);
UPDATE `trainer_spell` SET `MoneyCost`=238, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=3929);
UPDATE `trainer_spell` SET `MoneyCost`=190, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=3977);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=3925);
UPDATE `trainer_spell` SET `MoneyCost`=124, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=3923);
UPDATE `trainer_spell` SET `MoneyCost`=109, `ReqSkillLine`=2506, `VerifiedBuild`=27547 WHERE (`TrainerId`=102 AND `SpellId`=3922);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=226106);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=226107);
UPDATE `trainer_spell` SET `MoneyCost`=95, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=226105);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=9065);
UPDATE `trainer_spell` SET `MoneyCost`=190, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=3759);
UPDATE `trainer_spell` SET `MoneyCost`=95, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=2162);
UPDATE `trainer_spell` SET `MoneyCost`=95, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=2161);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=3756);
UPDATE `trainer_spell` SET `MoneyCost`=95, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=2160);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=3816);
UPDATE `trainer_spell` SET `MoneyCost`=71, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=3753);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2532, `VerifiedBuild`=27547 WHERE (`TrainerId`=103 AND `SpellId`=2153);
UPDATE `trainer_spell` SET `MoneyCost`=380, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=50598);
UPDATE `trainer_spell` SET `MoneyCost`=380, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=50605);
UPDATE `trainer_spell` SET `MoneyCost`=380, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=50612);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=52739);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=52843);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=48248);
UPDATE `trainer_spell` SET `MoneyCost`=285, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=53462);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=58484);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2514, `VerifiedBuild`=27547 WHERE (`TrainerId`=387 AND `SpellId`=58472);
UPDATE `trainer_spell` SET `MoneyCost`=95, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2331);
UPDATE `trainer_spell` SET `MoneyCost`=238, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2334);
UPDATE `trainer_spell` SET `MoneyCost`=48, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=3170);
UPDATE `trainer_spell` SET `MoneyCost`=950, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2337);
UPDATE `trainer_spell` SET `MoneyCost`=142, `ReqSkillLine`=2485, `VerifiedBuild`=27547 WHERE (`TrainerId`=59 AND `SpellId`=2332);

DELETE FROM `creature_default_trainer` WHERE `CreatureId`=4753;
INSERT INTO `creature_default_trainer` (`CreatureId`, `TrainerId`) VALUES
(4753, 46);

-- NPC Vendor, creature equip

UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=55285 AND `item`=73839 AND `ExtendedCost`=0 AND `type`=1); -- Swift Mountain Horse
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=55285 AND `item`=73838 AND `ExtendedCost`=0 AND `type`=1); -- Mountain Horse
UPDATE `npc_vendor` SET `slot`=5, `PlayerConditionID`=12242, `VerifiedBuild`=27547 WHERE (`entry`=50307 AND `item`=64894 AND `ExtendedCost`=0 AND `type`=1); -- Shroud of Gilneas
UPDATE `npc_vendor` SET `slot`=4, `PlayerConditionID`=12242, `VerifiedBuild`=27547 WHERE (`entry`=50307 AND `item`=64893 AND `ExtendedCost`=0 AND `type`=1); -- Cape of Gilneas
UPDATE `npc_vendor` SET `slot`=3, `PlayerConditionID`=12242, `VerifiedBuild`=27547 WHERE (`entry`=50307 AND `item`=64892 AND `ExtendedCost`=0 AND `type`=1); -- Mantle of Gilneas
UPDATE `npc_vendor` SET `slot`=2, `PlayerConditionID`=12241, `VerifiedBuild`=27547 WHERE (`entry`=50307 AND `item`=67532 AND `ExtendedCost`=0 AND `type`=1); -- Gilnean Satchel
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=50307 AND `item`=64882 AND `ExtendedCost`=0 AND `type`=1); -- Gilneas Tabard
UPDATE `npc_vendor` SET `slot`=5, `PlayerConditionID`=12238, `VerifiedBuild`=27547 WHERE (`entry`=50305 AND `item`=64887 AND `ExtendedCost`=0 AND `type`=1); -- Cape of Darnassus
UPDATE `npc_vendor` SET `slot`=4, `PlayerConditionID`=12238, `VerifiedBuild`=27547 WHERE (`entry`=50305 AND `item`=64888 AND `ExtendedCost`=0 AND `type`=1); -- Mantle of Darnassus
UPDATE `npc_vendor` SET `slot`=3, `PlayerConditionID`=12238, `VerifiedBuild`=27547 WHERE (`entry`=50305 AND `item`=64886 AND `ExtendedCost`=0 AND `type`=1); -- Shroud of Darnassus
UPDATE `npc_vendor` SET `slot`=2, `PlayerConditionID`=12237, `VerifiedBuild`=27547 WHERE (`entry`=50305 AND `item`=67526 AND `ExtendedCost`=0 AND `type`=1); -- Darnassian Satchel
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=50305 AND `item`=45579 AND `ExtendedCost`=0 AND `type`=1); -- Darnassus Tabard
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=38783 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=42853 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=68993 AND `item`=37460 AND `ExtendedCost`=0 AND `type`=1); -- Rope Pet Leash
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=68993 AND `item`=37460 AND `ExtendedCost`=0 AND `type`=1); -- Rope Pet Leash
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=8952 AND `ExtendedCost`=0 AND `type`=1); -- Roasted Quail
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=4599 AND `ExtendedCost`=0 AND `type`=1); -- Cured Ham Steak
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=3771 AND `ExtendedCost`=0 AND `type`=1); -- Wild Hog Shank
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=3770 AND `ExtendedCost`=0 AND `type`=1); -- Mutton Chop
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=2287 AND `ExtendedCost`=0 AND `type`=1); -- Haunch of Meat
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=117 AND `ExtendedCost`=0 AND `type`=1); -- Tough Jerky
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=8952 AND `ExtendedCost`=0 AND `type`=1); -- Roasted Quail
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=4599 AND `ExtendedCost`=0 AND `type`=1); -- Cured Ham Steak
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=3771 AND `ExtendedCost`=0 AND `type`=1); -- Wild Hog Shank
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=3770 AND `ExtendedCost`=0 AND `type`=1); -- Mutton Chop
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=2287 AND `ExtendedCost`=0 AND `type`=1); -- Haunch of Meat
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=42953 AND `item`=117 AND `ExtendedCost`=0 AND `type`=1); -- Tough Jerky
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=68993 AND `item`=37460 AND `ExtendedCost`=0 AND `type`=1); -- Rope Pet Leash
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=43558 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=8, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2493 AND `ExtendedCost`=0 AND `type`=1); -- Wooden Mallet
UPDATE `npc_vendor` SET `slot`=7, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2490 AND `ExtendedCost`=0 AND `type`=1); -- Tomahawk
UPDATE `npc_vendor` SET `slot`=6, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2488 AND `ExtendedCost`=0 AND `type`=1); -- Gladius
UPDATE `npc_vendor` SET `slot`=5, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2495 AND `ExtendedCost`=0 AND `type`=1); -- Walking Stick
UPDATE `npc_vendor` SET `slot`=4, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2494 AND `ExtendedCost`=0 AND `type`=1); -- Stiletto
UPDATE `npc_vendor` SET `slot`=3, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2491 AND `ExtendedCost`=0 AND `type`=1); -- Large Axe
UPDATE `npc_vendor` SET `slot`=2, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2492 AND `ExtendedCost`=0 AND `type`=1); -- Cudgel
UPDATE `npc_vendor` SET `slot`=1, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2489 AND `ExtendedCost`=0 AND `type`=1); -- Two-Handed Sword
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=68993 AND `item`=37460 AND `ExtendedCost`=0 AND `type`=1); -- Rope Pet Leash
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36779 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=44125 AND `item`=60379 AND `ExtendedCost`=0 AND `type`=1); -- Mud Pie
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=44125 AND `item`=60378 AND `ExtendedCost`=0 AND `type`=1); -- Plumpkin Pie
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=44125 AND `item`=60377 AND `ExtendedCost`=0 AND `type`=1); -- Lots 'o Meat Pie
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=44125 AND `item`=60376 AND `ExtendedCost`=0 AND `type`=1); -- Very Berry Pie
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=44125 AND `item`=60375 AND `ExtendedCost`=0 AND `type`=1); -- Cheery Cherry Pie
UPDATE `npc_vendor` SET `slot`=8, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2493 AND `ExtendedCost`=0 AND `type`=1); -- Wooden Mallet
UPDATE `npc_vendor` SET `slot`=7, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2490 AND `ExtendedCost`=0 AND `type`=1); -- Tomahawk
UPDATE `npc_vendor` SET `slot`=6, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2488 AND `ExtendedCost`=0 AND `type`=1); -- Gladius
UPDATE `npc_vendor` SET `slot`=5, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2495 AND `ExtendedCost`=0 AND `type`=1); -- Walking Stick
UPDATE `npc_vendor` SET `slot`=4, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2494 AND `ExtendedCost`=0 AND `type`=1); -- Stiletto
UPDATE `npc_vendor` SET `slot`=3, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2491 AND `ExtendedCost`=0 AND `type`=1); -- Large Axe
UPDATE `npc_vendor` SET `slot`=2, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2492 AND `ExtendedCost`=0 AND `type`=1); -- Cudgel
UPDATE `npc_vendor` SET `slot`=1, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2489 AND `ExtendedCost`=0 AND `type`=1); -- Two-Handed Sword
UPDATE `npc_vendor` SET `slot`=8, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2493 AND `ExtendedCost`=0 AND `type`=1); -- Wooden Mallet
UPDATE `npc_vendor` SET `slot`=7, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2490 AND `ExtendedCost`=0 AND `type`=1); -- Tomahawk
UPDATE `npc_vendor` SET `slot`=6, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2488 AND `ExtendedCost`=0 AND `type`=1); -- Gladius
UPDATE `npc_vendor` SET `slot`=5, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2495 AND `ExtendedCost`=0 AND `type`=1); -- Walking Stick
UPDATE `npc_vendor` SET `slot`=4, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2494 AND `ExtendedCost`=0 AND `type`=1); -- Stiletto
UPDATE `npc_vendor` SET `slot`=3, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2491 AND `ExtendedCost`=0 AND `type`=1); -- Large Axe
UPDATE `npc_vendor` SET `slot`=2, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2492 AND `ExtendedCost`=0 AND `type`=1); -- Cudgel
UPDATE `npc_vendor` SET `slot`=1, `IgnoreFiltering`=1, `VerifiedBuild`=27547 WHERE (`entry`=36717 AND `item`=2489 AND `ExtendedCost`=0 AND `type`=1); -- Two-Handed Sword
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=68993 AND `item`=37460 AND `ExtendedCost`=0 AND `type`=1); -- Rope Pet Leash
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `VerifiedBuild`=27547 WHERE (`entry`=36695 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water
UPDATE `npc_vendor` SET `slot`=25, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=39505 AND `ExtendedCost`=0 AND `type`=1); -- Virtuoso Inking Set
UPDATE `npc_vendor` SET `slot`=24, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=20815 AND `ExtendedCost`=0 AND `type`=1); -- Jeweler's Kit
UPDATE `npc_vendor` SET `slot`=23, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=39354 AND `ExtendedCost`=0 AND `type`=1); -- Light Parchment
UPDATE `npc_vendor` SET `slot`=22, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6260 AND `ExtendedCost`=0 AND `type`=1); -- Blue Dye
UPDATE `npc_vendor` SET `slot`=21, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2324 AND `ExtendedCost`=0 AND `type`=1); -- Bleach
UPDATE `npc_vendor` SET `slot`=20, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2604 AND `ExtendedCost`=0 AND `type`=1); -- Red Dye
UPDATE `npc_vendor` SET `slot`=19, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6529 AND `ExtendedCost`=0 AND `type`=1); -- Shiny Bauble
UPDATE `npc_vendor` SET `slot`=18, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4289 AND `ExtendedCost`=0 AND `type`=1); -- Salt
UPDATE `npc_vendor` SET `slot`=17, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=3371 AND `ExtendedCost`=0 AND `type`=1); -- Crystal Vial
UPDATE `npc_vendor` SET `slot`=16, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2880 AND `ExtendedCost`=0 AND `type`=1); -- Weak Flux
UPDATE `npc_vendor` SET `slot`=15, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2320 AND `ExtendedCost`=0 AND `type`=1); -- Coarse Thread
UPDATE `npc_vendor` SET `slot`=14, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=30817 AND `ExtendedCost`=0 AND `type`=1); -- Simple Flour
UPDATE `npc_vendor` SET `slot`=13, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2678 AND `ExtendedCost`=0 AND `type`=1); -- Mild Spices
UPDATE `npc_vendor` SET `slot`=12, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6217 AND `ExtendedCost`=0 AND `type`=1); -- Copper Rod
UPDATE `npc_vendor` SET `slot`=11, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=6256 AND `ExtendedCost`=0 AND `type`=1); -- Fishing Pole
UPDATE `npc_vendor` SET `slot`=10, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=5956 AND `ExtendedCost`=0 AND `type`=1); -- Blacksmith Hammer
UPDATE `npc_vendor` SET `slot`=9, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=85663 AND `ExtendedCost`=0 AND `type`=1); -- Herbalist's Spade
UPDATE `npc_vendor` SET `slot`=8, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=2901 AND `ExtendedCost`=0 AND `type`=1); -- Mining Pick
UPDATE `npc_vendor` SET `slot`=7, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=7005 AND `ExtendedCost`=0 AND `type`=1); -- Skinning Knife
UPDATE `npc_vendor` SET `slot`=6, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=5042 AND `ExtendedCost`=0 AND `type`=1); -- Red Ribboned Wrapping Paper
UPDATE `npc_vendor` SET `slot`=5, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4470 AND `ExtendedCost`=0 AND `type`=1); -- Simple Wood
UPDATE `npc_vendor` SET `slot`=4, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4498 AND `ExtendedCost`=0 AND `type`=1); -- Brown Leather Satchel
UPDATE `npc_vendor` SET `slot`=3, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4496 AND `ExtendedCost`=0 AND `type`=1); -- Small Brown Pouch
UPDATE `npc_vendor` SET `slot`=2, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=4540 AND `ExtendedCost`=0 AND `type`=1); -- Tough Hunk of Bread
UPDATE `npc_vendor` SET `slot`=1, `VerifiedBuild`=27547 WHERE (`entry`=38853 AND `item`=159 AND `ExtendedCost`=0 AND `type`=1); -- Refreshing Spring Water

-- Creature equip template update

DELETE FROM `creature_equip_template` WHERE (`CreatureID`=37067 AND `ID`=3) OR (`CreatureID`=37067 AND `ID`=2);
INSERT INTO `creature_equip_template` (`CreatureID`, `ID`, `ItemID1`, `AppearanceModID1`, `ItemVisual1`, `ItemID2`, `AppearanceModID2`, `ItemVisual2`, `ItemID3`, `AppearanceModID3`, `ItemVisual3`) VALUES
(37067, 3, 3367, 0, 0, 0, 0, 0, 0, 0, 0), -- Crash Survivor
(37067, 2, 3346, 0, 0, 0, 0, 0, 0, 0, 0); -- Crash Survivor

UPDATE `creature_equip_template` SET `ItemID2`=0 WHERE (`CreatureID`=4219 AND `ID`=1); -- Fylerian Nightwing
UPDATE `creature_equip_template` SET `ItemID2`=0 WHERE (`CreatureID`=4217 AND `ID`=1); -- Mathrengyl Bearwalker
UPDATE `creature_equip_template` SET `ItemID2`=0 WHERE (`CreatureID`=4214 AND `ID`=1); -- Erion Shadewhisper
UPDATE `creature_equip_template` SET `ItemID2`=0 WHERE (`CreatureID`=43727 AND `ID`=1); -- Lorna Crowley

-- creature template update

DELETE FROM `creature_template` WHERE `entry`=141903;
INSERT INTO `creature_template` (`entry`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `BaseAttackTime`, `RangeAttackTime`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `dynamicflags`, `VehicleId`, `HoverHeight`) VALUES
(141903, 0, 45, 45, 80, 1, 1, 1.142857, 2000, 2000, 1, 32768, 2048, 0, 0, 0, 1); -- Eranril Moontear

UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=33175; -- Johnathan Staats
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=32973; -- Dentaria Silverglade
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=120, `maxlevel`=120 WHERE `entry`=3841; -- Teldira Moonfeather
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `unit_flags`=537166336, `unit_flags2`=2049, `unit_flags3`=8192 WHERE `entry`=32974; -- Laird
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=32972; -- Serendia Oakwhisper
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=43420; -- Innkeeper Kyteran
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=43431; -- Periale
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=33359; -- Nightsaber Rider
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1 WHERE `entry`=49939; -- Kenral Nightwind
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=32971; -- Ranger Glynda Nal'Shea
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=32979; -- Gorbold Steelhand
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=32977; -- Wizbang Cranktoggle
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1 WHERE `entry`=49923; -- Sentinel Moonwing
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=43439; -- Nyrisse
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=32978; -- Tharnariun Treetender
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=43424; -- Ayriala
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=11037; -- Jenna Lemkenilli
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=43436; -- Ceriale Duskwhisper
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=43429; -- Taryel Firestrike
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1 WHERE `entry`=49940; -- Irlara Morninglight
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=4187; -- Harlon Thornguard
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=43428; -- Faeyrin Willowmoon
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=51997; -- Stephanie Krutsick
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=32912; -- Sentinel Lendra
UPDATE `creature_template` SET `speed_run`=0.8571429, `unit_flags2`=2048 WHERE `entry`=63084; -- Poe
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1 WHERE `entry`=49927; -- Lanla Bowleaf
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1 WHERE `entry`=49942; -- Dular
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1, `RangeAttackTime`=2000 WHERE `entry`=49963; -- Laera Dubois
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60, `npcflag`=1, `RangeAttackTime`=2000 WHERE `entry`=49968; -- Lareth Beld
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `faction`=80, `unit_flags`=512, `unit_flags2`=2048 WHERE `entry`=63083; -- Will Larsons
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=10, `maxlevel`=60 WHERE `entry`=10085; -- Jaelysia
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `unit_flags`=32768 WHERE `entry`=34056; -- Vigilant Protector
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `speed_run`=1.142857, `unit_flags`=32832 WHERE `entry`=33864; -- Vile Terror
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `unit_flags`=32768 WHERE `entry`=32969; -- Lor'danel Sentinel
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `unit_flags`=33536, `unit_flags2`=2099200 WHERE `entry`=33115; -- Lor'danel Sentinel
UPDATE `creature_template` SET `faction`=188, `speed_walk`=0.16, `speed_run`=0.05714286, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=64375; -- Shimmershell Snail
UPDATE `creature_template` SET `maxlevel`=60, `unit_flags`=32768 WHERE `entry`=32935; -- Corrupted Tide Crawler
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60, `speed_run`=1.142857, `unit_flags`=32768 WHERE `entry`=32928; -- Vile Spray
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=11042; -- Sylvanna Forestmoon
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=4160; -- Ainethil
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=11041; -- Milla Fairancora
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=4213; -- Taladan
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=11070; -- Lalina Summermoon
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=120, `maxlevel`=120, `npcflag`=0 WHERE `entry`=47584; -- Aladrel Whitespire
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=48735; -- Gwen Armstead
UPDATE `creature_template` SET `minlevel`=123, `maxlevel`=123, `unit_flags2`=2099200 WHERE `entry`=48736; -- Genn Greymane
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=0 WHERE `entry`=36479; -- Archmage Mordent Evenshade
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1, `RangeAttackTime`=2000 WHERE `entry`=50502; -- Vitus Darkwalker
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50498; -- Loren the Fence
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50499; -- Myriam Spellwaker
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50506; -- Talran of the Wild
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50507; -- Vassandra Stormclaw
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50505; -- Lyros Swiftwind
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50504; -- Belysra Starbreeze
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=50501; -- Sister Almyra
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1, `RangeAttackTime`=2000 WHERE `entry`=50500; -- Sergeant Cleese
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1, `RangeAttackTime`=2000 WHERE `entry`=50497; -- Huntsman Blake
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=3468; -- Ancient of Lore
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120, `speed_walk`=1 WHERE `entry`=2041; -- Ancient Protector
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=17 WHERE `entry`=4211; -- Dannelor
UPDATE `creature_template` SET `minlevel`=10, `maxlevel`=60 WHERE `entry`=34396; -- Whitetail Doe
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=52642; -- Foreman Pernic
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=52636; -- Tana Lentner
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=52637; -- Hugo Lentner
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=9047; -- Jenal
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4138; -- Jeen'ra Nightrunner
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4205; -- Dorion
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=4219; -- Fylerian Nightwing
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4218; -- Denatharion
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4217; -- Mathrengyl Bearwalker
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4146; -- Jocaste
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=10089; -- Silvaria
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=10056; -- Alassin
UPDATE `creature_template` SET `minlevel`=1, `maxlevel`=1 WHERE `entry`=14602; -- Swift Stormsaber
UPDATE `creature_template` SET `maxlevel`=1 WHERE `entry`=12360; -- Riding Striped Nightsaber
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=4210; -- Alegorn
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=4730; -- Lelanai
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=82 WHERE `entry`=4753; -- Jartsam
UPDATE `creature_template` SET `maxlevel`=1 WHERE `entry`=14555; -- Swift Mistsaber
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=14379; -- Huntress Ravenoak
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=1 WHERE `entry`=4215; -- Anishar
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4163; -- Syurna
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3 WHERE `entry`=4214; -- Erion Shadewhisper
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=4423; -- Darnassian Protector
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=51371; -- Darnassus Hippogryph Rider
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=4155; -- Idriana
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=7316; -- Sister Aquinne
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`=3681; -- Wisp
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=40552; -- Leora
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=3838; -- Vesprystus
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=42970; -- Gilneas Refugee
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=42968; -- Krennan Aranas
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=7916; -- Erelas Ambersky
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=10118; -- Nessa Shadowsong
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=120, `maxlevel`=120 WHERE `entry`=4262; -- Darnassus Sentinel
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=3607; -- Androl Oakhand
UPDATE `creature_template` SET `maxlevel`=20, `faction`=190, `npcflag`=0, `unit_flags`=768, `HoverHeight`=1 WHERE `entry`=53522; -- Baby Octopus
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_run`=1.142857 WHERE `entry`=43567; -- Korm Bonegrind
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `RangeAttackTime`=2000 WHERE `entry`=43767; -- Navigator
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `RangeAttackTime`=2000 WHERE `entry`=43764; -- Admiral Stormblood
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=43791; -- Wyvern
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=40350; -- Generic Trigger LAB
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=43651; -- Worgen Warrior
UPDATE `creature_template` SET `unit_flags`=33554688, `unit_flags3`=1 WHERE `entry`=43793; -- Gilneas Vehicle Rope
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=43703; -- Gilnean Sharpshooter
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `RangeAttackTime`=2000 WHERE `entry`=42141; -- Gunship Grunt
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=2099200 WHERE `entry`=43566; -- Lorna Crowley
UPDATE `creature_template` SET `unit_flags2`=4196352 WHERE `entry`=43718; -- Generic Trigger LAB (Gigantic AOI)
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_walk`=1, `unit_flags2`=32768 WHERE `entry`=37921; -- Orcish War Machine
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_run`=1.142857, `unit_flags2`=0 WHERE `entry`=37939; -- Riding War Wolf
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37938; -- Wolfmaw Outrider
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37916; -- Orc Raider
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=43747; -- Hippogryph
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=0, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=43749; -- Tobias Mistmantle
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=43727; -- Lorna Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=2099200 WHERE `entry`=37914; -- Towering Ancient
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=620; -- Chicken
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=1073743872 WHERE `entry`=36616; -- Admiral Nightwind
UPDATE `creature_template` SET `unit_flags`=33536 WHERE `entry`=50274; -- Ashley
UPDATE `creature_template` SET `unit_flags`=33536 WHERE `entry`=50275; -- James
UPDATE `creature_template` SET `unit_flags`=33536 WHERE `entry`=50273; -- Cynthia
UPDATE `creature_template` SET `gossip_menu_id`=10841, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=38783; -- Marie Allen
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=38149; -- Lord Darius Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38781; -- Gilnean Survivor
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=38144; -- Krennan Aranas
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37885; -- Restless Ancestor
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_walk`=1 WHERE `entry`=37884; -- Disturbed Spirit
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38364; -- Forsaken Plaguesmith
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags3`=1 WHERE `entry`=38287; -- Forsaken Catapult
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=32768 WHERE `entry`=38363; -- Forsaken Invader
UPDATE `creature_template` SET `unit_flags2`=2099200 WHERE `entry`=38344; -- Plague Cloud Bunny
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=1073741824, `unit_flags3`=1 WHERE `entry`=38150; -- Glaive Thrower
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=0 WHERE `entry`=38615; -- Captured Riding Bat
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=44388; -- Gilnean Militia
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38616; -- Forsaken Infantry
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38618; -- Forsaken Sergeant
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38617; -- Forsaken General
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=570458880, `unit_flags2`=2049, `unit_flags3`=8193 WHERE `entry`=39017; -- Gilnean Militia
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=38539; -- King Genn Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags3`=8192 WHERE `entry`=38614; -- Prince Liam Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=570458880, `unit_flags2`=2049, `unit_flags3`=8193 WHERE `entry`=39015; -- Forsaken Invader
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=570458880, `unit_flags2`=2049, `unit_flags3`=8193 WHERE `entry`=39016; -- Worgen Warrior
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38474; -- Prince Liam Greymane
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=5, `maxlevel`=20, `npcflag`=0 WHERE `entry`=38611; -- Lorna Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38613; -- Worgen Warrior
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags3`=1 WHERE `entry`=38473; -- Soultethered Banshee
UPDATE `creature_template` SET `speed_walk`=1, `unit_flags2`=2097152, `unit_flags3`=1 WHERE `entry`=38469; -- Lady Sylvanas Windrunner
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=0 WHERE `entry`=38331; -- Gorerot
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=32768 WHERE `entry`=38348; -- Worgen Warrior
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `BaseAttackTime`=1538 WHERE `entry`=38415; -- Lord Darius Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38426; -- Lorna Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags3`=1 WHERE `entry`=38424; -- Emberstone Cannon
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38425; -- Freed Emberstone Villager
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38464; -- Dark Ranger Elite
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=2099200 WHERE `entry`=38420; -- Vile Abomination
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38210; -- Forsaken Crossbowman
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38218; -- Prince Liam Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=32768 WHERE `entry`=38221; -- Gilnean Militia
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=32768 WHERE `entry`=38192; -- Forsaken Infantry
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=28332; -- Generic Trigger LAB (Large AOI)
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags2`=4194304 WHERE `entry`=38377; -- Damaged Catapult
UPDATE `creature_template` SET `gossip_menu_id`=14175, `minlevel`=5, `maxlevel`=20, `npcflag`=3, `RangeAttackTime`=2000 WHERE `entry`=38467; -- Huntsman Blake
UPDATE `creature_template` SET `gossip_menu_id`=10837, `minlevel`=5, `maxlevel`=20, `npcflag`=1 WHERE `entry`=38465; -- Myriam Spellwaker
UPDATE `creature_template` SET `gossip_menu_id`=10838, `minlevel`=5, `maxlevel`=20, `npcflag`=3 WHERE `entry`=38466; -- Sister Almyra
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38468; -- Gilnean Mastiff
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37802; -- Brothogg the Slavemaster
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37685; -- Valnov the Mad
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=32768 WHERE `entry`=37686; -- Executor Cornell
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37692; -- Forsaken Infantry
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37694; -- Enslaved Villager
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37701; -- Forsaken Slavedriver
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_walk`=1 WHERE `entry`=37786; -- Brown Stag
UPDATE `creature_template` SET `gossip_menu_id`=10841, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=42853; -- Karen Murray
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37803; -- Marcus
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=38143; -- Magda Whitewall
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=37783; -- Lorna Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38553; -- Krennan Aranas
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37784; -- Gilnean Militia
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37785; -- Wild Horse
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37735; -- Baron Ashbury
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=0 WHERE `entry`=37718; -- Mountain Mastiff
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37733; -- Lord Walden
UPDATE `creature_template` SET `RangeAttackTime`=2000 WHERE `entry`=1933; -- Sheep
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37875; -- Lord Godfrey
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=1 WHERE `entry`=38764; -- Lord Hewell
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37876; -- King Genn Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37716; -- Tempest's Reach Watchman
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37874; -- Krennan Aranas
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37873; -- Vassandra Stormclaw
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36814; -- Talran of the Wild
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37870; -- Lyros Swiftwind
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37195; -- Lord Darius Crowley
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37197; -- Feral Worgen
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37489; -- Feral Watcher
UPDATE `creature_template` SET `gossip_menu_id`=11672, `minlevel`=5, `maxlevel`=20, `faction`=2173, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=42953; -- Benjamin Sykes
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37045; -- Rygna
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37822; -- Belysra Starbreeze
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=50570; -- Whilsey Bottomtooth
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36813; -- Vilebrood Skitterer
UPDATE `creature_template` SET `gossip_menu_id`=14177, `npcflag`=3, `unit_class`=1 WHERE `entry`=38797; -- Vitus Darkwalker
UPDATE `creature_template` SET `gossip_menu_id`=14175, `npcflag`=3 WHERE `entry`=38798; -- Huntsman Blake
UPDATE `creature_template` SET `gossip_menu_id`=10838, `npcflag`=3 WHERE `entry`=38795; -- Sister Almyra
UPDATE `creature_template` SET `npcflag`=641, `unit_flags`=32768 WHERE `entry`=43558; -- Marie Allen
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=37815; -- Lorna Crowley
UPDATE `creature_template` SET `gossip_menu_id`=14290, `npcflag`=3 WHERE `entry`=38799; -- Celestine of the Harvest
UPDATE `creature_template` SET `npcflag`=65536 WHERE `entry`=38792; -- Willa Arnes
UPDATE `creature_template` SET `gossip_menu_id`=10843, `minlevel`=5, `maxlevel`=20, `npcflag`=3 WHERE `entry`=38796; -- Loren the Fence
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=37102; -- Gwen Armstead
UPDATE `creature_template` SET `gossip_menu_id`=14176, `npcflag`=3 WHERE `entry`=38793; -- Sergeant Cleese
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37499; -- Duskhaven Survivor
UPDATE `creature_template` SET `npcflag`=1 WHERE `entry`=38794; -- Myriam Spellwaker
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37807; -- Forsaken Catapult
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37806; -- Captain Asther
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37805; -- Forsaken Soldier
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36294; -- Koroth the Hillbreaker
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_run`=1.142857, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=0 WHERE `entry`=37492; -- Blackwald Fox
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38022; -- Veteran Dark Ranger
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_run`=1.142857, `unit_flags`=0 WHERE `entry`=36882; -- Swamp Crocolisk
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37757; -- Howling Banshee
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37067; -- Crash Survivor
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=37808; -- Koroth the Hillbreaker
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36293; -- Ogre Minion
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=38762; -- Ogre Ambusher
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=5, `maxlevel`=20, `unit_flags2`=1073743872 WHERE `entry`=37065; -- Prince Liam Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=36743; -- King Genn Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=36606; -- Queen Mia Greymane
UPDATE `creature_template` SET `speed_run`=1.142857 WHERE `entry`=43338; -- Stagecoach Horse
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `faction`=2166 WHERE `entry`=37946; -- Duskhaven Watchman
UPDATE `creature_template` SET `faction`=2163 WHERE `entry`=51409; -- Lorna Crowley
UPDATE `creature_template` SET `faction`=2166 WHERE `entry`=43907; -- Duskhaven Watchman
UPDATE `creature_template` SET `faction`=2163 WHERE `entry`=36138; -- Krennan Aranas
UPDATE `creature_template` SET `RangeAttackTime`=2000 WHERE `entry`=39660; -- Spirit Healer
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36528; -- Koroth the Hillbreaker
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36492; -- Ron Hayward
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36491; -- Trent Hayward
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36455; -- Walt Hayward
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36456; -- Sebastian Hayward
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36454; -- Tim Hayward
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36488; -- Forsaken Castaway
UPDATE `creature_template` SET `npcflag`=0, `unit_flags3`=1 WHERE `entry`=36540; -- Mountain Horse
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36671; -- Forsaken Scout
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=32768 WHERE `entry`=36461; -- Lucius the Cruel
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=36459; -- Chance
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_run`=1.142857, `unit_flags`=0 WHERE `entry`=36512; -- Fox
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36452; -- Gwen Armstead
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=36458; -- Grandma Wahl
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36460; -- Forsaken Survivor
UPDATE `creature_template` SET `gossip_menu_id`=0, `minlevel`=5, `maxlevel`=20, `unit_flags2`=1073743872 WHERE `entry`=36451; -- Prince Liam Greymane
UPDATE `creature_template` SET `npcflag`=0, `unit_flags`=33280 WHERE `entry`=36440; -- Drowning Watchman
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36399; -- Captain Morris
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36405; -- Attack Mastiff
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36396; -- Forsaken Sailor
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36397; -- Captain Anson
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags3`=16 WHERE `entry`=36312; -- Dark Ranger Thyala
UPDATE `creature_template` SET `RangeAttackTime`=2000 WHERE `entry`=385; -- Horse
UPDATE `creature_template` SET `gossip_menu_id`=10841, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=36779; -- Marie Allen
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=0, `unit_flags`=33587968, `unit_flags3`=16 WHERE `entry`=36288; -- Ashley
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=36291; -- Melinda Hammond
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=0, `unit_flags`=33536, `unit_flags3`=16 WHERE `entry`=36289; -- James
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36236; -- Forsaken Footsoldier
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=0, `unit_flags`=33536, `unit_flags3`=16 WHERE `entry`=36287; -- Cynthia
UPDATE `creature_template` SET `unit_flags2`=4196352 WHERE `entry`=36140; -- Prince Liam Greymane
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags3`=1 WHERE `entry`=36292; -- Forsaken Machinist
UPDATE `creature_template` SET `maxlevel`=20, `unit_flags2`=4196352, `unit_flags3`=16 WHERE `entry`=36231; -- Horrid Abomination
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `unit_flags`=33554688, `unit_flags2`=4196352, `unit_flags3`=1 WHERE `entry`=36283; -- Forsaken Catapult
UPDATE `creature_template` SET `maxlevel`=20, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=34511; -- Forsaken Invader
UPDATE `creature_template` SET `minlevel`=3, `maxlevel`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000 WHERE `entry`=36714; -- Docile Sheep
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `speed_run`=1.142857 WHERE `entry`=38881; -- Fox
UPDATE `creature_template` SET `npcflag`=2, `unit_flags`=537166592, `unit_flags3`=8192 WHERE `entry`=36205; -- Slain Watchman
UPDATE `creature_template` SET `npcflag`=65536 WHERE `entry`=38791; -- Willa Arnes
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=17 WHERE `entry`=50574; -- Amelia Atherton
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=50567; -- Fielding Chesterhill
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36190; -- Prince Liam Greymane
UPDATE `creature_template` SET `gossip_menu_id`=10843, `npcflag`=3 WHERE `entry`=36630; -- Loren the Fence
UPDATE `creature_template` SET `gossip_menu_id`=11794, `minlevel`=5, `maxlevel`=20, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=44125; -- Chris Moller
UPDATE `creature_template` SET `gossip_menu_id`=10842, `npcflag`=4225, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=36717; -- Gerard Walthorn
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=50252; -- Mary Oxworth
UPDATE `creature_template` SET `gossip_menu_id`=10841, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=36695; -- Samantha Buckley
UPDATE `creature_template` SET `gossip_menu_id`=14177, `npcflag`=3, `unit_class`=1 WHERE `entry`=36652; -- Vitus Darkwalker
UPDATE `creature_template` SET `gossip_menu_id`=14176, `npcflag`=3 WHERE `entry`=36651; -- Sergeant Cleese
UPDATE `creature_template` SET `gossip_menu_id`=10838, `npcflag`=3 WHERE `entry`=36632; -- Sister Almyra
UPDATE `creature_template` SET `gossip_menu_id`=10837, `npcflag`=1 WHERE `entry`=36631; -- Myriam Spellwaker
UPDATE `creature_template` SET `gossip_menu_id`=14290, `npcflag`=3 WHERE `entry`=36628; -- Celestine of the Harvest
UPDATE `creature_template` SET `gossip_menu_id`=14175, `npcflag`=3 WHERE `entry`=36629; -- Huntsman Blake
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36698; -- Captive Worgen
UPDATE `creature_template` SET `npcflag`=2 WHERE `entry`=36170; -- Lord Godfrey
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=17 WHERE `entry`=50247; -- Jack "All-Trades" Derrington
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36798; -- Captive Worgen
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20 WHERE `entry`=36797; -- Captive Worgen
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=34571; -- Gwen Armstead
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=14881; -- Spider
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `npcflag`=2 WHERE `entry`=36132; -- Krennan Aranas
UPDATE `creature_template` SET `unit_flags2`=4196352 WHERE `entry`=36449; -- Generic Trigger LAB - Multiphase (Gigantic)
UPDATE `creature_template` SET `unit_flags2`=4196352 WHERE `entry`=36286; -- Generic Trigger LAB - Multiphase (Gigantic AOI)
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry`=35627; -- Frenzied Stalker
UPDATE `creature_template` SET `gossip_menu_id`=0, `RangeAttackTime`=2000 WHERE `entry`=35566; -- Lord Darius Crowley
UPDATE `creature_template` SET `npcflag`=0, `speed_run`=1.142857 WHERE `entry`=44429; -- Crowley's Horse
UPDATE `creature_template` SET `gossip_menu_id`=14172, `npcflag`=3, `BaseAttackTime`=1500, `unit_flags`=768 WHERE `entry`=44455; -- Sergeant Cleese
UPDATE `creature_template` SET `unit_flags`=33280 WHERE `entry`=35551; -- Prince Liam Greymane
UPDATE `creature_template` SET `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33536 WHERE `entry`=35911; -- King Genn Greymane
UPDATE `creature_template` SET `RangeAttackTime`=2000, `unit_flags`=33536 WHERE `entry`=35552; -- Lord Darius Crowley
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=1111 WHERE `entry`=44464; -- Loren the Fence
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=33280 WHERE `entry`=44465; -- Myriam Spellwaker
UPDATE `creature_template` SET `npcflag`=0, `speed_run`=1.142857, `BaseAttackTime`=1111, `VehicleId`=0 WHERE `entry`=44427; -- Crowley's Horse
UPDATE `creature_template` SET `faction`=35, `RangeAttackTime`=2000, `unit_flags2`=2048 WHERE `entry`=44463; -- Baron
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=1111 WHERE `entry`=44459; -- Celestine of the Harvest
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=1111 WHERE `entry`=44468; -- Sister Almyra
UPDATE `creature_template` SET `RangeAttackTime`=2000 WHERE `entry`=35554; -- Shaken Survivor
UPDATE `creature_template` SET `faction`=2163, `BaseAttackTime`=1111 WHERE `entry`=44460; -- Gwen Armstead
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=1500 WHERE `entry`=44461; -- Huntsman Blake
UPDATE `creature_template` SET `RangeAttackTime`=2000 WHERE `entry`=44470; -- Injured Citizen
UPDATE `creature_template` SET `npcflag`=3, `BaseAttackTime`=1500 WHERE `entry`=44469; -- Vitus Darkwalker
UPDATE `creature_template` SET `unit_flags2`=2099200 WHERE `entry`=35916; -- Bloodfang Ripper
UPDATE `creature_template` SET `npcflag`=0, `unit_flags2`=2099200 WHERE `entry`=35229; -- Bloodfang Stalker
UPDATE `creature_template` SET `maxlevel`=3, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=35915; -- Gilneas City Guard
UPDATE `creature_template` SET `unit_flags3`=1 WHERE `entry`=35914; -- Commandeered Cannon
UPDATE `creature_template` SET `gossip_menu_id`=83 WHERE `entry`=6491; -- Spirit Healer
UPDATE `creature_template` SET `faction`=2163, `unit_flags`=32768 WHERE `entry`=35753; -- Krennan Aranas
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=35550; -- King Genn Greymane
UPDATE `creature_template` SET `unit_flags`=32768, `unit_flags2`=2099200 WHERE `entry`=35505; -- Bloodfang Ripper
UPDATE `creature_template` SET `npcflag`=0, `unit_flags2`=2099200 WHERE `entry`=35463; -- Bloodfang Lurker
UPDATE `creature_template` SET `minlevel`=5, `maxlevel`=20, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768 WHERE `entry`=41561; -- Wary Mastiff
UPDATE `creature_template` SET `BaseAttackTime`=1500 WHERE `entry`=50371; -- Captain Broderick
UPDATE `creature_template` SET `RangeAttackTime`=2000 WHERE `entry`=35077; -- Lord Darius Crowley
UPDATE `creature_template` SET `BaseAttackTime`=1111 WHERE `entry`=35124; -- Tobias Mistmantle
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=35871; -- Loren the Fence
UPDATE `creature_template` SET `unit_flags2`=0 WHERE `entry`=47091; -- Wounded Guard
UPDATE `creature_template` SET `gossip_menu_id`=14174, `npcflag`=3, `BaseAttackTime`=1500 WHERE `entry`=35874; -- Huntsman Blake
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=35872; -- Myriam Spellwaker
UPDATE `creature_template` SET `npcflag`=3 WHERE `entry`=35870; -- Sister Almyra
UPDATE `creature_template` SET `gossip_menu_id`=0, `npcflag`=3, `BaseAttackTime`=1500 WHERE `entry`=35869; -- Vitus Darkwalker
UPDATE `creature_template` SET `gossip_menu_id`=14172, `npcflag`=3, `BaseAttackTime`=1500 WHERE `entry`=35839; -- Sergeant Cleese
UPDATE `creature_template` SET `npcflag`=4194433, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=68993; -- Fenegan Cobbler
UPDATE `creature_template` SET `gossip_menu_id`=14290, `npcflag`=3 WHERE `entry`=35873; -- Celestine of the Harvest
UPDATE `creature_template` SET `faction`=2163, `unit_flags`=768 WHERE `entry`=51947; -- Gilnean Steed
UPDATE `creature_template` SET `gossip_menu_id`=10841, `npcflag`=641, `BaseAttackTime`=2000, `RangeAttackTime`=2000, `unit_flags`=32768, `unit_flags2`=2048 WHERE `entry`=38853; -- Marie Allen
UPDATE `creature_template` SET `unit_flags`=32768 WHERE `entry`=35840; -- Gwen Armstead
UPDATE `creature_template` SET `minlevel`=120, `maxlevel`=120 WHERE `entry`=89715; -- Franklin Martin
UPDATE `creature_template` SET `unit_flags2`=2099200 WHERE `entry`=35457; -- Bloodfang Bloodletter
UPDATE `creature_template` SET `npcflag`=0, `unit_flags3`=16 WHERE `entry`=35118; -- Bloodfang Worgen
UPDATE `creature_template` SET `unit_flags2`=2099200 WHERE `entry`=35456; -- Worgen Runt
UPDATE `creature_template` SET `faction`=2174, `unit_flags2`=2099200, `unit_flags3`=16 WHERE `entry`=34884; -- Rampaging Worgen
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60, `faction`=114, `unit_flags`=33555200 WHERE `entry`=35164; -- Gilneas Prison Event Run Marker
UPDATE `creature_template` SET `faction`=2163, `unit_flags`=537166080, `unit_flags2`=2049, `unit_flags3`=8192 WHERE `entry`=44105; -- Slain Citizen
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=35011; -- Gilneas Evacuation Facing Marker (Far)
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60, `faction`=114, `unit_flags`=33555200 WHERE `entry`=35166; -- Gilneas Prison Event Spawn Marker
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=35006; -- Gilneas Market Evacuation Credit
UPDATE `creature_template` SET `unit_flags`=537165824, `unit_flags2`=2049, `unit_flags3`=8192 WHERE `entry`=34863; -- Lieutenant Walden
UPDATE `creature_template` SET `unit_flags`=537166592, `unit_flags2`=2049, `unit_flags3`=8193 WHERE `entry`=39095; -- Slain Guard
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60, `npcflag`=0, `unit_flags3`=16 WHERE `entry`=35830; -- Gilneas Evacuation Facing Marker (First)
UPDATE `creature_template` SET `unit_flags2`=2099200 WHERE `entry`=34867; -- Shadowy Figure
UPDATE `creature_template` SET `gossip_menu_id`=0 WHERE `entry`=34850; -- Prince Liam Greymane
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=35010; -- Gilneas Evacuation Facing Marker (Near)
UPDATE `creature_template` SET `faction`=188, `unit_flags`=0 WHERE `entry`=6368; -- Cat
UPDATE `creature_template` SET `speed_run`=1.142857 WHERE `entry`=34864; -- Gilneas City Guard
UPDATE `creature_template` SET `minlevel`=60, `maxlevel`=60 WHERE `entry`=35374; -- Generic Trigger LAB - Multiphase
UPDATE `creature_template` SET `unit_flags`=0, `unit_flags3`=17, `VehicleId`=470 WHERE `entry`=35317; -- Rebel Cannon

