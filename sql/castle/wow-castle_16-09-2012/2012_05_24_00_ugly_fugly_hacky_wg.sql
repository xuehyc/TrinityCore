UPDATE creature_template SET unit_flags = 512 WHERE entry IN (31036, 31091, 31151, 31153);
UPDATE creature_template SET unit_flags = 768 WHERE entry IN (32294, 32296, 39172, 39173);
DELETE FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE Id IN (32294, 32296, 39172, 39173));
DELETE FROM creature_template_addon WHERE entry IN (32294, 32296, 39172, 39173);
INSERT INTO creature_template_addon (entry, path_id, mount, bytes1, bytes2, emote, auras) VALUES
(32294, 0, 27247, 0, 257, 0, ''),
(32296, 0, 27245, 0, 257, 0, ''),
(39172, 0, 28912, 0, 257, 0, ''),
(39173, 0, 29261, 0, 257, 0, '');

DELETE FROM gameobject WHERE id IN (193138, 193130);
INSERT INTO gameobject (id,map,spawnMask,phaseMask,position_x,position_y,position_z,orientation,rotation0,rotation1,rotation2,rotation3,spawntimesecs,animprogress,state) VALUES
(193138,571,1,1,5297.41,2889.56,409.191,5.52938,0,0,0.368044,-0.929808,300,0,1),
(193130,571,1,1,5297.41,2889.56,409.191,5.52938,0,0,0.368044,-0.929808,300,0,1);
