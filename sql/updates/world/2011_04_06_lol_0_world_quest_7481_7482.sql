-- Fix Quest #7481(H) &  #7482(A)'Elven Legends'
SET @HQuest = 7481;
SET @AQuest = 7482;
SET @Gossip = 5743; 	-- gossip_menu id Kariel
SET @Kariel = 179544; 	-- GO Skeletal Remains of Kariel Winthalus
SET @Lydros = 14368; 	-- Lorekeeper Lydros
-- update
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=@Kariel;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@Lydros;
-- creature_text
DELETE FROM creature_text WHERE entry = @Lydros;
INSERT INTO creature_text VALUES
(@Lydros,0,0,"I very much doubt that he will have anything to say, stranger...",0,0,0,1,0,0,'text0'),
(@Lydros,1,0,"I personally didn't mind him. It was the Prince who took exception to a high elf in his domain. Alas, I am not one to question the Prince. In his defense, he did not incinerate master Winthalus immediately.",0,0,0,1,0,0,'text1'),
(@Lydros,2,0,"We most definitely do not need any more attention drawn to us, stranger. Return to those that sent you in search of the lost master and tell them that nothing could be found. When this is done - and I will know when it is so - return and I shall reveal the secrets of the deceased.",0,0,0,1,0,0,'text2');
-- gossip_menu_option
DELETE FROM gossip_menu_option WHERE menu_id = @Gossip;
INSERT INTO gossip_menu_option VALUES
(@Gossip,0,0,"Please, give me your knowledge!",1,1,0,0,0,0,0,''),
(@Gossip,1,0,"Please, give me your knowledge!",1,1,0,0,0,0,0,'');
-- SmartAI
DELETE FROM smart_scripts WHERE entryorguid IN (@Kariel,@Kariel*100,@Lydros);
INSERT INTO smart_scripts VALUES
(@Kariel,1,0,1,62,0,100,0,@Gossip,0,0,0,80,@Kariel*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'on gossip0 select - start script'),
(@Kariel,1,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
(@Kariel,1,2,3,62,0,100,0,@Gossip,1,0,0,80,@Kariel*100,0,0,0,0,0,1,0,0,0,0,0,0,0,'on gossip1 select - start script'),
(@Kariel,1,3,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
(@Kariel*100,9,1,0,0,0,100,0,1000,1000,0,0,45,0,1,0,0,0,0,9,@Lydros,0,15,0,0,0,0, 'set data 0 1'),
(@Kariel*100,9,2,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,9,@Lydros,0,30,0,0,0,0,'say text0'),
(@Kariel*100,9,3,0,0,0,100,0,4000,4000,0,0,1,1,0,0,0,0,0,9,@Lydros,0,30,0,0,0,0,'say text1'),
(@Kariel*100,9,4,0,0,0,100,0,6000,6000,0,0,1,2,0,0,0,0,0,9,@Lydros,0,30,0,0,0,0,'say text2'),
(@Kariel*100,9,5,7,0,0,100,0,4000,4000,0,0,15,@HQuest,0,0,0,0,0,7,0,0,0,0,0,0,0,'quest credit'),
(@Kariel*100,9,6,7,0,0,100,0,0,0,0,0,15,@AQuest,0,0,0,0,0,7,0,0,0,0,0,0,0,'quest credit'),
(@Kariel*100,9,7,0,0,0,100,0,2000,2000,0,0,45,0,2,0,0,0,0,9,@Lydros,0,15,0,0,0,0, 'set data  0 2'),
-- Lydros
(@Lydros,0,0,1,38,0,100,0,0,1,0,0,66,0,0,0,0,0,0,17,0,15,0,0,0,0,0, 'on dataset 0 1 - turn closest player'),
(@Lydros,0,1,0,38,0,100,0,0,2,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,3.12, 'on dataset 0 2 - turn to bookshelf');
-- conditions
DELETE FROM conditions WHERE SourceTypeOrReferenceId =15 AND SourceGroup = @Gossip;
DELETE FROM conditions WHERE SourceTypeOrReferenceId =20 AND SourceEntry IN (7483,7484,7485);
INSERT INTO conditions VALUES
(15,@Gossip,0,0,9,@HQuest,0,0,0,'','show gossip menu option if player has quest 7481'),
(15,@Gossip,1,0,9,@AQuest,0,0,0,'','show gossip menu option if player has quest 7482');