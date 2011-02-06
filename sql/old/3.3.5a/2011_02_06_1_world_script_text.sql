DELETE FROM `script_texts` WHERE `entry` in range (-1800072,-1800079);
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
(18428,-1800072, 'Help! Help! They''re going to eat me!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,0,1,0,0, NULL),
(18428,-1800073, 'My children will be made orphans!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,0,1,0,0, NULL), 
(18428,-1800074, 'The ogres have the keys! Kill the ogres and get me out of here!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,0,1,0,0, NULL), 
(18428,-1800075, 'I''m done for!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,0,1,0,0, NULL),
(18428,-1800076, 'Death to the ogres!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(18428,-1800077, 'Spirits watch for you, $R.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(18428,-1800078, 'Many Thanks, hero!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL),
(18428,-1800079, 'Thank you, $R! Your service to the Mag''har will not be forgotten.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, NULL);