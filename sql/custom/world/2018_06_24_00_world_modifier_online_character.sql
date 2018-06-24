DELETE FROM `trinity_string` WHERE `entry` IN (11400, 11401);
REPLACE INTO `trinity_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES
  (11400, '|cffd3f4bcTime is money, friend!|r', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '|cffd3f4bcВремя выдачи наград онлайн игрокам.|r'),
  (11401, 'You get %u coins as a reward for your loyality. Thank you for playing here!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Вам было отправлено %u монет в качестве награды за посещение нашего мира. Спасибо, что с нами!');
