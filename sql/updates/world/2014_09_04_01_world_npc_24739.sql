
-- http://www.wowhead.com/npc=24739	Benjari Edune

-- missing creature_text

delete from creature_text where entry=24739 and id=0 and groupid between 1 and 10;
insert into creature_text value
(24739,1,0,"... and have I told you about the time when I ventured deep into the heart of Blackrock Mountain?",12,0,100,0,0,0,"tell's history",23739),
(24739,2,0,"That was when I slew the Orc with a great slash and took away these spaulders.",12,0,100,0,0,0,"tell's history",23740),
(24739,3,0,"I found a mighty axe there, freshly forged upon the fire.",12,0,100,0,0,0,"tell's history",23741),
(24739,4,0,"There, I crafted this breastplate with my own hands, toiling for hours upon the forge.",12,0,100,0,0,0,"tell's history",23742),
(24739,5,0,"There, deep within the pockets of a Troll was the beautiful gem, which I sold for a handsome price!",12,0,100,0,0,0,"tell's history",23743),
(24739,6,0,"..with a mighty blow, I slew a Murloc, freeing the orb from his cold, slimy hands!",12,0,100,0,0,0,"tell's history",23744),
(24739,7,0,"... not to forget that time I ventured deep within the forests of Zul'Aman.",12,0,100,0,0,0,"tell's history",23745),
(24739,8,0,"... the burning sands of Silithus scorched my face as we battled wave after wave of Silithid.",12,0,100,0,0,0,"tell's history",23746),
(24739,9,0,"... the city was burned, a scorched ruin of what it once was. The armies of the undead rose where the people had once lived.",12,0,100,0,0,0,"tell's history",23747),
(24739,10,0,"... did I tell you about the time that I explored the far reaches of Dire Maul?",12,0,100,0,0,0,"tell's history",23748);

update creature_template set AIName="", ScriptName="npc_benjari_edune" where entry=24739;


