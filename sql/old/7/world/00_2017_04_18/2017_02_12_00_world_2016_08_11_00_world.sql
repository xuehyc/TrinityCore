DELETE FROM `server_string` WHERE `entry` = 1031;
INSERT INTO `server_string` (`entry`, `content_default`) VALUES
(1031, 'An account password can NOT be longer than 16 characters (client limit). The account was NOT created.');
