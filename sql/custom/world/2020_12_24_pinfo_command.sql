SET @r := '|r '; -- Reset color with whitespace
SET @r1 := '|r'; -- Reset color without whitespace
SET @red := '|cFFFF0000';
SET @extraColor := '|cff7bbef7';
SET @newLine := CONCAT(@red, '│', @r1, @extraColor);
SET @newLineList := CONCAT(@red, '│', @r1, '- ', @extraColor);

-- Add new strings
DELETE FROM `warhead_string` WHERE `entry` IN (453, 548, 549, 550, 714, 716, 749, 752, 788, 789, 843, 844, 845, 846, 847, 848, 849, 850, 851, 852, 853, 854, 871, 879, 882);
INSERT INTO `warhead_string`(`entry`, `content_default`, `content_loc8`) VALUES 

-- LANG_PINFO_PLAYER
(453, 
CONCAT(@newLine, 'Player:', @r, '%s%s ', @extraColor, '(guid:', @r, '%u', @extraColor, ')', @r1),
CONCAT(@newLine, 'Игрок:', @r, '%s%s ', @extraColor, '(номер:', @r, '%u', @extraColor, ')', @r1)),

-- LANG_PINFO_GM_ACTIVE
(548,
CONCAT(@newLine, 'GM Mode', @r, 'active', @extraColor, ', Phase:', @r, ' -1'),
CONCAT(@newLine, 'ГМ Мод', @r, 'активен', @extraColor, ', Фаза:', @r, ' -1')),

-- LANG_PINFO_BANNED_IP
(549,
CONCAT(@newLine, 'Banned: (Type:', @r, 'IP', @extraColor, ', Left', @r, '%s', @extraColor, ', Time:', @r, '%s', @extraColor, ', By:', @r, '%s', @extraColor, ', Reason:', @r, '%s', @extraColor, ')', @r1),
CONCAT(@newLine, 'Забанен: (Тип:', @r, 'IP', @extraColor, ', Осталось', @r, '%s', @extraColor, ', Время:', @r, '%s', @extraColor, ', Автор:', @r, '%s', @extraColor, ', Причина:', @r, '%s', @extraColor, ')', @r1)),

-- LANG_PINFO_MUTED
(550,
CONCAT(@newLineList, 'Muted: (Left:', @r, '%s', @extraColor, ', Time:', @r, '%s', @extraColor, ', By:', @r, '%s', @extraColor, ', Reason:', @r, '%s', @extraColor, ')', @r1),
CONCAT(@newLineList, 'Замьючен: (Осталось:', @r, '%s', @extraColor, ', Время:', @r, '%s', @extraColor, ', Автор:', @r, '%s', @extraColor, ', Причина:', @r, '%s', @extraColor, ')', @r1)),

-- LANG_PINFO_ACC_ACCOUNT
(714,
CONCAT(@newLine, 'Account:', @r, '%s ', @extraColor, '(ID:', @r, '%u', @extraColor, '), GMLevel:', @r, '%u'),
CONCAT(@newLine, 'Аккаунт:', @r, '%s ', @extraColor, '(Номер:', @r, '%u', @extraColor, '), ГМ уровень:', @r, '%u')),

-- LANG_PINFO_ACC_LASTLOGIN
(716,
CONCAT(@newLine, 'Last Login:', @r, '%s ', @extraColor, '(Failed Logins:', @r, '%u', @extraColor, ')', @r1),
CONCAT(@newLine, 'Последний вход:', @r, '%s ', @extraColor, '(Неудачные авторизации:', @r, '%u', @extraColor, ')', @r1)),

-- LANG_PINFO_ACC_OS
(749,
CONCAT(@newLine, 'OS:', @r, '%s. ', @extraColor, 'Latency:', @r, '%u', @extraColor, ' ms', @r1),
CONCAT(@newLine, 'ОС:', @r, '%s. ', @extraColor, 'Задержка:', @r, '%u', @extraColor, ' мс', @r1)),

-- LANG_PINFO_ACC_IP
(752,
CONCAT(@newLine, 'Last IP:', @r, '%s ', @extraColor, '(Locked:', @r, '%s', @extraColor, ')', @r1),
CONCAT(@newLine, 'Последний IP:', @r, '%s ', @extraColor, '(Заблокирован:', @r, '%s', @extraColor, ')', @r1)),

-- LANG_PINFO_BANNED_ACCOUNT
(788,
CONCAT(@newLineList, 'Banned: (Type:', @r, 'Account', @extraColor, ', Left', @r, '%s', @extraColor, ', Time:', @r, '%s', @extraColor, ', By:', @r, '%s', @extraColor, ', Reason:', @r, '%s', @extraColor, ')', @r1),
CONCAT(@newLineList, 'Забанен: (Тип:', @r, 'Аккаунт', @extraColor, ', Осталось', @r, '%s', @extraColor, ', Время:', @r, '%s', @extraColor, ', Автор:', @r, '%s', @extraColor, ', Причина:', @r, '%s', @extraColor, ')', @r1)),

