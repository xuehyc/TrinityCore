-- fix quest chain linking for sons of hodir chain
UPDATE quest_template SET PrevQuestId = 12956 WHERE Id = 12924;
UPDATE quest_template SET PrevQuestId = 12915 WHERE Id = 12922;
UPDATE quest_template SET PrevQuestId = 12900 WHERE Id = 12983;