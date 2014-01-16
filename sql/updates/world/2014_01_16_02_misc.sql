

-- http://www.wowhead.com/npc=198  Khelden Bremen
-- he is not queststarter for quest 3104

delete from creature_queststarter where id=198 and quest=3104;
 

-- http://www.wowhead.com/npc=42937  Blackrock Invader
-- there are >50 npc.. wowhead : 17.. i delete 26 of them

set @ENTRY=42937;
delete from creature where id=@ENTRY and guid in(48844,48506,48106,48564,48075,48786,48825,49218,49571,49176,49819,49662,49918,49952,49963,49538,49120,49997,49961,49959,49919,49965,50034,50045,50007,50071);
delete from creature_addon where guid in(48844,48506,48106,48564,48075,48786,48825,49218,49571,49176,49819,49662,49918,49952,49963,49538,49120,49997,49961,49959,49919,49965,50034,50045,50007,50071);

update creature_template set AIName="",ScriptName="npc_blackrock_invader" where entry=@entry;

delete from creature_text where entry=@ENTRY;
INSERT INTO creature_text VALUES (@ENTRY,0,0,"Beg for life!",12,0,50,0,0,0,"on Aggro Text");
INSERT INTO creature_text VALUES (@ENTRY,0,1,"Blackrock take forest!",12,0,50,0,0,0,"on Aggro Text");
INSERT INTO creature_text VALUES (@ENTRY,0,2,"Eat you!",12,0,50,0,0,0,"on Aggro Text");
INSERT INTO creature_text VALUES (@ENTRY,0,3,"Orc KILL $R!",12,0,50,0,0,0,"on Aggro Text");
INSERT INTO creature_text VALUES (@ENTRY,0,4,"The grapes were VERY TASTY!",12,0,50,0,0,0,"on Aggro Text");


-- http://www.wowhead.com/npc=43278  Ashley Blank
-- wrong gossip text

SET @GOSSIPID=11860;
delete from gossip_menu where entry=@GOSSIPID;
insert into gossip_menu values (@GOSSIPID,16622);  

update npc_text set Text0_0="What can i do for you?",Text0_1="What can i do for you?" where ID=16622;

delete from gossip_menu_option where menu_id=@GOSSIPID;
insert into gossip_menu_option values (@GOSSIPID,0,3,"I seek training in the ways of the Hunter.",5,16,0,0,0,0,"");  
insert into gossip_menu_option values (@GOSSIPID,1,0,"Learn about Dual Talent Specialization.",1,1,10371,0,0,0,"");  
insert into gossip_menu_option values (@GOSSIPID,2,0,"I wish to unlearn my talents.",1,1,4461,0,0,0,"");  

--  http://www.wowhead.com/npc=44564  Wounded Trainee
update creature_template set KillCredit1=44175 where entry=44564;
 

-- http://www.wowhead.com/npc=49869  Stormwind Infantry
-- trying to help player.. wrong flags
 
SET @ENTRY := 49869; 
UPDATE creature SET MovementType=0,spawndist=0,unit_flags=658176 WHERE id=@entry;
update creature_template set AIName="",ScriptName="npc_stormwind_infantry" where entry=@entry;

delete from creature_text where entry=49869;
insert into creature_text values
(@entry,0,0,"Come, monsters! We will crush you!",14,0,100,0,0,0,""),
(@entry,0,1,"I'll kill a hundred more of your battle worgs!",14,0,100,0,0,0,""),
(@entry,0,2,"Look alive, men! There are orcs and worgs about!",14,0,100,0,0,0,""),
(@entry,0,3,"Your filthy dogs won't be enough!",14,0,100,0,0,0,""),
(@entry,0,4,"Your worgs are no match for the might of Stormwind!",14,0,100,0,0,0,""),
(@entry,1,0,"HELP!",12,0,100,0,0,0,""),
(@entry,1,1,"I could use a heal, brother!",12,0,100,0,0,0,""),
(@entry,1,2,"I need a heal!",12,0,100,0,0,0,""),
(@entry,1,3,"Make yourself useful and heal me, Paxton!",12,0,100,0,0,0,"");

-- http://www.wowhead.com/npc=49871  Blackrock Battle Worg
-- set movement on all worg's there are not involved in show fight

