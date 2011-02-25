-- Salvaged Chopper has faction dependent modelid
UPDATE `creature_template` SET `modelid2` = 0 WHERE `entry` = 33062;
-- Sanctum Sentry 25 damage nerf
UPDATE `creature_template` SET `dmg_multiplier` = 35 WHERE `entry` = 34166;