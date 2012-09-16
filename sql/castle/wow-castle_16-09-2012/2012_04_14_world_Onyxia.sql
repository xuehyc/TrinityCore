-- Apply the standard boss immunity to Onyxia - again.
UPDATE `creature_template` SET `mechanic_immune_mask`=650853247 WHERE `entry` IN (10184, 36538); 