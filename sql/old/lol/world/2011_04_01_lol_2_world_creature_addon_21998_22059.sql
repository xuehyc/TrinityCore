-- add mounts to creatures 
UPDATE creature_template SET InhabitType = 4 WHERE entry IN (21998,22059);
DELETE FROM creature_template_addon WHERE entry IN (21998,22059);
INSERT INTO creature_template_addon VALUES
(21998,0,17719,0,4097,0,NULL),
(22059,0,17717,0,4097,0,NULL);