UPDATE creature SET spawndist=10,MovementType=1 WHERE id=49871;
UPDATE creature SET spawndist=0,MovementType=0 WHERE guid IN(48513,48771,49291,49913,49927,49947,49956,49968,49984,49996,50003,50016,50021,50046);
update creature_template set unit_flags=512,AIName="",ScriptName="npc_blackrock_battle_worg" where entry=49871;

-- wowhead  http://www.wowhead.com/npc=49874  Blackrock Spy
set @ENTRY=49874;

update creature_template set unit_flags=512 where entry=@ENTRY;

delete from creature_text WHERE entry=@ENTRY;
INSERT INTO creature_text VALUES (@ENTRY,0,0,"Orc KILL $R!",12,0,50,0,0,0,"on Aggro Text"); 
INSERT INTO creature_text VALUES (@ENTRY,0,1,"Blackrock take forest!",12,0,50,0,0,0,"on Aggro Text"); 
INSERT INTO creature_text VALUES (@ENTRY,0,2,"The grapes were VERY TASTY!",12,0,50,0,0,0,"on Aggro Text"); 
INSERT INTO creature_text VALUES (@ENTRY,0,3,"Beg for life!",12,0,50,0,0,0,"on Aggro Text");
INSERT INTO creature_text VALUES (@ENTRY,0,4,"Eat you!",12,0,50,0,0,0,"on Aggro Text");

-- http://de.wowhead.com/npc=50039
update creature_template set AIName="",ScriptName="npc_goblin_assassin" where entry=50039;

delete from creature_text where entry=50039;
insert into creature_text Values (50039,0,0,"DIE!!!",12,0,50,0,0,0,"on Aggro Text");
insert into creature_text Values (50039,0,1,"Time to join your friends, kissin' the dirt!",12,0,50,0,0,0,"on Aggro Text");
insert into creature_text Values (50039,0,2,"We'll kill anybody for the right price!",12,0,50,0,0,0,"on Aggro Text");
insert into creature_text Values (50039,0,3,"We're gonna burn this place to the ground!",12,0,50,0,0,0,"on Aggro Text");

update creature_template set unit_flags=512 where entry=50039;

SET @ENTRY=50047;

delete from creature_text where entry=@ENTRY and groupid=1;
insert into creature_text values 
(@ENTRY,1,0,"Bless you, hero!",12,0,100,0,0,0,""),
(@ENTRY,1,1,"I live to fight another day!",12,0,100,0,0,0,""),
(@ENTRY,1,2,"I will fear no evil!",12,0,100,0,0,0,""),
(@ENTRY,1,3,"I... I'm ok! I'm ok!",12,0,100,0,0,0,""),
(@ENTRY,1,4,"Thank the Light!",12,0,100,0,0,0,""),
(@ENTRY,1,5,"You're $P! The hero that everyone has been talking about! Thank you!",12,0,100,0,0,0,"");

UPDATE creature_template SET npcflag=1, AIName="",ScriptName="npc_injured_soldier" WHERE entry=@ENTRY LIMIT 1;

SET @ENTRY=50378;

update creature_template set name="Injured Stormwind Infantry",subname="Dummy" where entry=@ENTRY;

delete from creature_text where entry=@ENTRY and groupid=1;
insert into creature_text values 
(@ENTRY,1,0,"Bless you, hero!",12,0,100,0,0,0,""),
(@ENTRY,1,1,"I live to fight another day!",12,0,100,0,0,0,""),
(@ENTRY,1,2,"I will fear no evil!",12,0,100,0,0,0,""),
(@ENTRY,1,3,"I... I'm ok! I'm ok!",12,0,100,0,0,0,""),
(@ENTRY,1,4,"Thank the Light!",12,0,100,0,0,0,""),
(@ENTRY,1,5,"You're $P! The hero that everyone has been talking about! Thank you!",12,0,100,0,0,0,"");

UPDATE creature_template SET AIName="",ScriptName="npc_injured_soldier_dummy" WHERE entry=@ENTRY LIMIT 1;

SET @ENTRY := 951; 
delete from creature_text where entry=@ENTRY;
insert into creature_text values
(@ENTRY,0,0,"AND I LAY MY HANDS UPON YOU!",12,0,100,0,0,0,""),
(@ENTRY,0,1,"Be healed, brother!",12,0,100,0,0,0,""),
(@ENTRY,0,2,"BY THE LIGHT BE RENEWED!",12,0,100,0,0,0,""),
(@ENTRY,0,3,"FIGHT ON, BROTHER!",12,0,100,0,0,0,""),
(@ENTRY,0,4,"Let the Holy Light embrace you!",12,0,100,0,0,0,"");

