-- Remove double spawns.
DELETE FROM `creature` WHERE `guid` IN (3466, 452546, 452548, 452553, 452558, 452561, 452618, 452623, 452624, 452625, 452627, 452628, 452629, 452630, 452634, 452637, 452638, 452677);

-- Proper templates for guard patrols.
UPDATE `creature` SET `id`=74228 WHERE `guid`=286504;
UPDATE `creature` SET `id`=74228 WHERE `guid`=286518;
