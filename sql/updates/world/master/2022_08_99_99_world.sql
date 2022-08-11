-- 
SET @STRINGENTRY := 884;

DELETE FROM `trinity_string` WHERE `entry`=@STRINGENTRY;
INSERT INTO `trinity_string` (`entry`, `content_default`) VALUES
(@STRINGENTRY, 'Objective %u not found.');
