
-- drops quest items from not involved npc.. drops items 58361,60401,772,780,773 
delete from creature_loot_template where ChanceOrQuestChance>=0 and item in(58361,60401,772,780,773);

