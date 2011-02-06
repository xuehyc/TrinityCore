-- id
update creature_template set `flags_extra` = `flags_extra`|'1' where entry in 
(20690,23122,23035,20706);

-- Sethekkhallen
update gameobject set spawnMask = 3 where guid = 28507;
