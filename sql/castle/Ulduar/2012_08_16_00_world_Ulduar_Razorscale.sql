UPDATE `creature_model_info` SET `bounding_radius`=1.0 WHERE `modelid`=28787; -- Model of Razorscale
UPDATE `creature_template` SET `speed_run`=1.42857, `unit_flags`=33280, `mechanic_immune_mask`=650853247 WHERE `entry`=33724; -- Razorscale 25m
UPDATE `creature_template` SET `InhabitType`=1|4 WHERE `entry` IN (33186,33724);

-- The first row was already present in the database, but the 25m entry also requires it.
-- Entry copied, just to get an overview.
DELETE FROM `creature_template_addon` WHERE `entry` IN (33186,33724);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES 
(33186, 0, 0, 0x3000000, 1, 0, NULL),
(33724, 0, 0, 0x3000000, 1, 0, NULL);