
SET @quest_murder=26209; -- 		http://www.wowhead.com/quest=26209 	Murder Was The Case That They Gave Me
SET @npc_investigator1=42559; --   	http://www.wowhead.com/npc=42559	Stormwind Investigator
SET @npc_investigator2=42309; --   	http://www.wowhead.com/npc=42309	Stormwind Investigator
SET @npc_horatio=42308; --   		http://www.wowhead.com/npc=42308	Lieutenant Horatio Laine
SET @npc_bot=42311; --				http://www.wowhead.com/npc=42311	Crime Scene Alarm-o-Bot
SET @npc_drifters=42391; --			http://www.wowhead.com/npc=42391	West Plains Drifter
SET @npc_citizen=42386; --			http://www.wowhead.com/npc=42386	Homeless Stormwind Citizen
SET @npc_transient=42383; --		http://www.wowhead.com/npc=42383	Transient
SET @npc_ragamuffin=42413; --		http://www.wowhead.com/npc=42413	Ragamuffin

-- creature_text for entry 42413
delete from creature_text where entry=@npc_ragamuffin and groupid=0 and id between 0 and 4;
insert into creature_text values (@npc_ragamuffin,0,0,"Check her pockets!",12,0,100,0,0,0,"Ragamuffin text",0);
insert into creature_text values (@npc_ragamuffin,0,1,"Check his pockets!",12,0,100,0,0,0,"Ragamuffin text",0);
insert into creature_text values (@npc_ragamuffin,0,2,"Does he have boots? Get 'em!",12,0,100,0,0,0,"Ragamuffin text",0);
insert into creature_text values (@npc_ragamuffin,0,3,"Does she have boots? Get 'em!",12,0,100,0,0,0,"Ragamuffin text",0);
insert into creature_text values (@npc_ragamuffin,0,4,"MINE!",12,0,100,0,0,0,"Ragamuffin text",0);

-- creature_text for entry 42383
delete from creature_text where entry=@npc_transient and groupid between 1 and 4 and id=0;
insert into creature_text values (@npc_transient,1,0,"Between you, me, and the tree, murlocs killed the Furlbrows. Yep, saw 'em with my own two eyes. Think they'd been casin' the joint for days, maybe months. They left in a hurry once they got wind of \"Johnny Law\" and the idiot brigade over there...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,2,0,"Who killed the Furlbrows? I'll tell you who killed the Furlbrows: KING VARIAN WRYNN, THAT'S WHO! And he's killin' the rest of us too. One bum at a time. The only thing I can tell you is that I saw some gnolls leavin' the place a few hours before the law arrived.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,3,0,"I didn't see who killed 'em, $Gbub:lady;, but I got a whiff. Smelled rich, kinda like you. Damn shame too. Furlbrows were a fixture around here. Nice people, always willin' to share a meal or a patch of dirt.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,4,0,"Listen, $Gpal:lady;, I don't want any trouble, ok? I didn't see who murdered 'em, but I sure heard it! Lot of yelling. Human voices... you dig? Now get out of here before I change my mind about beating you up and takin' your shoes.",12,0,100,0,0,0,"",0);

