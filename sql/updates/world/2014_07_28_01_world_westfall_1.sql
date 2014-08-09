
-- westfall startdialog and first quest's
-- some npc standing on wrong position, have wrong emote and wrong auras

-- http://www.wowhead.com/npc=42308  Lieutenant Horatio Laine
-- http://www.wowhead.com/npc=42309  Stormwind Investigator
-- http://www.wowhead.com/npc=42311  Crime Scene Alarm-o-Bot

delete from creature_template_addon where entry in (42308,42309,42311,237,238,582);
insert into creature_template_addon (entry,bytes1,bytes2,emote,auras) values
(42308,65636,1,0,79488),
(42309,65636,1,0,79488),
(42311,65636,1,0,79488),
(237,65636,1,0,79488),
(238,65636,1,0,79488),
(582,7,0,65,79488);

delete from creature where guid in (13619,42397,43299); -- guid by ArkDB
insert into creature (guid,id,map,modelid,position_x,position_y,position_z,orientation,spawntimesecs) values
(13619,42308,0,0,-9850.02,916.48,30.3026,4.0055,7200),
(42397,42309,0,32776,-9853.99,920.216,30.2154,5.45848,500),
(43299,42309,0,32775,-9853.42,909.219,29.8886,0.120533,500);

delete from creature_addon where guid in(13619,42397,43299); -- guid by ArkDB
insert into creature_addon (guid,bytes1,bytes2,emote,auras) values
(42397,8,0,0,79488);

-- http://www.wowhead.com/npc=42405  Two-Shoed Lou (alive)
delete from creature_template_addon where entry in (42405);
insert into creature_template_addon (entry,bytes1,bytes2,auras) values
(42405,65636,1,78284);

-- http://www.wowhead.com/npc=42558  Lieutenant Horatio Laine (10754)
-- http://www.wowhead.com/npc=42559  Stormwind Investigator (13615,13616)
-- http://www.wowhead.com/npc=42560  Two-Shoed Lou (dead) (13618)
-- http://www.wowhead.com/npc=42384  Homeless Stormwind Citizen (13614,13622)
delete from creature_template_addon where entry in (42558,42559,42560);
insert into creature_template_addon (entry,bytes1,bytes2,emote,auras) values
(42558,8,0,0,79343),
(42559,65636,1,0,79343),
(42560,7,0,65,79343);

-- insert quest http://www.wowhead.com/quest=26229 "I TAKE Candle!"
delete from creature_queststarter where id=42498 and quest=26229;
insert into creature_queststarter values (42498,26229);
delete from creature_questender where id=42498 and quest=26229;
insert into creature_questender values (42498,26229);

delete from creature where guid in (13615,13616); -- guid by ArkDB
insert into creature (guid,id,map,modelid,position_x,position_y,position_z,orientation,spawntimesecs) values
(13615,42559,0,0,-9859.54,1275.91,40.7858,2.74917,500),
(13616,42559,0,0,-9854.2,1275.14,40.9059,5.90646,500);

delete from creature_addon where guid in (10754,13614,13615,13616,13618,13622); -- guid by ArkDB
insert into creature_addon (guid,bytes1,bytes2,emote,auras) values
(13614,65636,1,431,79343),
(13622,65636,1,431,79343);

-- http://www.wowhead.com/quest=28562  Hero's Call: Westfall!
-- http://www.wowhead.com/quest=26378  Hero's Call: Westfall!
-- http://www.wowhead.com/spell=79489  SEE Quest Invis Zone 0
UPDATE quest_template SET SourceSpellId=79489 WHERE Id in (26378,28562);

-- http://www.wowhead.com/quest=26215  Meet Two-Shoed Lou
-- http://www.wowhead.com/spell=78284  Apply Quest Invis Zone 1
UPDATE quest_template SET SourceSpellId=78284 WHERE Id=26215;

-- http://www.wowhead.com/quest=26232  Lou's Parting Thoughts
-- http://www.wowhead.com/spell=79343  Apply Quest Invis Zone 2
-- after listen to the npc's, the invisible aura zone 0 and 1 is removed, instead aura zone 2 is applied.. done by core script..

