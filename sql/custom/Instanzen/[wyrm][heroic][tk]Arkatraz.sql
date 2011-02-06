-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(21626,21590,21624,21599);

update gameobject set spawnMask = 3 where map = 552;