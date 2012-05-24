-- @DorianGrey
-- Workaround for Q11310: Warning: Some Assembly Required.
-- Since the abomination pet does not work yet, enable the ability to just kill the Plagued Vrykuls directly.
UPDATE `creature_template` SET `KillCredit1`=24274 WHERE `entry` IN (23564, 24198, 24199);