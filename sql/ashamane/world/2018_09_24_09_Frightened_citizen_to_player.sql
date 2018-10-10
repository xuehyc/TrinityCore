DELETE FROM `creature_text` WHERE `CreatureID`=34981;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(34981, 1, 0, 'Flee!  They\'re everywhere!', 12, 0, 100, 1, 0, 0, 35240, 0, 'Frightened Citizen to Player'),
(34981, 1, 1, 'Worgen!  Worgen everywhere!', 12, 0, 100, 1, 0, 0, 35238, 0, 'Frightened Citizen to Player'),
(34981, 1, 2, 'Protect me, please!', 12, 0, 100, 1, 0, 0, 35234, 0, 'Frightened Citizen to Player'),
(34981, 1, 3, 'Let\\\'s go!', 12, 0, 100, 1, 0, 0, 35236, 0, 'Frightened Citizen to Player'),
(34981, 1, 4, 'No time to waste!', 12, 0, 100, 1, 0, 0, 35237, 0, 'Frightened Citizen to Player');
DELETE FROM `creature_text` WHERE `CreatureID`=35836;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(35836, 0, 0, 'Help me, please!', 12, 0, 100, 430, 0, 0, 36038, 0, 'Frightened Citizen to Player'),
(35836, 0, 1, 'There\'s one after me!', 12, 0, 100, 430, 0, 0, 36039, 0, 'Frightened Citizen to Player'),
(35836, 0, 2, 'It\\\'s coming right for me!', 12, 0, 100, 430, 0, 0, 36037, 0, 'Frightened Citizen to Player'),
(35836, 0, 3, 'I don\\\'t want to die!', 12, 0, 100, 430, 0, 0, 36041, 0, 'Frightened Citizen to Player'),
(35836, 0, 4, 'Help!', 12, 0, 100, 430, 0, 0, 36040, 0, 'Frightened Citizen to Player');
