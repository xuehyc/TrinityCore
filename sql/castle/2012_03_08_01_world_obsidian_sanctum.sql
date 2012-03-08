-- Fix combat range of creature 28860 Sartharion
UPDATE `creature_model_info` SET `bounding_radius` = 8.0, `combat_reach` = 8.0 WHERE `modelid` = 27035;