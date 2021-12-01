DELETE FROM `server_string` WHERE `entry` IN (1134, 1135);
INSERT INTO `server_string` (`entry`, `content_default`) VALUES
(1134, 'Sending tickets is allowed.'),
(1135, 'Sending tickets is not allowed.');
