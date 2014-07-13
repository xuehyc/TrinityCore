

-- guid changed for ArkDB
update gameobject set phaseMask=16 where guid in (103208,103209,103228,103234,103236,103240,103242);
update gameobject set phaseMask=32 where guid in (103258);
update gameobject set phaseMask=64 where guid in (103243,103244,103252,103253,103254,103255);
update gameobject set phaseMask=128 where guid in (2012,2013,2024,103206,103207,103210,103245,103229,103235,103237,103238,103239,2025,2026,103241);


UPDATE `gameobject` SET `position_x`=4526.46, `position_y`=2810.18, `position_z`=391.2, `orientation`=3.28995 WHERE `id`=192269; -- Horde Banner
UPDATE `gameobject` SET `position_x`=4991.04, `position_y`=2525.72, `position_z`=340.366, `orientation`=4.04916 WHERE `id`=192290; -- Horde Banner
UPDATE `gameobject` SET `position_x`=4991.08, `position_y`=2525.76, `position_z`=340.918, `orientation`=4.04044 WHERE `id`=192291; -- Alliance Banner
UPDATE `gameobject` SET `position_x`=5352.15, `position_y`=3054.77, `position_z`=444.61, `orientation`=1.57952 WHERE `id`=192376; -- Horde Banner
UPDATE `gameobject` SET `position_x`=4408.57, `position_y`=2422.61, `position_z`=377.179, `orientation`=1.58825 WHERE `id`=192416; -- Alliance Banner
