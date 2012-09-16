-- Disable Malygos vMaps LoS Check
DELETE FROM `disables` WHERE `sourceType` = 6 AND `entry` = 616;
INSERT INTO `disables` (sourceType, entry, flags, params_0, params_1, comment) VALUES
(6, 616, 4, '', '', 'Disable Malygos vMaps LoS Check');