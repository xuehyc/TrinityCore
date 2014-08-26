
-- http://www.wowhead.com/npc=15701	Field Marshal Snowfall <War Effort Commander>
-- has active creature_questtaker 
-- 15701	8795	http://www.wowhead.com/quest=8795	The Alliance Needs Your Help!
-- 15701	8796	http://www.wowhead.com/quest=8796	The Alliance Needs Your Help!
-- 15701	8797	http://www.wowhead.com/quest=8797	The Alliance Needs Your Help!
-- 15701	8846	http://www.wowhead.com/quest=8846	Five Signets for War Supplies 
-- 15701	10501	http://www.wowhead.com/quest=10501	The Alliance Needs Your Help!

-- all are obsolete since 3.0.8, so i remove the active creature_questtaker entry's

delete from creature_questtaker where id=15701 and quest in (8795,8796,8797,8846,10501);



