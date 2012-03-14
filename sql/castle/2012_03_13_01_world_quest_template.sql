-- Fix drop of draconic for dummies chapters, missing ReqSourceItemId for negative ChanceOrQuestChance
UPDATE quest_template SET RequiredSourceItemId1=21110, RequiredSourceItemId2=21108, RequiredSourceItemCount1=1, RequiredSourceItemCount2=1 WHERE Id=8620;
