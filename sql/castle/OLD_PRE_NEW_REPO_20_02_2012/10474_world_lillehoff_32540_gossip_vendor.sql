-- Fix Gossip Menu for NPC 32540, Lillehoff, Hodir vendor
UPDATE `gossip_menu_option` SET `option_id` = 3 WHERE `menu_id` = 10281 AND `id` = 0;