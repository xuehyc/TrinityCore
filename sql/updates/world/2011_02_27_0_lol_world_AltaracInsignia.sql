--Frostwolf Banner faction change to Frostwolf Clan
UPDATE gameobject_template SET faction = '1214' WHERE entry = '179025';
--Stormpike Banner faction change to Stormpike Clan
UPDATE gameobject_template SET faction = '1216' WHERE entry = '179024';
--Questreihe Frostwolf Insingia
UPDATE quest_template SET NextQuestId = '7163' WHERE entry = '7161'; --Rank 1
UPDATE quest_template SET NextQuestId = '7164' WHERE entry = '7163'; --Rank 2
UPDATE quest_template SET NextQuestId = '7165' WHERE entry = '7164'; --Rank 3
UPDATE quest_template SET NextQuestId = '7166' WHERE entry = '7165'; --Rank 4
UPDATE quest_template SET NextQuestId = '7167' WHERE entry = '7166'; --Rank 5

UPDATE quest_template SET PrevQuestId = '7161' WHERE entry = '7163'; --Rank 2
UPDATE quest_template SET PrevQuestId = '7163' WHERE entry = '7164'; --Rank 3
UPDATE quest_template SET PrevQuestId = '7164' WHERE entry = '7165'; --Rank 4
UPDATE quest_template SET PrevQuestId = '7165' WHERE entry = '7166'; --Rank 5
UPDATE quest_template SET PrevQuestId = '7166' WHERE entry = '7167'; --Rank 6
--Faction Requirement
UPDATE quest_template SET RepObjectiveFaction = '729' WHERE entry = '7163'; --Rank 2
UPDATE quest_template SET RepObjectiveFaction = '729' WHERE entry = '7164'; --Rank 3
UPDATE quest_template SET RepObjectiveFaction = '729' WHERE entry = '7165'; --Rank 4
UPDATE quest_template SET RepObjectiveFaction = '729' WHERE entry = '7166'; --Rank 5
UPDATE quest_template SET RepObjectiveFaction = '729' WHERE entry = '7167'; --Rank 6

UPDATE quest_template SET RepObjectiveValue = '3000' WHERE entry = '7163'; --Rank 2 friendly
UPDATE quest_template SET RepObjectiveValue = '9000' WHERE entry = '7164'; --Rank 3 honored
UPDATE quest_template SET RepObjectiveValue = '21000' WHERE entry = '7165'; --Rank 4 revered
UPDATE quest_template SET RepObjectiveValue = '42000' WHERE entry = '7166'; --Rank 5 exalted
UPDATE quest_template SET RepObjectiveValue = '42300' WHERE entry = '7167'; --Rank 6 exaltet + 300 rep not working why?

--Faction min Requirement
UPDATE quest_template SET RequiredMinRepFaction = '729' WHERE entry = '7163'; --Rank 2
UPDATE quest_template SET RequiredMinRepFaction = '729' WHERE entry = '7164'; --Rank 3
UPDATE quest_template SET RequiredMinRepFaction = '729' WHERE entry = '7165'; --Rank 4
UPDATE quest_template SET RequiredMinRepFaction = '729' WHERE entry = '7166'; --Rank 5
UPDATE quest_template SET RequiredMinRepFaction = '729' WHERE entry = '7167'; --Rank 6

UPDATE quest_template SET RequiredMinRepValue = '3000' WHERE entry = '7163'; --Rank 2 friendly
UPDATE quest_template SET RequiredMinRepValue = '9000' WHERE entry = '7164'; --Rank 3 honored
UPDATE quest_template SET RequiredMinRepValue = '21000' WHERE entry = '7165'; --Rank 4 revered
UPDATE quest_template SET RequiredMinRepValue = '42000' WHERE entry = '7166'; --Rank 5 exalted
UPDATE quest_template SET RequiredMinRepValue = '42300' WHERE entry = '7167'; --Rank 6 exaltet + 300 rep not working why?

--Questreihe Stormpike Insingia
UPDATE quest_template SET NextQuestId = '7168' WHERE entry = '7162'; --Rank 1
UPDATE quest_template SET NextQuestId = '7169' WHERE entry = '7168'; --Rank 2
UPDATE quest_template SET NextQuestId = '7170' WHERE entry = '7169'; --Rank 3
UPDATE quest_template SET NextQuestId = '7171' WHERE entry = '7170'; --Rank 4
UPDATE quest_template SET NextQuestId = '7172' WHERE entry = '7171'; --Rank 5

UPDATE quest_template SET PrevQuestId = '7162' WHERE entry = '7168'; --Rank 2
UPDATE quest_template SET PrevQuestId = '7168' WHERE entry = '7169'; --Rank 3
UPDATE quest_template SET PrevQuestId = '7169' WHERE entry = '7170'; --Rank 4
UPDATE quest_template SET PrevQuestId = '7170' WHERE entry = '7171'; --Rank 5
UPDATE quest_template SET PrevQuestId = '7171' WHERE entry = '7172'; --Rank 6
--Faction Requirement
UPDATE quest_template SET RepObjectiveFaction = '730' WHERE entry = '7168'; --Rank 2
UPDATE quest_template SET RepObjectiveFaction = '730' WHERE entry = '7169'; --Rank 3
UPDATE quest_template SET RepObjectiveFaction = '730' WHERE entry = '7170'; --Rank 4
UPDATE quest_template SET RepObjectiveFaction = '730' WHERE entry = '7171'; --Rank 5
UPDATE quest_template SET RepObjectiveFaction = '730' WHERE entry = '7172'; --Rank 6

UPDATE quest_template SET RepObjectiveValue = '3000' WHERE entry = '7168'; --Rank 2 friendly
UPDATE quest_template SET RepObjectiveValue = '9000' WHERE entry = '7169'; --Rank 3 honored
UPDATE quest_template SET RepObjectiveValue = '21000' WHERE entry = '7170'; --Rank 4 revered
UPDATE quest_template SET RepObjectiveValue = '42000' WHERE entry = '7171'; --Rank 5 exalted
UPDATE quest_template SET RepObjectiveValue = '42300' WHERE entry = '7172'; --Rank 6 exaltet + 300 rep

--Faction min Requirement
UPDATE quest_template SET RequiredMinRepFaction = '730' WHERE entry = '7168'; --Rank 2
UPDATE quest_template SET RequiredMinRepFaction = '730' WHERE entry = '7169'; --Rank 3
UPDATE quest_template SET RequiredMinRepFaction = '730' WHERE entry = '7170'; --Rank 4
UPDATE quest_template SET RequiredMinRepFaction = '730' WHERE entry = '7171'; --Rank 5
UPDATE quest_template SET RequiredMinRepFaction = '730' WHERE entry = '7172'; --Rank 6

UPDATE quest_template SET RequiredMinRepValue = '3000' WHERE entry = '7168'; --Rank 2 friendly
UPDATE quest_template SET RequiredMinRepValue = '9000' WHERE entry = '7169'; --Rank 3 honored
UPDATE quest_template SET RequiredMinRepValue = '21000' WHERE entry = '7170'; --Rank 4 revered
UPDATE quest_template SET RequiredMinRepValue = '42000' WHERE entry = '7171'; --Rank 5 exalted
UPDATE quest_template SET RequiredMinRepValue = '42300' WHERE entry = '7172'; --Rank 6 exaltet + 300 rep