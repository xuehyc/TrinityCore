-- ----------------------------
-- Table structure for ips_shop
-- ----------------------------
DROP TABLE IF EXISTS `ips_shop`;
CREATE TABLE `ips_shop`  (
  `ID` int(10) NOT NULL DEFAULT 1,
  `Type` int(10) NOT NULL DEFAULT 0,
  `Value` int(10) NOT NULL,
  `Comment` text DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ips_shop
-- ----------------------------
INSERT INTO `ips_shop` VALUES 
(9, 0, 58165, 'Донат монета !!!!'),
(10, 1, 0, 'Ренейм перонажа'),
(11, 4, 0, 'Рекастом (смена пола)'),
(12, 2, 0, 'Рерасса (смена рассы)'),
(13, 3, 0, 'Рефракция (смена фракции)'),
(14, 0, 62712, 'Конверт Донат Монеты 50'),
(15, 0, 62713, 'Конверт Донат Монеты 100'),
(16, 0, 62714, 'Конверт Донат Монеты 500'),
(21, 0, 61678, 'Красное трико любви'),
(22, 0, 12063, 'Древковое --- Вертикально (тр.12063)'),
(23, 0, 32731, 'Кинжал --- За спиной (тр. 32731)');
