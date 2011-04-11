-- Correct Savage Gladiator's Totems
UPDATE `item_template` SET `flags` = `flags`|4096 , `AllowableClass` = 64 , `maxcount` = 1, `TotemCategory` = 21 WHERE `entry` IN (42595, 42594, 42593);