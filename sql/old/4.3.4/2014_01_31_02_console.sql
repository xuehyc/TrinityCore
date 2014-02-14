
-- console errors during game

-- duplicate auras in creature and template
update creature_addon set auras="" where guid in (78040,78752);

-- duplicate auras during spell use 
update creature_template_addon set auras="" where entry in (32969);