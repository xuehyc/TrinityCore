
-- fix - corect models for captive worgen 36698 26797 36798
UPDATE creature_template SET modelid1=30294 AND modelid2=30293 AND modelid3=30295 AND modelid4=0 WHERE entry IN (36698);
UPDATE creature_template SET modelid1=30293 AND modelid2=30294 AND modelid3=30295 AND modelid4=0 WHERE entry IN (36797);
UPDATE creature_template SET modelid1=30295 AND modelid2=30294 AND modelid3=30293 AND modelid4=0 WHERE entry IN (36798);
