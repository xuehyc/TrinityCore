--
-- Table structure for table `mail_external`
--
DROP TABLE IF EXISTS `mail_external`;
CREATE TABLE IF NOT EXISTS `mail_external` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receiver` bigint(20) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `item` int(11) DEFAULT NULL,
  `item_count` int(11) DEFAULT NULL,
  `sended` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;