-- LANG_PINFO_BANNED_CHARACTER
(789,
CONCAT(@newLineList, 'Banned: (Type:', @r, 'Character', @extraColor, ', Left', @r, '%s', @extraColor, ', Time:', @r, '%s', @extraColor, ', By:', @r, '%s', @extraColor, ', Reason:', @r, '%s', @extraColor, ')', @r1),
CONCAT(@newLineList, 'Забанен: (Тип:', @r, 'Персонаж', @extraColor, ', Осталось', @r, '%s', @extraColor, ', Время:', @r, '%s', @extraColor, ', Автор:', @r, '%s', @extraColor, ', Причина:', @r, '%s', @extraColor, ')', @r1)),

-- LANG_PINFO_CHR_LEVEL_LOW
(843,
CONCAT(@newLine, 'Level:', @r, '%u', @extraColor, '. XP:', @r, '%u/%u', @extraColor, '. XP left:', @r, '%u', @r1),
CONCAT(@newLine, 'Уровень:', @r, '%u', @extraColor, '. Опыт:', @r, '%u/%u', @extraColor, '. Опыта осталось:', @r, '%u', @r1)),

-- LANG_PINFO_CHR_RACE
(844,
CONCAT(@newLine, 'Gender:', @r, '%s', @extraColor, ', Race:', @r, '%s', @extraColor, ', Class', @r, '%s', @r1),
CONCAT(@newLine, 'Пол:', @r, '%s', @extraColor, ', Расса:', @r, '%s', @extraColor, ', Класс', @r, '%s', @r1)),

-- LANG_PINFO_CHR_ALIVE
(845,
CONCAT(@newLine, 'Alive?:', @r, '%s'),
CONCAT(@newLine, 'Живой?:', @r, '%s')),

-- LANG_PINFO_CHR_PHASE
(846,
CONCAT(@newLine, 'Phase:', @r, '%u'),
CONCAT(@newLine, 'Фаза:', @r, '%u')),

-- LANG_PINFO_CHR_MONEY
(847,
CONCAT(@newLine, 'Money:', @r, '%ug %us %uc'),
CONCAT(@newLine, 'Деньги:', @r, '%uз %uс %uм')),

-- LANG_PINFO_CHR_MAP
(848,
CONCAT(@newLine, 'Map:', @r, '%s', @extraColor, ', Zone:', @r, '%s'),
CONCAT(@newLine, 'Карта:', @r, '%s', @extraColor, ', Зона:', @r, '%s')),

-- LANG_PINFO_CHR_GUILD
(849,
CONCAT(@newLine, 'Guild:', @r, '%s ', @extraColor, '(ID:', @r, '%u', @extraColor, ')', @r1),
CONCAT(@newLine, 'Гильдия:', @r, '%s ', @extraColor, '(Номер:', @r, '%u', @extraColor, ')', @r1)),

-- LANG_PINFO_CHR_GUILD_RANK
(850,
CONCAT(@newLineList, 'Rank:', @r, '%s'),
CONCAT(@newLineList, 'Ранк:', @r, '%s')),

-- LANG_PINFO_CHR_GUILD_NOTE
(851,
CONCAT(@newLineList, 'Note:', @r, '%s'),
CONCAT(@newLineList, 'заметка:', @r, '%s')),

-- LANG_PINFO_CHR_GUILD_ONOTE
(852,
CONCAT(@newLineList, 'O. Note:', @r, '%s'),
CONCAT(@newLineList, 'О. Заметка:', @r, '%s')),

-- LANG_PINFO_CHR_PLAYEDTIME
(853,
CONCAT(@newLine, 'Played time:', @r, '%s'),
CONCAT(@newLine, 'Сыгранное время:', @r, '%s')),

-- LANG_PINFO_CHR_MAILS
(854,
CONCAT(@newLine, 'Mails:', @r, '%d ', @extraColor, 'Read/|r%u ', @extraColor, 'Total', @r1),
CONCAT(@newLine, 'Письма:', @r, '%d ', @extraColor, 'Прочитано/|r%u ', @extraColor, 'Всего', @r1)),

-- LANG_PINFO_CHR_LEVEL_HIGH
(871,
CONCAT(@newLine, 'Level:', @r, '%u'),
CONCAT(@newLine, 'Уровень:', @r, '%u')),

-- LANG_PINFO_ACC_REGMAILS
(879,
CONCAT(@newLine, 'Registration Email:', @r, '%s', @extraColor, '. Email:', @r, '%s'),
CONCAT(@newLine, 'Регистрационный Email:', @r, '%s', @extraColor, '. Email:', @r, '%s')),

-- LANG_PINFO_CHR_MAP_WITH_AREA
(882,
CONCAT(@newLine, 'Map:', @r, '%s', @extraColor, ', Zone:', @r, '%s', @extraColor, ', Area:', @r, '%s'),
CONCAT(@newLine, 'Карта:', @r, '%s', @extraColor, ', Зона:', @r, '%s', @extraColor, ', Область:', @r, '%s'));

-- Add ruRU locale
UPDATE `warhead_string` SET `content_loc8` = 'Да' WHERE `entry` = 421;
UPDATE `warhead_string` SET `content_loc8` = 'нет' WHERE `entry` = 422;
UPDATE `warhead_string` SET `content_loc8` = 'Мужчина' WHERE `entry` = 855;
UPDATE `warhead_string` SET `content_loc8` = 'Женщина' WHERE `entry` = 856;