delete from creature_text where entry=@npc_transient and groupid=0 and id between 0 and 30;
insert into creature_text values (@npc_transient,0,0,"Get off my land!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,1,"HAHAHAH! Good one, Mr. Penguin! GOOD ONE!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,2,"HEY! HEY YOU! GET OFF MY PROPERTY!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,3,"I ain't tellin' you a damn thing!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,4,"I don't think I'm gonna make it...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,5,"I miss being robbed by the Defias. At least they'd leave you a little something to eat from time to time.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,6,"I TOLD YOU TO PAY UP, PAL!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,7,"I wonder if it's possible to eat rocks? Got plenty of rocks around here. Just imagine it! I'd be the richest person in the world for making that discovery!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,8,"I'd know that smell anywhere! Salma's famous stew!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,9,"I'm starving!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,10,"JACKPOT!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,11,"Judgment day comes! The brotherhood will be reborn!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,12,"Let's get out of here before they try and pin this on us.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,13,"Livin' like an animal is hard enough without your insults!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,14,"Looks like I found us a savory and clean piece of dirt! Tonight we eat like kings, Mr. Penguin! Of course I'll share it with you! You're my best friend!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,15,"Looks like we'll be eating shoe leather for dinner again.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,16,"Maybe I can sell your liver for some gold.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,17,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,18,"The only thing I'll tell you is to get the hell out of here!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,19,"They died of natural causes...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,20,"We're hungry and cold! Help us!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,21,"Westfall stew? I'll never forget this moment!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,22,"What happened to me? I used to be the king of Stormwind!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,23,"What right do you have keeping us out?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,24,"What the hell happened here?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,25,"What's happened to us? We're in worse shape now than when the Defias ran amok!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,26,"You can't buy me! DIE!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,27,"You got no business here, lout! Beat it!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,28,"You rich punks are all the same!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,29,"You want my foot in your front or in your rear? Make the call.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_transient,0,30,"You'll get nothing out of me!",12,0,100,0,0,0,"",0);

-- creature_text for entry 42386
delete from creature_text where entry=@npc_citizen and groupid between 1 and 4 and id=0;
insert into creature_text values (@npc_citizen,1,0,"Between you, me, and the tree, murlocs killed the Furlbrows. Yep, saw 'em with my own two eyes. Think they'd been casin' the joint for days, maybe months. They left in a hurry once they got wind of \"Johnny Law\" and the idiot brigade over there...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,2,0,"Who killed the Furlbrows? I'll tell you who killed the Furlbrows: KING VARIAN WRYNN, THAT'S WHO! And he's killin' the rest of us too. One bum at a time. The only thing I can tell you is that I saw some gnolls leavin' the place a few hours before the law arrived.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,3,0,"I didn't see who killed 'em, $Gbub:lady;, but I got a whiff. Smelled rich, kinda like you. Damn shame too. Furlbrows were a fixture around here. Nice people, always willin' to share a meal or a patch of dirt.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,4,0,"Listen, $Gpal:lady;, I don't want any trouble, ok? I didn't see who murdered 'em, but I sure heard it! Lot of yelling. Human voices... you dig? Now get out of here before I change my mind about beating you up and takin' your shoes.",12,0,100,0,0,0,"",0);

delete from creature_text where entry=@npc_citizen and groupid=0 and id between 0 and 36;
insert into creature_text values (@npc_citizen,0,0,"Bless you, friend.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,1,"Down with the king!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,2,"Get off my land!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,3,"HAHAHAH! Good one, Mr. Penguin! GOOD ONE!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,4,"HEY! HEY YOU! GET OFF MY PROPERTY!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,5,"I ain't tellin' you a damn thing!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,6,"I don't think I'm gonna make it...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,7,"I miss being robbed by the Defias. At least they'd leave you a little something to eat from time to time.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,8,"I TOLD YOU TO PAY UP, PAL!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,9,"I wonder if it's possible to eat rocks? Got plenty of rocks around here. Just imagine it! I'd be the richest person in the world for making that discovery!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,10,"I'd know that smell anywhere! Salma's famous stew!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,11,"I'm starving!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,12,"I... I didn't see nothin'! He... he died of natural causes.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,13,"Is this equality and justice for all?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,14,"JACKPOT!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,15,"Judgment day comes! The brotherhood will be reborn!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,16,"Let us in!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,17,"Livin' like an animal is hard enough without your insults!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,18,"Looks like I found us a savory and clean piece of dirt! Tonight we eat like kings, Mr. Penguin! Of course I'll share it with you! You're my best friend!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,19,"Looks like we'll be eating shoe leather for dinner again.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,20,"Maybe I can sell your liver for some gold.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,21,"Maybe... maybe life is worth living.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,22,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,23,"Perhaps one day I will repay you for this kind act.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,24,"Thank you, kind and gentle stranger.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,25,"The only thing I'll tell you is to get the hell out of here!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,26,"They died of natural causes...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,27,"We're hungry and cold! Help us!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,28,"Westfall stew? I'll never forget this moment!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,29,"What do you expect us to do?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,30,"What happened to me? I used to be the king of Stormwind!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,31,"What right do you have keeping us out?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,32,"You can't buy me! DIE!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,33,"You got no business here, lout! Beat it!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,34,"You rich punks are all the same!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,35,"You want my foot in your front or in your rear? Make the call.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_citizen,0,36,"You'll get nothing out of me!",12,0,100,0,0,0,"",0);

-- creature_text for entry 42391
delete from creature_text where entry=@npc_drifters and groupid between 1 and 4 and id=0;
insert into creature_text values (@npc_drifters,1,0,"Between you, me, and the tree, murlocs killed the Furlbrows. Yep, saw 'em with my own two eyes. Think they'd been casin' the joint for days, maybe months. They left in a hurry once they got wind of \"Johnny Law\" and the idiot brigade over there...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,2,0,"Who killed the Furlbrows? I'll tell you who killed the Furlbrows: KING VARIAN WRYNN, THAT'S WHO! And he's killin' the rest of us too. One bum at a time. The only thing I can tell you is that I saw some gnolls leavin' the place a few hours before the law arrived.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,3,0,"I didn't see who killed 'em, $Gbub:lady;, but I got a whiff. Smelled rich, kinda like you. Damn shame too. Furlbrows were a fixture around here. Nice people, always willin' to share a meal or a patch of dirt.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,4,0,"Listen, $Gpal:lady;, I don't want any trouble, ok? I didn't see who murdered 'em, but I sure heard it! Lot of yelling. Human voices... you dig? Now get out of here before I change my mind about beating you up and takin' your shoes.",12,0,100,0,0,0,"",0);

delete from creature_text where entry=@npc_drifters and groupid=0 and id between 0 and 34;
insert into creature_text values (@npc_drifters,0,0,"Bless you, friend.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,1,"Down with the king!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,2,"Get off my land!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,3,"Good call.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,4,"HAHAHAH! Good one, Mr. Penguin! GOOD ONE!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,5,"HEY! HEY YOU! GET OFF MY PROPERTY!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,6,"I ain't tellin' you a damn thing!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,7,"I don't think I'm gonna make it...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,8,"I miss being robbed by the Defias. At least they'd leave you a little something to eat from time to time.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,9,"I TOLD YOU TO PAY UP, PAL!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,10,"I wonder if it's possible to eat rocks? Got plenty of rocks around here. Just imagine it! I'd be the richest person in the world for making that discovery!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,11,"I'm starving!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,12,"Is this equality and justice for all?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,13,"JACKPOT!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,14,"Judgment day comes! The brotherhood will be reborn!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,15,"Let us in!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,16,"Livin' like an animal is hard enough without your insults!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,17,"Looks like I found us a savory and clean piece of dirt! Tonight we eat like kings, Mr. Penguin! Of course I'll share it with you! You're my best friend!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,18,"Looks like the Furlbrow's were murdered...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,19,"Looks like we'll be eating shoe leather for dinner again.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,20,"Maybe I can sell your liver for some gold.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,21,"Maybe... maybe life is worth living.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,22,"Now you've gone and done it! TIME FOR THE FIST!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,23,"Thank you, kind and gentle stranger.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,24,"The only thing I'll tell you is to get the hell out of here!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,25,"They died of natural causes...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,26,"We're hungry and cold! Help us!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,27,"What happened to me? I used to be the king of Stormwind!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,28,"What right do you have keeping us out?",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,29,"Yep. That King Varian is good for nothin'.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,30,"You can't buy me! DIE!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,31,"You got no business here, lout! Beat it!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,32,"You rich punks are all the same!",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,33,"You want my foot in your front or in your rear? Make the call.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_drifters,0,34,"You'll get nothing out of me!",12,0,100,0,0,0,"",0);

-- creature_text for entry 42309
delete from creature_text where entry=@npc_investigator2 and groupid between 3 and 5 and id=0;
insert into creature_text values (@npc_investigator2,3,0,"Damn shame what they did to Old Blanchy...",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_investigator2,4,0,"Given the body temperature, I'd say they've been dead no more than 6 hours.",12,0,100,0,0,0,"",0);
insert into creature_text values (@npc_investigator2,5,0,"It's a bloodbath, lieutenant. They've been murdered.",12,0,100,0,0,0,"",0);

-- creature_text for entry 42559
delete from creature_text where entry=@npc_investigator1 and groupid = 2 and id=0;
insert into creature_text values (@npc_investigator1,2,0,"Natural causes? Two bullets in the chest and his shoes are on his head. What kind of natural death would that be?",12,0,100,0,0,0,"",0);