-- ragamuffin 42413 are spawned from script..
delete from creature where id=42413;
update creature_text set BroadcastTextID=42364 where entry=42413 and groupid=0 and id in(0,1);
update creature_text set BroadcastTextID=42362 where entry=42413 and groupid=0 and id in(2,3);
update creature_text set BroadcastTextID=42363 where entry=42413 and groupid=0 and id=4;

-- set gossip for quest member
UPDATE creature_template SET gossip_menu_id=0, npcflag=1 WHERE entry in (42391,42383,42386);

-- set immune mask
UPDATE creature_template SET unit_flags=33536 WHERE entry in(42383,42386,42391);

-- children are not sleeping
update creature_template_addon set auras=NULL where entry=42385;
update creature set MovementType=1, spawndist=5 where guid in (42422,43551); -- guid by ArkDB

-- not all homeless or drifters are sleeping..
update creature_template_addon set auras=NULL where entry in (42391,42386);

update creature_template set AIName="", ScriptName="npc_horatio_lane_42308" where entry = 42308;
update creature_template set AIName="", ScriptName="npc_investigator_42309" where entry = 42309;
update creature_template set AIName="", ScriptName="npc_west_plains_drifters" where entry = 42391;
update creature_template set AIName="", ScriptName="npc_transient" where entry = 42383;
update creature_template set AIName="", ScriptName="npc_ragamuffin" where entry = 42413;
update creature_template set AIName="", ScriptName="" where entry = 42559;
update creature_template set AIName="", ScriptName="npc_horatio_lane_42558" where entry = 42558;
update creature_template set AIName="", ScriptName="npc_homeless_stormwind_citizen" where entry = 42386;
update creature_template set AIName="", ScriptName="npc_lues_old_house" where entry = 42500;
update creature_template set AIName="", ScriptName="npc_thug" where entry = 42387;
update creature_template set AIName="", ScriptName="npc_farmer_saldean" where entry = 233;


-- remove double ? on minimap for quest's Hero's Call: Westfall!
delete from quest_poi where questId in (26378,28562) and objIndex=-1;

-- set questorder
UPDATE quest_template SET NextQuestId=26209,ExclusiveGroup=26378,NextQuestIdChain=26209 WHERE Id=26378;
UPDATE quest_template SET NextQuestId=26209,ExclusiveGroup=26378,NextQuestIdChain=26209 WHERE Id=28562;
UPDATE quest_template SET PrevQuestId=0,NextQuestId=0,ExclusiveGroup=0,NextQuestIdChain=0 WHERE Id=26209;
UPDATE quest_template SET PrevQuestId=0,NextQuestId=26215,ExclusiveGroup=-26213,NextQuestIdChain=26215 WHERE Id=26213;
UPDATE quest_template SET PrevQuestId=0,NextQuestId=26215,ExclusiveGroup=-26213,NextQuestIdChain=26215 WHERE Id=26214;

delete from creature_text where entry=42308 and groupid between 3 and 7;
delete from creature_text where entry=42558 and groupid between 0 and 4;
insert into creature_text values
(42558,0,0,"Doesn't look good, rookie.",12,0,100,1,3000,0,"Horatio Laine Lou's murder 1st sentence",0),
(42558,1,0,"This was an execution. Whoever did this was sending a message.",12,0,100,1,3000,0,"Horatio Laine Lou's murder 2nd sentence",0),
(42558,2,0,"A message for anyone that would dare snitch on these criminals.",12,0,100,1,3000,0,"Horatio Laine Lou's murder 3rd sentence",0),
(42558,3,0,"It would appear that poor Lou readlly did put his foot...",12,0,100,1,3000,0,"Horatio Laine Lou's murder 4th sentence",0),
(42558,4,0,"In his mouth.",12,0,100,1,3000,0,"Horatio Laine Lou's murder 5th sentence",0);

delete from creature_text where entry=42559;
insert into creature_text values
(42559,0,0,"You were standing right here! What the hell did you see? Speak up!",12,0,100,1,3000,0,"Stormwind investigator Lou's murder 1st sentence",0),
(42559,1,0,"Natural causes? Two bullets in the chest and his shoes are on his head. What kind of natural death would that be?",12,0,100,1,3000,0,"Stormwind investigator Lou's murder 2nd sentence",0);

