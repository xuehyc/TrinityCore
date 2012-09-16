-- Call to Arms: Happy Hour
SET @eventEntry = 100;
SET @holiday := 284;
SET @occurence := 60*24*7;
SET @length := 60;
DELETE FROM game_event WHERE holiday = @holiday AND eventEntry != 19; -- remove custom entrys, but not original one
INSERT INTO game_event (eventEntry, start_time, end_time, occurence, length, holiday, description, world_event) VALUES
(@eventEntry, '2012-06-11 22:00:00', '2020-12-31 06:00:00', @occurence, @length, @holiday, 'Call To Arms - Happy Hour - Monday', 0),
(@eventEntry+1, '2012-06-12 22:00:00', '2020-12-31 06:00:00', @occurence, @length, @holiday, 'Call To Arms - Happy Hour - Tuesday', 0),
(@eventEntry+2, '2012-06-13 22:00:00', '2020-12-31 06:00:00', @occurence, @length, @holiday, 'Call To Arms - Happy Hour - Wednesday', 0),
(@eventEntry+3, '2012-06-14 22:00:00', '2020-12-31 06:00:00', @occurence, @length, @holiday, 'Call To Arms - Happy Hour - Thursday', 0);

-- Call to Arms: Weekend (eventEntrys are from TDB)
SET @length := 61 * 60; -- fr 16 - mo 5
SET @occurrence := 60 * 24 * 7 * 5; -- every 5 weeks
DELETE FROM game_event WHERE holiday IN (283, 284, 285, 353, 400, 420) AND eventEntry IN (18, 19, 20, 21, 53, 54);
INSERT INTO game_event (eventEntry, start_time, end_time, occurence, length, holiday, description, world_event) VALUES
(18, '2012-06-01 16:00:00', '2020-12-31 06:00:00', @occurence, @length, 283, 'Ruf zu den Waffen: Alteractal!', 0),
(19, '2012-06-08 16:00:00', '2020-12-31 06:00:00', @occurence, @length, 284, 'Ruf zu den Waffen: Kriegshymnenschlucht!', 0),
(20, '2012-06-15 16:00:00', '2020-12-31 06:00:00', @occurence, @length, 285, 'Ruf zu den Waffen: Arathibecken!', 0),
(21, '2012-06-22 16:00:00', '2020-12-31 06:00:00', @occurence, @length, 353, 'Ruf zu den Waffen: Auge des Sturms!', 0),
(53, '2012-06-29 16:00:00', '2020-12-31 06:00:00', @occurence, @length, 400, 'Ruf zu den Waffen: Strand der Uralten!', 0),
(54, '2011-07-06 16:00:00', '2011-12-31 06:00:00', @occurence, @length, 420, 'Ruf zu den Waffen: Insel der Eroberung!', 0); -- disable Isle of Conquest for now, correct years to activate.
