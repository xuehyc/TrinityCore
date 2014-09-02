
-- http://www.wowhead.com/npc=17106	Vindicator Palanaar

-- is spawned twice.. remove one of them..
delete from creature where guid=98813 and id=17106; -- GUID by ArkDB

-- http://www.wowhead.com/quest=26453	A Helping Hand
-- http://www.wowhead.com/spell=63160	A Helping Hand: Summon Palanaar's Elekk
-- http://www.wowhead.com/npc=33514		Palanaar's Elekk

-- missing vehicle id