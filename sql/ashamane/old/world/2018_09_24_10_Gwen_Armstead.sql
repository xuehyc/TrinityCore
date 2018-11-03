DELETE FROM `creature_text` WHERE `CreatureID`=35840;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(35840, 0, 0, 'We must stick together to survive.  Move around in groups.', 12, 0, 100, 1, 0, 0, 36094, 0, 'Gwen Armstead'),
(35840, 1, 0, 'The plan is to keep moving south.  We can\\\'t go back to the Merchant Square.  It\\\'s not safe.', 12, 0, 100, 1, 0, 0, 36093, 0, 'Gwen Armstead'),
(35840, 2, 0, 'The king\\\'s men will protect us.  We\\\'re almost there.', 12, 0, 100, 1, 0, 0, 36095, 0, 'Gwen Armstead');
