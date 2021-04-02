DELETE FROM `creature_trainer` WHERE `CreatureId` IN (15279, 15284, 15280, 42618, 15285, 38244, 15513, 15283);
insert into `creature_trainer` values 
('15279', '44', '14136', '0'),
('15284', '127', '14139', '0'),
('15280', '168', '14137', '0'),
('42618', '32', '11645', '0'),
('15285', '17', '14140', '0'),
('38244', '17', '10985', '0'),
('15513', '15', '14141', '0'),
('15283', '32', '14138', '0');

DELETE FROM `gossip_menu_option` WHERE  `MenuId` IN (14136, 14139, 14137, 11645, 14140, 10985, 14141, 14138);

Insert into `gossip_menu_option` values
('14139','0','3', 'I seek more training in the priestly ways.','3266','5','16','15600'),
('14141','0','3', 'I seek training in the ways of the Hunter.','3266','5','16','15600'),
('14137','0','3', 'I require paladin training.','3266','5','16','15600'),
('14136','0','3', 'I am interested in mage training.','3266','5','16','15600'),
('14138','0','3', 'I am interested in warlock training.','3266','5','16','15600'),
('11645','0','3', 'I am interested in warlock training.','3266','5','16','15600'),
('10985','0','3', 'I would like training.','3266','5','16','15600'),
('14140','0','3', 'I would like training.','3266','5','16','15600'),
('14139','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('10985','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('14140','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('14137','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('14136','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('14138','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('11645','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('14141','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('14139','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('14137','2','0','I wish to know about Dual Talent Specialization.','33762','20','1','15600'),
('14136','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('14138','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('10985','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('14140','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('14141','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('11645','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600');