-- http://www.wowhead.com/quest=26391  Extinguishing Hope

UPDATE quest_template SET SpecialFlags=4 WHERE Id=26391;

-- http://www.wowhead.com/quest=26918     The Power of the Light
-- autocomplete is wrong

UPDATE quest_template SET Method=2 WHERE Id=26918;
-- failure on wowhead
-- http://www.wowhead.com/quest=26919
-- http://www.wowhead.com/spell=589 has level 3, but on trinity is it level 4
-- i ignore wowhead and create the quest as is, without changing ArkDB
-- a youtube video show the quest is correct.. http://www.youtube.com/watch?v=Mmw8hUcLCoo

UPDATE quest_template SET Method=2,RequiredSpell=2061 WHERE Id=26919;

-- http://www.wowhead.com/quest=3101  Consecrated Letter
-- http://www.wowhead.com/npc=925     Brother Sammuel is queststarter to

delete from creature_queststarter WHERE id=925 and quest=3101;

-- http://www.wowhead.com/quest=3104   Glyphic Letter
-- type failure

UPDATE quest_template SET OfferRewardText="Haha, I knew my note would not dissuade you from your path. So, you're prepared then, are you? Prepared to accept your fate? Prepared to challenge the gods and any other forces that stand before you in the pursuit of knowledge and power?$B$BI will not lie, $N, you will be feared as much as respected. But also know this, I will be here for you when you need training. Simply seek me out as you grow more powerful." WHERE Id=3104;

-- Beating Them Back!
-- http://www.wowhead.com/quest=28757  mage
-- http://www.wowhead.com/quest=28762  paladin
-- http://www.wowhead.com/quest=28763  priest
-- http://www.wowhead.com/quest=28764  rogue
-- http://www.wowhead.com/quest=28765  warlock
-- http://www.wowhead.com/quest=28766  warrior
-- http://www.wowhead.com/quest=28767  hunter
-- http://www.wowhead.com/quest=29078  druide
-- http://www.wowhead.com/quest=31139  5.xx 

UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredRaces=1101 WHERE Id in (28757,28762,28763,28764,28765,28766,28767,29078,31139);
UPDATE quest_template SET RequiredClasses=128 WHERE Id=28757;
UPDATE quest_template SET RequiredClasses=2 WHERE Id=28762;
UPDATE quest_template SET RequiredClasses=16 WHERE Id=28763;
UPDATE quest_template SET RequiredClasses=8 WHERE Id=28764;
UPDATE quest_template SET RequiredClasses=256 WHERE Id=28765;
UPDATE quest_template SET RequiredClasses=1 WHERE Id=28766;
UPDATE quest_template SET RequiredClasses=4 WHERE Id=28767;
UPDATE quest_template SET RequiredClasses=1024 WHERE Id=29078;

-- wowhead http://www.wowhead.com/quest=28806 Fear No Evil hunter
-- wowhead http://www.wowhead.com/quest=28808 Fear No Evil priest
-- wowhead http://www.wowhead.com/quest=28809 Fear No Evil paladin
-- wowhead http://www.wowhead.com/quest=28810 Fear No Evil mage
-- wowhead http://www.wowhead.com/quest=28811 Fear No Evil rogue
-- wowhead http://www.wowhead.com/quest=28812 Fear No Evil warlock
-- wowhead http://www.wowhead.com/quest=28813 Fear No Evil warrier
-- wowhead http://www.wowhead.com/quest=29082 Fear No Evil druid

-- wrong minlevel
UPDATE quest_template SET MinLevel=3,RequiredNpcOrGo1=50047,RequiredNpcOrGoCount1=5 WHERE id IN (28806,28808,28809,28810,28811,28812,28813,29082);

-- missing mixed zone/class values
UPDATE quest_template SET ZoneOrSort=12,RequiredRaces=1101,Flags=524288,SpecialFlags=4 WHERE Id in (28806,28808,28809,28810,28811,28812,28813,29082);
-- missing text
UPDATE quest_template SET RequestItemsText="Rescue our soldiers!",CompletedText="Return to Brother Paxton behind Northshire Abbey in Elwynn Forest." WHERE Id in (28806,28808,28809,28810,28811,28812,28813,29082);

