
-- crater un'goro   Tar Lord

set @MPI = 14585; 
set @CI = @MPI+1;

delete from pool_template where entry=@MPI;
insert into pool_template value(@MPI,1,"Mother pool, Tar Lord, crater un'goror");

delete from pool_template where entry between @CI and @CI+32;
insert into pool_template value(@CI,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+1,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+2,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+3,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+4,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+5,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+6,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+7,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+8,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+9,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+10,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+11,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+12,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+13,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+14,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+15,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+16,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+17,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+18,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+19,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+20,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+21,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+22,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+23,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+24,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+25,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+26,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+27,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+28,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+29,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+30,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+31,1,"Group, Tar Lord, crater un'goror");
insert into pool_template value(@CI+32,1,"Group, Tar Lord, crater un'goror");


delete from pool_pool where pool_id between @CI and @CI+32;
insert into pool_pool values (@CI,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+1,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+2,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+3,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+4,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+5,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+6,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+7,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+8,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+9,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+10,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+11,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+12,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+13,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+14,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+15,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+16,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+17,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+18,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+19,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+20,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+21,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+22,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+23,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+24,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+25,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+26,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+27,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+28,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+29,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+30,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+31,@MPI,0,"group: Tar Lord, crater un'goror"); 
insert into pool_pool values (@CI+32,@MPI,0,"group: Tar Lord, crater un'goror"); 


-- group 1
delete from pool_creature where guid in (74042,105570);
insert into pool_creature values (74042,@CI,0,"Tar Lord group 1");
insert into pool_creature values (105570,@CI,0,"Tar Lord group 1");

-- group 2
delete from pool_creature where guid in (74058,105678);
insert into pool_creature values (74058,@CI+1,0,"Tar Lord group 2");
insert into pool_creature values (105678,@CI+1,0,"Tar Lord group 2");

-- group 3
delete from pool_creature where guid in (74060,113960);
insert into pool_creature values (74060,@CI+2,0,"Tar Lord group 3");
insert into pool_creature values (113960,@CI+2,0,"Tar Lord group 3");

-- group 4
delete from pool_creature where guid in (74061,113776);
insert into pool_creature values (74061,@CI+3,0,"Tar Lord group 4");
insert into pool_creature values (113776,@CI+3,0,"Tar Lord group 4");

-- group 5
delete from pool_creature where guid in (74032,105827);
insert into pool_creature values (74032,@CI+4,0,"Tar Lord group 5");
insert into pool_creature values (105827,@CI+4,0,"Tar Lord group 5");

-- group 6
delete from pool_creature where guid in (74035,105729);
insert into pool_creature values (74035,@CI+5,0,"Tar Lord group 6");
insert into pool_creature values (105729,@CI+5,0,"Tar Lord group 6");

-- group 7
delete from pool_creature where guid in (74034,105518);
insert into pool_creature values (74034,@CI+6,0,"Tar Lord group 7");
insert into pool_creature values (105518,@CI+6,0,"Tar Lord group 7");

-- group 8
delete from pool_creature where guid in (74036,113948);
insert into pool_creature values (74036,@CI+7,0,"Tar Lord group 8");
insert into pool_creature values (113948,@CI+7,0,"Tar Lord group 8");

-- group 9
delete from pool_creature where guid in (74056,105465);
insert into pool_creature values (74056,@CI+8,0,"Tar Lord group 9");
insert into pool_creature values (105465,@CI+8,0,"Tar Lord group 9");

-- group 10
delete from pool_creature where guid in (74052,113611);
insert into pool_creature values (74052,@CI+9,0,"Tar Lord group 10");
insert into pool_creature values (113611,@CI+9,0,"Tar Lord group 10");

-- group 11
delete from pool_creature where guid in (74054,113783);
insert into pool_creature values (74054,@CI+10,0,"Tar Lord group 11");
insert into pool_creature values (113783,@CI+10,0,"Tar Lord group 11");

-- group 12
delete from pool_creature where guid in (74127,105914);
insert into pool_creature values (74127,@CI+11,0,"Tar Lord group 12");
insert into pool_creature values (105914,@CI+11,0,"Tar Lord group 12");

-- group 13
delete from pool_creature where guid in (74015,113738);
insert into pool_creature values (74015,@CI+12,0,"Tar Lord group 13");
insert into pool_creature values (113738,@CI+12,0,"Tar Lord group 13");

-- group 14
delete from pool_creature where guid in (74118,105380);
insert into pool_creature values (74118,@CI+13,0,"Tar Lord group 14");
insert into pool_creature values (105380,@CI+13,0,"Tar Lord group 14");

