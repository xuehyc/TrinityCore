
update creature_template set gossip_menu_id=0, KillCredit1=42625, KillCredit2=0 where entry in(42383,42391);
update creature_template set KillCredit1=0, KillCredit2=0 where entry=42386;
update creature_template set KillCredit1=0, KillCredit2=0 where entry=42625;
update creature_template set KillCredit1=42625 where entry in(42414,42415,42416,42417);

update quest_template set RequiredNpcOrGo1=42414,RequiredNpcOrGoCount1=1 where id=26209;
update quest_template set RequiredNpcOrGo2=42415,RequiredNpcOrGoCount2=1 where id=26209;
update quest_template set RequiredNpcOrGo3=42416,RequiredNpcOrGoCount3=1 where id=26209;
update quest_template set RequiredNpcOrGo4=42417,RequiredNpcOrGoCount4=1 where id=26209;

delete from quest_poi where questId=26209 and id=0 and objIndex=-1;


