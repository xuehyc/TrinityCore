DELETE FROM spell_script_names WHERE spell_id = 66765;
INSERT INTO spell_script_names VALUES 
(66765, "spell_koralon_meteor_fists");

DELETE FROM `creature_model_info` WHERE (`modelid`=29524);
INSERT INTO `creature_model_info` (`modelid`, `bounding_radius`, `combat_reach`, `gender`, `modelid_other_gender`) VALUES (29524, 0.45, 8, 2, 0);