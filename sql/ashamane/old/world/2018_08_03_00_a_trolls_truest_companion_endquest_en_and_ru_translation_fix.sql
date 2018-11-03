DELETE FROM `quest_offer_reward` WHERE `ID`=24622;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES (24622, 3, 0, 0, 0, 0, 0, 0, 0, 'Nice ta see new faces \'round here, mon. It\'s easy ta get ta feelin\' isolated since we left Orgrimmar.', 26365);
DELETE FROM `quest_offer_reward_locale` WHERE `ID`=24622;
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES (24622, 'ruRU', 'Я всегда рада новым лицам. Мы тут будто в изоляции, с тех пор как ушли из Оргриммара.', 0);
