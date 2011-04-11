-- Majestic Dragon Figurine
DELETE FROM `spell_proc_event` WHERE `entry`=60524;
INSERT INTO `spell_proc_event` (`entry`,`procEx`) VALUES (60524,65536);

-- Lightweave Embroidery
UPDATE `spell_proc_event` SET `procEx`=65536 WHERE `entry`=55640;
