



-- Bloodmyst Isle

-- double spawns  17609 and 17610 Sunhawk Agent and Sunhawk Saboteur
delete from creature where guid in (175363,175360,175388,175381,175346,175372,175352,175376,175347,175355);
delete from creature where guid in (175350,175356,175389,175390);
delete from creature_addon where guid in (175363,175360,175388,175381,175346,175372,175352,175376,175347,175355);
delete from creature_addon where guid in (175350,175356,175389,175390);

-- quest 9740 Sun Gate
UPDATE quest_template SET RequiredNpcOrGo1=-182026,RequiredNpcOrGoCount1=1 WHERE Id=9740;

-- wrong queststarter 
delete from creature_queststarter where id=17468 and quest=9699;
delete from creature_queststarter where id=17434 and quest=9579;

-- ToDo
-- quest 9671 disabled, there is no mail send, so i give the item as resource
-- the quest is captured from core but no mail is send to player.. where in the core is this done??? 
UPDATE quest_template SET Method=2,SourceItemId=24132,SourceItemCount=1 WHERE Id=9671;

-- quest 9672
UPDATE quest_template SET RequiredItemId1=24132,RequiredItemCount1=1,Objectives="Read the Message",Details="Are you $N? I have an important message for you." WHERE Id=9672;

-- quest 9683 empty id1 
UPDATE quest_template SET RequiredNpcOrGo1=17715,RequiredNpcOrGo2=0,RequiredNpcOrGoCount1=1,RequiredNpcOrGoCount2=0 WHERE Id=9683;

-- npc 17715 is spawned from script.. not from db
delete from creature where guid=159680;

-- quest 13591  wrong queststarter
delete from creature_queststarter where id=32971 and quest=13591;

--  Ashenvale

-- double spawns npc 3733
delete from creature where guid in (98338,71206,98325,98322,98337,80443,80509,70931,70642,98336);
delete from creature where guid in (70709,98331,72471,71391);
delete from creature_addon where guid in (98338,71206,98325,98322,98337,80443,80509,70931,70642,98336);
delete from creature_addon where guid in (70709,98331,72471,71391);
-- double spawns npc 3734
delete from creature where guid in (98344,98343,98342,98340,98339);
delete from creature_addon where guid in (98344,98343,98342,98340,98339);

-- quest 13595 autocomplete
UPDATE quest_template SET Method=2,RequiredSourceItemId1=44967,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13595;

-- double spawns npc 3713 3717
delete from creature where guid in (71431,80692,80283,72009,71328);
delete from creature where guid in (72585,98165,72004,98166,98112,98164);
delete from creature_addon where guid in (71431,80692,80283,72009,71328);
delete from creature_addon where guid in (72585,98165,72004,98166,98112,98164);

-- quest 13602 
update creature_template set KillCredit1=3717, KillCredit2=0 where entry=3713;
UPDATE quest_template SET RequiredNpcOrGo1=3713 WHERE Id=13602;

-- double spawns npc 11806
delete from creature where guid in (97785);

-- quest 13624 autocomplete
UPDATE quest_template SET Method=2 WHERE Id=13624;

-- quest 13642 autocomplete
UPDATE quest_template SET Method=2,RequiredSourceItemId1=45065,RequiredSourceItemId2=0,RequiredSourceItemCount1=1 WHERE Id=13642;

-- quest 13630 autocomplete
UPDATE quest_template SET Method=2,RequiredNpcOrGo1=-194309,RequiredNpcOrGo2=-194310,RequiredNpcOrGo3=-194311,RequiredNpcOrGoCount1=1,RequiredNpcOrGoCount2=1,RequiredNpcOrGoCount3=1 WHERE Id=13630;







