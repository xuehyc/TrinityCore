
--
-- npc 34415
--
-- the picture from wowhead shown 4 priestess, one is missing
INSERT INTO creature VALUES (NULL,34415,1,1,1,0,0,4595.093,899.426,41.42056,5.097,500,0,0,433,490,0,0,0,0);

-- no movement on them
update creature set SpawnDist=0, MovementType=0 where id=34415;
 



