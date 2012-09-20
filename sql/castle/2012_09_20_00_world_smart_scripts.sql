-- make turkey marker self cast so it will stack with every cast
UPDATE smart_scripts SET action_type = 85, action_param2 = 0, target_type = 1 WHERE action_type IN (11, 85) AND action_param1 = 25281;