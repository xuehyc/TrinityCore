
-- http://www.wowhead.com/quest=25112/butcherbot
-- http://www.wowhead.com/item=52715  	Butcherbot Control Gizmo
-- http://www.wowhead.com/spell=74175  	Deploy Butcherbot
-- http://www.wowhead.com/npc=39696 	Butcherbot spawned by 74176..
-- http://www.wowhead.com/npc=40508 	Butcherbot
-- http://www.wowhead.com/spell=74176	Summon Butcherbot to Corpse
-- http://www.wowhead.com/npc=5419		Glasshide Basilisk
-- http://www.wowhead.com/spell=74227	Create Butcherbot Item
-- http://www.wowhead.com/spell=74168 	Butcherbot Butchering
-- http://www.wowhead.com/spell=74228	Force Player to Create Butcherbot
-- http://www.wowhead.com/npc=39702		Tanaris Basilisk Kill Credit Bunny

UPDATE quest_template SET method=2,Flags=0,QuestGiverPortrait=141,QuestGiverTextWindow="Glasshide Basilisk",QuestGiverTargetName="Glasshide Basilisk" WHERE Id=25112;
UPDATE quest_template SET RequiredNpcOrGo1=39702 WHERE Id=25112;

delete from creature_text where entry=39696 and groupid=0 and id between 0 and 7;
insert into creature_text values
(39696,0,0,"Chop chop chop!",12,0,100,0,0,0,"Butcherbot on work",39701),
(39696,0,1,"Hooray for meat! HIP HIP HOORAY!",12,0,100,0,0,0,"Butcherbot on work",39697),
(39696,0,2,"VWHHHHHRRRRRRRRRRRRRRRHHHHHHHHMNNGHHHGH!",12,0,100,0,0,0,"Butcherbot on work",39702),
(39696,0,3,"I want the arterieeeeeees!",12,0,100,0,0,0,"Butcherbot on work",39699),
(39696,0,4,"Increase your profit potential with Butcherbot!",12,0,100,0,0,0,"Butcherbot on work",39703),
(39696,0,5,"No part goes to waste! Yay!",12,0,100,0,0,0,"Butcherbot on work",39700),
(39696,0,6,"Yaaaaaaaaaaaaay!",12,0,100,0,0,0,"Butcherbot on work",39704),
(39696,0,7,"Butcherbot will harvest meat, tra la la la la.",12,0,100,0,0,0,"Butcherbot on work",39698);

update creature_template set AIName="", ScriptName="npc_glasshide_basilisk" where entry=5419;
update creature_template set AIName="", ScriptName="npc_butcherbot_spawned" where entry=39696;
