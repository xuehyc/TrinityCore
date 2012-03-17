-- Update Encounters Murmur+Ragnaros: Bosses should not be able to move at all (cmp. http://www.wowwiki.com/Murmur#Strategy)
UPDATE creature_template SET unit_flags = unit_flags | 4 WHERE entry IN (18708,20657,11502);

