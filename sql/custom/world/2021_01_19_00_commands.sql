DELETE FROM `command` WHERE `name` IN ('reload trinity_string', 'reload warhead_string');
INSERT INTO `command`(`name`, `help`) VALUES ('reload warhead_string', 'Syntax: .reload warhead_string\nReload warhead_string table.');
