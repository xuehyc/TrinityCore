REVOKE ALL PRIVILEGES ON * . * FROM 'mobius'@'localhost';

REVOKE ALL PRIVILEGES ON `world` . * FROM 'mobius'@'localhost';

REVOKE GRANT OPTION ON `world` . * FROM 'mobius'@'localhost';

REVOKE ALL PRIVILEGES ON `characters` . * FROM 'mobius'@'localhost';

REVOKE GRANT OPTION ON `characters` . * FROM 'mobius'@'localhost';

REVOKE ALL PRIVILEGES ON `auth` . * FROM 'mobius'@'localhost';

REVOKE GRANT OPTION ON `auth` . * FROM 'mobius'@'localhost';

REVOKE ALL PRIVILEGES ON `hotfixes` . * FROM 'mobius'@'localhost';

REVOKE GRANT OPTION ON `hotfixes` . * FROM 'mobius'@'localhost';

DROP USER 'mobius'@'localhost';

DROP DATABASE IF EXISTS `world`;

DROP DATABASE IF EXISTS `characters`;

DROP DATABASE IF EXISTS `auth`;

DROP DATABASE IF EXISTS `hotfixes`;
