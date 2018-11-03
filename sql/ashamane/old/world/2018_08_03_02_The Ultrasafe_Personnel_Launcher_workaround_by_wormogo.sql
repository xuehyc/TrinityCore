-- Ultrasafe Personnel Launcher - 25839
-- Solution Workaround - Player has to face where the quest end exists to blast off there

DELETE FROM npc_spellclick_spells WHERE npc_entry IN (41327, 41398);
INSERT INTO npc_spellclick_spells (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(41327, 77424, 2, 0),
(41398, 77424, 2, 0),
(41327, 77431, 3, 0),
(41398, 77431, 3, 0);
