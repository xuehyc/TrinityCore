-- remove spell power coefficient for instant and wound poison (all ranks)
UPDATE `spell_bonus_data` SET direct_bonus = 0, dot_bonus = 0
WHERE entry IN 
(8680, 8685, 8689, 11335, 11336, 11337, 26890, 57964, 57965, -- instant poison
 13218, 13222, 13223, 13224, 27189, 57974, 57975); -- wound poison