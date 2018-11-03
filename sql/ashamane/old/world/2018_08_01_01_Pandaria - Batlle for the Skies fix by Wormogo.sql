DELETE FROM creature_addon WHERE guid = 21001459;
INSERT INTO creature_addon (guid, path_id, mount, bytes1, bytes2, emote, aiAnimKit, movementAnimKit, meleeAnimKit, auras) VALUES
(21001459, 4514730, 0, 50331648, 1, 0,0,0,0,0);

DELETE FROM waypoint_data WHERE id=4514730;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, orientation, delay, move_type, action, action_chance, wpguid) VALUES
(4514730, 1, 719.36, 4164.60, 216.06, 0, 0, 2, 0, 100, 0), -- 55786
(4514730, 2, 745.91, 4154.35, 223.48, 0, 0, 2, 0, 100, 0), -- 55786
(4514730, 3, 717.04, 4141.16, 219.83, 0, 0, 2, 0, 100, 0), -- 55786
(4514730, 4, 689.62, 4153.16, 217.63, 0, 0, 2, 0, 100, 0), -- 55786
(4514730, 5, 684.53, 4173.24, 216.98, 0, 0, 2, 0, 100, 0), -- 55786
(4514730, 6, 704.77, 4190.16, 218.24, 0, 0, 2, 0, 100, 0), -- 55786
(4514730, 7, 736.90, 4183.85, 221.41, 0, 0, 2, 0, 100, 0); -- 55786
