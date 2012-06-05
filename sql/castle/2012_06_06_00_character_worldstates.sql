-- add initial win streak worldstates for wg to support insta promotion over restarts
REPLACE `worldstates` SET `entry` = 31004, `value` = 0, `comment` ='wg allianceWinStreaks';
REPLACE `worldstates` SET `entry` = 31005, `value` = 0, `comment` ='wg hordeWinStreaks';