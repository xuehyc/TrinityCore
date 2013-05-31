-- Use on TrinityCORE 3.3.5a auth realm
-- both cores updates to 30/05/2013
-- STATUS: 100%

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- Update realms to 4.3.4
UPDATE `realmlist` SET `gamebuild` = '15595';

-- Update all accounts to 3
UPDATE `account` SET `expansion` = '3';

-- account
ALTER TABLE `account` 
	CHANGE `expansion` `expansion` tinyint(3) unsigned   NOT NULL DEFAULT 3 after `online`;

-- ip2nation
ALTER TABLE `ip2nation` ENGINE=InnoDB; 

-- ip2nationcountries
ALTER TABLE `ip2nationcountries` ENGINE=InnoDB; 

-- realmlist
ALTER TABLE `realmlist` 
	CHANGE `gamebuild` `gamebuild` int(10) unsigned   NOT NULL DEFAULT 15595 after `population`;


-- uptime
ALTER TABLE `uptime` 
	CHANGE `revision` `revision` varchar(255)  COLLATE utf8_general_ci NOT NULL DEFAULT 'ArkCORE' after `maxplayers`;

/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;