
--
-- quest 28159 The Doomstone
--
update creature_template set minlevel=93,maxlevel=93,faction_A=7,faction_H=7,rank=1 where entry=47745;
update creature_template_addon set auras="" where entry=47745; -- he has aura 88877 and is invisible: See Quest Invis 23, Unlimited range, Instant
update creature_template set minlevel=47,maxlevel=47,faction_A=7,faction_H=7,rank=1 where entry=47941;



