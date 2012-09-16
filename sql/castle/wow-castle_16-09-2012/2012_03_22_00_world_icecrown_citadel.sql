-- Blood Prince Council: Fix resetting so they will stay attackable - Improve enter evade mode so they recheck for targets before doing so
UPDATE `creature_template` SET `mechanic_immune_mask` = 617296767 WHERE `entry` IN (38125, 38130, 37134, 37133, 37132, 37127, 38126, 38132, 38133, 38131);
-- Trash Crok -> Svalna : Add immunities to effects which affect movement or control
UPDATE `creature_template` SET `unit_flags` = 536903746 WHERE `entry` IN (37970, 37972, 37973, 38399, 38400, 38769, 38771, 38770, 38772, 38401, 38784, 38785);