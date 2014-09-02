
-- http://www.wowhead.com/quest=13646	Astranaar Bound
-- http://www.wowhead.com/npc=33445		Sentinel Avana
-- http://www.wowhead.com/spell=63022	Astranaar Bound: Summon Avana's Nightsaber
-- http://www.wowhead.com/spell=63021 	Riding Nightsaber to Astranaar
-- http://www.wowhead.com/spell=63083 	Avana's Nightsaber: Abandon Vehicle
-- http://www.wowhead.com/spell=63101	Sentinel Luara: Character Force Cast From Gossip


update creature_template set gossip_menu_id=10339,AIName="",ScriptName="npc_sentinel_avana" where entry=33445;

delete from creature_text where entry=33445 and groupid=0 and id=0;
insert into creature_text values
(33445,0,0,"There is no hope for you. Your Darkshore lies in ruins. Astranaar will fall before the end of the day as will this place. Retreat to Darnassus while you still can.",12,0,100,0,0,0,"",33482);

