
-- Remove Dalaran Visitor spawns from DB
-- DELETE FROM creature WHERE id IN (32596,32597,32598,32600,32601,32602);  -- ArkDB not shure

-- Fix Addon for Jean Pierre Poulain
-- DELETE FROM `creature_addon` WHERE `guid`=85236;  -- ArkDB not shure

UPDATE `creature_template_addon` SET `mount`=22471, `auras`='63500' WHERE `entry`=34244;
