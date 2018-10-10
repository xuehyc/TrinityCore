-- fix - corect npcflag for 
-- Tainted Arcane Wraith - 15298
-- Tender - 15271
-- Arcane Wraith - 15273
UPDATE `creature_template` SET `npcflag`=0 WHERE `entry` IN (15298, 15271, 15273);

-- fix - corect unit_flags for 
-- Springpaw Lynx 15372

UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry` IN (15372);