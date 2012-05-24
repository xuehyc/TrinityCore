-- make sure all titanium siegebreakers / thunderers are attackable in halls of lightning
UPDATE creature_ai_scripts SET action1_param1 = 14, action2_param1 = 0 WHERE id = 2896503; -- thunderer faction
UPDATE creature_ai_scripts SET action1_param1 = 14, action2_param1 = 0 WHERE id = 2896103; -- siegebreaker faction