-- mixed zone/class values
UPDATE quest_template SET RequiredClasses=4 WHERE Id=28806;
UPDATE quest_template SET RequiredClasses=16 WHERE Id=28808;
UPDATE quest_template SET RequiredClasses=2 WHERE Id=28809;
UPDATE quest_template SET RequiredClasses=128 WHERE Id=28810;
UPDATE quest_template SET RequiredClasses=8 WHERE Id=28811;
UPDATE quest_template SET RequiredClasses=256 WHERE Id=28812;
UPDATE quest_template SET RequiredClasses=1 WHERE Id=28813;
UPDATE quest_template SET RequiredClasses=1024 WHERE Id=29082;

-- some wrong queststarter 
delete from creature_queststarter where id=951;
insert into creature_queststarter value (951,28806);
insert into creature_queststarter value (951,28808);
insert into creature_queststarter value (951,28809);
insert into creature_queststarter value (951,28810);
insert into creature_queststarter value (951,28811);
insert into creature_queststarter value (951,28812);
insert into creature_queststarter value (951,28813);
insert into creature_queststarter value (951,29082);

-- http://www.wowhead.com/npc=44548    Training Dummy in Northshire.  
-- http://www.wowhead.com/npc=44175    Spell Practice Credit
-- http://www.wowhead.com/quest=26913 Warrier Charging into Battle
-- http://www.wowhead.com/quest=26914 Warlock Corruption
-- http://www.wowhead.com/quest=26915 Rogue   The Deepest Cut
-- http://www.wowhead.com/quest=26916 Mage    Mastering the Arcane
-- http://www.wowhead.com/quest=26917 Hunter  The Hunter's Path
-- http://www.wowhead.com/quest=26918 Paladin The Power of the Light
-- http://www.wowhead.com/quest=26919 Priest  Learning the Word

-- http://www.wowhead.com/search?q=They+Sent+Assassins They Sent Assassins
-- http://www.wowhead.com/search?q=The+Rear+is+Clear The Rear is Clear

SET @ENTRY := 44548;
SET @CREDIT := 44175;

update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=2,QuestGiverPortrait=32778,QuestGiverTextWindow="Training Dummy",QuestGiverTargetName="Training Dummy" where id=26916; -- Mage quest
update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=1,QuestGiverPortrait=32778,QuestGiverTextWindow="Training Dummy",QuestGiverTargetName="Training Dummy" where id=26918; -- Paladin quest
update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=5,QuestGiverPortrait=32778,QuestGiverTextWindow="Training Dummy",QuestGiverTargetName="Training Dummy" where id=26917; -- Hunter quest
update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=5,QuestGiverPortrait=32778,QuestGiverTextWindow="Training Dummy",QuestGiverTargetName="Training Dummy" where id=26913; -- Warrier quest
update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=3,QuestGiverPortrait=32778,QuestGiverTextWindow="Training Dummy",QuestGiverTargetName="Training Dummy" where id=26915; -- Rogue quest
update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=5,QuestGiverPortrait=33967,QuestGiverTextWindow="Wounded Trainee",QuestGiverTargetName="Wounded Trainee" where id=26919; -- Priest quest
update quest_template set RequiredNpcOrGo1=@CREDIT,RequiredNpcOrGoCount1=5,QuestGiverPortrait=32778,QuestGiverTextWindow="Training Dummy",QuestGiverTargetName="Training Dummy" where id=26914; -- Warlock quest

-- quest chain paladin  28762, 28770, 3101, 26918, 28785 > 28793 28819
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=2,RequiredRaces=1101,NextQuestIdChain=0 where id in (28762,28770,3101,26918,28785,28793);
UPDATE quest_template SET NextQuestId=28770 WHERE Id=28762;
UPDATE quest_template SET NextQuestId=3101 WHERE Id=28770;
UPDATE quest_template SET NextQuestId=26918 WHERE Id=3101;
UPDATE quest_template SET NextQuestId=28785 WHERE Id=26918;
UPDATE quest_template SET NextQuestId=28793 WHERE Id=28785;
UPDATE quest_template SET NextQuestId=28819 WHERE Id=28793;

-- quest chain priest  28763 28771 3103 26919 28786 > 28794 28820
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=16,RequiredRaces=1101,NextQuestIdChain=0 where id in (28763,28771,3103,26919,28786,28794);
UPDATE quest_template SET NextQuestId=28771 WHERE Id=28763;
UPDATE quest_template SET NextQuestId=3103 WHERE Id=28771;
UPDATE quest_template SET NextQuestId=26919 WHERE Id=3103;
UPDATE quest_template SET NextQuestId=28786 WHERE Id=26919;
UPDATE quest_template SET NextQuestId=28794 WHERE Id=28786;
UPDATE quest_template SET NextQuestId=28820 WHERE Id=28794;

