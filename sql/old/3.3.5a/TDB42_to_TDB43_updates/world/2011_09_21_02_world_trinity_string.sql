DELETE FROM server_string WHERE entry IN (1137, 1138);
INSERT INTO server_string (`entry`,`content_default`) VALUES
(1137, 'Dev mode is ON'),
(1138, 'Dev mode is OFF');
