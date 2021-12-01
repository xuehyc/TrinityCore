UPDATE `server_string` SET `content_default` = 'Map: %u (%s) Zone: %u (%s) Area: %u (%s) Phase: %u\nX: %f Y: %f Z: %f Orientation: %f' WHERE `entry` = 101;
DELETE FROM `server_string` WHERE `entry` = 185;
INSERT INTO `server_string` (`entry`, `content_default`) VALUES
(185, 'grid[%u,%u]cell[%u,%u] InstanceID: %u\n ZoneX: %f ZoneY: %f\nGroundZ: %f FloorZ: %f Have height data (Map: %u VMap: %u MMap: %u)');