delete from creature_text where entry=42309;
insert into creature_text values
(42309,0,0,"It's a real bloodshed, lieutenant. They were murdered.",12,0,100,1,3,0,"Stormwind investigator 1st sentence",0),
(42309,1,0,"According to body temperature, I'll say they've been dead for less than six hours.",12,0,100,1,3,0,"Stormwind investigator 2nd sentence",0),
(42309,2,0,"What they did to Old Blanchy is truly a shame.",12,0,100,1,3,0,"Stormwind investigator 3rd sentence",0);

delete from npc_text where ID between 70 and 74;
insert into npc_text (ID,Text0_0) values
(70,"You wanna talk? Pay up."),
(71,"Whaddya want?"),
(72,"What do you want?"),
(73,"Get off my land!"),
(74,"You'll get nothing out of me!");

delete from creature_text where entry=42386 and groupid in (5,6) and id=0;
insert into creature_text values
(42386,5,0,"I... I didn't see nothin'! He... he died of natural causes.",12,0,100,0,0,0,"Answer to: Stormwind investigator Lou's murder 1st sentence",0);

delete from creature_text where entry=42383 and groupid=0;
insert into creature_text values
(42383,0,0,"Livin' like an animal is hard enough without your insults!",12,0,100,0,0,0,"aggro text #1",0),
(42383,0,1,"The only thing I'll tell you is to get the hell out of here!",12,0,100,0,0,0,"aggro text #2",0),
(42383,0,2,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,"aggro text #3",0),
(42383,0,3,"Looks like we'll be eating shoe leather for dinner again.",12,0,100,0,0,0,"aggro text #4",0),
(42383,0,4,"HEY! HEY YOU! GET OFF MY PROPERTY!",12,0,100,0,0,0,"aggro text #5",0),
(42383,0,5,"You can't buy me! DIE!",12,0,100,0,0,0,"aggro text #6",0),
(42383,0,6,"I ain't tellin' you a damn thing!",12,0,100,1,0,0,"aggro text #7",0),
(42383,0,7,"You rich punks are all the same!",12,0,100,1,0,0,"aggro text #8",0);

delete from creature_text where entry=42386 and groupid=0;
insert into creature_text values
(42386,0,0,"Livin' like an animal is hard enough without your insults!",12,0,100,0,0,0,"aggro text #1",0),
(42386,0,1,"The only thing I'll tell you is to get the hell out of here!",12,0,100,0,0,0,"aggro text #2",0),
(42386,0,2,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,"aggro text #3",0),
(42386,0,3,"Looks like we'll be eating shoe leather for dinner again.",12,0,100,0,0,0,"aggro text #4",0),
(42386,0,4,"HEY! HEY YOU! GET OFF MY PROPERTY!",12,0,100,0,0,0,"aggro text #5",0),
(42386,0,5,"You can't buy me! DIE!",12,0,100,0,0,0,"aggro text #6",0),
(42386,0,6,"I ain't tellin' you a damn thing!",12,0,100,1,0,0,"aggro text #7",0),
(42386,0,7,"You rich punks are all the same!",12,0,100,1,0,0,"aggro text #8",0);

delete from creature_text where entry=42391 and groupid=0;
insert into creature_text values
(42391,0,0,"Livin' like an animal is hard enough without your insults!",12,0,100,0,0,0,"aggro text #1",0),
(42391,0,1,"The only thing I'll tell you is to get the hell out of here!",12,0,100,0,0,0,"aggro text #2",0),
(42391,0,2,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,"aggro text #3",0),
(42391,0,3,"Looks like we'll be eating shoe leather for dinner again.",12,0,100,0,0,0,"aggro text #4",0),
(42391,0,4,"HEY! HEY YOU! GET OFF MY PROPERTY!",12,0,100,0,0,0,"aggro text #5",0),
(42391,0,5,"You can't buy me! DIE!",12,0,100,0,0,0,"aggro text #6",0),
(42391,0,6,"I ain't tellin' you a damn thing!",12,0,100,1,0,0,"aggro text #7",0),
(42391,0,7,"You rich punks are all the same!",12,0,100,1,0,0,"aggro text #8",0);

-- missing some queststarter and questender 
delete from creature_questender where id=42405 and quest=26215;
insert into creature_questender values(42405,26215);

delete from creature_questender where id=42405 and quest=26228;
insert into creature_questender values(42405,26228);

