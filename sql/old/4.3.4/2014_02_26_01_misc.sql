

-- zero values for npc
update creature_template set minlevel=60,maxlevel=60,mindmg=175.2,maxdmg=230.4,attackpower=286,baseattacktime=2000,rangeattacktime=2000,unit_class=2,unit_flags=32768,minrangedmg=121.2,maxrangedmg=200.4,rangedattackpower=36,AIName="",ScriptName="npc_maximillian_of_northshire_2" where entry=38343;
update creature_template set minlevel=60,maxlevel=60,mindmg=175.2,maxdmg=230.4,attackpower=286,baseattacktime=2000,rangeattacktime=2000,unit_class=2,unit_flags=32768,minrangedmg=121.2,maxrangedmg=200.4,rangedattackpower=36,AIName="",ScriptName="npc_maximillian_of_northshire_2" where entry=38666;

UPDATE quest_template SET RequiredSourceItemId1=50288,RequiredSourceItemId4=0,RequiredItemId1=50288,RequiredItemCount1=1 WHERE Id=24705;

-- correct quest chain
UPDATE quest_template SET PrevQuestId=24703,ExclusiveGroup=-24704 WHERE Id in (24704,24705);
UPDATE quest_template SET PrevQuestId=24704 WHERE Id in (24706,24707);

UPDATE quest_template SET Flags=536870922,SpecialFlags=0 WHERE Id=24703;