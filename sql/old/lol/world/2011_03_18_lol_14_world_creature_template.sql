-- Fix Quest 11599 NPC moving away
UPDATE creature_template SET unit_flags = 6 WHERE entry = 25385; -- non attackable/disable move