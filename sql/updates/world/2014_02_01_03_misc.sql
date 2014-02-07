
--
-- quest 13919 A Trip to the Moonwell
--
UPDATE quest_template SET Flags=262146 WHERE Id=13919;

--
-- quest 26475 Elune's Tear
--
UPDATE quest_template SET Method=2 WHERE Id=26475;

--
-- quest 13867 Culling the Furbolg Threat
--
update creature_template set KillCredit1=3925 where entry in (3924,3926);

--
-- quest 13976 Three Friends of the Forest
--
update creature_template set AIName="",ScriptName="npc_bolyun_1" where entry=3698; 
update creature_template set AIName="",ScriptName="npc_bolyun_2" where entry=34599;
update creature_template set minlevel=26,maxlevel=26,mindmg=70.3,maxdmg=93.1,attackpower=171,minrangedmg=47.5,maxrangedmg=70.3,rangedattackpower=9 where entry=34602;

--
-- quest 13982 In a Bind
--
UPDATE quest_template SET PrevQuestId=13976 WHERE Id=13982;

--
-- quest 13985 Clear the Shrine
--
update creature set id=34604 where guid=70799 and id=34608;
update creature_template set KillCredit1=3774 where entry in (3772,3773);

--
-- quest 13987 The Last Stand
--
update creature_template set AIName="",ScriptName="npc_big_baobob" where entry=34604;
update creature_template set dmg_multiplier=0.5 where entry=34609;

--
-- quest 13849 Astranaar's Burning!
--
update creature_template set ModelId1=0,ModelId2=15880,AIName="",ScriptName="npc_astranaar_burning_fire_bunny" where entry=34123;
