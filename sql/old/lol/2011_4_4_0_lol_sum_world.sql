-- Halls of Reflection
-- Creature Templates 
UPDATE `creature_template` SET `speed_walk`='1.5', `speed_run`='2.0' WHERE `entry` in (36954, 37226);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRintro' WHERE `entry` in (37221, 37223);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_falric' WHERE `entry`=38112;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_marwyn' WHERE `entry`=38113;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_lich_king_hr' WHERE `entry`=36954;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='boss_lich_king_hor' WHERE `entry`=37226;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_jaina_and_sylvana_HRextro' WHERE `entry` in (36955, 37554);
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_raging_gnoul' WHERE `entry`=36940;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_risen_witch_doctor' WHERE `entry`=36941;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_abon' WHERE `entry`=37069;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_ghostly_priest' WHERE `entry`=38175;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_phantom_mage' WHERE `entry`=38172;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_phantom_hallucination' WHERE `entry`=38567;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_shadowy_mercenary' WHERE `entry`=38177;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_spectral_footman' WHERE `entry`=38173;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_ghostly_priest' WHERE `entry`=38176;
UPDATE `creature_template` SET `AIName`='', `Scriptname`='npc_frostworn_general' WHERE `entry`=36723;

UPDATE `creature_template` SET `scale`='0.8', `equipment_id`='1221' WHERE `entry` in (37221, 36955);
UPDATE `creature_template` SET `equipment_id`='1290' WHERE `entry` in (37223, 37554);
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry`=36954;
UPDATE `creature_template` SET `scale`='1' WHERE `entry`=37223;
UPDATE `creature_template` SET `scale`='0.8' WHERE `entry` in (36658, 37225, 37223, 37226, 37554);
UPDATE `creature_template` SET `unit_flags`='768', `type_flags`='268435564' WHERE `entry` in (38177, 38176, 38173, 38172, 38567, 38175);
UPDATE `creature_template` set `scale`='1' where `entry` in (37223);
UPDATE `instance_template` SET `script` = 'instance_hall_of_reflection' WHERE map=668;
UPDATE `gameobject_template` SET `faction`='1375' WHERE `entry` in (197341, 202302, 201385, 201596);
UPDATE `creature` SET `phaseMask` = 128 WHERE `id` = 36993; 
UPDATE `creature` SET `phaseMask` = 64 WHERE `id` = 36990; 
UPDATE `instance_template` SET `script` = 'instance_halls_of_reflection' WHERE map=668;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1594540 AND -1594430;
INSERT INTO `script_texts` (`entry`,`content_default`,`content_loc8`,`sound`,`type`,`language`,`emote`,`comment`) VALUES
(-1594473, '<need translate>', 'Глупая девчонка! Тот кого ты ищещь давно убит! Теперь он лишь призрак, слабый отзвук в моем сознании!', 17229,1,0,0, '67234'),
(-1594474, '<need translate>', 'Я не повторю прежней ошибки, Сильвана. На этот раз тебе не спастись. Ты не оправдала моего доверия и теперь тебя ждет только забвение!', 17228,1,0,0, '67234'),
-- SCENE - Hall Of Reflection (Extro) - PreEscape
(-1594477, 'Your allies have arrived, Jaina, just as you promised. You will all become powerful agents of the Scourge.', 'Твои союзники прибыли, Джайна! Как ты и обещала... Ха-ха-ха-ха... Все вы станете могучими солдатами Плети...', 17212,1,0,0, '67234'),
(-1594478, 'I will not make the same mistake again, Sylvanas. This time there will be no escape. You will all serve me in death!', 'Я не повторю прежней ошибки, Сильвана! На этот раз тебе не спастись. Вы все будите служить мне после смерти...', 17213,1,0,0, '67234'),
(-1594479, 'He is too powerful, we must leave this place at once! My magic will hold him in place for only a short time! Come quickly, heroes!', 'Он слишком силен. Мы должны выбраться от сюда как можно скорее. Моя магия задержит его ненадолго, быстрее герои...', 16644,0,0,1, '67234'),
(-1594480, 'He\'s too powerful! Heroes, quickly, come to me! We must leave this place immediately! I will do what I can do hold him in place while we flee.', 'Он слишком силен. Герои скорее, за мной. Мы должны выбраться отсюда немедленно. Я постараюсь его задержать, пока мы будем убегать.', 17058,0,0,1, '67234'),
-- SCENE - Hall Of Reflection (Extro) - Escape
(-1594481, 'Death\'s cold embrace awaits.', 'Смерть распростерла ледяные обьятия!', 17221,1,0,0, '67234'),
(-1594482, 'Rise minions, do not left them us!', 'Восстаньте прислужники, не дайте им сбежать!', 17216,1,0,0, '67234'),
(-1594483, 'Minions sees them. Bring their corpses back to me!', 'Схватите их! Принесите мне их тела!', 17222,1,0,0, '67234'),
(-1594484, 'No...', 'Надежды нет!', 17214,1,0,0, '67234'),
(-1594485, 'All is lost!', 'Смирись с судьбой.', 17215,1,0,0, '67234'),
(-1594486, 'There is no escape!', 'Бежать некуда!', 17217,1,0,0, '67234'),
(-1594487, 'I will destroy this barrier. You must hold the undead back!', 'Я разрушу эту преграду, а вы удерживайте нежить на расстоянии!', 16607,1,0,0, '67234'),
(-1594488, 'No wall can hold the Banshee Queen! Keep the undead at bay, heroes! I will tear this barrier down!', 'Никакие стены не удержат Королеву Баньши. Держите нежить на расстоянии, я сокрушу эту преграду.', 17029,1,0,0, '67234'),
(-1594489, 'Another ice wall! Keep the undead from interrupting my incantation so that I may bring this wall down!', 'Опять ледяная стена... Я разобью ее, только не дайте нежити прервать мои заклинания...', 16608,1,0,0, '67234'),
(-1594490, 'Another barrier? Stand strong, champions! I will bring the wall down!', 'Еще одна преграда. Держитесь герои! Я разрушу эту стену!', 17030,1,0,0, '67234'),
(-1594491, 'Succumb to the chill of the grave.', 'Покоритесь Леденящей смерти!', 17218,1,0,0, '67234'),
(-1594492, 'Another dead end.', 'Вы в ловушке!', 17219,1,0,0, '67234'),
(-1594493, 'How long can you fight it?', 'Как долго вы сможете сопротивляться?', 17220,1,0,0, '67234'),
(-1594494, '<need translate>', 'Он с нами играет. Я  покажу ему что бывает когда лед встречается со огнем!', 16609,0,0,0, '67234'),
(-1594495, 'Your barriers can\'t hold us back much longer, monster. I will shatter them all!', 'Твои преграды больше не задержат нас, чудовище. Я смету их с пути!', 16610,1,0,0, '67234'),
(-1594496, 'I grow tired of these games, Arthas! Your walls can\'t stop me!', 'Я устала от этих игр Артас. Твои стены не остановят меня!', 17031,1,0,0, '67234'),
(-1594497, 'You won\'t impede our escape, fiend. Keep the undead off me while I bring this barrier down!', 'Ты не помешаешь нам уйти, монстр. Сдерживайте нежить, а я уничтожу эту преграду.', 17032,1,0,0, '67234'),
(-1594498, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 16645,1,0,0, '67234'),
(-1594499, 'We\'re almost there... Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 16646,1,0,0, '67234'),
(-1594500, 'There\'s an opening up ahead. GO NOW!', 'Я вижу выход, скорее!', 17059,1,0,0, '67234'),
(-1594501, 'We\'re almost there! Don\'t give up!', 'Мы почти выбрались, не сдавайтесь!', 17060,1,0,0, '67234'),
(-1594502, 'It... It\'s a dead end. We have no choice but to fight. Steel yourself heroes, for this is our last stand!', 'Больше некуда бежать. Теперь нам придется сражаться. Это наша последняя битва!', 16647,1,0,0, '67234'),
(-1594503, 'BLASTED DEAD END! So this is how it ends. Prepare yourselves, heroes, for today we make our final stand!', 'Проклятый тупик, значит все закончится здесь. Готовьтесь герои, это наша последняя битва.', 17061,1,0,0, '67234'),
(-1594504, 'Nowhere to run! You\'re mine now...', 'Ха-ха-ха... Бежать некуда. Теперь вы мои!', 17223,1,0,0, '67234'),
(-1594505, 'Soldiers of Lordaeron, rise to meet your master\'s call!', 'Солдаты Лордерона, восстаньте по зову Господина!', 16714,1,0,0, '67234'),
(-1594506, 'The master surveyed his kingdom and found it... lacking. His judgement was swift and without mercy. Death to all!', 'Господин осмотрел свое королевство и признал его негодным! Его суд был быстрым и суровым - предать всех смерти!', 16738,1,0,0, '67234'),
-- FrostWorn General
(-1594519, 'You are not worthy to face the Lich King!', 'Вы недостойны предстать перед Королем - Личом!', 16921,1,0,0, '67234'),
(-1594520, 'Master, I have failed...', 'Господин... Я подвел вас...', 16922,1,0,0, '67234');

-- Waipoints to escort event on Halls of reflection

DELETE FROM script_waypoint WHERE entry IN (36955,37226,37554);
INSERT INTO script_waypoint VALUES
-- Jaina

   (36955, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (36955, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (36955, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (36955, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (36955, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (36955, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (36955, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (36955, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (36955, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (36955, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (36955, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (36955, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (36955, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (36955, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (36955, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (36955, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (36955, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (36955, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (36955, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (36955, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (36955, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (36955, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Sylvana

   (37554, 0, 5587.682,2228.586,733.011, 0, 'WP1'),
   (37554, 1, 5600.715,2209.058,731.618, 0, 'WP2'),
   (37554, 2, 5606.417,2193.029,731.129, 0, 'WP3'),
   (37554, 3, 5598.562,2167.806,730.918, 0, 'WP4 - Summon IceWall 01'), 
   (37554, 4, 5556.436,2099.827,731.827, 0, 'WP5 - Spell Channel'),
   (37554, 5, 5543.498,2071.234,731.702, 0, 'WP6'),
   (37554, 6, 5528.969,2036.121,731.407, 0, 'WP7'),
   (37554, 7, 5512.045,1996.702,735.122, 0, 'WP8'),
   (37554, 8, 5504.490,1988.789,735.886, 0, 'WP9 - Spell Channel'),
   (37554, 9, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37554, 10, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37554, 11, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37554, 12, 5445.157,1894.955,748.757, 0, 'WP13 - Spell Channel'),
   (37554, 13, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37554, 14, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37554, 15, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37554, 16, 5335.422,1766.951,767.635, 0, 'WP17 - Spell Channel'),
   (37554, 17, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37554, 18, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37554, 19, 5260.400,1677.775,784.301, 3000, 'WP20'),
   (37554, 20, 5262.439,1680.410,784.294, 0, 'WP21'),
   (37554, 21, 5260.400,1677.775,784.301, 0, 'WP22'),

-- Lich King

   (37226, 0, 5577.187,2236.003,733.012, 0, 'WP1'),
   (37226, 1, 5587.682,2228.586,733.011, 0, 'WP2'),
   (37226, 2, 5600.715,2209.058,731.618, 0, 'WP3'),
   (37226, 3, 5606.417,2193.029,731.129, 0, 'WP4'),
   (37226, 4, 5598.562,2167.806,730.918, 0, 'WP5'), 
   (37226, 5, 5559.218,2106.802,731.229, 0, 'WP6'),
   (37226, 6, 5543.498,2071.234,731.702, 0, 'WP7'),
   (37226, 7, 5528.969,2036.121,731.407, 0, 'WP8'),
   (37226, 8, 5512.045,1996.702,735.122, 0, 'WP9'),
   (37226, 9, 5504.490,1988.789,735.886, 0, 'WP10'),
   (37226, 10, 5489.645,1966.389,737.653, 0, 'WP10'),
   (37226, 11, 5475.517,1943.176,741.146, 0, 'WP11'),
   (37226, 12, 5466.930,1926.049,743.536, 0, 'WP12'),
   (37226, 13, 5445.157,1894.955,748.757, 0, 'WP13'),
   (37226, 14, 5425.907,1869.708,753.237, 0, 'WP14'),
   (37226, 15, 5405.118,1833.937,757.486, 0, 'WP15'),
   (37226, 16, 5370.324,1799.375,761.007, 0, 'WP16'),
   (37226, 17, 5335.422,1766.951,767.635, 0, 'WP17'),
   (37226, 18, 5311.438,1739.390,774.165, 0, 'WP18'),
   (37226, 19, 5283.589,1703.755,784.176, 0, 'WP19'),
   (37226, 20, 5278.694,1697.912,785.692, 0, 'WP20'),
   (37226, 21, 5283.589,1703.755,784.176, 0, 'WP19');
   
-- Fixed Halls of Reflection
DELETE FROM `gameobject_template` WHERE `entry` = 500001;
INSERT INTO `gameobject_template` VALUES ('500001', '0', '9214', 'Ice Wall', '', '', '', '1375', '0', '2.5', '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '', '', '1'); 
DELETE FROM `creature` WHERE `id` IN (38112,37223,37221,36723,36955,37158,38113,37554,37226) AND `map` = 668;
INSERT INTO `creature` (`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`)
VALUES 
('38112', '668', '3', '1', '0', '0', '5276.81', '2037.45', '709.32', '5.58779', '604800', '0', '0', '377468', '0', '0', '0', '0', '0', '0'),
('37223', '668', '3', '64', '0', '0', '5266.78', '1953.42', '707.697', '0.740877', '7200', '0', '0', '6972500', '85160', '0', '0', '0', '0', '0'),
('37221', '668', '3', '128', '0', '0', '5266.78', '1953.42', '707.697', '0.740877', '7200', '0', '0', '5040000', '881400', '0', '0', '0', '0', '0'),
('36723', '668', '3', '1', '0', '0', '5413.84', '2116.44', '707.695', '3.88117', '7200', '0', '0', '315000', '0', '0', '0', '0', '0', '0'),
('36955', '668', '3', '128', '0', '0', '5547.27', '2256.95', '733.011', '0.835987', '7200', '0', '0', '252000', '881400', '0', '0', '0', '0', '0'),
('37158', '668', '3', '2', '0', '0', '5304.5', '2001.35', '709.341', '4.15073', '7200', '0', '0', '214200', '0', '0', '0', '0', '0', '0'),
('38113', '668', '3', '1', '0', '0', '5341.72', '1975.74', '709.32', '2.40694', '604800', '0', '0', '539240', '0', '0', '0', '0', '0', '0'),
('37554', '668', '3', '64', '0', '0', '5547.27', '2256.95', '733.011', '0.835987', '7200', '0', '0', '252000', '881400', '0', '0', '0', '0', '0'),
('37226', '668', '3', '1', '0', '0', '5551.29', '2261.33', '733.012', '4.0452', '604800', '0', '0', '27890000', '0', '0', '0', '0', '0', '0');
DELETE FROM `gameobject` WHERE `id` IN (202302,202236,201596,500001,196391,196392,202396,201885,197341,201976,197342,197343,201385,202212,201710,202337,202336,202079) AND `map`=668;
INSERT INTO `gameobject` (`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`)
VALUES 
('202302', '668', '3', '1', '5309.51', '2006.64', '709.341', '5.50041', '0', '0', '0.381473', '-0.92438', '604800', '100', '1'),
('202236', '668', '3', '1', '5309.51', '2006.64', '709.341', '5.53575', '0', '0', '0.365077', '-0.930977', '604800', '100', '1'),
('201596', '668', '3', '1', '5275.28', '1694.23', '786.147', '0.981225', '0', '0', '0.471166', '0.882044', '25', '0', '1'),
('500001', '668', '3', '1', '5323.61', '1755.85', '770.305', '0.784186', '0', '0', '0.382124', '0.924111', '604800', '100', '1'),
('196391', '668', '3', '1', '5232.31', '1925.57', '707.695', '0.815481', '0', '0', '0.396536', '0.918019', '300', '0', '1'),
('196392', '668', '3', '1', '5232.31', '1925.57', '707.695', '0.815481', '0', '0', '0.396536', '0.918019', '300', '0', '1'),
('202396', '668', '3', '1', '5434.27', '1881.12', '751.303', '0.923328', '0', '0', '0.445439', '0.895312', '604800', '100', '1'),
('201885', '668', '3', '1', '5494.3', '1978.27', '736.689', '1.0885', '0', '0', '0.517777', '0.855516', '604800', '100', '1'),
('197341', '668', '3', '1', '5359.24', '2058.35', '707.695', '3.96022', '0', '0', '0.917394', '-0.397981', '300', '100', '1'),
('201976', '668', '3', '1', '5264.6', '1959.55', '707.695', '0.736951', '0', '0', '0.360194', '0.932877', '300', '100', '0'),
('197342', '668', '3', '1', '5520.72', '2228.89', '733.011', '0.778581', '0', '0', '0.379532', '0.925179', '300', '100', '1'),
('197343', '668', '3', '1', '5582.96', '2230.59', '733.011', '5.49098', '0', '0', '0.385827', '-0.922571', '300', '100', '1'),
('201385', '668', '3', '1', '5540.39', '2086.48', '731.066', '1.00057', '0', '0', '0.479677', '0.877445', '604800', '100', '1'),
('202212', '668', '1', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('201710', '668', '1', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202337', '668', '2', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202336', '668', '2', '65535', '5241.05', '1663.44', '784.295', '0.54', '0', '0', '0', '0', '-604800', '100', '1'),
('202079', '668', '3', '1', '5250.96', '1639.36', '784.302', '0', '0', '0', '0', '0', '-604800', '100', '1');
-- cast spell on player instead of questgiver
UPDATE `quest_start_scripts` SET `datalong2`=3 WHERE `id`=12886;

-- add quest credit + target despawn (quest 12810)
DELETE FROM `spell_scripts` WHERE `id`=6509;
INSERT INTO `spell_scripts` VALUES 
(6509,0,0,8,29391,1,0,0,0,0,0),
(6509,0,0,18,0,0,0,0,0,0,0);

UPDATE `creature_ai_scripts` SET `event_param1`=5000, `event_param2`=10000, `event_param3`=4000, `event_param4`=9000 WHERE `id` IN (2921701, 2921702);
UPDATE `creature_ai_scripts` SET `event_param1`=10000, `event_param2`=35000, `event_param3`=15000, `event_param4`=20000 WHERE `id` IN (2921703, 2921704);

UPDATE `creature_template` SET `dmg_multiplier`=0.2 WHERE `entry` IN (29209,31647);
UPDATE `creature_template` SET `dmg_multiplier`=0.5 WHERE `entry` IN (29213,31597);
UPDATE `creature_template` SET `dmg_multiplier`=0.75 WHERE `entry` = 29217;
UPDATE `creature_template` SET `dmg_multiplier`=1.25 WHERE `entry` = 31607;

-- Skinning Group for Engineering no Blizz dropchance
-- http://www.wowwiki.com/Salvage
DELETE FROM `skinning_loot_template` WHERE `entry` = 90001;
INSERT INTO `skinning_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `lootmode`, `groupid`, `mincountOrRef`, `maxcount`) VALUES
	(90001, 49050, 3, 1, 1, 1, 1),      -- Schematic: Jeeves
	(90001, 36812, 12, 1, 1, 1, 3),     -- Ground Gear
	(90001, 41337, 12, 1, 1, 1, 3),     -- Whizzed-Out Gizmo
	(90001, 42930, 12, 1, 1, 1, 3),     -- Crooked Cog
	(90001, 41338, 12, 1, 1, 1, 3),     -- Sprung Whirlygig
	(90001, 42931, 12, 1, 1, 1, 3),     -- Toothless Gear
	(90001, 39683, 7.4, 1, 1, 1, 2),    -- Froststeel Tube
	(90001, 39684, 7.4, 1, 1, 1, 1),    -- Hair Trigger
	(90001, 39681, 7.4, 1, 1, 1, 3),    -- Handful of Cobalt Bolts
	(90001, 39682, 7.4, 1, 1, 1, 2),    -- Overcharge Capacitor
	(90001, 39690, 7.4, 1, 1, 1, 1);    -- Volatile Blasting Trigger

