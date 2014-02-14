
-- wrong queststarter
DELETE FROM creature_queststarter WHERE id=2700 and quest = 26079;
-- double and obsolete quest 685
DELETE FROM creature_queststarter WHERE id=2713 and quest = 685;
DELETE FROM gameobject_queststarter WHERE id=2713 and quest = 685;


