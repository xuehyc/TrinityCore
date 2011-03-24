-- Fix for NPC 30204 Forgotten Depths Ambusher
UPDATE creature_template SET unit_flags = 0 WHERE entry = 30204;
