

-- http://www.wowhead.com/quest=25072
-- http://www.wowhead.com/npc=39082
UPDATE creature_template SET KillCredit1=39170 WHERE entry in (5441,5450,5451,5452,5453,5454);
UPDATE creature SET spawndist=10,MovementType=1 WHERE id in (5441,5450,5451,5452,5453,5454);

-- http://www.wowhead.com/npc=39081 Hazzali Cocoon
update creature_template set AIName="",ScriptName="npc_hazzali_cocoon" where entry=39082;

-- http://www.wowhead.com/npc=39082
update creature_template set minlevel=47,maxlevel=47,faction=474,AIName="",ScriptName="npc_captured_goblin_bughunter" where entry=39082;

delete from creature_text where entry=39082 and groupid=0 and id between 39198 and 39202;
insert into creature_text values
(39082,0,0,"I can breathe!",12,0,100,0,0,0,"captured goblin says",39198),
(39082,0,1,"What day is it?",12,0,100,0,0,0,"captured goblin says",39199),
(39082,0,2,"Hey! Those bugs took my watch!",12,0,100,0,0,0,"captured goblin says",39200),
(39082,0,3,"Thanks a ton, pal!",12,0,100,0,0,0,"captured goblin says",39201),
(39082,0,4,"I'm alive!",12,0,100,0,0,0,"captured goblin says",39202);

