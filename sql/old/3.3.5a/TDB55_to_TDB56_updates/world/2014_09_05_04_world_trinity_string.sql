-- Implements in-game gm message when tickets are completed
SET @LANG_COMMAND_TICKETCOMPLETED := 2030;
DELETE FROM `server_string` WHERE `entry` = @LANG_COMMAND_TICKETCOMPLETED;
INSERT INTO `server_string` (`entry`, `content_default`) VALUES (@LANG_COMMAND_TICKETCOMPLETED, '|cff00ff00Completed by|r:|cff00ccff %s|r');

