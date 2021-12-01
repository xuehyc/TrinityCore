DELETE FROM `server_string` WHERE `entry` IN (5024,5025,5026,5027);
INSERT INTO server_string (`entry`, `content_default`) VALUES
(5024, 'Entry: %u'),
(5025, 'Type: %u'),
(5026, 'DisplayID: %u'),
(5027, 'Name: %s');
