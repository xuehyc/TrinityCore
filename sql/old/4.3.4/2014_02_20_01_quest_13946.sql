
-- teldrassil quest 13946

-- wrong display id in quest
update quest_template set QuestGiverPortrait=6809 where Id=13946;

-- additional killcredit
update creature_template set KillCredit1=34440 where entry=2002;



