/* 51123 rank1 3
51127 rank2 6 
51128 rank3 9 
51129 rank4 12 
51130 rank5 15*/
-- Killing maschine
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=3 WHERE `entry`=51123;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=6 WHERE `entry`=51127;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=9 WHERE `entry`=51128;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=12 WHERE `entry`=51129;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=15 WHERE `entry`=51130;