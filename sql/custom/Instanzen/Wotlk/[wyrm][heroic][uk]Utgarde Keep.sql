-- Utgarde Keep Heroic Loot Emblems
UPDATE creature_loot_template SET item = 40752 WHERE item = 47241 AND entry IN (31674,30748);
UPDATE reference_loot_template SET item = 40752 WHERE item = 47241 AND entry IN (35049);

DELETE FROM creature_loot_template WHERE entry IN (
31666, -- Dragonflayer Strategist
31663, -- Dragonflayer Runecaster
30747, -- Dragonflayer Ironhelm
31658, -- Dragonflayer Bonecrusher
31660, -- Dragonflayer Heartsplitter
31661, -- Dragonflayer Metalworker
31659, -- Dragonflayer Forge Master
31667, -- Dragonflayer Weaponsmith
31675, -- Proto-Drake Handler
31669, -- Enslaved Proto-Drake
31662, -- Dragonflayer Overseer
31678) -- Savage Worg
 AND item IN (37197, 37196); -- Tattered Castle Drape & Runecaster's Mantle

# Chances from wowhead
INSERT INTO creature_loot_template VALUES
-- Tattered Castle Drape
(31666, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Strategist
(31663, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Runecaster
(30747, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Ironhelm
(31658, 37197, 1,   1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Bonecrusher
(31660, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Heartsplitter
(31661, 37197, 0.8, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Metalworker
(31659, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Forge Master
(31667, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Weaponsmith
(31675, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Proto-Drake Handler
(31669, 37197, 0.4, 1, 0, 1, 1, 0, 0, 0), -- Enslaved Proto-Drake
(31662, 37197, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Overseer
(31678, 37197, 0.5, 1, 0, 1, 1, 0, 0, 0), -- Savage Worg
-- Runecaster's Mantle
(31666, 37196, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Strategist
(31663, 37196, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Runecaster
(30747, 37196, 0.8, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Ironhelm
(31658, 37196, 0.8, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Bonecrusher
(31660, 37196, 1,   1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Heartsplitter
(31661, 37196, 0.7, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Metalworker
(31659, 37196, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Forge Master
(31667, 37196, 0.8, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Weaponsmith
(31675, 37196, 0.8, 1, 0, 1, 1, 0, 0, 0), -- Proto-Drake Handler
(31669, 37196, 0.4, 1, 0, 1, 1, 0, 0, 0), -- Enslaved Proto-Drake
(31662, 37196, 0.9, 1, 0, 1, 1, 0, 0, 0), -- Dragonflayer Overseer
(31678, 37196, 0.5, 1, 0, 1, 1, 0, 0, 0); -- Savage Worg

UPDATE creature_template SET lootid = 31666 WHERE entry = 31666; -- Dragonflayer Strategist
UPDATE creature_template SET lootid = 31663 WHERE entry = 31663; -- Dragonflayer Runecaster
UPDATE creature_template SET lootid = 30747 WHERE entry = 30747; -- Dragonflayer Ironhelm
UPDATE creature_template SET lootid = 31658 WHERE entry = 31658; -- Dragonflayer Bonecrusher
UPDATE creature_template SET lootid = 31660 WHERE entry = 31660; -- Dragonflayer Heartsplitter
UPDATE creature_template SET lootid = 31661 WHERE entry = 31661; -- Dragonflayer Metalworker
UPDATE creature_template SET lootid = 31659 WHERE entry = 31659; -- Dragonflayer Forge Master
UPDATE creature_template SET lootid = 31667 WHERE entry = 31667; -- Dragonflayer Weaponsmith
UPDATE creature_template SET lootid = 31675 WHERE entry = 31675; -- Proto-Drake Handler
UPDATE creature_template SET lootid = 31669 WHERE entry = 31669; -- Enslaved Proto-Drake
UPDATE creature_template SET lootid = 31662 WHERE entry = 31662; -- Dragonflayer Overseer
UPDATE creature_template SET lootid = 31678 WHERE entry = 31678; -- Savage Worg
