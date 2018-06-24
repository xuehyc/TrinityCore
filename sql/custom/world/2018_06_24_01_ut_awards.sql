DELETE FROM trinity_string WHERE entry BETWEEN 20100 AND 20119;
INSERT INTO trinity_string (entry, content_default, content_loc1, content_loc2, content_loc3, content_loc4, content_loc5, content_loc6, content_loc7, content_loc8) VALUES
(20100, 'Double kill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Двойное убийство!'),
(20101, 'Triple kill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Тройное убийство!'),
(20102, 'Multi kill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Мульти убийство!'),
(20103, 'Mega kill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Мега убийство!'),
(20104, 'Ultra kill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ультра убийство!'),
(20105, 'Monster kill!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Зверское убийство!'),
(20106, 'Holy Shit!!!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Срань господня!!!'),

(20110, '(%s) First blood!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Первая кровь!'),
(20111, '(%s) Killing spree!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Произвёл серию убийств!'),

(20112, '(%s) Dominating!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Доминирование!'),
(20113, '(%s) Rampage!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Впал в ярость!'),
(20114, '(%s) Unstoppable!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Неудержимый!'),
(20115, '(%s) Godlike!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Божественный!'),
(20116, '(%s) Beyond godlike!!!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Превзошёл богов!!!'),

(20119, '(%s) Interrupted a series of kills (%s)!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '(%s) Прервал серию убийств (%s)!');
