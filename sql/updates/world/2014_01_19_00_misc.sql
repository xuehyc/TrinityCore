
-- quest 9393
UPDATE quest_template SET RequiredRaces=0,NextQuestId=10070,SpecialFlags=4 WHERE Id=9393;

-- quest 10070
UPDATE quest_template SET RequiredRaces=0,SpecialFlags=4 WHERE Id=10070;

-- there are many ! without npc on some quest..
delete from quest_poi where questId in (8325,8336,8337,10073) and id=2;
delete from quest_poi_points where questId in (8325,8336,8337,10073) and id=2;

-- wrong level..
UPDATE quest_template SET Level=3,MinLevel=2 WHERE Id=10070;

-- quest 8345 using gameobject 180516 without function
UPDATE quest_template SET SpecialFlags=4,RequiredNpcOrGo1=-180516,RequiredNpcOrGoCount1=1 WHERE Id=8345;
update gameobject_template set data1=8345 where entry=180516;

-- quest 9799
UPDATE quest_template SET Method=2,Flags=524288,SpecialFlags=4 WHERE Id=9799;

-- quest 9280
UPDATE quest_template SET RequiredRaces=1024,SpecialFlags=4,NextQuestId=9409 WHERE Id=9280;

-- quest 9369
UPDATE quest_template SET RequiredRaces=2097229,SpecialFlags=4,NextQuestId=9409 WHERE Id=9369;

-- quest chain  10302
UPDATE quest_template SET NextQuestId=10302 WHERE Id=9371;
UPDATE quest_template SET NextQuestId=9293,SpecialFlags=4 WHERE Id=10302;

-- npc 16483 is not a quest starter
delete from creature_queststarter where id=16483;

-- quest 9313
UPDATE quest_template SET SpecialFlags=4 WHERE Id=9313;

-- quest 9288
UPDATE quest_template SET Method=2,RequiredRaces=0,NextQuestId=26963,SpecialFlags=4,Details="I'm glad that you have come to me.  For quite some time now I have been responsible for the training of our young hunters, a responsibility that I intend to continue on this new world.  I've had my eye upon you for a while now and it would be my honor to help train you in the ways of the $C.$B$BShall we begin?",OfferRewardText="" WHERE Id=9288;

-- quest 26963
UPDATE quest_template SET RequiredRaces=0,Flags=524288,SpecialFlags=4 WHERE Id=26963;





