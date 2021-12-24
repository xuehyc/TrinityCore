-- Remove double spawns.
DELETE FROM `creature` WHERE `guid` IN (452639, 452640);

-- Proper templates.
UPDATE `creature` SET `id`=54657 WHERE `guid`=287048;
UPDATE `creature` SET `id`=69977 WHERE `guid`=287056;
UPDATE `creature` SET `id`=69978 WHERE `guid`=287063;
