-- add charm immunity for frostwyrm handler in sindragosa encounter, may break the script
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask | 1 WHERE entry = 37531;