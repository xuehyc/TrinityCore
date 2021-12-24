-- Remove invalid spawn.
DELETE FROM `creature` WHERE `guid`=314197;

-- Proper templates.
UPDATE `creature` SET `id`=54660 WHERE `guid`=314212;
UPDATE `creature` SET `id`=69974 WHERE `guid`=314207;
UPDATE `creature` SET `id`=69975 WHERE `guid`=314199;
