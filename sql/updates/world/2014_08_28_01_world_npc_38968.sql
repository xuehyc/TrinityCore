
-- http://www.wowhead.com/npc=38968	Mazoga

delete from creature_text where entry=38968 and groupid=0 and id between 0 and 3;
insert into creature_text values
(38968,0,0,"Behold! Sul'thraze the Lasher be rejoined!",12,0,100,0,0,0,"Say on Aggro",38914),
(38968,0,1,"Enough'a dis...Chief Sandscalp can't reward me if I'm dead, yah? Farewell, mon...for good.",12,0,100,0,0,0,"Say on Aggro",38915),
(38968,0,2,"Joke's on you, mon. I found Jang'thraze long ago. Had both of de halves...'til some wily one come and steal one away in de night.",12,0,100,0,0,0,"Say on Aggro",38912),
(38968,0,3,"Now dat Sang'thraze is mine again, de only thing ya be findin' here...is ya own fresh grave.",12,0,100,0,0,0,"Say on Aggro",38913);








