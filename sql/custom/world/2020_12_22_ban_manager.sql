-- Delete old
DELETE FROM `warhead_string` WHERE `entry` IN (11002, 11003, 11100, 11101, 11102, 11103, 11104, 11105, 11106, 11107);

-- Add ruRU and replace default
INSERT INTO `warhead_string`(`entry`, `content_default`, `content_loc8`) VALUES
(11100,
'|cffff0000[Server]:|r %s |cff6C8CD5has kicked|r %s|cff6C8CD5, reason:|r %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5кикнул|r %s|cff6C8CD5, причина:|r %s'),
(11101,
'|cffff0000[Server]:|r %s |cff6C8CD5has muted|r %s |cff6C8CD5for|r %u |cff6C8CD5minutes, reason:|r %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5замутил|r %s |cff6C8CD5на|r %u |cff6C8CD5минут, причина:|r %s'),
(11102,
'|cffff0000[Server]:|r %s |cff6C8CD5has banned character|r %s for %s, reason: %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5забанил персонажа|r %s |cff6C8CD5на|r %s|cff6C8CD5, причина:|r %s'),
(11103,
'|cffff0000[Server]:|r %s |cff6C8CD5has banned character|r %s permanetly, reason: %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5забанил персонажа|r %s |cff6C8CD5навсегда, reason:|r %s'),
(11104,
'|cffff0000[Server]:|r %s |cff6C8CD5has banned account|r %s |cff6C8CD5for|r %s|cff6C8CD5, reason:|r %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5забанил аккаунт|r %s |cff6C8CD5на|r %s|cff6C8CD5, причина:|r %s'),
(11105,
'|cffff0000[Server]:|r %s |cff6C8CD5has banned account|r %s |cff6C8CD5permanetly, reason:|r %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5забанил аккаунт|r %s |cff6C8CD5навсегда, причина:|r %s'),
(11106,
'|cffff0000[Server]:|r %s |cff6C8CD5has banned ip|r %s |cff6C8CD5for|r %s|cff6C8CD5, reason:|r %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5забанил айпи|r %s |cff6C8CD5на|r %s|cff6C8CD5, причина:|r %s'),
(11107,
'|cffff0000[Server]:|r %s |cff6C8CD5has banned ip|r %s |cff6C8CD5permanetly, reason:|r %s', 
'|cffff0000[Система]:|r %s |cff6C8CD5забанил айпи|r %s |cff6C8CD5навсегда, причина:|r %s');
