
-- crater un'goro	Diemetradon

set @MPI = 14518;
set @CI = @MPI+1;

delete from pool_template where entry=@MPI;
insert into pool_template value(@MPI,1,"Mother pool, Elder Diemetradon, crater un'goror");

delete from pool_template where entry between @CI and @CI+29;
insert into pool_template value(@CI,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+1,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+2,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+3,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+4,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+5,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+6,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+7,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+8,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+9,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+10,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+11,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+12,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+13,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+14,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+15,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+16,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+17,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+18,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+19,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+20,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+21,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+22,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+23,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+24,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+25,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+26,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+27,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+28,1,"Group, Elder Diemetradon, crater un'goror");
insert into pool_template value(@CI+29,1,"Group, Elder Diemetradon, crater un'goror");


delete from pool_pool where pool_id between @CI and @CI+29;
insert into pool_pool values (@CI,@MPI,0,"group1: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+1,@MPI,0,"group2: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+2,@MPI,0,"group3: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+3,@MPI,0,"group4: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+4,@MPI,0,"group5: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+5,@MPI,0,"group6: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+6,@MPI,0,"group7: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+7,@MPI,0,"group8: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+8,@MPI,0,"group9: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+9,@MPI,0,"group10: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+10,@MPI,0,"group11: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+11,@MPI,0,"group12: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+12,@MPI,0,"group13: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+13,@MPI,0,"group14: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+14,@MPI,0,"group15: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+15,@MPI,0,"group16: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+16,@MPI,0,"group17: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+17,@MPI,0,"group18: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+18,@MPI,0,"group19: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+19,@MPI,0,"group20: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+20,@MPI,0,"group21: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+21,@MPI,0,"group22: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+22,@MPI,0,"group23: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+23,@MPI,0,"group24: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+24,@MPI,0,"group25: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+25,@MPI,0,"group26: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+26,@MPI,0,"group27: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+27,@MPI,0,"group28: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+28,@MPI,0,"group29: Elder Diemetradon, crater un'goror"); 
insert into pool_pool values (@CI+29,@MPI,0,"group30: Elder Diemetradon, crater un'goror"); 

-- group 1
delete from pool_creature where guid in (74437,105468);
insert into pool_creature values (74437,@CI,0,"Elder Diemetradon group 1");
insert into pool_creature values (105468,@CI,0,"Elder Diemetradon group 1");

-- group 2
delete from pool_creature where guid in (74438,113736);
insert into pool_creature values (74438,@CI+1,0,"Elder Diemetradon group 2");
insert into pool_creature values (113736,@CI+1,0,"Elder Diemetradon group 2");

-- group 3
delete from pool_creature where guid in (74432,113859);
insert into pool_creature values (74432,@CI+2,0,"Elder Diemetradon group 3");
insert into pool_creature values (113859,@CI+2,0,"Elder Diemetradon group 3");

-- group 4
delete from pool_creature where guid in (74398,105813);
insert into pool_creature values (74398,@CI+3,0,"Elder Diemetradon group 4");
insert into pool_creature values (105813,@CI+3,0,"Elder Diemetradon group 4");

-- group 5
delete from pool_creature where guid in (74414,105540);
insert into pool_creature values (74414,@CI+4,0,"Elder Diemetradon group 5");
insert into pool_creature values (105540,@CI+4,0,"Elder Diemetradon group 5");

-- group 6
delete from pool_creature where guid in (74418,113863);
insert into pool_creature values (74418,@CI+5,0,"Elder Diemetradon group 6");
insert into pool_creature values (113863,@CI+5,0,"Elder Diemetradon group 6");

-- group 7
delete from pool_creature where guid in (74404,105402);
insert into pool_creature values (74404,@CI+6,0,"Elder Diemetradon group 7");
insert into pool_creature values (105402,@CI+6,0,"Elder Diemetradon group 7");

-- group 8
delete from pool_creature where guid in (74401,105675);
insert into pool_creature values (74401,@CI+7,0,"Elder Diemetradon group 8");
insert into pool_creature values (105675,@CI+7,0,"Elder Diemetradon group 8");

-- group 9
delete from pool_creature where guid in (74419,105691);
insert into pool_creature values (74419,@CI+8,0,"Elder Diemetradon group 9");
insert into pool_creature values (105691,@CI+8,0,"Elder Diemetradon group 9");

-- group 10
delete from pool_creature where guid in (74420,105982);
insert into pool_creature values (74420,@CI+9,0,"Elder Diemetradon group 10");
insert into pool_creature values (105982,@CI+9,0,"Elder Diemetradon group 10");

-- group 11
delete from pool_creature where guid in (74428,105361);
insert into pool_creature values (74428,@CI+10,0,"Elder Diemetradon group 11");
insert into pool_creature values (105361,@CI+10,0,"Elder Diemetradon group 11");

