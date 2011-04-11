-- Fix Item 33450 Carved Horn to prevent Mass-spawning of NPC
UPDATE `item_template` SET `spellcooldown_1`=300000 WHERE `entry`=33450 LIMIT 1; 