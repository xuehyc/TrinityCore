-- Quest - Forced to Watch from Afar, changed faction from 22 to 57 (Ironforge) make them friendly and changed unit_flags to be non-attackable and pacified
UPDATE creature_template SET faction=57 WHERE entry IN (40991,40994, 41056);
UPDATE creature_template SET unit_flags=131074 WHERE entry IN (40991,40994, 41056);