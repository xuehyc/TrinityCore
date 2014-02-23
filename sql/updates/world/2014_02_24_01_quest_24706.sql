
-- quest 24706 crater un'goro

update creature_template set AIName="",ScriptName="npc_maximillian_of_northshire" where entry=38237;
update creature_template set minlevel=60,maxlevel=60,mindmg=175.2,maxdmg=230.4,attackpower=286,baseattacktime=2000,rangeattacktime=2000,unit_class=2,unit_flags=32768,minrangedmg=121.2,maxrangedmg=200.4,rangedattackpower=36,AIName="",ScriptName="npc_maximillian_of_northshire_2" where entry=38255;
update creature_template set AIName="",ScriptName="npc_steaming_fury" where entry=38254;

update creature_template_addon set auras="" where entry in (38237,38373);

-- creature_text for entry 38255
delete from creature_text where entry=38255 and groupid between 0 and 48 and id=0;
insert into creature_text values (38255,0,0,"A DRAGON!",14,0,100,0,0,0,"");
insert into creature_text values (38255,1,0,"Be flung! To safety!",14,0,100,0,0,0,"");
insert into creature_text values (38255,2,0,"DRAGON!",14,0,100,0,0,0,"");
insert into creature_text values (38255,3,0,"Dragon! Hear me out! I am Maximillian of Northshire, and I have come to deliver you. Your blood shall fill...",14,0,100,0,0,0,"");
insert into creature_text values (38255,4,0,"DRAGON, I SHALL RUN YOU THROUGH!",14,0,100,0,0,0,"");
insert into creature_text values (38255,5,0,"FOR DOLORIA!",14,0,100,0,0,0,"");
insert into creature_text values (38255,6,0,"For Doloria!",14,0,100,0,0,0,"");
insert into creature_text values (38255,7,0,"Great Uther's ghost, it's chasing after us! Squire, do something! Throw rocks at it! I have no plan!",14,0,100,0,0,0,"");
insert into creature_text values (38255,8,0,"Now, cry not, as you fall not to your death, but into the waiting arms of my squire! Off you go now!",14,0,100,0,0,0,"");
insert into creature_text values (38255,9,0,"Before I take my leave, you must be told that it is not by my fault that you lay stretched on the ground, but by the fault of my squire.",12,0,100,0,0,0,"");
insert into creature_text values (38255,10,0,"Curiously the bird does not become flame and ash. A phoenix that does not become flame and ash 'pon its slaying is a dire omen indeed.",12,0,100,0,0,0,"");
insert into creature_text values (38255,11,0,"Finally, I entreat you to stop buffeting my squire with punches and kicks.",12,0,100,0,0,0,"");
insert into creature_text values (38255,12,0,"Finally, I humbly request that you cease venting your hostility 'pon my good squire.",12,0,100,0,0,0,"");
insert into creature_text values (38255,13,0,"Finally, please find it in your heart to forgive my squire, for I see that you are smiting him.",12,0,100,0,0,0,"");
insert into creature_text values (38255,14,0,"Hup!",12,0,100,0,0,0,"");
insert into creature_text values (38255,15,0,"I accept your blessing.",12,0,100,0,0,0,"");
insert into creature_text values (38255,16,0,"I also ask you to shine your glorious light upon the immaculate face of my lady Doloria.",12,0,100,0,0,0,"");
insert into creature_text values (38255,17,0,"I also ask you to sprinkle wildflowers around the feet of my beautiful Doloria, where'er she may walk.",12,0,100,0,0,0,"");
insert into creature_text values (38255,18,0,"I fear I must now depart you and your ex-phoenix. Light be with you!",12,0,100,0,0,0,"");
insert into creature_text values (38255,19,0,"I request that you summon birds to sing pleasant meadow-tunes into my Doloria's ears, while she sleeps.",12,0,100,0,0,0,"");
insert into creature_text values (38255,20,0,"I see the dragon up ahead. She is larger than I had first anticipated.",12,0,100,0,0,0,"");
insert into creature_text values (38255,21,0,"It appears that adventure has made itself apparent. Look, for as yonder maiden treads innocently through the jungle, a hatchling phoenix stalks her as its prey!",12,0,100,0,0,0,"");
insert into creature_text values (38255,22,0,"Let us re-convene by my camp, as friends and fellow heroes, to discuss our final and most dangerous quest. Hup Hup, Pimento!",12,0,100,0,0,0,"");
insert into creature_text values (38255,23,0,"Light, give us the courage we need to enter battle with Un'Goro's corrupted dragons.",12,0,100,0,0,0,"");
insert into creature_text values (38255,24,0,"Light, give us the strength we need to defeat the vile broodmother of Un'Goro.",12,0,100,0,0,0,"");
insert into creature_text values (38255,25,0,"Light, grant us the ability to bring Un'Goro's dragons to their demise.",12,0,100,0,0,0,"");
insert into creature_text values (38255,26,0,"Look squire, yon maiden has lost her purse to the sulfurous waters of the Golakka Hot Springs.",12,0,100,0,0,0,"");
insert into creature_text values (38255,27,0,"Luck is with us today! A damsel appears before us, stuck in a crag, without hope of escape! Let us go save her!",12,0,100,0,0,0,"");
insert into creature_text values (38255,28,0,"Maiden! Fear not, for Maximillian of Northshire has arrived to deliver you from your rocky tomb!",12,0,100,0,0,0,"");
insert into creature_text values (38255,29,0,"Maiden! Fear not, I seek only to steady the quiver in thine lower lip. Is that your purse that floats 'pon the water, so agonizingly close yet so perilously far away?",12,0,100,0,0,0,"");
insert into creature_text values (38255,30,0,"Maiden: if your curiosity gnaws at you, then you may know your salvation was delivered by Maximillian of Northshire.",12,0,100,0,0,0,"");
insert into creature_text values (38255,31,0,"My squire will retrieve your purse for you.",12,0,100,0,0,0,"");
insert into creature_text values (38255,32,0,"Nevertheless, you are now freed from the mountains' grip and safe from harm. Marshal's Stand lies to the east, I believe.",12,0,100,0,0,0,"");
insert into creature_text values (38255,33,0,"Perhaps you should try hurling them at the nearby dragons to practice your throwing arm.",12,0,100,0,0,0,"");
insert into creature_text values (38255,34,0,"Squire! I understand you are newly trained, but must I tell you not to kill the spirits of the Light?",12,0,100,0,0,0,"");
insert into creature_text values (38255,35,0,"Squire! Please stand next to me as I request the blessing of this Light-blessed spirit.",12,0,100,0,0,0,"");
insert into creature_text values (38255,36,0,"Watch as the accursed bird becomes flame and ash as soon as it is slayed.",12,0,100,0,0,0,"");
insert into creature_text values (38255,37,0,"We sally forth in search of the dragons' despicable broodmother. Follow me, squire!",12,0,100,0,0,0,"");
insert into creature_text values (38255,38,0,"What luck! Pimento's hooves have kicked up some stones that we may use against the mighty dragons. Oh glorious day!",12,0,100,0,0,0,"");
insert into creature_text values (38255,39,0,"You should try using my stallion's stomp ability. Her powerful hooves will cleave the ground itself, stunning any nearby dragons.",12,0,100,0,0,0,"");
insert into creature_text values (38255,40,0,"You're not a what? Not available? Worry not, for my heart belongs only to the lady Doloria, though one as fair as you must command the hearts of many.",12,0,100,0,0,0,"");
insert into creature_text values (38255,41,0,"Your health is faltering. Allow me to help.",12,0,100,0,0,0,"");
insert into creature_text values (38255,42,0,"Eat my other shoulder-plate, vile lizard!",15,0,100,0,0,0,"");
insert into creature_text values (38255,43,0,"I have managed to remove my gloves. You may lob them at our foe.",15,0,100,0,0,0,"");
insert into creature_text values (38255,44,0,"If you can heft my breastplate, then throw it! Throw it for Doloria!",15,0,100,0,0,0,"");
insert into creature_text values (38255,45,0,"That shield-toss worked remarkably well. Quickly, hurl my holy shoulder-plate!",15,0,100,0,0,0,"");
insert into creature_text values (38255,46,0,"The ironclad heel of my armored boot should prove to be quite destructive.",15,0,100,0,0,0,"");
insert into creature_text values (38255,47,0,"This is quickly becoming humiliating... and drafty. Hopefully my legplates shall deal the deathblow.",15,0,100,0,0,0,"");
insert into creature_text values (38255,48,0,"Wait, I have an idea! Here, throw my Light-blessed shield at the beast!",15,0,100,0,0,0,"");

 






