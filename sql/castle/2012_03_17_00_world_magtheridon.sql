-- Set Civilian Flag for Magtheridon Channelers; Combat should only start upon first attack of players, enables group to enter room without starting event
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 2 WHERE `entry` = 17256;
