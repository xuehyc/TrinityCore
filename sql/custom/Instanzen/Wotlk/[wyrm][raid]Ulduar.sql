-- For Achievement Champion/Conqueror of Ulduar
DELETE FROM achievement_criteria_data WHERE `type` = 18 AND criteria_id IN
(10042,10342,10340,10341,10598,10348,10351,10439,
10403,10582,10347,10349,10350,
10352,10355,10353,10354,10599,10357,10363,10719,
10404,10583,10361,10362,10364);

INSERT INTO achievement_criteria_data (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10042,18,0,0,''),
(10342,18,0,0,''),
(10340,18,0,0,''),
(10341,18,0,0,''),
(10598,18,0,0,''),
(10348,18,0,0,''),
(10351,18,0,0,''),
(10439,18,0,0,''),
(10403,18,0,0,''),
(10582,18,0,0,''),
(10347,18,0,0,''),
(10349,18,0,0,''),
(10350,18,0,0,''),
(10352,18,0,0,''),
(10355,18,0,0,''),
(10353,18,0,0,''),
(10354,18,0,0,''),
(10599,18,0,0,''),
(10357,18,0,0,''),
(10363,18,0,0,''),
(10719,18,0,0,''),
(10404,18,0,0,''),
(10583,18,0,0,''),
(10361,18,0,0,''),
(10362,18,0,0,''),
(10364,18,0,0,'');

DELETE FROM disables WHERE sourceType = 4 AND entry IN 
(10042,10342,10340,10341,10598,10348,10351,10439,
10403,10582,10347,10349,10350,
10352,10355,10353,10354,10599,10357,10363,10719,
10404,10583,10361,10362,10364);

-- For Achievement In his House he waits dreaming
DELETE FROM achievement_criteria_data WHERE `type` = 18 AND criteria_id IN
(10321,10322,10323,10324,10325,10326);

INSERT INTO achievement_criteria_data (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10321,18,0,0,''),(10322,18,0,0,''),
(10323,18,0,0,''),(10324,18,0,0,''),
(10325,18,0,0,''),(10326,18,0,0,'');

DELETE FROM disables WHERE sourceType = 4 AND entry IN 
(10321,10322,10323,10324,10325,10326);

-- For Achievement He Feeds on your Tears
DELETE FROM achievement_criteria_data WHERE `type` = 18 AND criteria_id IN
(10568,10570);

INSERT INTO achievement_criteria_data (`criteria_id`,`type`,`value1`,`value2`,`ScriptName`)
VALUES
(10568,18,0,0,''),
(10570,18,0,0,'');

DELETE FROM disables WHERE sourceType = 4 AND entry IN 
(10568,10570);