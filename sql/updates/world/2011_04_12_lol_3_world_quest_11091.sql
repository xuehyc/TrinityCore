-- Fix Required Reputation of Quest 'A Special Thank You' #11091
UPDATE quest_template SET ReqMinRepValue = 3000 WHERE entry = 11091;