
-- http://www.wowhead.com/npc=34123	Astranaar's Burning! Fire Bunny
-- modelId1 is fire with bunny inside, modelid2 is fire without bunny

update creature_template set modelid1=15880,modelid2=0 where entry=34123;

-- the fire bunny has fire as aura, and invisible 1
delete from creature_template_addon where entry=34123;
insert into creature_template_addon values
(34123,0,0,0,1,0,"64573 52855");