delete from creature_queststarter where id=42405 and quest=26228;
insert into creature_queststarter values(42405,26228);

delete from creature_queststarter where id=42405 and quest=26232;
insert into creature_queststarter values(42405,26232);

-- wrong faction for lou
update creature_template set faction=15, npcflag=2, unit_flags=33536 where entry=42405;
update creature_template set npcflag=1, unit_flags=33024 where entry=42384;

-- enable quest's
UPDATE quest_template SET Method=2,Flags=0,RequiredSourceItemId1=57761,RequiredSourceItemId4=0,RequiredSourceItemCount1=1,RequiredSourceItemCount4=0 WHERE Id=26228;
UPDATE quest_template SET Method=2,Flags=0 WHERE Id=26232;
UPDATE quest_template SET RequiredNpcOrGo1=42492,RequiredNpcOrGoCount1=1,ObjectiveText1="Use Two-Shoed Lou's Old House" WHERE Id=26228;

-- wrong questgiver portrait and text 
UPDATE quest_template SET QuestGiverPortrait=32828,QuestGiverTextWindow="Thug",QuestGiverTargetName="Thug" WHERE Id=26232;

UPDATE creature_template SET unit_flags=33536,mechanic_immune_mask=0 WHERE entry in (42492,42515);

-- thug
update creature set spawntimesecs=120 where id=42387;

-- prevent investigator to attack npc
UPDATE creature_template SET unit_flags=33536 WHERE entry=42559;

-- insert text for quest 26228
delete from creature_text where entry=42492 and groupid between 0 and 4;
insert into creature_text values 
(42492,0,0,"What little humie want? Why you call Glubtok?",12,0,100,0,0,0,"video text #1",42418),
(42492,1,0,"Glubtok crush you!",12,0,100,0,0,0,"video text #3",42420),
(42492,2,0,"What option two?",12,0,100,0,0,0,"video text #6",42422),
(42492,3,0,"So Glubtok have two choices: die or be rich and powerful?",12,0,100,0,0,0,"video text #8",42425),
(42492,4,0,"Glubtok take choice two.",12,0,100,0,0,0,"video text #9",42427);

delete from creature_text where entry=42515 and groupid between 0 and 5;
insert into creature_text values
(42515,0,0,"Sad... Is this the life you had hoped for, Glubtok? Running two-bit extortion operations out of a cave?",12,0,100,0,0,0,"video text #2",42419),
(42515,1,0,"Oh will you? Do you dare cross that line and risk your life?",12,0,100,0,0,0,"video text #4",42421),
(42515,2,0,"You may attempt to kill me - and fail - or you may take option two.",12,0,100,0,0,0,"video text #5",42423),
(42515,3,0,"You join me and I shower wealth and power upon you.",12,0,100,0,0,0,"video text #7",42424),
(42515,4,0,"I thought you'd see it my way.",12,0,100,0,0,0,"video text #10",42428),
(42515,5,0,"I will call for you when the dawning is upon us.",12,0,100,0,0,0,"video text #11",42429);

delete from creature_text where entry=42387 and groupid between 0 and 6;
insert into creature_text values
(42387,0,0,"Did you... Did you meet her?",12,0,100,0,0,0,"Thugs text #1",42439),
(42387,1,0,"Yep. She's for real.",12,0,100,0,0,0,"Thugs text #2",42440),
(42387,2,0,"She wanted me to tell you lugs that she appreciates the job that we did for her on the Furlbrows. Gave me a pile o' gold to split with you all.",12,0,100,0,0,0,"Thugs text #3",42441),
(42387,3,0,"See her face? Is it really...",12,0,100,0,0,0,"Thugs text #4",42442),
(42387,4,0,"Whoa, what do we have here? Looks like we have ourselves an eavesdropper, boys.",12,0,100,0,0,0,"Thugs text #5",42443),
(42387,5,0,"Only one thing to do with a lousy, good-for-nothin eavesdropper.",12,0,100,0,0,0,"Thugs text #6",42444),
(42387,6,0,"DIE!",12,0,100,0,0,0,"Thugs text #7",42445);

delete from creature_text where entry=42390 and groupid between 0 and 1;
insert into creature_text values
(42390,0,0,"Psssst...",12,0,100,0,0,0,"text #1",0),
(42390,1,0,"Keep your head low, $g buddy:lady;.",12,0,100,0,0,0,"text #2",42314);

