
-- troll
-- autocomplete
UPDATE quest_template SET Flags=524288,SpecialFlags=4 WHERE Id=24814;

-- move Vanira to start position
UPDATE creature SET position_x=-739.79,position_y=-5615.713,position_z=25.09844 WHERE guid=92950;  -- 38437

-- move Zuni to start position
UPDATE creature SET position_x=-746.9446,position_y=-5611.333,position_z=25.28383 WHERE guid=88645; -- 38423

-- set Vol'jin to phase 1
update creature set phasemask=1 where guid=93786;

-- missing one npc
INSERT INTO creature VALUES (NULL,38301,1,1,1,0,0,-704.3971,-5586.532,25.7576,0,300,0,0,100,0,0,0,0,0);

-- some text from wowhead
delete from creature_text where entry=38423; -- Zuni
insert into creature_text values(38423,0,0,"I'll get the fires dis time!",14,0,100,0,0,0,"");

delete from creature_text where entry=38306; -- Zar'jira
insert into creature_text values(38306,0,0,"Leave the fire alone, pesky trolls! Just give up and die.",14,0,100,0,0,0,"");
insert into creature_text values(38306,1,0,"My power is waning... you fool! I will come for you next!",14,0,100,0,0,0,"");
insert into creature_text values(38306,2,0,"No! I will make your death slow and painful, little trolls.",14,0,100,0,0,0,"");
insert into creature_text values(38306,3,0,"Not so fast, little troll!",14,0,100,0,0,0,"");
insert into creature_text values(38306,4,0,"You are weak Vol'jin, like your father was weak. Today I will finish what I started long ago - the Darkspear shall be wiped from existence!",14,0,100,0,0,0,"");
insert into creature_text values(38306,5,0,"You were a fool to touch my fires! When Vol'jin falls, you know who dies next!",14,0,100,0,0,0,"");

delete from creature_text where entry=38225; -- Vol'jin
insert into creature_text values(38225,0,0,"Ya were foolish to come 'ere, Sea Witch. Ya escaped our vengeance once, but the Darkspear Tribe will not abide ya trespassin' again.",14,0,100,0,0,0,"");
insert into creature_text values(38225,1,0,"I been waitin' a long time for a chance to avenge my father. A great weight has been lifted from my shoulders.",12,0,100,0,0,0,"");
insert into creature_text values(38225,2,0,"I must be returnin' ta Darkspear Hold. Please meet me there once Vanira is done with her healin' of the boy.",12,0,100,0,0,0,"");
insert into creature_text values(38225,3,0,"I've no love for Garrosh, dat much is sure, but leavin' tha Horde is not a decision I be takin' lightly.",12,0,100,0,0,0,"");
insert into creature_text values(38225,4,0,"It be done. Our ancient enemy is defeated.",12,0,100,0,0,0,"");

delete from creature_text where entry=38437; -- Vanira
insert into creature_text values(38437,0,0,"Take care of her spirits! We be handlin' Zar'jira.",14,0,100,0,0,0,"");
insert into creature_text values(38437,1,0,"ZUNI! NOOOO!",14,0,100,0,0,0,"");
insert into creature_text values(38437,2,0,"I'll send some watchers ta get his body so we can offer a proper farewell... I wish I could do more.",12,0,100,0,0,0,"");
insert into creature_text values(38437,3,0,"I'm afraid there's nothin' I can do for our brother... her power tore away at his soul.",12,0,100,0,0,0,"");
insert into creature_text values(38437,4,0,"Vol'jin rushed off in eagerness, but I can take us back to safety. Just give me the word when ya ready, mon.",12,0,100,0,0,0,"");

update creature_template set AIName="",ScriptName="npc_zuni" where entry=38423;
update creature_template set AIName="",ScriptName="npc_zarjira" where entry=38306;
update creature_template set AIName="",ScriptName="npc_voljin" where entry=38225;
update creature_template set AIName="",ScriptName="npc_vanira" where entry=38437;






