
-- http://www.wowhead.com/npc=8308		Alenndaar Lapidaar <Hunter Trainer>
-- http://www.wowhead.com/spell=45631	Cosmetic - Enslave Chains Self
-- has auras kneel and chain

update creature_template_addon set auras="65709 45631" where entry=8308;