-- append some broadcast id's
update creature_text set BroadcastTextID=42456 WHERE entry=42559 and groupid=0 and id=0;
update creature_text set BroadcastTextID=42458 WHERE entry=42559 and groupid=1 and id=0;
update creature_text set BroadcastTextID=42457 WHERE entry=42384 and groupid=0 and id=0;
update creature_text set BroadcastTextID=42447 WHERE entry=42558 and groupid=0 and id=0;
update creature_text set BroadcastTextID=42449 WHERE entry=42558 and groupid=1 and id=0;
update creature_text set BroadcastTextID=42450 WHERE entry=42558 and groupid=2 and id=0;
update creature_text set BroadcastTextID=42451 WHERE entry=42558 and groupid=3 and id=0;
update creature_text set BroadcastTextID=42452 WHERE entry=42558 and groupid=4 and id=0;

-- remove double ? from quest_poi
delete from quest_poi where questid=26232 and id=0;

-- update quest chain
UPDATE quest_template SET PrevQuestId=26232 WHERE Id=26236;
UPDATE quest_template SET PrevQuestId=26236 WHERE Id=26237;
UPDATE quest_template SET PrevQuestId=26237 WHERE Id=26270;
UPDATE quest_template SET PrevQuestId=26270 WHERE Id=26266;

-- ################################## insert some german locale

delete from locales_creature_text where entry=42308 and groupid between 0 and 2;
insert into locales_creature_text (entry,groupid,id,text_loc3) value 
(42308,0,0,"Im Ernst, Neuling..."),
(42308,1,0,"Offenbar haben sie den Wagen..."),
(42308,2,0,"... Vor das Pferd gespannt.");

delete from locales_creature_text where entry=42309 and groupid between 0 and 2;
insert into locales_creature_text (entry,groupid,id,text_loc3) value 
(42309,0,0,"Ein Blutbad, Leutnant. Sie sind ermordet worden."),
(42309,1,0,"Nach der Körpertemperatur würde ich sagen, sie sind noch keine 6 Stunden tot."),
(42309,2,0,"Eine Schande was sie Graumähne angetan haben.");

delete from locales_creature_text where entry=42558 and groupid between 0 and 4;
insert into locales_creature_text (entry,groupid,id,text_loc3) value 
(42558,0,0,"Es sieht nicht gut aus, Neuling."),
(42558,1,0,"Das war eine Hinrichtung. Wer immer es getan hat, wollte eine Botschaft hinterlassen."),
(42558,2,0,"Eine Botschaft an jeden, der es wagen würde diese Kriminellen zu verpfeiffen."),
(42558,3,0,"Es scheint als wäre der arme Lou wirklich tief..."),
(42558,4,0,"ins Fettnäpfchen getreten");

delete from locales_creature_text where entry=42559 and groupid between 0 and 1;
insert into locales_creature_text (entry,groupid,id,text_loc3) value 
(42559,0,0,"Ihr seid genau hier gestanden! Was in aller Welt habt ihr gesehen? Sprecht!"),
(42559,1,0,"Eines natürlichen Todes? Mit zwei Kugeln in der Brust und seinen Schuhen auf dem Kopf? Was ist daran denn bitte natürlich?");

delete from locales_npc_text where ID between 70 and 74;
insert into locales_npc_text (ID,text0_0_loc3) values 
(70,"Ihr wollt Informationen? Bezahlt."),
(71,"Was willst Du?"),
(72,"Was wollt Ihr?"),
(73,"Haut ab."),
(74,"Ich werde Euch nichts verraten!");

delete from locales_gossip_menu_option where menu_id=87;
insert into locales_gossip_menu_option (menu_id,id,option_text_loc3,box_text_loc3) values
(87,0,"Habt Ihr gesehen wer die Brauenwirbels getötet hat?",NULL),
(87,1,"Vielleicht lockern ein paar Kupfermünzen Eure Zunge. Sagt mir jetzt, habt Ihr gesehen wer die Brauenwirbels getötet hat?","Seid Ihr Euch sicher?");

