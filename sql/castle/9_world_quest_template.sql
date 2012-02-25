-- fix broken RequiredNpcOrGoId1 in quest 13828 (Master of the Melee), Horde was already working
UPDATE quest_template SET RequiredNpcOrGo1 = 33973 WHERE id = 13828 LIMIT 1;
