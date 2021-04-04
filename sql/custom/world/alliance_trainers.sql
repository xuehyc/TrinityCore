DELETE FROM `creature_trainer` WHERE `CreatureId` IN (37115, 37121, 42331, 42323, 42366, 43006, 43455);
insert into `creature_trainer` values 
('43455', '32', '11831', '0'),
('43006', '44', '11810', '0'),
('42331', '44', '11620', '0'),
('37121', '44', '10878', '0'),
('37115', '134', '10879', '0'),
('42323', '127', '11617', '0'),
('42366', '17', '11621', '0');

DELETE FROM `gossip_menu_option` WHERE  `MenuId` IN ( 11620, 10878, 10879, 11617, 11621, 11810, 11831);

Insert into `gossip_menu_option` values
('11617','0','3', 'I seek more training in the priestly ways.','3266','5','16','15600'),
('11617','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('11617','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('11621','0','3', 'I would like training.','3266','5','16','15600'),
('11621','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('11621','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('11831','0','3', 'I am interested in warlock training.','3266','5','16','15600'),
('11831','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('11831','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('10879','0','3', 'Teach me the ways of the spirits.','3266','5','16','15600'),
('10879','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('10879','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('10878','0','3', 'I am interested in mage training.','3266','5','16','15600'),
('10878','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('10878','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('11620','0','3', 'I am interested in mage training.','3266','5','16','15600'),
('11620','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('11620','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600'),
('11810','0','3', 'I am interested in mage training.','3266','5','16','15600'),
('11810','1','0','I wish to unlearn my talents.','62295','16','16','15600'),
('11810','2','0','Learn about Dual Talent Specialization.','33762','20','1','15600');