delete from locales_creature_text where entry=42391 and groupid between 1 and 4;
insert into locales_creature_text (entry,groupid,id,text_loc3) values
(42391,1,0,"Hört zu, Kumpel. Ich möchte keinen Arger, verstanden? Ich habe nicht gesehen, wer sie ermordet hat, doch ganz siher gehört! Es war ein Riesengeschrei. Habt Ihr menschliche Stimmen darunter ausgemacht? Jetzt verschwindet, bevor ich es mir anders überlege, Euch zusammenschlage und Eure Schuhe mitnehme."),
(42391,2,0,"Ich habe nicht gesehen, wer sie getötet hat, Kumpel, doch ich habe eine Ahnung. Haben nach Geld gerochen, ein bisschen so wie Ihr. So eine Schande auch. Die Brauenwirbels waren angesehen und beliebt hier. Nette Leute. Immer herzlich und gastfreundlich."),
(42391,3,0,"Wer hat die Brauenwirbels getötet? Ich werde Euch sagen, wer die Brauenwirbels getötet hat: KÖNIG VARIAN WRYNN WAR ES! Und er wird uns Übrige ebenfalls töten. Einen nach dem anderen. Das Einzige, was ich Euch sagen kann, dass ich ein paar Stunden, bevor die Polizei eintraf, ein paar Gnolle verschwinden sah."),
(42391,4,0,"Unter uns. Murlocs haben die Brauenwirbels getötet. Ja. Ich habe sie mit eigenen Augen gesehen. Seit Tagen hatten sie die Gegend beobachtet, vielleicht auch schon seit Wochen. Als sie die Spurensicherung und die dümmliche Brigade dort drüben witterten, hatten sie es sehr eilig...");

delete from locales_creature_text where entry=42383 and groupid between 1 and 4;
insert into locales_creature_text (entry,groupid,id,text_loc3) values
(42383,1,0,"Hört zu, Kumpel. Ich möchte keinen Arger, verstanden? Ich habe nicht gesehen, wer sie ermordet hat, doch ganz siher gehört! Es war ein Riesengeschrei. Habt Ihr menschliche Stimmen darunter ausgemacht? Jetzt verschwindet, bevor ich es mir anders überlege, Euch zusammenschlage und Eure Schuhe mitnehme."),
(42383,2,0,"Ich habe nicht gesehen, wer sie getötet hat, Kumpel, doch ich habe eine Ahnung. Haben nach Geld gerochen, ein bisschen so wie Ihr. So eine Schande auch. Die Brauenwirbels waren angesehen und beliebt hier. Nette Leute. Immer herzlich und gastfreundlich."),
(42383,3,0,"Wer hat die Brauenwirbels getötet? Ich werde Euch sagen, wer die Brauenwirbels getötet hat: KÖNIG VARIAN WRYNN WAR ES! Und er wird uns Übrige ebenfalls töten. Einen nach dem anderen. Das Einzige, was ich Euch sagen kann, dass ich ein paar Stunden, bevor die Polizei eintraf, ein paar Gnolle verschwinden sah."),
(42383,4,0,"Unter uns. Murlocs haben die Brauenwirbels getötet. Ja. Ich habe sie mit eigenen Augen gesehen. Seit Tagen hatten sie die Gegend beobachtet, vielleicht auch schon seit Wochen. Als sie die Spurensicherung und die dümmliche Brigade dort drüben witterten, hatten sie es sehr eilig...");

delete from locales_creature_text where entry=42386 and groupid between 1 and 5;
insert into locales_creature_text (entry,groupid,id,text_loc3) values
(42386,1,0,"Hört zu, Kumpel. Ich möchte keinen Arger, verstanden? Ich habe nicht gesehen, wer sie ermordet hat, doch ganz siher gehört! Es war ein Riesengeschrei. Habt Ihr menschliche Stimmen darunter ausgemacht? Jetzt verschwindet, bevor ich es mir anders überlege, Euch zusammenschlage und Eure Schuhe mitnehme."),
(42386,2,0,"Ich habe nicht gesehen, wer sie getötet hat, Kumpel, doch ich habe eine Ahnung. Haben nach Geld gerochen, ein bisschen so wie Ihr. So eine Schande auch. Die Brauenwirbels waren angesehen und beliebt hier. Nette Leute. Immer herzlich und gastfreundlich."),
(42386,3,0,"Wer hat die Brauenwirbels getötet? Ich werde Euch sagen, wer die Brauenwirbels getötet hat: KÖNIG VARIAN WRYNN WAR ES! Und er wird uns Übrige ebenfalls töten. Einen nach dem anderen. Das Einzige, was ich Euch sagen kann, dass ich ein paar Stunden, bevor die Polizei eintraf, ein paar Gnolle verschwinden sah."),
(42386,4,0,"Unter uns. Murlocs haben die Brauenwirbels getötet. Ja. Ich habe sie mit eigenen Augen gesehen. Seit Tagen hatten sie die Gegend beobachtet, vielleicht auch schon seit Wochen. Als sie die Spurensicherung und die dümmliche Brigade dort drüben witterten, hatten sie es sehr eilig..."),
(42386,5,0,"Ich habe nichts gesehen, Er... er starb eines natürlichen Todes.");

