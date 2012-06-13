-- Fix quest 10427 Creatures of the Eco-Domes / Fauna der Biokuppel in zone Netherstorm, fix quest credit counting
-- by Tollmer
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (20610, 20777) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2077700, 2061000) AND `source_type` = 9;
INSERT INTO `smart_scripts` (entryorguid, source_type, id, link, event_type, event_phase_mask, event_chance, event_flags, event_param1, event_param2, event_param3, event_param4, action_type, action_param1, action_param2, action_param3, action_param4, action_param5, action_param6, target_type, target_param1, target_param2, target_param3, target_x, target_y, target_z, target_o, comment) VALUES
(20610, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Aggro - Say text 0'),
(20610, 0, 1, 0, 0, 0, 100, 0, 1000, 1000, 8000, 11000, 11, 32019, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - In Combat - Cast Gore'),
(20610, 0, 2, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - At 20% HP - Say Text 1'),
(20610, 0, 3, 4, 8, 0, 100, 0, 35771, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - On Spellhit - Give Killcredit'),
(20610, 0, 4, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Doe - Despawn'),
(20777, 0, 0, 0, 0, 0, 100, 0, 1000, 1000, 8000, 11000, 11, 32023, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - In Combat - Cast Hoof Stomp'),
(20777, 0, 1, 0, 2, 0, 100, 1, 0, 20, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - At 20% HP - Say Text 0'),
(20777, 0, 2, 3, 8, 0, 100, 0, 35771, 0, 0, 0, 33, 20982, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - On Spellhit - Give Killcredit'),
(20777, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Talbuk Sire - Despawn');