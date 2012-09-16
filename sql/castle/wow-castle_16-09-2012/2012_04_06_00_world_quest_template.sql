-- @DorianGrey
-- Added a missing quest dependency from "Forging an Alliance" (Q 12924) and "You Can't Miss Him" (Q 12966).
-- It was possible to take 12966 without starting 12924, which breaks down the quest-chain, since 12924 cannot 
-- be completed when following the other quest-chain before starting it.
UPDATE `quest_template` SET `PrevQuestId`=-12924 WHERE `Id`=12966;