
-- http://www.wowhead.com/quest=13849	Astranaar's Burning!
-- wrong model id for the fire, i found no correct

update quest_template set QuestGiverPortrait=0, QuestGiverTextWindow="",QuestGiverTargetName="" where Id=13849;
