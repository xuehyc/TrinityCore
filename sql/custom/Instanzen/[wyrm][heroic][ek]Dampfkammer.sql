update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(20629,20630,20633);

update gameobject set spawnMask = 3 where map = 545;
update creature_template set RegenHealth = 0 where entry in (17954,20631);