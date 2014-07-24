
-- crater un'goro	Ravasaurus

set @MPI = 14549; 
set @CI = @MPI+1;

delete from pool_template where entry=@MPI;
insert into pool_template value(@MPI,1,"Mother pool, Ravasaurus, crater un'goro");

delete from pool_template where entry between @CI and @CI+34;
insert into pool_template value(@CI,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+1,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+2,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+3,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+4,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+5,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+6,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+7,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+8,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+9,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+10,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+11,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+12,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+13,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+14,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+15,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+16,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+17,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+18,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+19,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+20,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+21,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+22,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+23,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+24,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+25,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+26,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+27,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+28,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+29,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+30,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+31,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+32,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+33,1,"Group, Ravasaurus, crater un'goro");
insert into pool_template value(@CI+34,1,"Group, Ravasaurus, crater un'goro");


delete from pool_pool where pool_id between @CI and @CI+34;
insert into pool_pool values (@CI,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+1,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+2,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+3,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+4,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+5,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+6,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+7,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+8,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+9,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+10,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+11,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+12,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+13,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+14,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+15,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+16,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+17,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+18,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+19,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+20,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+21,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+22,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+23,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+24,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+25,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+26,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+27,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+28,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+29,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+30,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+31,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+32,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+33,@MPI,0,"group: Ravasaurus, crater un'goro"); 
insert into pool_pool values (@CI+34,@MPI,0,"group: Ravasaurus, crater un'goro"); 


-- group 1
delete from pool_creature where guid in (73707,105913);
insert into pool_creature values (73707,@CI,0,"Ravasaurus group 1");
insert into pool_creature values (105913,@CI,0,"Ravasaurus group 1");

-- group 2
delete from pool_creature where guid in (73709,137651);
insert into pool_creature values (73709,@CI+1,0,"Ravasaurus group 2");
insert into pool_creature values (137651,@CI+1,0,"Ravasaurus group 2");

-- group 3
delete from pool_creature where guid in (73706,105880,105781);
insert into pool_creature values (73706,@CI+2,0,"Ravasaurus group 3");
insert into pool_creature values (105880,@CI+2,0,"Ravasaurus group 3");
insert into pool_creature values (105781,@CI+2,0,"Ravasaurus group 3");

-- group 4
delete from pool_creature where guid in (73750,105968,73739);
insert into pool_creature values (73750,@CI+3,0,"Ravasaurus group 4");
insert into pool_creature values (105968,@CI+3,0,"Ravasaurus group 4");
insert into pool_creature values (73739,@CI+3,0,"Ravasaurus group 4");

-- group 5
delete from pool_creature where guid in (73738,73718);
insert into pool_creature values (73738,@CI+4,0,"Ravasaurus group 5");
insert into pool_creature values (73718,@CI+4,0,"Ravasaurus group 5");

-- group 6
delete from pool_creature where guid in (105450,73721);
insert into pool_creature values (105450,@CI+5,0,"Ravasaurus group 6");
insert into pool_creature values (73721,@CI+5,0,"Ravasaurus group 6");

-- group 7
delete from pool_creature where guid in (105754,113687,105994,73722);
insert into pool_creature values (105754,@CI+6,0,"Ravasaurus group 7");
insert into pool_creature values (113687,@CI+6,0,"Ravasaurus group 7");
insert into pool_creature values (105994,@CI+6,0,"Ravasaurus group 7");
insert into pool_creature values (73722,@CI+6,0,"Ravasaurus group 7");

-- group 8
delete from pool_creature where guid in (113535,73748);
insert into pool_creature values (113535,@CI+7,0,"Ravasaurus group 8");
insert into pool_creature values (73748,@CI+7,0,"Ravasaurus group 8");

-- group 9
delete from pool_creature where guid in (73719,105626,73716);
insert into pool_creature values (73719,@CI+8,0,"Ravasaurus group 9");
insert into pool_creature values (105626,@CI+8,0,"Ravasaurus group 9");
insert into pool_creature values (73716,@CI+8,0,"Ravasaurus group 9");

-- group 10
delete from pool_creature where guid in (73728,113802);
insert into pool_creature values (73728,@CI+9,0,"Ravasaurus group 10");
insert into pool_creature values (113802,@CI+9,0,"Ravasaurus group 10");

-- group 11
delete from pool_creature where guid in (73725,105535);
insert into pool_creature values (73725,@CI+10,0,"Ravasaurus group 11");
insert into pool_creature values (105535,@CI+10,0,"Ravasaurus group 11");

-- group 12
delete from pool_creature where guid in (73724,113524);
insert into pool_creature values (73724,@CI+11,0,"Ravasaurus group 12");
insert into pool_creature values (113524,@CI+11,0,"Ravasaurus group 12");

-- group 13
delete from pool_creature where guid in (73712,105778);
insert into pool_creature values (73712,@CI+12,0,"Ravasaurus group 13");
insert into pool_creature values (105778,@CI+12,0,"Ravasaurus group 13");

