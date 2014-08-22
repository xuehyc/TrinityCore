
-- http://www.wowhead.com/quest=24951   A Great Idea
-- http://www.wowhead.com/npc=5451		Hazzali Swarmer
-- http://www.wowhead.com/npc=38739		Wrangled Swarmer
-- http://www.wowhead.com/npc=38742		Wrangled Bug Credit Bunny
-- http://www.wowhead.com/npc=38718		Silithid Bait <Meaty>
-- http://www.wowhead.com/item=52031    Bootlegger Bug Bait
-- http://www.wowhead.com/spell=72659   Throw Hyena Chunk
-- http://www.wowhead.com/spell=72677	Summon Wrangled Silithid
-- http://www.wowhead.com/spell=72681	Wrangling a Silithid


-- wrong questgiverportrait  
UPDATE quest_template SET QuestGiverPortrait=11093,RequiredNpcOrGo1=38742,QuestGiverTextWindow="Wrangled Swarmer",QuestGiverTargetName="Wrangled Swarmer" WHERE Id=24951;
update creature_template set AIName="", ScriptName="npc_silithid_bait_meaty" where entry=38718;

