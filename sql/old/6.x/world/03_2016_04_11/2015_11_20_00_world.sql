UPDATE `server_string` SET `content_default`='PhaseID: %u, PhaseGroup: %u' WHERE `entry`=5020;

DELETE FROM `server_string` WHERE `entry`=5018;
INSERT INTO `server_string` (`entry`,`content_default`) VALUES
(5018,'It consist of PhaseIDs:');
