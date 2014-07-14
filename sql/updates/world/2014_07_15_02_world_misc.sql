
SET @quest_murder=26209; -- 		http://www.wowhead.com/quest=26209 	Murder Was The Case That They Gave Me
SET @npc_investigator1=42559; --   	http://www.wowhead.com/npc=42559	Stormwind Investigator
SET @npc_investigator2=42309; --   	http://www.wowhead.com/npc=42309	Stormwind Investigator
SET @npc_horatio=42308; --   		http://www.wowhead.com/npc=42308	Lieutenant Horatio Laine
SET @npc_bot=42311; --				http://www.wowhead.com/npc=42311	Crime Scene Alarm-o-Bot
SET @npc_drifters=42391; --			http://www.wowhead.com/npc=42391	West Plains Drifter
SET @npc_citizen=42386; --			http://www.wowhead.com/npc=42386	Homeless Stormwind Citizen
SET @npc_transient=42383; --		http://www.wowhead.com/npc=42383	Transient
SET @npc_ragamuffin=42413; --		http://www.wowhead.com/npc=42413	Ragamuffin
SET @npc_old_blanchy=582; -- 		http://www.wowhead.com/npc=582		Old Blanchy

-- investigator1 is invisible.. wrong
update creature_template_addon set auras=NULL where entry=@npc_investigator1;

-- investigator1 wrong position
update creature set position_x=-9854.61, position_y=907.874, position_z=29.8131, orientation=0.742147 where guid=43299 and id=@npc_investigator1; 

-- investigator2 wrong position
update creature set position_x=-9854.988281, position_y=920.216248, position_z=30.215382, orientation=5.458476 where guid=42397 and id=@npc_investigator2;

-- investigator1 
update creature_template set faction=11, npcflag=0, gossip_menu_id=0, minlevel=21, maxlevel=24 WHERE entry=@npc_investigator1;

-- investigator2 has gossip flag.. wrong,
UPDATE creature_template SET npcflag=2, gossip_menu_id=0 WHERE entry=@npc_investigator2;

-- investigator1 has more text
delete from creature_text where entry=@npc_investigator1 and groupid=3 and id=0;
insert into creature_text values (@npc_investigator1,3,0,"Damn shame what they did to Old Blanchy...",12,0,100,0,0,0,"",0);

-- random move for npc_bot
update creature set spawndist=15, MovementType=1 where guid in (26686,26687,26688,26689) and id=@npc_bot;

-- correct position for dead horse old blunchy
update creature set position_x=-9851.66, position_y=909.887, position_z=29.911, orientation=4.75661 where guid=6878 and id=582;

-- correct start position for horatio lane
update creature set position_x=-9850.017578, position_y=916.479980, position_z=30.302572, orientation=4.005495 where guid=13619 and id=@npc_horatio;

-- move to corescript
update creature_template set AIName="",ScriptName="npc_horatio_lane" where entry=@npc_horatio;
update creature_template set AIName="",ScriptName="npc_investigator42559" where entry=@npc_investigator1;
update creature_template set AIName="",ScriptName="npc_investigator42309" where entry=@npc_investigator2;
update creature_template set AIName="",ScriptName="npc_west_plains_drifters" where entry=@npc_drifters;
update creature_template set AIName="",ScriptName="npc_homeless_stormwind_citizen" where entry=@npc_citizen;
update creature_template set AIName="",ScriptName="npc_transient" where entry=@npc_transient;
update creature_template set AIName="",ScriptName="npc_ragamuffin" where entry=@npc_ragamuffin;

-- wrong required entry for quest 26209
UPDATE quest_template SET RequiredNpcOrGo1=42414,RequiredNpcOrGo2=42415,RequiredNpcOrGo3=42416,RequiredNpcOrGo4=42417,RequiredNpcOrGoCount1=1,RequiredNpcOrGoCount2=1,RequiredNpcOrGoCount3=1,RequiredNpcOrGoCount4=1 WHERE Id=26209;

-- set questchain for the serie
UPDATE quest_template SET NextQuestId=26209, ExclusiveGroup=26378 WHERE id=26378;
UPDATE quest_template SET NextQuestId=26209, ExclusiveGroup=26378 WHERE id=28262;
UPDATE quest_template SET PrevQuestId=26209, NextQuestId=26215, ExclusiveGroup=26213  WHERE id=26213;   
UPDATE quest_template SET PrevQuestId=26209, NextQuestId=26215, ExclusiveGroup=26213  WHERE id=26214;  
UPDATE quest_template SET NextQuestIdChain=26228 WHERE id=26215;
UPDATE quest_template SET NextQuestIdChain=26232  WHERE id=26228;

-- add random move
update creature set spawndist=10, MovementType=1 where id=42391;

-- npc_ragamuffin are spawned from script..
delete from creature where id=@npc_ragamuffin;

-- quest 26209 want correct killkredit..  the part KillCredit1=42625 is from 5.4.2 and not necessary yet..
UPDATE creature_template SET KillCredit1=42414,KillCredit2=42625 WHERE entry=42391;  
UPDATE creature_template SET KillCredit1=42414,KillCredit2=42625 WHERE entry=42383;
UPDATE creature_template SET KillCredit1=42414,KillCredit2=42625 WHERE entry=42386;
UPDATE creature_template SET KillCredit1=42415 WHERE entry=42414;
UPDATE creature_template SET KillCredit1=42416 WHERE entry=42415;
UPDATE creature_template SET KillCredit1=42417 WHERE entry=42416;
UPDATE creature_template SET KillCredit1=42414 WHERE entry=42417;

-- missing gossip menu
UPDATE creature_template SET npcflag=1, gossip_menu_id=11635 WHERE entry in (42391,42383,42386);
delete from gossip_menu where entry=11635;
insert into gossip_menu values(11635,11635);














