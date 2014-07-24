
-- crater un'goro

-- wrong auras
update creature_template_addon set auras="" where entry=38238;
update creature_template_addon set auras="" where entry=38239;
update creature_template_addon set auras="71442" where entry=38240;

-- missing KillCredit
update creature_template set KillCredit1=38708 where entry=38346;

-- wrong faction
update creature_template set faction_A=14,faction_H=14 where entry in (6501,6502);
update creature_template set faction_A=634,faction_H=634 where entry in (38346,38708);