-- group 12
delete from pool_creature where guid in (74427,113887);
insert into pool_creature values (74427,@CI+11,0,"Elder Diemetradon group 12");
insert into pool_creature values (113887,@CI+11,0,"Elder Diemetradon group 12");

-- group 13
delete from pool_creature where guid in (74409,113536);
insert into pool_creature values (74409,@CI+12,0,"Elder Diemetradon group 13");
insert into pool_creature values (113536,@CI+12,0,"Elder Diemetradon group 13");

-- group 14
delete from pool_creature where guid in (74407,105488);
insert into pool_creature values (74407,@CI+13,0,"Elder Diemetradon group 14");
insert into pool_creature values (105488,@CI+13,0,"Elder Diemetradon group 14");

-- group 15
delete from pool_creature where guid in (113790,113768,113777);
insert into pool_creature values (113790,@CI+14,0,"Elder Diemetradon group 15");
insert into pool_creature values (113768,@CI+14,0,"Elder Diemetradon group 15");
insert into pool_creature values (113777,@CI+14,0,"Elder Diemetradon group 15");

-- group 16
delete from pool_creature where guid in (105516,113574);
insert into pool_creature values (105516,@CI+15,0,"Elder Diemetradon group 16");
insert into pool_creature values (113574,@CI+15,0,"Elder Diemetradon group 16");

-- group 17
delete from pool_creature where guid in (105593,74345);
insert into pool_creature values (105593,@CI+16,0,"Elder Diemetradon group 17");
insert into pool_creature values (74345,@CI+16,0,"Elder Diemetradon group 17");

-- group 18
delete from pool_creature where guid in (105928,74385,105866);
insert into pool_creature values (105928,@CI+17,0,"Elder Diemetradon group 18");
insert into pool_creature values (74385,@CI+17,0,"Elder Diemetradon group 18");
insert into pool_creature values (105866,@CI+17,0,"Elder Diemetradon group 18");

-- group 19
delete from pool_creature where guid in (113617,74391);
insert into pool_creature values (113617,@CI+18,0,"Elder Diemetradon group 19");
insert into pool_creature values (74391,@CI+18,0,"Elder Diemetradon group 19");

-- group 20
delete from pool_creature where guid in (105918,105828);
insert into pool_creature values (105918,@CI+19,0,"Elder Diemetradon group 20");
insert into pool_creature values (105828,@CI+19,0,"Elder Diemetradon group 20");

-- group 21
delete from pool_creature where guid in (105761,105497);
insert into pool_creature values (105761,@CI+20,0,"Elder Diemetradon group 21");
insert into pool_creature values (105497,@CI+20,0,"Elder Diemetradon group 21");

-- group 22
delete from pool_creature where guid in (105736,105782);
insert into pool_creature values (105736,@CI+21,0,"Elder Diemetradon group 22");
insert into pool_creature values (105782,@CI+21,0,"Elder Diemetradon group 22");

-- group 23
delete from pool_creature where guid in (105669,74387);
insert into pool_creature values (105669,@CI+22,0,"Elder Diemetradon group 23");
insert into pool_creature values (74387,@CI+22,0,"Elder Diemetradon group 23");

-- group 24
delete from pool_creature where guid in (74384,105789);
insert into pool_creature values (74384,@CI+23,0,"Elder Diemetradon group 24");
insert into pool_creature values (105789,@CI+23,0,"Elder Diemetradon group 24");

-- group 25
delete from pool_creature where guid in (106030,74389);
insert into pool_creature values (106030,@CI+24,0,"Elder Diemetradon group 25");
insert into pool_creature values (74389,@CI+24,0,"Elder Diemetradon group 25");

-- group 26
delete from pool_creature where guid in (105789,74384);
insert into pool_creature values (105789,@CI+25,0,"Elder Diemetradon group 26");
insert into pool_creature values (74384,@CI+25,0,"Elder Diemetradon group 26");

-- group 27
delete from pool_creature where guid in (113714,74352);
insert into pool_creature values (113714,@CI+26,0,"Elder Diemetradon group 27");
insert into pool_creature values (74352,@CI+26,0,"Elder Diemetradon group 27");

-- group 28
delete from pool_creature where guid in (105638,74353);
insert into pool_creature values (105638,@CI+27,0,"Elder Diemetradon group 28");
insert into pool_creature values (74353,@CI+27,0,"Elder Diemetradon group 28");

-- group 29
delete from pool_creature where guid in (113858,74435);
insert into pool_creature values (113858,@CI+28,0,"Elder Diemetradon group 29");
insert into pool_creature values (74435,@CI+28,0,"Elder Diemetradon group 29");

-- group 30
delete from pool_creature where guid in (105879,113696);
insert into pool_creature values (105879,@CI+29,0,"Elder Diemetradon group 30");
insert into pool_creature values (113696,@CI+29,0,"Elder Diemetradon group 30");






