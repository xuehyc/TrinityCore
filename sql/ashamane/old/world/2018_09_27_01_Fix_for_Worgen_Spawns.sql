-- Fix for Worgen spawns

UPDATE creature SET spawnDifficulties=0 WHERE guid BETWEEN 801209 AND 804942;