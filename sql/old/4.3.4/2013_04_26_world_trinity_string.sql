DELETE FROM `trinity_string` WHERE `entry` IN (183,184,185);
INSERT INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
(183, 'You changed FOCUS of %s to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(184, '%s changed your FOCUS to %i/%i.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(185, 'Current focus: %u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
