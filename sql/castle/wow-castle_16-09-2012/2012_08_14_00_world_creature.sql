-- correct spawn time and phasemask for greater elementals in wintergrasp
UPDATE creature SET spawntimesecs = 300, phasemask = 257 WHERE id IN (30876, 30873, 30877, 30872, 34300);