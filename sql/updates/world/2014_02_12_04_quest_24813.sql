
-- troll
-- Territorial Fetish

UPDATE quest_template SET Method=2,SpecialFlags=4,ExclusiveGroup=0,RequiredSourceItemId1=52065,RequiredSourceItemId4=0,RequiredSourceItemCount1=1 WHERE Id=24813;

update creature_template set AIName="",ScriptName="npc_echo_isles_quest_bunny" where entry=38003;

-- wrong npc is spawned
update creature set id=38003 where id=38560; 