-- group 15
delete from pool_creature where guid in (74017,113579);
insert into pool_creature values (74017,@CI+14,0,"Tar Lord group 15");
insert into pool_creature values (113579,@CI+14,0,"Tar Lord group 15");

-- group 16
delete from pool_creature where guid in (74122,105536);
insert into pool_creature values (74122,@CI+15,0,"Tar Lord group 16");
insert into pool_creature values (105536,@CI+15,0,"Tar Lord group 16");

-- group 17
delete from pool_creature where guid in (74121,113685);
insert into pool_creature values (74121,@CI+16,0,"Tar Lord group 17");
insert into pool_creature values (113685,@CI+16,0,"Tar Lord group 17");

-- group 18
delete from pool_creature where guid in (74023,113903);
insert into pool_creature values (74023,@CI+17,0,"Tar Lord group 18");
insert into pool_creature values (113903,@CI+17,0,"Tar Lord group 18");

-- group 19
delete from pool_creature where guid in (74014,113847);
insert into pool_creature values (74014,@CI+18,0,"Tar Lord group 19");
insert into pool_creature values (113847,@CI+18,0,"Tar Lord group 19");

-- group 20
delete from pool_creature where guid in (74016,105760);
insert into pool_creature values (74016,@CI+19,0,"Tar Lord group 20");
insert into pool_creature values (105760,@CI+19,0,"Tar Lord group 20");

-- group 21
delete from pool_creature where guid in (74028,113640);
insert into pool_creature values (74028,@CI+20,0,"Tar Lord group 21");
insert into pool_creature values (113640,@CI+20,0,"Tar Lord group 21");

-- group 22
delete from pool_creature where guid in (74019,105520);
insert into pool_creature values (74019,@CI+21,0,"Tar Lord group 22");
insert into pool_creature values (105520,@CI+21,0,"Tar Lord group 22");

-- group 23
delete from pool_creature where guid in (74018,113672);
insert into pool_creature values (74018,@CI+22,0,"Tar Lord group 23");
insert into pool_creature values (113672,@CI+22,0,"Tar Lord group 23");

-- group 24
delete from pool_creature where guid in (74128,105489);
insert into pool_creature values (74128,@CI+23,0,"Tar Lord group 24");
insert into pool_creature values (105489,@CI+23,0,"Tar Lord group 24");

-- group 25
delete from pool_creature where guid in (74020,113585);
insert into pool_creature values (74020,@CI+24,0,"Tar Lord group 25");
insert into pool_creature values (113585,@CI+24,0,"Tar Lord group 25");

-- group 26
delete from pool_creature where guid in (74126,105805);
insert into pool_creature values (74126,@CI+25,0,"Tar Lord group 26");
insert into pool_creature values (105805,@CI+25,0,"Tar Lord group 26");

-- group 27
delete from pool_creature where guid in (74026,106019);
insert into pool_creature values (74026,@CI+26,0,"Tar Lord group 21");
insert into pool_creature values (106019,@CI+26,0,"Tar Lord group 21");

-- group 28
delete from pool_creature where guid in (74027,105950);
insert into pool_creature values (74027,@CI+27,0,"Tar Lord group 28");
insert into pool_creature values (105950,@CI+27,0,"Tar Lord group 28");

-- group 29
delete from pool_creature where guid in (74124,113565);
insert into pool_creature values (74124,@CI+28,0,"Tar Lord group 29");
insert into pool_creature values (113565,@CI+28,0,"Tar Lord group 29");

-- group 30
delete from pool_creature where guid in (74024,105947);
insert into pool_creature values (74024,@CI+29,0,"Tar Lord group 30");
insert into pool_creature values (105947,@CI+29,0,"Tar Lord group 30");

-- group 31
delete from pool_creature where guid in (74050,113558);
insert into pool_creature values (74050,@CI+30,0,"Tar Lord group 31");
insert into pool_creature values (113558,@CI+30,0,"Tar Lord group 31");

-- group 32
delete from pool_creature where guid in (74051,113698);
insert into pool_creature values (74051,@CI+31,0,"Tar Lord group 32");
insert into pool_creature values (113698,@CI+31,0,"Tar Lord group 32");

-- group 33
delete from pool_creature where guid in (74029,105479);
insert into pool_creature values (74029,@CI+32,0,"Tar Lord group 33");
insert into pool_creature values (105479,@CI+32,0,"Tar Lord group 33");