delete from locales_creature_text where entry=42383 and groupid=0;
insert into locales_creature_text (entry,groupid,id,text_loc3) values
(42383,0,0,"Wie ein Tier zu leben ist schon ohne Eure Beschimpfungen schwer genug!"),
(42383,0,1,"Das Einzigte was ich Euch sagen werde, ist, das Ihr nichts erfahrt!"),
(42383,0,2,"Nun habt Ihr es geschafft! ZEIT, DIE FÄUSTE SPRECHEN ZU LASSEN!"),
(42383,0,3,"Wie es aussieht, werden wir wieder einmal Schuhsohlen zu Abend essen."),
(42383,0,4,"HE! HE,IHR DA! VERSCHWINDET VON MEINEM GRUND UND BODEN!"),
(42383,0,5,"Ihr könnt mich nicht kaufen! STERBT"),
(42383,0,6,"Ich werde Euch überhaupt nichts sagen!"),
(42383,0,7,"Ihr Reichen seid doch alle gleich!");

delete from locales_creature_text where entry=42386 and groupid=0;
insert into locales_creature_text (entry,groupid,id,text_loc3) values
(42386,0,0,"Wie ein Tier zu leben ist schon ohne Eure Beschimpfungen schwer genug!"),
(42386,0,1,"Das Einzigte was ich Euch sagen werde, ist, das Ihr nichts erfahrt!"),
(42386,0,2,"Nun habt Ihr es geschafft! ZEIT, DIE FÄUSTE SPRECHEN ZU LASSEN!"),
(42386,0,3,"Wie es aussieht, werden wir wieder einmal Schuhsohlen zu Abend essen."),
(42386,0,4,"HE! HE,IHR DA! VERSCHWINDET VON MEINEM GRUND UND BODEN!"),
(42386,0,5,"Ihr könnt mich nicht kaufen! STERBT"),
(42386,0,6,"Ich werde Euch überhaupt nichts sagen!"),
(42386,0,7,"Ihr Reichen seid doch alle gleich!");

delete from locales_creature_text where entry=42391 and groupid=0;
insert into locales_creature_text (entry,groupid,id,text_loc3) values
(42391,0,0,"Wie ein Tier zu leben ist schon ohne Eure Beschimpfungen schwer genug!"),
(42391,0,1,"Das Einzigte was ich Euch sagen werde, ist, das Ihr nichts erfahrt!"),
(42391,0,2,"Nun habt Ihr es geschafft! ZEIT, DIE FÄUSTE SPRECHEN ZU LASSEN!"),
(42391,0,3,"Wie es aussieht, werden wir wieder einmal Schuhsohlen zu Abend essen."),
(42391,0,4,"HE! HE,IHR DA! VERSCHWINDET VON MEINEM GRUND UND BODEN!"),
(42391,0,5,"Ihr könnt mich nicht kaufen! STERBT"),
(42391,0,6,"Ich werde Euch überhaupt nichts sagen!"),
(42391,0,7,"Ihr Reichen seid doch alle gleich!");

UPDATE locales_quest SET ObjectiveText1_loc3="Benutze Lou Zweischuhs altes Haus." WHERE Id=26228;
UPDATE locales_quest SET QuestGiverTextWindow_loc3="Rohling",QuestGiverTargetName_loc3="Rohling" WHERE Id=26232;


-- "Psssst..."
-- "Verhaltet Euch unauffällig, Kumpel."


















