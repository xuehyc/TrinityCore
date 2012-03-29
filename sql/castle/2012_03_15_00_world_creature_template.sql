-- Update Encounters Murmur+Ragnaros: Bosses should not be able to move at all (cmp. http://www.wowwiki.com/Murmur#Strategy)
-- Update 2012/03/21: Also add immunity for Death Grip (Grip effect only, not taunt) to ensure they stick in their spawn place.
UPDATE creature_template SET unit_flags = unit_flags | 4 WHERE entry IN (18708,20657,11502);
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask | 32 WHERE entry IN (18708,20657,11502);

