-- ICC, Lord Marrowgar, NPC Bone Spike - adopting immunity to death grip to all versions.
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|32 WHERE `entry` IN
(36619, 38233, 38459, 38460, -- Bone spike part 1
38711, 38970, 38971, 38972,  -- Bone spike part 2
38712, 38973, 38974, 38975); -- Bone spike part 3