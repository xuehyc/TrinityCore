-- Fix -correct spawnDifficulties for maps 530, 860, 0, 1
UPDATE gameobject SET spawnDifficulties = 0 where map IN (530, 860, 0, 1);