-- quest chain hunter   28767,28759,26910,26917,28780 >  28791 28817
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=4,RequiredRaces=1101,NextQuestIdChain=0 where id in (28767,28759,26910,26917,28780,28791);
UPDATE quest_template SET NextQuestId=28759 WHERE Id=28767;
UPDATE quest_template SET NextQuestId=26910 WHERE Id=28759;
UPDATE quest_template SET NextQuestId=26917 WHERE Id=26910;
UPDATE quest_template SET NextQuestId=28780 WHERE Id=26917;
UPDATE quest_template SET NextQuestId=28791 WHERE Id=28780;
UPDATE quest_template SET NextQuestId=28817 WHERE Id=28791;

-- quest chain mage   28757,28769,3104,26916,28784 > 28792 28818
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=128,RequiredRaces=1101,NextQuestIdChain=0 where id in (28757,28769,3104,26916,28784,28792);
UPDATE quest_template SET NextQuestId=28769 WHERE Id=28757;
UPDATE quest_template SET NextQuestId=3104 WHERE Id=28769;
UPDATE quest_template SET NextQuestId=26916 WHERE Id=3104;
UPDATE quest_template SET NextQuestId=28784 WHERE Id=26916;
UPDATE quest_template SET NextQuestId=28792 WHERE Id=28784;
UPDATE quest_template SET NextQuestId=28818 WHERE Id=28792;

-- quest chain rogue    28764,28772,3102,26915,28787 > 28795 28821
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=8,RequiredRaces=1101,NextQuestIdChain=0 where id in (28764,28772,3102,26915,28787,28795);
UPDATE quest_template SET NextQuestId=28772 WHERE Id=28764;
UPDATE quest_template SET NextQuestId=3102 WHERE Id=28772;
UPDATE quest_template SET NextQuestId=26915 WHERE Id=3102;
UPDATE quest_template SET NextQuestId=28787 WHERE Id=26915;
UPDATE quest_template SET NextQuestId=28795 WHERE Id=28787;
UPDATE quest_template SET NextQuestId=28821 WHERE Id=28795;

-- quest chain warlock   28765,28773,3105,26914,28788 > 28796 28822
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=256,RequiredRaces=1101,NextQuestIdChain=0 where id in (28765,28773,3105,26914,28788,28796,28822);
UPDATE quest_template SET NextQuestId=28773 WHERE Id=28765;
UPDATE quest_template SET NextQuestId=3105 WHERE Id=28773;
UPDATE quest_template SET NextQuestId=26914 WHERE Id=3105;
UPDATE quest_template SET NextQuestId=28788 WHERE Id=26914;
UPDATE quest_template SET NextQuestId=28796 WHERE Id=28788;
UPDATE quest_template SET NextQuestId=28822 WHERE Id=28796;

-- quest chain warrier    28766,28774,3100,26913,28789 > 28797 28823
UPDATE quest_template SET ZoneOrSort=12,Flags=524288,SpecialFlags=4,RequiredClasses=1,RequiredRaces=1101,NextQuestIdChain=0 where id in (28766,28774,3100,26913,28789,28797,28823);
UPDATE quest_template SET NextQuestId=28774 WHERE Id=28766;
UPDATE quest_template SET NextQuestId=3100 WHERE Id=28774;
UPDATE quest_template SET NextQuestId=26913 WHERE Id=3100;
UPDATE quest_template SET NextQuestId=28789 WHERE Id=26913;
UPDATE quest_template SET NextQuestId=28797 WHERE Id=28789;
UPDATE quest_template SET NextQuestId=28823 WHERE Id=28797;

-- http://www.wowhead.com/quest=28759  Lions for Lambs
-- http://www.wowhead.com/quest=28769  Lions for Lambs
-- http://www.wowhead.com/quest=28770  Lions for Lambs
-- http://www.wowhead.com/quest=28771  Lions for Lambs
-- http://www.wowhead.com/quest=28772  Lions for Lambs
-- http://www.wowhead.com/quest=28773  Lions for Lambs
-- http://www.wowhead.com/quest=28774  Lions for Lambs

-- some more quest text
UPDATE quest_template SET RequestItemsText="Kill the spies!" where Id in(28759,28769,28770,28771,28772,28773,28774);





-- 