-- group 14
delete from pool_creature where guid in (73769,105463);
insert into pool_creature values (73769,@CI+13,0,"Ravasaurus group 14");
insert into pool_creature values (105463,@CI+13,0,"Ravasaurus group 14");

-- group 15
delete from pool_creature where guid in (73746,113877);
insert into pool_creature values (73746,@CI+14,0,"Ravasaurus group 15");
insert into pool_creature values (113877,@CI+14,0,"Ravasaurus group 15");

-- group 16
delete from pool_creature where guid in (73747,113678);
insert into pool_creature values (73747,@CI+15,0,"Ravasaurus group 16");
insert into pool_creature values (113678,@CI+15,0,"Ravasaurus group 16");

-- group 17
delete from pool_creature where guid in (73713,105620);
insert into pool_creature values (73713,@CI+16,0,"Ravasaurus group 17");
insert into pool_creature values (105620,@CI+16,0,"Ravasaurus group 17");

-- group 18
delete from pool_creature where guid in (73727,106091);
insert into pool_creature values (73727,@CI+17,0,"Ravasaurus group 18");
insert into pool_creature values (106091,@CI+17,0,"Ravasaurus group 18");

-- group 19
delete from pool_creature where guid in (73726,113946);
insert into pool_creature values (73726,@CI+18,0,"Ravasaurus group 19");
insert into pool_creature values (113946,@CI+18,0,"Ravasaurus group 19");

-- group 20
delete from pool_creature where guid in (73754,113896);
insert into pool_creature values (73754,@CI+19,0,"Ravasaurus group 20");
insert into pool_creature values (113896,@CI+19,0,"Ravasaurus group 20");

-- group 21
delete from pool_creature where guid in (73753,105517);
insert into pool_creature values (73753,@CI+20,0,"Ravasaurus group 21");
insert into pool_creature values (105517,@CI+20,0,"Ravasaurus group 21");

-- group 22
delete from pool_creature where guid in (73757,105447);
insert into pool_creature values (73757,@CI+21,0,"Ravasaurus group 22");
insert into pool_creature values (105447,@CI+21,0,"Ravasaurus group 22");

-- group 23
delete from pool_creature where guid in (73730,113815);
insert into pool_creature values (73730,@CI+22,0,"Ravasaurus group 23");
insert into pool_creature values (113815,@CI+22,0,"Ravasaurus group 23");

-- group 24
delete from pool_creature where guid in (73756,137650);
insert into pool_creature values (73756,@CI+23,0,"Ravasaurus group 24");
insert into pool_creature values (137650,@CI+23,0,"Ravasaurus group 24");

-- group 25
delete from pool_creature where guid in (73742,106079);
insert into pool_creature values (73742,@CI+24,0,"Ravasaurus group 25");
insert into pool_creature values (106079,@CI+24,0,"Ravasaurus group 25");

-- group 26
delete from pool_creature where guid in (73732,113601);
insert into pool_creature values (73732,@CI+25,0,"Ravasaurus group 26");
insert into pool_creature values (113601,@CI+25,0,"Ravasaurus group 26");

-- group 27
delete from pool_creature where guid in (73762,105460);
insert into pool_creature values (73762,@CI+26,0,"Ravasaurus group 27");
insert into pool_creature values (105460,@CI+26,0,"Ravasaurus group 27");

-- group 28
delete from pool_creature where guid in (73737,105777);
insert into pool_creature values (73737,@CI+27,0,"Ravasaurus group 28");
insert into pool_creature values (105777,@CI+27,0,"Ravasaurus group 28");

-- group 29
delete from pool_creature where guid in (73743,106065);
insert into pool_creature values (73743,@CI+28,0,"Ravasaurus group 29");
insert into pool_creature values (106065,@CI+28,0,"Ravasaurus group 29");

-- group 30
delete from pool_creature where guid in (73758,113742);
insert into pool_creature values (73758,@CI+29,0,"Ravasaurus group 30");
insert into pool_creature values (113742,@CI+29,0,"Ravasaurus group 30");

-- group 31
delete from pool_creature where guid in (73714,113917);
insert into pool_creature values (73714,@CI+30,0,"Ravasaurus group 31");
insert into pool_creature values (113917,@CI+30,0,"Ravasaurus group 31");

-- group 32
delete from pool_creature where guid in (73759,113912);
insert into pool_creature values (73759,@CI+31,0,"Ravasaurus group 32");
insert into pool_creature values (113912,@CI+31,0,"Ravasaurus group 32");

-- group 33
delete from pool_creature where guid in (73720,105653);
insert into pool_creature values (73720,@CI+32,0,"Ravasaurus group 33");
insert into pool_creature values (105653,@CI+32,0,"Ravasaurus group 33");

-- group 34
delete from pool_creature where guid in (73743,105492);
insert into pool_creature values (73743,@CI+33,0,"Ravasaurus group 34");
insert into pool_creature values (105492,@CI+33,0,"Ravasaurus group 34");

-- group 35
delete from pool_creature where guid in (73708,106026);
insert into pool_creature values (73708,@CI+34,0,"Ravasaurus group 35");
insert into pool_creature values (106026,@CI+34,0,"Ravasaurus group 35");



