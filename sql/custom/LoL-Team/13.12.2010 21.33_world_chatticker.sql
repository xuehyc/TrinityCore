CREATE TABLE `chatticker` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(12) NOT NULL,
  `race` tinyint(3) NOT NULL,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `timestamp` (`timestamp`)
)