-- Adding Skinloot to Creatures 
UPDATE `creature_template` SET `skinloot` = 90001 WHERE `entry` IN (
29724, -- Library Guardian
25793, -- 55-D Collect-a-tron
25758, -- Defendo-tank 66D
32500, -- Dirkee
25814, -- Fizzcrank Mechagnome
32358, -- Fumblub Gearwind
29389, -- Mechagnome Laborer
25766, -- Rig Hauler AC-9
25752, -- Scavenge-bot 004-A8
25792, -- Scavenge-bot 005-B6
25753, -- Sentry-bot 57-K
29861, -- Stormforged Eradicator
29382, -- Stormforged Reaver
29380); -- Stormforged War Golem
-- stormforged Wargolem
DELETE FROM `creature_loot_template` WHERE (`entry`=29380);
INSERT INTO `creature_loot_template` VALUES
(29380, 22926, 0.0032, 0, -22926, 1, 0, 0, 0),
(29380, 33365, 10, 0, -33365, 1, 0, 0, 0),
(29380, 33422, 10, 0, -33422, 1, 0, 0, 0),
(29380, 36027, 0.29, 0, -36027, 1, 0, 0, 0),
(29380, 36035, 0.63, 0, -36035, 1, 0, 0, 0),
(29380, 36043, 0.66, 0, -36043, 1, 0, 0, 0),
(29380, 36051, 0.25, 0, -36051, 1, 0, 0, 0),
(29380, 37254, 0.0032, 0, -37254, 1, 0, 0, 0),
(29380, 37704, 0.0035, 0, 1, 1, 0, 0, 0),
(29380, 37760, 0.0211, 0, -37760, 1, 0, 0, 0),
(29380, 37761, 0.0349, 0, -37761, 1, 0, 0, 0),
(29380, 37769, 0.0096, 0, -37769, 1, 0, 0, 0),
(29380, 41777, 0.007, 0, -41777, 1, 0, 0, 0),
(29380, 42203, 13.64, 0, 1, 1, 0, 0, 0),
(29380, 42204, 34.548, 0, 1, 1, 0, 0, 0),
(29380, 42780, 33.1297, 0, 1, 1, 0, 0, 0),
(29380, 42930, 79.5346, 0, 1, 1, 0, 0, 0),
(29380, 42931, 19.1167, 0, 1, 1, 0, 0, 0),
(29380, 43624, 0.0032, 0, 1, 1, 0, 0, 0);

-- Teron Blutschatten
REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`,
`KillCredit1`, `KillCredit2`, `modelid_1`, `modelid_2`, `modelid_3`, `modelid_4`, `name`, `subname`,
`IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`,
`armor`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`,
`maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`,
`unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`,
`minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`,
`skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`,
`spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`,
`InhabitType`, `unk16`, `unk17`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`,
`questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`,
`flags_extra`, `ScriptName`) VALUES (21867, 0, 0, 0, 0, 0, 21576, 0, 0, 0, 'Teron Blutschatten', '', '', 0,
72, 72, 17709, 17709, 19854, 19854, 7265, 14, 14, 0, 1, 1.14286, 1, 1, 407, 611, 0, 153, 2, 3000, 3000, 2,
16777216, 0, 0, 0, 0, 0, 0, 326, 489, 122, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3,
3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 1, 321, 1, 0, '');

-- the heart of the storm
DELETE FROM `gameobject` WHERE `id`=192181;
INSERT INTO `gameobject`

(`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(47643, 192181, 571, 1, 1, 7308.94, -727.916, 791.608, 1.53589, 0, 0, 0.690772, 0.723073, 30, 100, 1);
UPDATE `creature_template` SET `ScriptName`='npc_commander_kunz' WHERE `entry`=28039;

-- temp. disable invisibility
DELETE FROM `creature_addon` WHERE `guid` = 85057;

-- update creature_templates
UPDATE `creature_template` SET `flags_extra`=2, `npcflag`=2097153, `unit_flags`=770 WHERE `entry` IN (35594,35607);

-- spawn
DELETE FROM `creature` WHERE `id` IN (35594,35607);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`)
VALUES
('85057','35594','571','1','1','28282','0','5931.78','729.095','642.136','3.29716','180','0','0','5342','0','0','0','0','0','0'),
('502329','35607','571','1','1','28282','0','5923.62','723.277','642.136','1.50253','180','0','0','5342','0','0','0','0','0','0');

-- gossip menu
DELETE FROM `gossip_menu_option` WHERE `menu_id`=10656 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`)
VALUES (10656,0,1,NULL,13,2097152,0,0,0,0,0,NULL);

-- condition
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=10656;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES (15,10656,0,0,7,202,350,0,0,'','steam powered auctioneer - requires engineering 350');

-- captive proto-drake
DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=29708;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`)
VALUES (29708,55028,12856,1,12856,1,0,0,0);

-- freed proto-drake
DELETE FROM `creature_template_addon` WHERE `entry`=29709;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(29709,0,50331648,257,0, NULL);

UPDATE `creature_template` SET `unit_flags`=`unit_flags`|16777216, `ScriptName`='' WHERE `entry`=29708;
UPDATE `creature_template` SET `InhabitType`=7 WHERE `entry`=29709;

UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~512 WHERE `entry` IN (29307,31365);

DELETE FROM `creature_questrelation` WHERE `quest` = 8945;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 8945;
UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = 8945;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (16016, 8945);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = 16016;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 8945;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 8945;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (16031, 8945);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=16031;
REPLACE INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `SkillOrClassMask`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredRaces`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RepObjectiveFaction2`, `RepObjectiveValue2`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `CharTitleId`, `PlayersSlain`, `BonusTalents`, `RewardArenaPoints`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `RewXPId`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemId5`, `ReqItemId6`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqItemCount5`, `ReqItemCount6`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValueId1`, `RewRepValueId2`, `RewRepValueId3`, `RewRepValueId4`, `RewRepValueId5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewHonorAddition`, `RewHonorMultiplier`, `unk0`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `WDBVerified`) VALUES (8945, 2, 2017, 0, 58, 0, 60, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 0, 0, 8946, 6, 0, 0, 0, 'Die letzte Bitte eines toten Mannes', 'Ich werde Euch mit den Informationen, nach denen Ihr verlangt, versorgen, $N. Aber jetzt gibt es Wichtigeres zu tun.$B$BMeine geliebte Frau wird von Totenschwurs Abschaum gefangen gehalten.$B$BIch war immer dagegen, dass sie sich dem n?rrischen Kreuzzug der Argentumd?mmerung anschlie?t, aber jetzt ist es zu sp?t f?r Schuldgef?hle. Ihr m?sst das vollbringen, wozu ich nicht f?hig war. Ihr m?sst Ysida aus den F?ngen des Barons befreien!', 'Geht nach Stratholme und befreit Ysida Harmon aus den F?ngen von Baron Totenschwur.', 'Thank you for rescuing me... I feared for my life. Please accept this as a small token of my gratitude.$B$BAnthion is... no... he can\'t be...', 'Tell me, is Ysida alive?', '', 'Kehrt zu Ysida Harmon in Stratholme zur?ck.', 'Ysida befreit', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45412, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22137, 0, 0, 0, 1, 0, 0, 0, 529, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);

UPDATE quest_template SET RewRepValueId1 = 4, RewRepFaction1 = 369 WHERE entry = 1707;
UPDATE quest_template SET RewRepValueId1 = 4, RewRepFaction1 = 369 WHERE entry = 1878;


