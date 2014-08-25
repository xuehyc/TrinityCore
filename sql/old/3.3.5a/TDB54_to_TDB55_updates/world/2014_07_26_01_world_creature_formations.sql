
-- Fix Garadar Wolf Rider Formations  (double post??)
-- http://www.wowhead.com/npc=19068
UPDATE `creature` SET `position_x`=-1312.285,`position_y`=6940.27,`position_z`=31.40549,`orientation`=1.049322 WHERE `guid`=185101; -- GUID by ArkDB
DELETE FROM `creature_formations` WHERE `leaderGUID`=185102; -- GUID by ArkDB
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(185102,185102,0,0,2), -- GUID by ArkDB
(185102,185101,8,0,2);

UPDATE `creature` SET `position_x`=-1212.921,`position_y`=7400.358,`position_z`=28.68889,`orientation`=2.005122 WHERE `guid`=185103; -- GUID by ArkDB
DELETE FROM `creature_formations` WHERE `leaderGUID`=185104; -- GUID by ArkDB
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(185104,185104,0,0,2), -- GUID by ArkDB
(185104,185103,8,0,2);
