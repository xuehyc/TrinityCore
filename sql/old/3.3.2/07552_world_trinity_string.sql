-- Add text for disabled bg/arenas.
DELETE FROM `server_string` WHERE `entry` in (747,748);
INSERT INTO `server_string` (`entry`, `content_default`) VALUES
(747, 'This Battleground have been disabled. You can''t join the queue.'),
(748, 'Arenas have been disabled. You can''t join the queue.');
