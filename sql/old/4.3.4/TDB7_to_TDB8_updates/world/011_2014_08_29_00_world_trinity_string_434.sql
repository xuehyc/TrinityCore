-- .guild info command strings
DELETE FROM `server_string` WHERE `entry`=1184;
INSERT INTO `server_string` (`entry`, `content_default`) VALUES
(1184, '| Guild Level: %u');
