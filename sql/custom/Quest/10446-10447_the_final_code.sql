-- The Final Code - 10446, 10447 - Kill credit for Mana Bomb Kill Credit Trigger was not given.
DELETE FROM `event_scripts` WHERE `id`=13470;
INSERT INTO `event_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`) VALUES (13470,1,8,21039,0); 
UPDATE `quest_template` SET `ReqSpellCast2`=0 WHERE `entry` IN (10446,10447);