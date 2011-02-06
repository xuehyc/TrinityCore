-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(20636,20637,20653,20657);

-- Schattenlabyrinth
update gameobject set spawnMask = 3 where guid in (24143,24142);
update gameobject_template set faction = 14 where entry in (183295,183296);