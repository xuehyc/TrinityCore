-- close #216: fix wrong NpcOrGoId1 for Mounting Up
UPDATE quest_template SET RequiredNpcOrGo1=26472 WHERE id=12414 LIMIT 1;