/* 51123 rank1 3
51127 rank2 6 
51128 rank3 9 
51129 rank4 12 
51130 rank5 15*/
-- Killing maschine
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=3 WHERE `entry`=51123;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=6 WHERE `entry`=51127;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=9 WHERE `entry`=51128;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=12 WHERE `entry`=51129;
UPDATE `spell_proc_event` SET `procEx`=1, `ppmRate`=15 WHERE `entry`=51130;
-- QUEST 11322 "The cleansing"
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=186649;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=14, `faction_A`=14 WHERE `entry`=27959;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27959,186649,2795900,18664900);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Frostblade Shrine script
(186649,1,0,0,64,0,100,0,0,0,0,0,80,18664900,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On Frostblade Shrine use start script'),
(18664900,9,0,0,0,0,100,0,0,0,0,0,75,43351,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Cast Cleansing Soul on player'),
(18664900,9,1,0,0,0,100,0,10000,10000,0,0,85,50167,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Summon Inner Turmoil'),
-- Inner Turmoil script
(27959,0,0,1,54,0,100,0,0,0,0,0,85,50218,0,0,0,0,0,1,0,0,0,0,0,0,0,'On spawn copy the invoker'),
(27959,0,1,0,61,0,100,0,0,0,0,0,80,2795900,0,2,0,0,0,1,0,0,0,0,0,0,0,'Start script'),
(27959,0,2,0,2,0,100,0x01,0,50,0,0,1,2,0,0,0,0,0,7,0,0,0,0,0,0,0,'On 50% HP wisper text 2'),
(27959,0,3,4,6,0,100,0,0,0,0,0,1,3,0,0,0,0,0,7,0,0,0,0,0,0,0,'On death wisper text 3'),
(27959,0,4,0,61,0,100,0,0,0,0,0,75,50237,0,0,0,0,0,7,0,0,0,0,0,0,0,'Apply Slow Fall'),
(2795900,9,0,0,0,0,100,0,0,0,0,0,18,131072,0,0,0,0,0,1,0,0,0,0,0,0,0,'Set unit_flags'),
(2795900,9,1,0,0,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Disable movement'),
(2795900,9,2,0,0,0,100,0,1000,1000,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Wisper text 0'),
(2795900,9,3,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,7,0,0,0,0,0,0,0,'Wisper text 1'),
(2795900,9,4,0,0,0,100,0,6000,6000,0,0,19,131072,0,0,0,0,0,1,0,0,0,0,0,0,0,'Remove unit_flags'),
(2795900,9,5,0,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Enable movement');

DELETE FROM `creature_text` WHERE `entry`=27959;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27959,0,0,'You think that you can get rid of me through meditation?',4,0,100,1,0,0,'Inner Turmoil text 0'),
(27959,1,0,'Fool! I will destroy you and finally become that which has been building inside of you all of these years!',4,0,100,1,0,0,'Inner Turmoil text 1'),
(27959,2,0,'You cannot defeat me. I''m an inseparable part of you!',4,0,100,1,0,0,'Inner Turmoil text 50%'),
(27959,3,0,'NOOOOOOOoooooooooo!',4,0,100,1,0,0,'Inner Turmoil text death');

DELETE FROM `gameobject` WHERE `guid` IN (87584,87585);
-- Quest Fix 12988 Destroy the forges
UPDATE quest_template SET ReqSpellCast1 = 56275, ReqSpellCast2 = 56275, ReqSpellCast3 = 56275 WHERE entry = 12988;
-- add Horn Fragment Container (192081)
DELETE FROM `gameobject` WHERE `id` = 192081;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(192081, 571, 1, 1, 7696.32, -3199.08, 867.877, 1.95512, 0, 0, 0.829135, 0.559049, 300, 0, 1),
(192081, 571, 1, 1, 7823.76, -3303.56, 861.544, 3.97751, 0, 0, 0.913919, -0.405896, 300, 0, 1),
(192081, 571, 1, 1, 7887.96, -3304.67, 856.835, 4.69065, 0, 0, 0.71475, -0.69938, 300, 0, 1),
(192081, 571, 1, 1, 7914.8, -3284.45, 854.553, 5.54124, 0, 0, 0.362522, -0.931975, 300, 0, 1),
(192081, 571, 1, 1, 7764.72, -3168.89, 864.471, 0.13769, 0, 0, 0.0687906, 0.997631, 300, 0, 1),
(192081, 571, 1, 1, 7760.13, -3272.26, 864.405, 2.15223, 0, 0, 0.880121, 0.47475, 300, 0, 1),
(192081, 571, 1, 1, 7774.18, -3208.9, 865.76, 3.87853, 0, 0, 0.93288, -0.360188, 300, 0, 1),
(192081, 571, 1, 1, 7804.78, -3316.72, 864.805, 4.99301, 0, 0, 0.601269, -0.799047, 300, 0, 1),
(192081, 571, 1, 1, 7810.27, -3168.81, 862.536, 3.14672, 0, 0, 0.999997, -0.00256602, 300, 0, 1),
(192081, 571, 1, 1, 7724.15, -3270.37, 862.743, 0.927191, 0, 0, 0.447167, 0.89445, 300, 0, 1),
(192081, 571, 1, 1, 7732.62, -3321.35, 870.119, 3.69493, 0, 0, 0.96197, -0.273155, 300, 0, 1),
(192081, 571, 1, 1, 7799.53, -3269.97, 860.759, 0.466943, 0, 0, 0.231356, 0.972869, 300, 0, 1),
(192081, 571, 1, 1, 7775.55, -3244.98, 861.89, 1.64346, 0, 0, 0.732327, 0.680954, 300, 0, 1),
(192081, 571, 1, 1, 7741.48, -3293.32, 864.358, 6.16186, 0, 0, 0.0606264, -0.998161, 300, 0, 1),
(192081, 571, 1, 1, 7719.13, -3289.05, 863.474, 2.35189, 0, 0, 0.923054, 0.384671, 300, 0, 1),
(192081, 571, 1, 1, 7774.06, -3334.35, 874.046, 4.45283, 0, 0, 0.792671, -0.60965, 300, 0, 1),
(192081, 571, 1, 1, 7855.17, -3333.45, 859.95, 3.81666, 0, 0, 0.943575, -0.331159, 300, 0, 1),
(192081, 571, 1, 1, 7875.99, -3255.95, 850.392, 3.62502, 0, 0, 0.970929, -0.239368, 300, 0, 1),
(192081, 571, 1, 1, 7869.29, -3185.85, 856.779, 1.03321, 0, 0, 0.493929, 0.869502, 300, 0, 1),
(192081, 571, 1, 1, 7811.41, -3205.6, 859.865, 0.800728, 0, 0, 0.389753, 0.920919, 300, 0, 1),
(192081, 571, 1, 1, 7730.31, -3205.79, 861.841, 0.916966, 0, 0, 0.442588, 0.896725, 300, 0, 1),
(192081, 571, 1, 1, 7737.01, -3247.55, 862.548, 0.405672, 0, 0, 0.201448, 0.979499, 300, 0, 1),
(192081, 571, 1, 1, 7800.67, -3270.82, 860.949, 5.14555, 0, 0, 0.538635, -0.842539, 300, 0, 1),
(192081, 571, 1, 1, 7755.63, -3254.65, 863.106, 0.492066, 0, 0, 0.243558, 0.969886, 300, 0, 1);
-- Clean Up NPC 'Rokhan' 26859
DELETE FROM `creature` WHERE `id` = 26859; 
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203386, 26859, 571, 1, 1, 0, 0, 4339.94, 980.231, 91.9789, 5.51524, 120, 0, 0, 96100, 0, 0, 0, 0, 0, 0);
-- Clean Up NPC 'Kontokanis' 26979
DELETE FROM `creature` WHERE `id` = 26979;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203387, 26979, 571, 1, 1, 0, 0, 4322.3, 1009.02, 95.6906, 2.56563, 120, 0, 0, 92910, 0, 0, 0, 0, 0, 0);
-- QUEST 11647 "Neutralizing the Cauldrons"
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=25494;
UPDATE `quest_template` SET `ReqSpellCast1`=45656,`ReqSpellCast2`=45656,`ReqSpellCast3`=45656 WHERE `entry`=11647;

DELETE FROM `smart_scripts` WHERE `entryorguid`=25494;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(25494,0,0,0,54,0,100,0,0,0,0,0,85,45655,0,0,0,0,0,0,0,0,0,0,0,0,0, 'On summon purify cauldron');

-- Fix Quest 11599 NPC moving away
UPDATE creature_template SET unit_flags = 6 WHERE entry = 25385; -- non attackable/disable move
-- Fix Quest Linking of 13384 and onwards
UPDATE `quest_template` SET `PrevQuestId`=13372 WHERE `entry` =13384;
UPDATE `quest_template` SET `PrevQuestId`=13375 WHERE `entry` =13385;

-- Fix for Quest 11008 Fire above Skettis
DELETE FROM `creature_questrelation` WHERE `quest` = 11008;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 11008;
UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = 11008;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (23048, 11008);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = 23048;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 11008;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 11008;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (23048, 11008);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=23048;
REPLACE INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `SkillOrClassMask`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredRaces`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RepObjectiveFaction2`, `RepObjectiveValue2`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `CharTitleId`, `PlayersSlain`, `BonusTalents`, `RewardArenaPoints`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `RewXPId`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemId5`, `ReqItemId6`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqItemCount5`, `ReqItemCount6`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValueId1`, `RewRepValueId2`, `RewRepValueId3`, `RewRepValueId4`, `RewRepValueId5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewHonorAddition`, `RewHonorMultiplier`, `unk0`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `WDBVerified`) VALUES (11008, 2, 3679, 762, 70, 0, 70, 0, 0, 225, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4224, 1, 0, 0, 0, 0, 11098, 0, 0, 0, 5, 32406, 1, 0, 'Feuer ?ber Skettis', 'Glaubt Ihr, dass Ihr das Zeug dazu habt, ein Teil der Himmelswache zu sein? Wir werden ?berpr?fen m?ssen, wie gut Ihr in der Luft zurechtkommt.$B$BDie Arakkoa z?chten eine gigantische Menge von ihren Kampfv?geln, die sie auf unsere Sp?her hetzen! Ich m?chte, dass Ihr diese Sprengladungen nehmt und ihre Brutst?tten ?ber den Siedlungen der Arakkoa zerst?rt. Macht aber einen Bogen um die monstr?sen Kaliri, welche die Brutst?tten bewachen. Sie werden Euch vom Reittier holen, bevor Ihr wisst, wie Euch geschieht!', 'Haltet nach monstr?sen Kalirieiern oben in den Siedlungen von Skettis Ausschau und benutzt die Sprengladungen der Himmelswache, um sie in die Luft zu sprengen. Kehrt danach zu Himmelsoffizier Doryn zur?ck.', 'Ausgezeichnete Arbeit, $N! Das wird diesen Vogelwesen zeigen, wer die wahren Herren der L?fte sind!', 'Habt Ihr Euren Auftrag schon erledigt?', '', 'Kehrt zu Himmelsoffizier Doryn im Schattenwindlager in den W?ldern von Terokkar zur?ck.', 'Monstr?ses Kaliriei zerst?rt', '', '', '', 0, 32406, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -185549, 0, 0, 0, 20, 0, 0, 0, 39844, 39844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1031, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44000, 7500, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);

DELETE FROM `creature` WHERE `id`=23118;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(211012, 23118, 530, 1, 1, 0, 0, 2824.71, 7044.79, 369.877, -0.750491, 20, 0, 0, 42, 0, 0, 0, 0, 33554432, 0),
(211011, 23118, 530, 1, 1, 0, 0, 2786.61, 7036.28, 370.686, -2.04204, 20, 0, 0, 42, 0, 0, 0, 0, 33554432, 0),
(211010, 23118, 530, 1, 1, 0, 0, 2764.71, 7024.45, 370.203, 2.89725, 20, 0, 0, 42, 0, 0, 0, 0, 33554432, 0),
(211009, 23118, 530, 1, 1, 0, 0, 2824.71, 7044.79, 369.877, -0.750491, 20, 0, 0, 42, 0, 0, 0, 0, 33554432, 0);



DELETE FROM `creature_questrelation` WHERE `quest` = 11010;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 11010;
UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = 11010;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (23120, 11010);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = 23120;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 11010;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 11010;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (23120, 11010);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=23120;
REPLACE INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `SkillOrClassMask`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredRaces`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RepObjectiveFaction2`, `RepObjectiveValue2`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `CharTitleId`, `PlayersSlain`, `BonusTalents`, `RewardArenaPoints`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `RewXPId`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemId5`, `ReqItemId6`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqItemCount5`, `ReqItemCount6`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValueId1`, `RewRepValueId2`, `RewRepValueId3`, `RewRepValueId4`, `RewRepValueId5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewHonorAddition`, `RewHonorMultiplier`, `unk0`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `WDBVerified`)
VALUES
(11010, 2, 3522, -511, 70, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 11023, 11010, 11023, 5, 32456, 1, 40197, 'Bomberangriff', 'Ihr habt ein fliegendes Reittier... ja und! Glaubt Ihr denn, dass Ihr das Zeug dazu habt, es gekonnt einzusetzen?$B$BDas Konstruktionslager: Wut und das Konstruktionslager: Terror, im Norden und im Süden, sind mir schon seit langem ein Dorn im Auge und obendrein bedrohen sie das friedliche Ogri\'la. Mit all diesen Teufelskanonen, die die Himmelswache von rechts und links unter Beschuss nehmen, gibt es einfach kein Hindurchkommen und unser Unterfangen ist zum Scheitern verurteilt.$B$BWürdet Ihr Euch gerne unter Beweis stellen? Nehmt diese Bomben und vernichtet ihre Munitionsvorräte. Lasst Euch aber nicht auch noch vom Himmel herunterholen!', 'Vernichtet mithilfe der Bomben der Himmelswache 15 Stapel mit Teufelskanonenkugeln.', 'Gut, gut, scheinbar seid Ihr doch härter im Nehmen als ich dachte. Ausgezeichnete Arbeit. Möglicherweise hatte der alte Keller doch Unrecht, was Euch anbelangt. <Himmelsoffizier Vanderlip grinst.>', 'Habt Ihr schon ihre Stapel mit Teufelskanonenkugeln vernichtet?', '', 'Kehrt zu Himmelsoffizier Vanderlip am Aussenposten der Himmelswache auf dem Schergrat zurück.', 'Stapel mit Teufelskanonenkugeln zerstört', 'Stapel mit Teufelskanonenkugeln zerstört', 'Stapel mit Teufelskanonenkugeln zerstört', '', 0, 32456, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23118, 0, 0, 0, 15, 0, 0, 0, 40160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1031, 1038, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44000, 7500, 0, 40198, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);



DELETE FROM `creature_questrelation` WHERE `quest` = 11102;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 11102;
UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = 11102;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (23120, 11102);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = 23120;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 11102;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 11102;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (23120, 11102);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=23120;
REPLACE INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `SkillOrClassMask`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredRaces`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RepObjectiveFaction2`, `RepObjectiveValue2`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `CharTitleId`, `PlayersSlain`, `BonusTalents`, `RewardArenaPoints`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `RewXPId`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemId5`, `ReqItemId6`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqItemCount5`, `ReqItemCount6`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValueId1`, `RewRepValueId2`, `RewRepValueId3`, `RewRepValueId4`, `RewRepValueId5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewHonorAddition`, `RewHonorMultiplier`, `unk0`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `WDBVerified`)
VALUES
(11102, 2, 3522, -1024, 70, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 11023, 11010, 11023, 5, 32456, 1, 40197, 'Bomberangriff', 'Ihr könnt also wie eine Krähe herumfliegen... ja und! Schon mal etwas am Boden ausradiert, während Ihr geflogen seid? Lust, es mal zu probieren?$B$BDas Konstruktionslager: Wut und das Konstruktionslager: Terror, im Norden und im Süden, sind mir schon seit langem ein Dorn im Auge und eine Gefahr für Ogri\'la. Mit all diesen Teufelskanonen, die die Himmelswache von rechts und links unter Beschuss nimmt, gibt es einfach kein Hindurchkommen und unser Unterfangen ist zum Scheitern verurteilt.$B$BWürdet Ihr Euch gerne unter Beweis stellen? Nehmt diese Bomben und vernichtet ihre Munitionsvorräte. Lasst Euch aber nicht auch noch vom Himmel herunterholen!', 'Vernichtet mithilfe der Bomben der Himmelswache 15 Stapel mit Teufelskanonenkugeln.', 'Gut, gut, scheinbar seid Ihr doch härter im Nehmen als ich dachte. Ausgezeichnete Arbeit. Möglicherweise hatte der alte Keller doch Unrecht, was Euch anbelangt.$B$B<Himmelsoffizier Vanderlip grinst.>', 'Habt Ihr schon ihre Stapel mit Teufelskanonenkugeln vernichtet?', '', 'Kehrt zu Himmelsoffizier Vanderlip am Außenposten der Himmelswache auf dem Schergrat zurück.', 'Stapel mit Teufelskanonenkugeln zerstört', '', '', '', 0, 32456, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23118, 0, 0, 0, 15, 0, 0, 0, 40160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1031, 1038, 0, 0, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44000, 7500, 0, 40198, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);

-- QUEST 12261 "No Place to Run"
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=27430;

DELETE FROM `creature_text` WHERE `entry` IN (27430);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(27430,0,0, 'The %s gains in power.',2,0,100,0,0,0, 'Destructive Ward power up'),
(27430,1,0, 'The %s is fully charged up.',2,0,100,0,0,0, 'Destructive Ward fully charged');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (27430,2743000); 	
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(27430,0,0,0,54,0,100,0,0,0,0,0,80,2743000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On summon run script'),
(2743000,9,0,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,1,0,60,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Power up'),
(2743000,9,2,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,3,0,60,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Power up'),
(2743000,9,4,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,5,0,60,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Power up'),
(2743000,9,6,0,60,0,100,0,10000,25000,0,0,11,48735,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Powerup ward after 10-25 seconds'),
(2743000,9,7,0,60,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Announcement: Fully charged'),
(2743000,9,8,0,60,0,100,0,2000,2000,0,0,11,52409,0x02,0,0,0,0,1,0,0,0,0,0,0,0, 'Give quest credit'),
(2743000,9,9,0,60,0,100,0,1000,1000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn');

-- Fix for Quest 11648 The Art of Persuasion
DELETE FROM `quest_template` where `entry` = 11648
INSERT INTO `quest_template`
VALUES
(11648, 2, 3537, 0, 69, 0, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 11646, 0, 0, 11663, 4, 34811, 1, 0, 'The Art of Persuasion', 'It is fortunate you\'re here, $r.$b$bYou see, the Kirin Tor code of conduct frowns upon our taking certain \'extreme\' measures - even in desperate times such as these.$b$bYou, however, as an outsider, are not bound by such restrictions and could take any steps necessary in the retrieval of information.$b$bDo what you must. We need to know where Lady Evanor is being held at once!$b$bI\'ll just busy myself organizing these shelves here. Oh, and here, perhaps you\'ll find this old thing useful....', 'Librarian Normantis on Amber Ledge wants you to use the Neural Needler on the Imprisoned Beryl Sorcerer until he reveals the location of Lady Evanor.', 'Excellent! It was crucial that we collect that intelligence.$b$bWell done, friend.', 'Well? Do you know where Lady Evanor is being held?', '', 'Return to Librarian Normantis at Amber Ledge in Borean Tundra.', 'Prisoner Interrogated', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34811, 0, 0, 0, 1, 0, 0, 0, 25478, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1090, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37000, 18000, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 500, 0, 0, 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 12340); 
-- QUEST 12512 "Leave no one behind"
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry` IN (28133,28141,28143,28136,28142,28148,28137);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (28133,28141,28143,28136,28142,28148,28137,2813600,2814200,2814800);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Leave No One Behind Bunny
(28137,0,0,0,60,0,100,0,0,0,0,0,75,50670,0,0,0,0,0,11,28136,15,0,0,0,0,0, 'Apply aura when in range'),
(28137,0,1,0,60,0,100,0,0,0,0,0,75,50670,0,0,0,0,0,11,28142,15,0,0,0,0,0, 'Apply aura when in range'),
(28137,0,2,0,60,0,100,0,0,0,0,0,75,50670,0,0,0,0,0,11,28148,15,0,0,0,0,0, 'Apply aura when in range'),
-- Injured Crusader Jonathan
(28133,0,0,1,8,0,100,0,50662,0,0,0,85,50664,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit revive Crusader Jonathan'),
(28133,0,1,2,61,0,100,0,0,0,0,0,11,50666,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Apply timed debuff to player'),
(28133,0,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn injured Crusader Jonathan'),
-- Crusader Jonathan
(28136,0,0,1,54,0,100,0,0,0,0,0,29,0,0,28044,28136,0,0,7,0,0,0,0,0,0,0, 'On spawn start follow'),
(28136,0,1,2,61,0,100,0,0,0,0,0,11,50665,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Apply timed debuff to Crusader Jonathan'),
(28136,0,2,0,61,0,100,0,0,0,0,0,80,2813600,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Start script Crusader Jonathan'),
(28136,0,3,4,8,0,100,0x01,50669,0,0,0,11,50671,0,0,0,0,0,18,15,0,0,0,0,0,0, 'On complete-bunny spellhit give quest credit'),
(28136,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Jonathan rescued'),
(28136,0,5,6,61,0,100,0,0,0,0,0,28,50666,0,0,0,0,0,18,15,0,0,0,0,0,0, 'Remove timed debuff from player'),
(28136,0,6,0,61,0,100,0,0,0,0,0,53,0,28136,0,0,0,0,1,0,0,0,0,0,0,0, 'Start waypoint movement'),
(2813600,9,0,1,60,0,100,0,180000,180000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On debuff fade Crusader Jonathan dies'),
(2813600,9,1,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Jonathan death'),
-- Injured Crusader Lamoof
(28141,0,0,1,8,0,100,0,50662,0,0,0,85,50678,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit revive Crusader Lamoof'),
(28141,0,1,2,61,0,100,0,0,0,0,0,11,50679,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Apply timed debuff to player'),
(28141,0,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn dead Crusader Lamoof'),
-- Crusader Lamoof
(28142,0,0,1,54,0,100,0,0,0,0,0,29,1,0,28044,28142,0,0,7,0,0,0,0,0,0,0, 'On spawn start follow'),
(28142,0,1,2,61,0,100,0,0,0,0,0,11,50681,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Apply timed debuff to Crusader Lamoof'),
(28142,0,2,0,61,0,100,0,0,0,0,0,80,2814200,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Start script Crusader Lamoof'),
(28142,0,3,4,8,0,100,0x01,50669,0,0,0,11,50683,0,0,0,0,0,18,15,0,0,0,0,0,0, 'On complete-bunny spellhit give quest credit'),
(28142,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Lamoof rescued'),
(28142,0,5,6,61,0,100,0,0,0,0,0,28,50679,0,0,0,0,0,18,15,0,0,0,0,0,0, 'Remove timed debuff from player'),
(28142,0,6,0,61,0,100,0,0,0,0,0,53,0,28142,0,0,0,0,1,0,0,0,0,0,0,0, 'Start waypoint movement'),
(2814200,9,0,1,60,0,100,0,90000,90000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On debuff fade Crusader Lamoof dies'),
(2814200,9,1,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Lamoof death'),
-- Injured Crusader Josephine
(28143,0,0,1,8,0,100,0,50662,0,0,0,85,50692,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit revive Crusader Josephine'),
(28143,0,1,2,61,0,100,0,0,0,0,0,11,50693,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Apply timed debuff to player'),
(28143,0,2,0,61,0,100,0,0,0,0,0,41,1000,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn dead Crusader Josephine'),
-- Crusader Josephine
(28148,0,0,1,54,0,100,0,0,0,0,0,29,1,0,28044,28148,0,0,7,0,0,0,0,0,0,0, 'On spawn start follow'),
(28148,0,1,2,61,0,100,0,0,0,0,0,11,50695,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Apply timed debuff to Crusader Josephine'),
(28148,0,2,0,61,0,100,0,0,0,0,0,80,2814800,0,2,0,0,0,1,0,0,0,0,0,0,0, 'Start script Crusader Josephine'),
(28148,0,3,4,8,0,100,0x01,50669,0,0,0,11,50698,0,0,0,0,0,18,15,0,0,0,0,0,0, 'On complete-bunny spellhit give quest credit'),
(28148,0,4,5,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Josephine rescued'),
(28148,0,5,6,61,0,100,0,0,0,0,0,28,50693,0,0,0,0,0,18,15,0,0,0,0,0,0, 'Remove timed debuff from player'),
(28148,0,6,0,61,0,100,0,0,0,0,0,53,0,28148,0,0,0,0,1,0,0,0,0,0,0,0, 'On follow completed say rescued text'),
(2814800,9,0,1,60,0,100,0,150000,150000,0,0,37,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On debuff fade Crusader Josephine dies'),
(2814800,9,1,0,61,0,100,0,0,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say text Crusader Josephine death');

DELETE FROM `creature_text` WHERE `entry` IN (28136,28142,28148);
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(28136,0,0,'Thank you, friend. Were it not for your aid I would be no more.',0,0,100,0,0,0,'Crusader Jonathan rescued text'),
(28136,1,0,'',0,0,100,1,0,0,'Crusader Jonathan death text'),
(28142,0,0,'<sigh>... Well, I suppose it could be worse.',0,0,100,1,0,0,'Crusader Lamoof rescued text'),
(28142,1,0,'<sigh>... This is the end of me.',0,0,100,1,0,0,'Crusader Lamoof death text'),
(28148,0,0,'I am in your debt, friend. Thank you for my life.',0,0,100,1,0,0,'Crusader Josephine rescued text'),
(28148,1,0,'',0,0,100,1,0,0,'Crusader Josephine death text');

UPDATE `creature_template` SET `faction_A`=2070,`faction_H`=2070,`npcflag`=`npcflag`|1,`unit_flags`=`unit_flags`|32770,`speed_run`=1.143 WHERE `entry` IN (28136,28142,28148);
UPDATE `creature_model_info` SET `bounding_radius`=0.306,`combat_reach`=1.5 WHERE `modelid` IN (25131,25140,25143); 

DELETE FROM `creature_template_addon` WHERE `entry` IN (28136,28137,28133,28141,28142,28143,28148);
INSERT INTO `creature_template_addon` (`entry`,`bytes1`,`bytes2`,`auras`) VALUES
(28133,7,0,NULL), -- Crusader Jonathan appear dead
(28136,0,1,NULL), -- Crusader Jonathan
(28141,7,0,NULL), -- Crusader Lamoof appear dead
(28142,0,1,NULL), -- Crusader Lamoof
(28143,7,0,NULL), -- Crusader Josephine appear dead
(28148,0,1,NULL), -- Crusader Josephine
(28137,0,1, '50670 0'); -- Leave No One Behind Bunny

UPDATE `creature` SET `MovementType`=0,`spawndist`=0 WHERE `id`=28137; -- Incorrect movement for Leave No One Behind Bunny

DELETE FROM `waypoints` WHERE `entry` IN (28136,28142,28148);
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`) VALUES
(28136,0,5247.601,-3489.303,289.230),
(28136,1,5254.362,-3497.056,291.694),
(28142,0,5247.601,-3489.303,289.230),
(28142,1,5254.362,-3497.056,291.694),
(28148,0,5247.601,-3489.303,289.230),
(28148,1,5254.362,-3497.056,291.694);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (50671,50683,50698,50709,50723,50711,50710,50722,50712);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(50671,50680,1,'Crusader Jonathan kill credit'),
(50683,50684,1,'Crusader Lamoff kill credit'),
(50698,50699,1,'Crusader Josephine kill credit'),
(50709,50710,1,'Crusader Jonathan strip aura'),
(50723,50722,1,'Crusader Lamoof strip aura'),
(50711,50712,1,'Crusader Josephine strip aura'),
(50710,-50666,1,'Crusader Jonathan remove aura from player'),
(50722,-50679,1,'Crusader Lamoof remove aura from player'),
(50712,-50693,1,'Crusader Josephine remove aura from player');
-- Instructor Hroegar Flag and Loot Fix
SET @NPC = 29915;
UPDATE creature_template SET mingold = 1111,maxgold = 3333 , faction_A = 14 , faction_H =14 WHERE entry = @NPC;
DELETE FROM creature_loot_template WHERE entry = @NPC;
INSERT INTO creature_loot_template VALUES
(@NPC, 43297, 1, 1, 0, 1, 1),       -- Damaged Necklace
(@NPC, 41843, -99, 1, 0, 1, 1),     -- Key to Vaelen's Chains    
(@NPC, 43089, 98, 1, 0, 1, 1),      -- Vrykul Bones
(@NPC, 33470, 23, 1, 0, 1, 4),      -- Frostweave Cloth
(@NPC, 43852, 14, 1, 0, 1, 1),      -- Thick Fur Clothing Scraps
(@NPC, 43851, 14, 1, 0, 1, 1),      -- Fur Clothing Scraps
(@NPC, 33454, 4, 1, 0, 1, 1),       -- Salted Venison
(@NPC, 33445, 3, 1, 0, 1, 1),       -- Honeymint Tea
(@NPC, 42422, -14, 1, 0, 1, 1),     -- Jotunheim Cage Key
(@NPC, 33447, 1.9, 1, 0, 1, 1);     -- Runic Healing Potion 
-- QUEST 12957 "Slaves of the Stormforged"
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=29384;
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=29384 WHERE `entry`=12957;

DELETE FROM `gossip_menu` WHERE `entry`=9871 AND `text_id`=13682;
INSERT INTO `gossip_menu` (`entry`,`text_id`) VALUES
(9871,13682);

DELETE FROM `gossip_menu_option` WHERE `menu_id`=9871;
INSERT INTO `gossip_menu_option` (`menu_id`,`id`,`option_icon`,`option_text`,`option_id`,`npc_option_npcflag`,`action_menu_id`,`action_poi_id`,`action_script_id`,`box_coded`,`box_money`,`box_text`) VALUES
(9871,0,0,'I''m not a laborer. I''m here to free you from servitude in the mines.',1,1,0,0,0,0,0,'');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=14 OR `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9871;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(14,9871,13682,0,9,12957,0,0,0,'','Show gossip text only if player has quest 12957'),
(15,9871,0,0,9,12957,0,0,0,'','Show gossip menu option only if player has quest 12957');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29384,2938400);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(29384,0,0,0,62,0,100,0,9871,0,0,0,80,2938400,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On gossip option select run script'),
(2938400,9,0,0,0,0,100,0,0,0,0,0,81,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Turn off Gossip'),
(2938400,9,1,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Say random text'),
(2938400,9,2,0,0,0,100,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Set movement speed to walk'),
(2938400,9,3,0,0,0,100,0,0,0,0,0,69,0,0,0,0,0,0,21,0,0,0,0,0,0,0, 'Walk forward'),
(2938400,9,4,0,0,0,100,0,0,0,0,0,33,29384,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Give quest credit'),
(2938400,9,5,0,0,0,100,0,1000,1000,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn');

DELETE FROM `creature_text` WHERE `entry`=29384;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(29384,0,0,'Does not compute. Unit malfunctioning. Directive: Shut down.',0,0,100,1,0,0,'Captive Mechagnome text 0'),
(29384,0,1,'New directive: Leave mine and return to Inventor''s Library.',0,0,100,1,0,0,'Captive Mechagnome text 1'),
(29384,0,2,'New directive: Assist in the defeat of the iron dwarves.',0,0,100,1,0,0,'Captive Mechagnome text 2'),
(29384,0,3,'Free again? Keeper Mimir''s work awaits.',0,0,100,1,0,0,'Captive Mechagnome text 3'),
(29384,0,4,'Thank you, $r. I will join your struggle against the stormforged.',0,0,100,1,0,0,'Captive Mechagnome text 4');
-- Gallgrimm Graveyard Fix Only Horde 
UPDATE `game_graveyard_zone` SET `faction` = 67 WHERE `id` = 1309; 
-- Fix Quest linking from 12930 onwards
UPDATE `quest_template` SET `PrevQuestId`=12930, `ExclusiveGroup`=-12931, `NextQuestId`=12957 WHERE `entry`=12931;
UPDATE `quest_template` SET `PrevQuestId`=12930, `ExclusiveGroup`=-12931, `NextQuestId`=12964 WHERE `entry`=12937;
UPDATE `quest_template` SET `PrevQuestId`=12931, `ExclusiveGroup`=-12957, `NextQuestId`=12965 WHERE `entry`=12957;
UPDATE `quest_template` SET `PrevQuestId`=12937, `ExclusiveGroup`=-12957, `NextQuestId`=12978 WHERE `entry`=12964;
UPDATE `quest_template` SET `PrevQuestId`=12957 WHERE `entry`=12965;
UPDATE `quest_template` SET `PrevQuestId`=12964 WHERE `entry`=12978;
UPDATE `quest_template` SET `PrevQuestId`=12980 WHERE `entry`=12984;
UPDATE `quest_template` SET `ExclusiveGroup`=-12988, `NextQuestId`=12993 WHERE `entry`=12988;
UPDATE `quest_template` SET `PrevQuestId`=12984, `ExclusiveGroup`=-12988, `NextQuestId`=12993 WHERE `entry`=12991;


-- Quest Fix 13069 Shoot 'em up! 

-- Disable Move of Vehicle (30337)
DELETE FROM `creature_template` WHERE entry = 30337;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction_A`, `faction_H`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `WDBVerified`) VALUES 
(30337, 0, 0, 0, 0, 0, 26757, 0, 0, 0, 'Jotunheim Rapid-Fire Harpoon', '', 'vehichleCursor', 0, 80, 80, 2, 35, 35, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 2000, 0, 1, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56570, 0, 0, 0, 0, 0, 0, 229, 0, 0, '', 0, 3, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, '', 12340);
UPDATE `world` . `creature` SET unit_flags = 4 WHERE id = 30337;
-- Kill Credit Fix
UPDATE `quest_template` SET ReqSpellCast1 = 56578 WHERE entry = 13069;
-- Quest Fix 12555 A tangled skein
UPDATE `creature_template` SET unit_flags = 4 WHERE entry = 28274; -- don't attack player
UPDATE `quest_template` SET ReqCreatureOrGOId1 = 28274, ReqSpellCast1 = 51165 WHERE entry = 12555;
DELETE FROM `gameobject` WHERE `id` = 175334;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (175334, 229, 1, 1, 35.6104, -445.744, -18.7806, 5.89444, 0, 0, 0.193153, -0.981169, 300, 0, 1);

-- Quest 13070 Cold Weather Front nears
UPDATE quest_template SET SpecialFlags = 0 WHERE entry = 13070;

-- Fix NPC 'Gino' (29432)
DELETE FROM `creature` WHERE `guid` = 203055; 
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203055, 29432, 571, 1, 1, 0, 0, 6317.91, -1726.57, 455.974, 1.55527, 300, 0, 0, 12600, 0, 0, 0, 0, 0, 0);
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|2 WHERE `entry`=30282;

DELETE FROM `spell_script_names` WHERE `spell_id`=60936;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(60936, 'spell_surge_of_power_targeting');

DELETE FROM `spell_script_names` WHERE `spell_id`=29232;
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(29232, 'spell_fungal_creep_targeting');

-- Workaround for Quest 10722 Meeting at the Blackwing Coven
UPDATE creature_template SET gossip_menu_id = 22019 WHERE entry = 22019;
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 22019;
DELETE FROM npc_text WHERE ID = 22019;
INSERT INTO npc_text VALUES
(22019,'Welcome to the Blackwing Coven $c.', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 1);
DELETE FROM gossip_menu WHERE entry = 22019;
INSERT INTO gossip_menu VALUES
(22019,22019);
DELETE FROM gossip_menu_option WHERE menu_id = 22019;
INSERT INTO gossip_menu_option VALUES
(22019,0,0,'It´s over now!',1,1,0,0,0,0,0,'');
DELETE FROM smart_scripts WHERE entryorguid IN (22019,2201900);
INSERT INTO smart_scripts VALUES
(22019, 0, 0, 0, 62, 0, 100, 0, 22019, 0, 0, 0, 80, 2201900, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'run script on select gossip'),
(22019, 0, 1, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 8599, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'on aggro cast enrage'),
(22019, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 37704, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'on aggro cast whirlwind'),
(2201900, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'close gossip menu'),
(2201900, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 15, 10722, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'give quest credit'),
(2201900, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 28, 38157, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'remove Overseer Disguise from player');

-- CleanUp of NPC 24018
DELETE FROM `creature` WHERE `id` = 24018;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(203497, 24018, 571, 1, 1, 0, 0, 2589.42, -3742.93, 247.053, 0, 120, 0, 0, 1, 0, 0, 0, 0, 0, 0);
-- Add Smart AI by Malcrom @ www.TrinityCore.org
-- Necro Overlord Mezhen SAI
SET @GUID    := ( SELECT ( SELECT MAX(`guid`) FROM `creature`)+1 ); -- 1 Required for ELM General Purpose Bunny
SET @ENTRY   := 24018; -- NPC entry
SET @CHANNEL := 43151; -- Necrolord: Purple Beam
SET @TARGET  := 24021; -- ELM General Purpose Bunny (scale x0.01)
SET @SPELL1  := 32862; -- Drain Soul
SET @SPELL2  := 43559; -- Raise Dead
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type`=0 AND `entryorguid`=@ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@ENTRY,0,0,0,1,0,100,1,1000,1000,1000,1000,11,@CHANNEL,2,0,0,0,0,11,@TARGET,30,0,0,0,0,0, 'Necro Overlord Mezhen - On spawn & reset - Channel Necrolord: Purple Beam');
-- Fix Spell condition for Spell 43151 to only target ELM General Purpose Bunny (scale x0.01)
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceEntry`=43151;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,0,43151,0,18,1,24021,0,0,'','Spell 43151 targets only ELM General Purpose Bunny (scale x0.01)');
-- Add missing ELM General Purpose Bunny (scale x0.01)
DELETE FROM `creature` WHERE `guid`=@GUID; 
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(@GUID,24021,571,1,1,0,0,2597.148,-3735.499,261.9468,0.2094395,120,0,0,1,0,0,0);
-- ELM General Purpose Bunny (scale x0.01) fix InhabitType
UPDATE `creature_template` SET `InhabitType`=7 WHERE entry=24021;
-- Workaround for Quest 11529 'Sorlof`s Booty'
-- SAI
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry = 24914;
-- spawn GO 187238 'Sorlof´s Booty' after kill at invoker
DELETE FROM smart_scripts WHERE entryorguid = 24914;
INSERT INTO smart_scripts VALUES
(24914, 0, 0, 0, 6, 0, 100, 0, 0, 0, 0, 0, 11, 45070, 0x02, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'on death cast summon GO');

-- Fix Teleport between Sholazar Basin and Un'Goro Crater
-- in conection with quests 'The Etymidian' (12548) and 'Back Through the Waygate' (12797)
DELETE FROM areatrigger_teleport WHERE id IN (5046,5047);
INSERT INTO areatrigger_teleport VALUES
(5046,'Teleport from Sholazar to Un`Goro',1,-6164.0117,-1329.0784,-170.5762,2.378), -- Sholazar Waygate
(5047,'Teleport from Un`Goro to Sholazar',571,4892.8154,5179.8438,-88.5301,0.376); -- Un`Goro Waygate 
-- Fix for Quest 11314 The Fallen Sisters
-- Chill Nymph SAI (in progress)
UPDATE `creature_template` SET `AIName`= 'SmartAI' WHERE `entry`=23678;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (23678,2367800);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(23678,0,0,0,2,0,100,1,0,30,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'Do text emote on health 30%'),
(23678,0,1,0,0,0,75,0,2000,3000,2000,2000,11,9739,0,0,0,0,0,2,0,0,0,0,0,0,0,'Cast Wrath on victim'),
(23678,0,2,3,8,0,100,0,43340,0,0,0,66,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'On Spell hit 43340 face player'),
(23678,0,3,4,61,0,100,0,0,0,0,0,21,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'stop combat movement'),
(23678,0,4,5,61,0,100,0,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,'evade'),
(23678,0,5,6,61,0,100,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,'set faction 35'),
(23678,0,6,7,61,0,100,0,0,0,0,0,33,24117,0,0,0,0,0,7,0,0,0,0,0,0,0,'quest credit'),
(23678,0,7,0,61,0,100,0,0,0,0,0,80,2367800,0,0,0,0,0,1,0,0,0,0,0,0,0,'load script'),
(23678,0,8,0,40,0,100,0,1,23678,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On reach waypoint 1 despawn'),
(2367800,9,0,0,0,0,100,0,2000,2000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,'Say text 1'),
(2367800,9,1,0,0,0,100,0,1000,1000,0,0,53,1,23678,0,0,0,0,1,0,0,0,0,0,0,0, 'start waypoint movement');
-- NPC talk text insert
DELETE FROM `creature_text` WHERE `entry`=23678;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(23678,0,0, 'Chill Nymph appears weak!',2,0,100,0,0,0, 'Chill Nymph'),
(23678,1,0, 'I knew Lurielle would send help! Thank you friend, and give Lurielle my thanks as well!',0,7,100,1,0,0, 'Chill Nymph'),
(23678,1,1, 'Where am I? What happened to me? You... you freed me?',0,7,100,1,0,0, 'Chill Nymph'),
(23678,1,2, 'Thank you. I thought I would die without seeing my sisters again!',0,7,100,1,0,0, 'Chill Nymph');
-- Chill Nymph Path
DELETE FROM `waypoints` WHERE `entry`=23678;
INSERT INTO `waypoints` (`entry`,`pointid`,`position_x`,`position_y`,`position_z`,`point_comment`) VALUES
(23678,1,2063,-4666,217,'Chill Nymph point 1');
-- Add condition for Item 33606 "Lurielle''s Pendant" to only target Chill Nymph 23678
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=18 AND `SourceEntry`=33606;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(18,0,33606,0,24,1,23678,0,63,'','Item 33606 Lurielle''s Pendant targets Chill Nymph 23678');
-- Workaround for Quest 10607 Whisper of the Raven God

DELETE FROM `creature_questrelation` WHERE `quest` = 10607;
DELETE FROM `gameobject_questrelation` WHERE `quest` = 10607;
UPDATE `item_template` SET `StartQuest`=0 WHERE `StartQuest` = 10607;
INSERT INTO `creature_questrelation` (`id`, `quest`) VALUES (21782, 10607);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` = 21782;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 10607;
DELETE FROM `gameobject_involvedrelation` WHERE `quest` = 10607;
INSERT INTO `creature_involvedrelation` (`id`, `quest`) VALUES (21782, 10607);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry`=21782;
REPLACE INTO `quest_template` (`entry`, `Method`, `ZoneOrSort`, `SkillOrClassMask`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredRaces`, `RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RepObjectiveFaction2`, `RepObjectiveValue2`, `RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, `LimitTime`, `QuestFlags`, `SpecialFlags`, `CharTitleId`, `PlayersSlain`, `BonusTalents`, `RewardArenaPoints`, `PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `RewXPId`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, `Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, `ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, `ReqItemId5`, `ReqItemId6`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqItemCount5`, `ReqItemCount6`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, `ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, `ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, `ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, `RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, `RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, `RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, `RewRepFaction4`, `RewRepFaction5`, `RewRepValueId1`, `RewRepValueId2`, `RewRepValueId3`, `RewRepValueId4`, `RewRepValueId5`, `RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewHonorAddition`, `RewHonorMultiplier`, `unk0`, `RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, `PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, `DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, `OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, `OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `WDBVerified`) VALUES (10607, 2, 3522, 0, 66, 0, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 136, 0, 0, 0, 0, 0, 10567, 0, 0, 0, 5, 0, 0, 0, 'Das Fl?stern des Rabengottes', 'In Grishnath k?nnen die Arakkoa mithilfe der Totems, die die Orakel des Raben aufgestellt haben, die Worte des Raben h?ren. Leider sind wir der Sprache der Arakkoa nicht m?chtig.$B$BMit dem Anh?nger des Herolds k?nnen wir sie verstehen. Ihr k?nnt die Seele der Arakkoa aufnehmen und so ihrer Sprache m?chtig werden. Begebt Euch zu den Totems, w?hrend ihr mit dem Geist der Arakkoa erf?llt seid, und h?rt Euch ihre Nachricht an.$B$BFindet es f?r uns heraus, $N.', 'T?tet die Arakkoa der Grishna, um f?r 2 Minuten den Zauber \'Rabensprache verstehen\' zu erhalten. H?rt Euch die Prophezeiungen aller vier Schreine an, solange der Zauber aktiv ist.', 'Das ist wirklich beunruhigend. Die Arakkoa waren lange ein friedliebendes Volk. Dieser Rabenkult ist nichts als eine Versammlung von Au?enseitern und Verr?ckten.$B$BAber wir k?nnen nicht leugnen, dass ihre Macht w?chst. Vielleicht steckt hinter diesem Raben mehr, als wir vermuten.', 'What is this $N? What do they believe he will do? Where do they believe he will lead them?', '', 'Kehrt zu Timeon im ewigen Hain im Schergrat zur?ck.', 'Erste Prophezeiung geh?rt', 'Zweite Prophezeiung geh?rt', 'Dritte Prophezeiung geh?rt', 'Vierte Prophezeiung geh?rt', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -184950, -184967, -184968, -184969, 1, 1, 1, 1, 0, 0, 0, 0, 31531, 31532, 31533, 31534, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 942, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);

-- Fix for NPC 30204 Forgotten Depths Ambusher
UPDATE creature_template SET unit_flags = 0 WHERE entry = 30204;

-- Fix for Quest 4788 The Final Tablets
-- Spawn Fifth Mosh'aru Tablet and Sixth Mosh'aru Tablet
DELETE FROM `gameobject` WHERE `id` IN (175949, 175950);
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
(175949, 229, 1, 1, -128.202, -482.001, 25.4587, 0.0125299, 0, 0, 0.00626493, 0.99998, 300, 0, 1),
(175950, 229, 1, 1, -10.0497, -465.8, -17.016, 1.57548, 0, 0, 0.70876, 0.70545, 300, 0, 1);
-- Quest 11416, 11417 Eyes of the eagle
DELETE FROM `gameobject` WHERE `id` IN (186814,190283);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(42458,186814,571,1,1,1597.404,-3903.790,79.702,0,0,0,0,0,60,100,1),
(42459,190283,571,1,1,1597.404,-3903.790,79.702,0,0,0,0,0,60,100,1);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry` IN(186814,190283);
UPDATE `creature_template` SET `AIName`='SmartAI', `speed_walk`=3.5, `InhabitType`=7 WHERE `entry`=24518;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (186814,190283,24518);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Talonshrike's egg script
(186814,1,0,0,64,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,24518,100,0,0,0,0,0, 'On egg use notify Talonshrike'),
(190283,1,0,0,64,0,100,0,0,0,0,0,45,0,1,0,0,0,0,11,24518,100,0,0,0,0,0, 'On egg use notify Talonshrike'),
-- Talonshrike script
(24518,0,0,0,38,0,100,0,0,1,0,0,69,0,0,0,0,0,0,8,0,0,0,1597.404,-3903.790,79.702,0, 'On notification fly to nest'),
(24518,0,1,0,0,0,100,0,5000,5000,10000,12000,11,49865,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Use Eye Peck'),
(24518,0,2,0,0,0,100,0,3000,3000,5000,7000,11,32909,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Use Talon Strike');
-- Fix Quest 12204 'In the Name of Loken'
-- Workaround  (missing creature_text of Hugh Glass - copied of Gavrock)

-- Gavrock SAI
SET @GAV_ENTRY := 26420;
-- Template
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=@GAV_ENTRY;
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@GAV_ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@GAV_ENTRY,0,0,'Ah, yes. Loken is well known to me.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@GAV_ENTRY,1,0,'It is he who commands the sons of iron in their ways against us.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@GAV_ENTRY,2,0,'From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken');
-- Script
DELETE FROM `smart_scripts` WHERE `entryorguid` in (@GAV_ENTRY,@GAV_ENTRY*100);
INSERT INTO `smart_scripts` 
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@GAV_ENTRY,0,0,0,62,0,100,0,9485,0,0,0,80,@GAV_ENTRY*100,2,0,0,0,0,1,0,0,0,0,0,0,0, 'Gavrock - Start Script'),
(@GAV_ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: close gossip menu'),
(@GAV_ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: say text 0'),
(@GAV_ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: say text 1 after text 0'),
(@GAV_ENTRY*100,9,3,0,0,0,100,0,4000,4000,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,'Gavrock: say text 2 after text 1'),
(@GAV_ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,33,@GAV_ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Gavrock: credit for quest In the Name of Loken');
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9485;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES (15,9485,0,0,9,12204,0,0,0,'','Gavrock: show gossip if player has quest 12204');

-- Hugh Glass SAI
-- ATTENTION: I haven't found any information about the texts used by this npc, so atm I used Gavarock texts.
-- Texts must be changed (and script must be modified accordingly if needed) when information from official servers are taken.
SET @HUGH_ENTRY := 26484;
-- Template
UPDATE `creature_template` SET `npcflag`=`npcflag`|1, `AIName`='SmartAI' WHERE `entry`=@HUGH_ENTRY;
-- Gossip Menu Option
DELETE from `gossip_menu_option` WHERE `menu_id`=9484 AND `id`=0;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES (9484,0,0,'What can you tell me about Loken and the iron dwarves?',1,1,0,0,0,0,0,'');
-- Texts
DELETE FROM `creature_text` WHERE `entry`=@HUGH_ENTRY;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(@HUGH_ENTRY,0,0,'Ah, yes. Loken is well known to me.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@HUGH_ENTRY,1,0,'It is he who commands the sons of iron in their ways against us.',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken'),
(@HUGH_ENTRY,2,0,'From his hiding place, he oversees their preparations for war with the goal of exterminating the stone giants!',0,0,100,0,0,0,'Gavrock: quest In the Name of Loken');
-- Script
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@HUGH_ENTRY,@HUGH_ENTRY*100);
INSERT INTO `smart_scripts` 
(`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(@HUGH_ENTRY,0,0,0,62,0,100,0,9484,0,0,0,80,@HUGH_ENTRY*100,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Hugh Glass - Start Script'),
(@HUGH_ENTRY*100,9,0,0,0,0,100,0,0,0,0,0,72,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: close gossip menu'),
(@HUGH_ENTRY*100,9,1,0,0,0,100,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: say text 0'),
(@HUGH_ENTRY*100,9,2,0,0,0,100,0,3000,3000,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: say text 1 after text 0'),
(@HUGH_ENTRY*100,9,3,0,0,0,100,0,4000,4000,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,'Hugh Glass: say text 2 after text 1'),
(@HUGH_ENTRY*100,9,4,0,0,0,100,0,0,0,0,0,33,@HUGH_ENTRY,0,0,0,0,0,7,0,0,0,0,0,0,0,'Hugh Glass: credit for quest In the Name of Loken');
-- Conditions
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=9484 AND `SourceEntry`=0;
	INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES (15,9484,0,0,9,12204,0,0,0,'','Hugh Glass: show gossip if player has quest 12204');

	
	

-- Fix Quest 4764 Doomrigger's Clasp

DELETE FROM `gameobject` WHERE `id` = 175382;
INSERT INTO `gameobject` (id, map, spawnMask, phaseMask, position_x, position_y, position_z, orientation, rotation1, rotation2, rotation3, spawntimesecs, animprogress, state) VALUES (175382, 229, 1, 1, 67.128304, -297.420990, 91.425499, -0.034906, 0, 0, 0, 300, 0, 1);
DELETE FROM gameobject_questrelations WHERE quest = 4764;
INSERT INTO gameobject_questrelation (id, quest) VALUES (NULL, 4764);
DELETE FROM gameobject_involvedrelation WHERE quest = 4764;
INSERT INTO gameobject_involvedrelation (id, quest) VALUES (NULL, 4764);
DELETE FROM gameobject_loot_template WHERE entry = 175382;
INSERT INTO gameobject_loot_template (entry, item, ChanceOrQuestChance, groupid, mincountOrRef, maxcount, lootcondition, condition_value1, condition_value2) VALUES (175382, 12352, -100, 1, 1, 1, 9, 4764, 0);


--Fix Reputation for Quest 11023 Bomb them again
UPDATE quest_template SET RewRepValueID1=7 WHERE entry=11023;
UPDATE quest_template SET RewRepValueID2=7 WHERE entry=11023;

INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(8, 669014),
(8, 669023),
(8, 302615);

-- put the pharmacist and the event npc in the game_event_creature
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES 
(8, 302610),
(8, 302611),
(8, 302612),
(8, 302613);

-- Fix for noblegarden eggs and npc
REPLACE INTO game_event_gameobject SELECT 9, guid FROM gameobject WHERE id IN (113768, 113769, 113770, 113771);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (9, 410015);

-- Put npc Omen in the game_event_creature
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES (7, 302600);

UPDATE `creature_template` SET `dmg_multiplier`=40 WHERE `entry`=28859;
UPDATE `creature_template` SET `dmg_multiplier`=70 WHERE `entry`=31734;
UPDATE `creature_template` SET `dmg_multiplier`=20 WHERE `entry`=30245;
UPDATE `creature_template` SET `dmg_multiplier`=30 WHERE `entry`=31750;

UPDATE `gameobject_loot_template` SET `item`=40753 WHERE `entry`=26097 AND `item`=47241;

UPDATE `npc_spellclick_spells` SET `spell_id`=46598 WHERE `npc_entry`=31748;

## Blessing of Kings & Blessing of Sanctuary Stack Fix
SET @group = 5000;

-- Insert Spells to Stackrules
DELETE FROM `spell_group` WHERE `id` = @group;
INSERT INTO `spell_group` (`id`, `spell_id`) VALUES
 (@group, 20911), -- Blessing of Sanctuary
 (@group, 20217), -- Blessing of Kings
 (@group, 69378); -- Blessing of Forgotten Kings

-- Set stack rule for group
DELETE FROM `spell_group_stack_rules` WHERE `group_id` = @group;
INSERT INTO `spell_group_stack_rules` (`group_id`, `stack_rule`) VALUES
 (@group, 1);
-- spawn 'Celestial Planetarium Access'
DELETE FROM `gameobject` WHERE `id`= 194628;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`)
VALUES (400002, 194628, 603, 3, 1, 1649.49, -174.711, 427.257, 1.5708, 0, 0, 0, 0, 180, 0, 1);

UPDATE `gameobject_template` SET `data0`=0, `ScriptName`='go_planetarium_access' WHERE `entry`=194628;

-- Fix Quest 'The Tome of Divinity' part 7 (1768)
-- Cleanup NPC
DELETE FROM `creature` WHERE `id` = 6172;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES 
(81163, 6172, 0, 1, 1, 0, 0, -9129.59, -984.313, 76.1811, 2.05949, 180, 0, 0, 186, 191, 0, 0, 0, 0, 0);
-- quest_template Changes 
UPDATE `quest_template` SET `ReqCreatureOrGOId1` = 6172, `ReqCreatureOrGOCount1` = 1, `ReqSpellCast1` = 8593 WHERE `entry` = 1786; 
-- creature_template - disable move
UPDATE `creature_template` SET `unit_flags` = `unit_flags` | 4 WHERE `entry` = 6172;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1575030 AND -1575000;
INSERT INTO `script_texts` (`npc_entry`, `entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
('0','-1575030','%s is within range of the harpoon launchers!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','3','0','0','skadi EMOTE_HARPOON_RANGE'),
('26693','-1575029','You motherless knaves! Your corpses will make fine morsels for my new drake!',NULL,NULL,'Ihr räudigen Halunken! Eure Leichen werden feine Appetithappen für meinen neuen Drachen abgeben!',NULL,NULL,NULL,NULL,NULL,'13507','1','0','0','skadi SAY_DRAKE_DEATH'),
('26693','-1575028','ARGH! You call that... an attack? I\'ll... show... aghhhh...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13506','1','0','0','skadi SAY_DEATH'),
('26693','-1575027','I\'ll mount your skull from the highest tower!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13505','1','0','0','skadi SAY_KILL_3'),
('26693','-1575026','Not so brash now, are you?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13504','1','0','0','skadi SAY_KILL_2'),
('26693','-1575025','Mjor Na Ul Kaval!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13503','1','0','0','skadi SAY_KILL_1'),
('26693','-1575024','If one more harpoon touches my drake I\'ll flae my miserable heins.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13502','1','0','0','skadi SAY_DRAKE_HARPOON_2'),
('26693','-1575023','I ask for ... to kill them, yet all I get is feeble whelps! By Ye.. SLAUGHTER THEM!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13501','1','0','0','skadi SAY_DRAKE_HARPOON_1'),
('26693','-1575022','Cleanse our sacred halls with flame!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13500','1','0','0','skadi SAY_DRAKEBREATH_3'),
('26693','-1575021','Go now! Leave nothing but ash in your wake!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13499','1','0','0','skadi SAY_DRAKEBREATH_2'),
('26693','-1575020','Sear them to the bone!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13498','1','0','0','skadi SAY_DRAKEBREATH_1'),
('26693','-1575019','What mongrels dare intrude here? Look alive, my brothers! A feast for the one that brings me their heads!',NULL,NULL,'Welche Hunde wagen es, hier einzudringen? Auf sie, meine Brüder! Ein Fest für den, der mir ihre Köpfe bringt!',NULL,NULL,NULL,NULL,NULL,'13497','1','0','0','skadi SAY_AGGRO'),
('26687','-1575018',' ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13467','1','0','0','gortok SAY_DEATH'),
('26687','-1575017','An easy task!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13466','1','0','0','gortok SAY_SLAY_2'),
('26687','-1575016','You die! That what master wants!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13465','1','0','0','gortok SAY_SLAY_1'),
('26687','-1575015','What this place? I will destroy you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13464','1','0','0','gortok SAY_AGGRO'),
('26668','-1575014','Nooo! I did not come this far... to...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13855','1','0','0','svala SAY_DEATH'),
('26668','-1575013','Any last words?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13854','1','0','0','svala SAY_SACRIFICE_5'),
('26668','-1575012','Yor-guul mak!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13853','1','0','0','svala SAY_SACRIFICE_4'),
('26668','-1575011','Your end is inevitable.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13852','1','0','0','svala SAY_SACRIFICE_3'),
('26668','-1575010','Go now to my master.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13851','1','0','0','svala SAY_SACRIFICE_2'),
('26668','-1575009','Your death approaches.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13850','1','0','0','svala SAY_SACRIFICE_1'),
('26668','-1575008','Another soul for my master.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13848','1','0','0','svala SAY_SLAY_3'),
('26668','-1575007','Your will is done, my king.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13847','1','0','0','svala SAY_SLAY_2'),
('26668','-1575006','You were a fool to challenge the power of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13845','1','0','0','svala SAY_SLAY_1'),
('26668','-1575005','I will vanquish your soul!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13842','1','0','0','svala SAY_AGGRO'),
('0','-1575004','I will be happy to slaughter them in your name! Come, enemies of the Scourge! I will show you the might of the Lich King!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13858','1','0','0','svala SAY_INTRO_5'),
('0','-1575003','Your first test awaits you. Destroy our uninvited guests.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'14733','1','0','0','svala SAY_INTRO_4_ARTHAS'),
('0','-1575002','The sensation is... beyond my imagining. I am yours to command, my king.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'13857','1','0','0','svala SAY_INTRO_3'),
('0','-1575001','Your sacrifice is a testament to your obedience. Indeed you are worthy of this charge. Arise, and forever be known as Svala Sorrowgrave!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'14732','1','0','0','svala SAY_INTRO_2_ARTHAS'),
('0','-1575000','My liege! I have done as you asked, and now beseech you for your blessing!',NULL,NULL,'Mein Meister! Ich tat, was Ihr verlangtet, und ersuche Euch um Euren Segen!',NULL,NULL,NULL,NULL,NULL,'13856','1','0','0','svala SAY_INTRO_1');

-- Fix Quest 10525 Vision Guide
UPDATE `item_template` SET `ScriptName`='fiery_soul_fragment_item' WHERE `entry` = 30481;
-- Quest 11324, 11326 "Alpha Worg"
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=14, `faction_A`=14 WHERE `entry`=24277;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=24210; -- Riven Widow Cocoons disable random movement

DELETE FROM `creature_addon` WHERE `guid`=199999;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES
(199999,1999990,0,0,0,0,'49415 0'); -- Invisibility and waypoint asignment

DELETE FROM `creature` WHERE `id`=24277;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(199999,24277,571,1,1,22233,0,2461.043,-3099.657,141.533,5.812,300,0,0,13936,0,0,2,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid`=24277;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(24277,0,0,0,0,0,100,0,2000,4000,10000,12000,11,50046,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Gnaw Bone'),
(24277,0,1,0,0,0,100,0,1000,3000,15000,18000,11,13443,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Rend'),
(24277,0,2,0,0,0,100,0,1500,2500,4000,6000,11,31279,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Swipe'),
(24277,0,3,0,0,0,100,0,10000,12000,20000,25000,11,6749,0,0,0,0,0,2,0,0,0,0,0,0,0,'Use Wide Swipe'),
(24277,0,4,5,2,0,100,0x01,0,50,0,0,3,0,26791,0,0,0,0,1,0,0,0,0,0,0,0,'Below 50% transform to worgen model'),
(24277,0,5,0,61,0,100,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'Say text Garwal');

DELETE FROM `waypoint_data` WHERE `id`=1999990;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_flag`,`action`,`action_chance`,`wpguid`) VALUES
(1999990,1,2461.043,-3099.657,141.533,0,0,0,100,0),
(1999990,2,2502.133,-3097.822,134.418,0,0,0,100,0),
(1999990,3,2559.702,-3097.267,121.556,0,0,0,100,0),
(1999990,4,2622.817,-3088.243,120.314,0,0,0,100,0),
(1999990,5,2638.738,-3096.804,121.635,0,0,0,100,0),
(1999990,6,2696.031,-3118.550,110.453,0,0,0,100,0),
(1999990,7,2744.101,-3110.267,115.296,0,0,0,100,0),
(1999990,8,2774.326,-3109.235,111.222,0,0,0,100,0),
(1999990,9,2797.473,-3106.683,110.129,0,0,0,100,0),
(1999990,10,2831.518,-3105.365,100.868,0,0,0,100,0),
(1999990,11,2847.851,-3089.628,91.186,0,0,0,100,0),
(1999990,12,2874.736,-3063.742,85.386,0,0,0,100,0),
(1999990,13,2872.254,-3045.130,82.085,0,0,0,100,0),
(1999990,14,2867.529,-3020.512,84.268,0,0,0,100,0),
(1999990,15,2811.413,-3018.185,88.837,0,0,0,100,0),
(1999990,16,2772.952,-3014.391,92.935,0,0,0,100,0),
(1999990,17,2700.462,-2996.456,92.247,0,0,0,100,0),
(1999990,18,2666.411,-2986.375,96.447,0,0,0,100,0),
(1999990,19,2649.578,-2979.369,95.366,0,0,0,100,0),
(1999990,20,2598.768,-2987.893,109.434,0,0,0,100,0),
(1999990,21,2560.210,-2988.716,111.262,0,0,0,100,0),
(1999990,22,2526.068,-3031.698,121.382,0,0,0,100,0),
(1999990,23,2501.948,-3041.872,126.281,0,0,0,100,0),
(1999990,24,2477.311,-3053.944,138.013,0,0,0,100,0),
(1999990,25,2467.604,-3071.109,141.345,0,0,0,100,0);

DELETE FROM `creature_text` WHERE `entry`=24277;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(24277,0,0,'Enough of this charade!',1,0,100,0,0,0,'Garwal morph text');

DELETE FROM `spell_scripts` WHERE `id`=50103;
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(50103,0,0,14,43060,1,0,0,0,0,0); -- Remove Eyes of the Eagle on quest turn in


DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (43682,50104);
INSERT INTO `spell_linked_spell` (`spell_trigger`,`spell_effect`,`type`,`comment`) VALUES
(43682,43060,1,'Apply Eyes of the Eagle'),
(50104,50103,1,'Remove Eyes of the Eagle');

UPDATE `quest_template` SET `SrcSpell`=43682 WHERE `entry` IN (11324,11326);
-- Fix Quest 13070 A Cold Front Approaches
UPDATE `quest_template` SET `SpecialFlags` = 0 WHERE `entry` = 13070;
DELETE FROM `creature_involvedrelation` WHERE `quest` = 13070;
INSERT INTO `creature_involvedrelation` VALUES
(30657,13070);


UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-5, `RewRepValueId2`=5 WHERE `entry`=662;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-2, `RewRepValueId2`=2 WHERE `entry`=663;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-5, `RewRepValueId2`=5 WHERE `entry`=664;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-5, `RewRepValueId2`=5 WHERE `entry`=665;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-6, `RewRepValueId2`=6 WHERE `entry`=666;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-6, `RewRepValueId2`=6 WHERE `entry`=667;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-3, `RewRepValueId2`=3 WHERE `entry`=668;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-5, `RewRepValueId2`=5 WHERE `entry`=669;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=-5, `RewRepValueId2`=5 WHERE `entry`=670;

UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=577 `RewRepValueId1`=-7, `RewRepValueId2`=7 WHERE `entry`=9266;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=470 `RewRepValueId1`=-7, `RewRepValueId2`=7 WHERE `entry`=9267;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=369 `RewRepValueId1`=-7, `RewRepValueId2`=7 WHERE `entry`=9268;
UPDATE `quest_template` SET `RewRepFaction1`=87, `RewRepFaction2`=21 `RewRepValueId1`=2, `RewRepValueId2`=-5 WHERE `entry`=9272;
--Fix Quest 10551 Loyalty to the Aldor
UPDATE `quest_template` SET `RewRepFaction2`=934 WHERE `entry`=10551
-- Quest 11895 "Master the Storm", Quest 11896 "Weakness to Lightning", Quest 11907 "The Sub-Chieftains" and Quest 11788 "Lefty Loosey, Righty Tighty"
DELETE FROM `creature` WHERE `id`=26048;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`,`npcflag`,`unit_flags`,`dynamicflags`) VALUES
(107478,26048,571,1,1,16988,0,3410.110,4128.981,18.054,5.699,60,0,0,8982,3155,0,0,0,0,0);

DELETE FROM `gameobject` WHERE `id` IN (188109,187987);
INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnMask`,`phaseMask`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`) VALUES
(188898,187987,571,1,1,3793.746,4805.559,-12.185,5.667,0,0,0,1,300,100,1),
(188899,188109,571,1,1,3791.950,4804.803,-12.158,4.571,0,0,0,1,300,100,1);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=26048;
UPDATE `creature_template` SET `unit_flags`=4, `AIName`='SmartAI' WHERE `entry`=26045;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25752;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25753;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25758;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=25792;

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry`=26048;
INSERT INTO `npc_spellclick_spells` (`npc_entry`,`spell_id`,`quest_start`,`quest_start_active`,`quest_end`,`cast_flags`,`aura_required`,`aura_forbidden`,`user_type`) VALUES
(26048,74772,11895,1,0,0,0,0,0);

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (26048,2604800,26045,25752,25753,25758,25792);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(26048,0,0,0,8,0,100,0,74772,0,0,0,80,2604800,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit start script'),
(2604800,9,0,0,60,0,100,0,0,0,0,0,12,26045,1,60000,0,1,0,8,0,0,0,3399.917,4135.566,18.054,5.699, 'Summon Storm Tempest'),
(2604800,9,1,0,60,0,100,0,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn'),
(26045,0,0,0,25,0,100,0,0,0,0,0,11,35487,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On summon Storm Tempest cast Lightning Cloud'),
(26045,0,1,0,4,0,100,0,0,0,60000,60000,1,0,0,0,0,0,0,2,0,0,0,0,0,0,0, 'On aggro Storm Tempest say text'),
(26045,0,2,0,0,0,100,0,0,0,4000,5000,11,15659,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Storm Tempest cast Chain Lightning'),
(26045,0,3,0,0,0,50,0,0,0,3000,4000,11,31272,0,0,0,0,0,2,0,0,0,0,0,0,0, 'Storm Tempest cast Wind Shock'),
(26045,0,4,0,6,0,100,0,0,0,0,0,85,46424,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On death apply Master the Storm'),
(25752,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25752,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25752,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25753,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25753,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25753,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25758,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25758,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25758,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura'),
(25792,0,0,0,8,0,100,0,46432,0,0,0,22,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On spellhit set phase 1'),
(25792,0,1,0,6,1,100,0,0,0,0,0,33,26082,0,0,0,0,0,1,0,0,0,0,0,0,0, 'If killed in phase 1 give quest credit'),
(25792,0,2,0,25,0,100,0,0,0,0,0,28,46432,0,0,0,0,0,1,0,0,0,0,0,0,0, 'On respawn remove aura');

DELETE FROM `creature_text` WHERE `entry`=26045;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(26045,0,0,'You will not defeat me, puny $R!',0,0,100,0,0,0, 'Storm Tempest text');

DELETE FROM `spell_scripts` WHERE `id` IN (46550);
INSERT INTO `spell_scripts` (`id`,`effIndex`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`o`) VALUES
(46550,0,0,14,46424,0,0,0,0,0,0);
-- QUEST 12998 "The Heart of the Storm"
UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=192181;
UPDATE `creature_template` SET `AIName`='SmartAI', `faction_H`=1954, `faction_A`=1954, `unit_flags`=768, `equipment_id`=749, `flags_extra`=2 WHERE `entry`=30299;

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (30299,3029900,192181,19218100);
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
-- Overseer Narvir script
(30299,0,0,0,25,0,100,0,0,0,0,0,80,3029900,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On summon Overseer Narvir start script'),
(3029900,9,0,0,0,0,100,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Set react passive'),
(3029900,9,1,0,0,0,100,0,500,500,0,0,69,0,0,0,0,0,0,8,0,0,0,7313.045,-726.853,791.610,0, 'Walk to the Heart of the Storm'),
(3029900,9,2,0,0,0,100,0,6500,6500,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,2.437, 'Set orientation'),
(3029900,9,3,0,0,0,100,0,2000,2000,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Narvir say text 0'),
(3029900,9,4,0,0,0,100,0,5000,5000,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Overseer Narvir say text 1'),
(3029900,9,5,0,0,0,100,0,6000,6000,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,3.334, 'Set orientation'),
(3029900,9,6,0,0,0,100,0,500,500,0,0,17,133,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Loot the heart'),
(3029900,9,7,0,0,0,100,0,5000,5000,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Stop looting'),
(3029900,9,8,0,0,0,100,0,1500,1500,0,0,5,463,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Disappear emote'),
(3029900,9,9,0,0,0,100,0,500,500,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0, 'Despawn'),
-- Heart of the Storm script
(192181,1,0,0,64,0,100,0x01,0,0,0,0,80,19218100,0,2,0,0,0,1,0,0,0,0,0,0,0, 'On use start script'),
(19218100,9,0,0,0,0,100,0,1000,1000,0,0,12,30299,1,60000,0,0,0,8,0,0,0,7312.130,-710.919,791.610,4.643, 'Summon Overseer Narvir'),
(19218100,9,1,0,0,0,100,0,0,0,0,0,75,56485,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Cyclone the invoker'),
(19218100,9,2,0,0,0,100,0,27000,27000,0,0,33,30299,0,0,0,0,0,7,0,0,0,0,0,0,0, 'Give quest credit');

DELETE FROM `creature_text` WHERE `entry`=30299;
INSERT INTO `creature_text` (`entry`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`comment`) VALUES
(30299,0,0,'You didn\'t think that I was going to let you walk in here and take the Heart of the Storm, did you?',0,0,100,6,0,0,'Narvir text 0'),
(30299,1,0,'You may have killed Valduran, but that will not stop me from completing the colossus.',0,0,100,274,0,0,'Narvir text 1');
UPDATE `creature_template` SET `mechanic_immune_mask` = `mechanic_immune_mask` | 16 WHERE `entry`=26125;
-- Fix Taxi from Quest 'To Westguard Keep!' #11291
SET @Emilune    = 27930; -- Emilune Winterwind
SET @Gossip     = 9618;   -- gossip_menu_id
SET @Quest      = 11291; -- Quest
SET @Spell      = 50028; -- Gryphon Taxi to Westguard Keep
-- Update creature_template
UPDATE `creature_template` SET `AIName` = 'SmartAI', `npcflag` = `npcflag` | 1 WHERE `entry` = @Emilune;
-- gossip_menu_option
DELETE FROM `gossip_menu_option` WHERE `menu_id` = @Gossip;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`) VALUES 
(@Gossip,0,0,'Please, Take me to Westguard Keep!',1,1,0,0,0,0,0,'');
-- SAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = @Emilune;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@Emilune,0,0,0,62,0,100,0,@Gossip,0,0,0,11,@Spell,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast taxi');
-- conditions
DELETE FROM `conditions` WHERE `SourceGroup` = @Gossip AND `SourceTypeOrReferenceId` = 28;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(15,@Gossip,0,0,28,@Quest,0,0,0,'','show gossip menu option if player has completed 11291');
-- CleanUp Captain Zorna
DELETE FROM `creature` WHERE `id` = 27511;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
(107018, 27511, 571, 1, 1, 24683, 0, 2708.7, -1812.33, 4.8389, 5.53136, 300, 5, 0, 30846, 0, 0, 1, 0, 0, 0);

-- add mounts to creatures 
UPDATE creature_template SET InhabitType = 4 WHERE entry IN (21998,22059);
DELETE FROM creature_template_addon WHERE entry IN (21998,22059);
INSERT INTO creature_template_addon VALUES
(21998,0,17719,0,4097,0,NULL),
(22059,0,17717,0,4097,0,NULL);
-- show Mootoo alive on escortquest Escaping the Mist (ID=25504)
UPDATE creature_addon SET bytes1 = 0 WHERE guid = 111075; 
-- Wanted Poster at Zabra'jin faction fix
UPDATE `gameobject_template` SET `faction` = 83 WHERE `entry` = 182165;

-- spawn Darkstone Tablet Container (Upper Blackrock Spire)
DELETE FROM `gameobject`WHERE `id` = 175385;
INSERT INTO `gameobject` (`id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES 
(175385, 229, 1, 1, 65.677, -281.64, 93.8493, 3.02213, 0, 0, 0.998217, 0.0596968, 300, 0, 1); 

-- FiX: get lost quest items on gossip with conditions
-- +-----------------+
-- |creature_template|
-- +-----------------+
UPDATE creature_template SET AIName = 'SmartAI' WHERE entry IN (21772,21774,21769,21773,28518,26117,24186,24273,22127);
UPDATE creature_template SET gossip_menu_id = 21772, npcflag = npcflag | 1 WHERE entry = 21772;       -- Chief Apothecary Hildagard
UPDATE creature_template SET gossip_menu_id = 21774, npcflag = npcflag | 1 WHERE entry = 21774;       -- Zorus the Judicator
UPDATE creature_template SET gossip_menu_id = 21769, npcflag = npcflag | 1 WHERE entry = 21769;       -- Overlord Or'barokh
UPDATE creature_template SET gossip_menu_id = 21773, npcflag = npcflag | 1 WHERE entry = 21773;       -- Thane Yoregar
UPDATE creature_template SET gossip_menu_id =  9709, npcflag = npcflag | 1 WHERE entry = 28518;       -- Stefan Vadu
UPDATE creature_template SET gossip_menu_id =  9253, npcflag = npcflag | 1 WHERE entry = 26117;       -- Raelorasz
UPDATE creature_template SET gossip_menu_id =  8908, npcflag = npcflag | 1 WHERE entry = 24186;       -- Sage Mistwalker
UPDATE creature_template SET gossip_menu_id =  8918, npcflag = npcflag | 1 WHERE entry = 24273;       -- Watcher Moonleaf
UPDATE creature_template SET gossip_menu_id = 22127, npcflag = npcflag | 1 WHERE entry = 22127;       -- Wildlord Antelarion
-- +-----------+
-- |gossip_menu|
-- +-----------+
DELETE FROM gossip_menu WHERE entry IN (21772,21774,21769,21773,9709,9253,8908,8918,22127);
INSERT INTO gossip_menu VALUES
(21772,1),      -- Chief Apothecary Hildagard
(21774,1),      -- Zorus the Judicator
(21769,1),      -- Overlord Or'barokh
(21773,1),      -- Thane Yoregar
(9709,13270),   -- Stefan Vadu
(9253,12592),   -- Raelorasz
(8908,11756),   -- Sage Mistwalker
(8918,11858),   -- Watcher Moonleaf
(22127,1);      -- Wildlord Anterarion
-- +------------------+
-- |gossip_menu_option|
-- +------------------+
DELETE FROM gossip_menu_option WHERE menu_id IN (21772,21774,21769,21773,9709,9253,8908,8918,22127);
INSERT INTO gossip_menu_option VALUES
-- Chief Apothecary Hildagard
(21772,0,0,'Please, give me a new Spectrecles.',1,1,0,0,0,0,0,''),
-- Zorus the Judicator
(21774,0,0,'Please, give me a new Spectrecles.',1,1,0,0,0,0,0,''),
-- Overlord Or'barokh
(21769,0,0,'Please, give me a new Kor´kron Flare Gun.',1,1,0,0,0,0,0,''),
-- Thane Yoregar
(21773,0,0,'Please, give me a new Wildhammer Flare Gun.',1,1,0,0,0,0,0,''),
-- Stefan Vadu
(9709,0,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,1,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,2,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,3,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
(9709,4,0,'Please, give me a new Ensorcelled Choker.',1,1,0,0,0,0,0,''),
-- Raelorasz
(9253,0,0,'What is the cause of this conflict?',1,1,9283,0,0,0,0,''),
(9253,1,0,'Please, give me a new Augmented Arcane Prison.',1,1,0,0,0,0,0,''),
-- Sage Mistwalker (H)
(8908,0,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
(8908,1,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
-- Watcher Moonleaf (A)
(8918,0,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
(8918,1,0,'Please, give me a new Worg Disguise.',1,1,0,0,0,0,0,''),
-- Wildlord Anterarion
(22127,0,0,'Please, give me a new Felsworn Gas Mask.',1,1,0,0,0,0,0,''),
(22127,1,0,'Please, give me a new Felsworn Gas Mask.',1,1,0,0,0,0,0,'');
-- +---------+
-- | SmartAI |
-- +---------+
DELETE FROM smart_scripts WHERE entryorguid IN (21772,21774,21769,21773,28518,26117,24186,24273,22127);
INSERT INTO smart_scripts VALUES
-- Spectrecles (H)
(21772,0,0,1,62,0,100,0,21772,0,0,0,11,37700,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Spectrecles to invoker'),
(21772,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Spectrecles (A)
(21774,0,0,1,62,0,100,0,21774,0,0,0,11,37700,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Spectrecles to invoker'),
(21774,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Kor´kron Flare Gun
(21769,0,0,1,62,0,100,0,21769,0,0,0,56,31108,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Kor´kron Flare Gun to invoker'),
(21769,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Wildhammer Flare Gun
(21773,0,0,1,62,0,100,0,21773,0,0,0,56,31310,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Wildhammer Flare Gun to invoker'),
(21773,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Ensorcelled Choker
(28518,0,0,1,62,0,100,0,9709,0,0,0,56,38699,1,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - add Ensorcelled Choker to invoker'),
(28518,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Augmented Arcane Prison
(26117,0,0,1,62,0,100,0,9253,1,0,0,11,46764,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Augmented Arcane Prison to invoker'),
(26117,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Worg Disguise (H)
(24186,0,0,1,62,0,100,0,8908,0,0,0,11,43379,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Worg Disguise to invoker'),
(24186,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Worg Disguise (A)
(24273,0,0,1,62,0,100,0,8918,0,0,0,11,43379,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Worg Disguise to invoker'),
(24273,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip'),
-- Felsworn Gas Mask
(22127,0,0,1,62,0,100,0,22127,0,0,0,11,39101,0x02,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - cast create Felsworn Gas Mask to invoker'),
(22127,0,1,0,61,0,100,0,0,0,0,0,72,0,0,0,0,0,0,7,0,0,0,0,0,0,0,'on gossip select - close gossip');
-- +----------+
-- |Conditions|
-- +----------+
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 15 AND SourceGroup IN (21772,21774,21769,21773,9709,9253,8918,8908,22127);
INSERT INTO conditions VALUES
-- Augmented Arcane Prison
(15,9253,1,0,8,11943,0,0,0,'','show gossip menu option if player has quest 11943 rewarded'),
-- Kor´kron Flare Gun
(15,21769,0,0,8,10750,0,0,0,'','show gossip menu option if player has quest 10750 rewarded'),
-- Spectrecles (Horde)
(15,21772,0,0,8,10625,0,0,0,'','show gossip menu option if player has quest 10625 rewarded'),
-- Spectrecles (Alliance)
(15,21774,0,0,8,10643,0,0,0,'','show gossip menu option if player has quest 10643 rewarded'),
-- Wildhammer Flare Gun
(15,21773,0,0,8,10772,0,0,0,'','show gossip menu option if player has quest 10772 rewarded'),
-- Ensorcelled Choker
(15,9709,0,0,9,12661,0,0,0,'','show gossip menu option if player has quest 12661'),
(15,9709,1,0,9,12669,0,0,0,'','show gossip menu option if player has quest 12669'),
(15,9709,2,0,9,12677,0,0,0,'','show gossip menu option if player has quest 12677'),
(15,9709,3,0,9,12676,0,0,0,'','show gossip menu option if player has quest 12676'),
(15,9709,4,0,9,12713,0,0,0,'','show gossip menu option if player has quest 12713'),
-- Worg Disguise (A)
(15,8918,0,0,28,11325,0,0,0,'','show gossip menu option if player has quest 11325'),
(15,8918,1,0,8,11325,0,0,0,'','show gossip menu option if player has quest 11325 rewarded'),
-- Worg Disguise (H)
(15,8908,0,0,28,11323,0,0,0,'','show gossip menu option if player has quest completed 11323'),   
(15,8908,1,0,8,11323,0,0,0,'','show gossip menu option if player has quest 11323 rewarded'),
-- Felsworn Gas Mask
(15,22127,0,0,28,10819,0,0,0,'','show gossip menu option if player has quest completed 10819'),
(15,22127,1,0,8,10819,0,0,0,'','show gossip menu option if player has quest 10819 rewarded');
DELETE FROM quest_template WHERE entry=10345;
INSERT INTO quest_template VALUES
(10345, 2, 3523, 0, 68, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 29473, 1, 0, "Fleisch geworden", "Seht Ihr diese Leichen, $r? Arconus ist fÃ¼r diese Massaker verantwortlich. Er hat sie ausgesaugt, sodass nur noch eine FleischhÃ¼lle Ã¼brig geblieben ist. Aber lasst Euch von den KÃ¶rpern nicht tÃ¤uschen! In diesen Leichen liegen Fleischbestien, die nur darauf warten, ahnungslose DummkÃ¶pfe, die sich zu nahe heranwagen, anzufallen.$B$BIch habe meine Befehle. Ich muss hierbleiben, bis meine VerstÃ¤rkung eintrifft. Das bedeutet aber nicht, dass Ihr nicht meinen AnzÃ¼nder nehmen und die siechenden Leichen, die Ã¼berall in den Minen herumliegen, zerstÃ¶ren kÃ¶nnt. So oder so muss diese Aufgabe erledigt werden. ", "Benutzt den AnzÃ¼nder des Protektorats um 12 siechende Leichen zu zerstÃ¶ren. Bringt den AnzÃ¼nder des Protektorats zu Agent Araxes auÃŸerhalb des Zugangsschachts Zeon zurÃ¼ck, wenn Ihr erfolgreich wart.", "Ihr habt meine Bandagen gerettet, $N. Dass Protektorat wird erfahren, was Ihr heute getan habt, Freund.", "Konntet Ihr Sechs-Uhr finden?", '', "Kehrt zu Agent Araxes auÃŸerhalb des Zugangsschachts Zeon in Netherstorm. zurÃ¼ck", "Siechende Leichen verbrannt", '', '', '', 0, 0, 0, 29473, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20561, 0, 0, 0, 12, 0, 0, 0, 35372, 0, 0, 0, 30352, 30341, 30342, 30519, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 933, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);

UPDATE creature SET spawntimesecs=180,unit_flags=132 WHERE id=20561;
UPDATE creature_template SET AIName="SmartAI", unit_flags=132,Faction_A=190, Faction_H=190 WHERE entry=20561;
DELETE FROM smart_scripts WHERE entryorguid=20561;
INSERT INTO smart_scripts VALUES
(20561, 0, 0, 0, 8, 0, 0, 0, 35372, 0, 0, 0, 37, 1000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On spell hit run script');

-- quest fix 10427
UPDATE quest_template SET ReqCreatureOrGOId2=20610,ReqSpellCast2=35771 WHERE entry=10427;
-- Fix quest 'Protecting Our Own' #10488 thy @ tigeria
DELETE FROM quest_template WHERE entry=10488;
INSERT INTO quest_template VALUES
(10488, 2, 3522, 0, 65, 0, 66, 0, 690, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 10487, 0, 0, 0, 5, 30175, 1, 0, "Die Eigenen schützen", "Ich habe aus dem magischen Staub, den Ihr gesammelt habt, eine Salbe hergestellt, die uns bei unserer Verteidigung helfen wird.$B$BAls wir hierher kamen, haben wir ein wundervolles Rudel Terrorwölfe mitgebracht. Sie sind die perfekte Kombination aus Reittier, Wachhund und Freund, aber der Abschaum der Allianz hat begonnen, sie im Zackengrat zu jagen.$B$B$N, ich möchte, dass Ihr diese Salbe nehmt und sie an unseren Terrorwolffreunden anwendet. Das wird der Allianz eine böse Überraschung bescheren, wenn sie das nächste Mal auf die Jagd geht.$B$BSeid Euch jedoch bewusst, dass einige der Wölfe das vielleicht nicht leiden mögen und Euch angreifen werden.", "Wendet Gor'dreks Salbe an 5 Terrorwölfen der Donnerfürsten an. ", "Nun, da Ihr die Wölfe und unsere Verteidigung gestärkt habt, können wir uns wieder einigen tödlicheren Angelegenheiten, wie zum Beispiel den Ogern, zuwenden.$B$BIhr habt uns hier gut geholfen. Wenn Ihr Euch entscheidet zu bleiben, könnten wir auch weiterhin die Dienste von jemandem, der so fähig ist wie Ihr, brauchen.$B$BWie auch immer Ihr Euch entscheiden mögt, Ihr habt meinen Respekt und meine Wertschätzung sicher. ", "Wie geht es mit der Verstärkung unserer Terrorwolfverteidigung voran? ", '', "Kehrt zu Gor'drek in der Donnerfeste auf dem Schergrat zurück.", "Terrorwolf der Donnerfürsten gestärkt ", '', '', '', 30175, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20748, 0, 0, 0, 5, 0, 0, 0, 32578, 0, 0, 0, 31481, 31482, 31483, 31484, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35000, 6900, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);
-- modify Dark Rune Protector melee damage
UPDATE `creature_template` SET `dmg_multiplier`=5 WHERE `entry`=27983;
UPDATE `creature_template` SET `dmg_multiplier`=10 WHERE `entry`=31876;

UPDATE `script_texts` SET `content_loc3`='Zeit für ein paar Antworten! Lasst uns loslegen!' WHERE `entry`=-1599024;
UPDATE `script_texts` SET `content_loc3`='Keine Sorge! Der alte Brann ist da! Kümmert Euch um das Metallmonster und ich schau\', ob ich der Maschine lieb zureden kann, Euch zu helfen!' WHERE `entry`=-1599025;
UPDATE `script_texts` SET `content_loc3`='Nehmt Euch einen Moment und genießt das mit mir. Bald wird alles offenbart. Alles klar, dann mal los!' WHERE `entry`=-1599029;
UPDATE `script_texts` SET `content_loc3`='Haltet jetzt die Augen offen! Ich werde die Sache hier im Handumdrehen...' WHERE `entry`=-1599030;
UPDATE `script_texts` SET `content_loc3`='Oh, das hört sich nicht gut an. Wir haben vielleicht ein Problem oder zwei...' WHERE `entry`=-1599032;
UPDATE `script_texts` SET `content_loc3`='Frage? Was glaubt Ihr wozu ich hier bin - Kaffee und Kuchen? Spuckt es endlich aus!' WHERE `entry`=-1599045;

-- add recovery option for quest #338 items
DELETE FROM `gossip_menu_option` WHERE `menu_id`=5483;
INSERT INTO `gossip_menu_option` (`menu_id`, `id`, `option_icon`, `option_text`, `option_id`, `npc_option_npcflag`, `action_menu_id`, `action_poi_id`, `action_script_id`, `box_coded`, `box_money`, `box_text`)
VALUES
(5483,0,0,'GOSSIP_OPTION_QUESTGIVER',2,2,0,0,0,0,0,''),
(5483,1,0,'Bitte gib mir ein neues Kapitel I.',1,1,0,0,548301,0,0,''),
(5483,2,0,'Bitte gib mir ein neues Kapitel II.',1,1,0,0,548302,0,0,''),
(5483,3,0,'Bitte gib mir ein neues Kapitel III.',1,1,0,0,548303,0,0,''),
(5483,4,0,'Bitte gib mir ein neues Kapitel IV.',1,1,0,0,548304,0,0,'');

DELETE FROM `gossip_scripts` WHERE `id` BETWEEN 548301 AND 548304;
INSERT INTO `gossip_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(548301,0,17,2756,1,0,0,0,0,0),
(548301,0,33,0,0,0,0,0,0,0),
(548302,0,17,2757,1,0,0,0,0,0),
(548302,0,33,0,0,0,0,0,0,0),
(548303,0,17,2758,1,0,0,0,0,0),
(548303,0,33,0,0,0,0,0,0,0),
(548304,0,17,2759,1,0,0,0,0,0),
(548304,0,33,0,0,0,0,0,0,0);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=5483;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
-- Chapter I
(15,5483,1,1,9,338,0,0,0,'',''),
(15,5483,1,1,8,339,0,0,0,'',''),
(15,5483,1,1,26,2756,1,0,0,'',''),
-- Chapter II
(15,5483,2,1,9,338,0,0,0,'',''),
(15,5483,2,1,8,340,0,0,0,'',''),
(15,5483,2,1,26,2757,1,0,0,'',''),
-- Chapter III
(15,5483,3,1,9,338,0,0,0,'',''),
(15,5483,3,1,8,341,0,0,0,'',''),
(15,5483,3,1,26,2758,1,0,0,'',''),
-- Chapter IV
(15,5483,4,1,9,338,0,0,0,'',''),
(15,5483,4,1,8,342,0,0,0,'',''),
(15,5483,4,1,26,2759,1,0,0,'','');

-- update Crystallized Life dropchance
UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance`=30 WHERE `item`=37704;

