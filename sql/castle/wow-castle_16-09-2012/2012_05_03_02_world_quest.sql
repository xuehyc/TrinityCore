-- Fix credit and quest loot for Fire Upon the Waters (New Hearthglenn, Dragonblight)
DELETE FROM spell_linked_spell WHERE spell_trigger = 48455;
INSERT INTO spell_linked_spell (spell_trigger, spell_effect, type, comment) VALUES
(48455, 50290, 0, 'Fire Upon the Waters: Sail Burning Kill Credit');

DELETE FROM creature_loot_template WHERE entry = 27232 AND item = 37305;
INSERT INTO creature_loot_template (entry, item, ChanceOrQuestChance, lootmode, groupid, mincountOrRef, maxcount) VALUES
(27232, 37305 , -100, 1 , 0, 1, 1);