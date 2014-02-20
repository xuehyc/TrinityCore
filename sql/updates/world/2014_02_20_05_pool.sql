
-- crater un'goro  Frenzied Pterrordax

set @MPI = 14619; 
set @CI = @MPI+1;

delete from pool_template where entry=@MPI;
insert into pool_template value(@MPI,1,"Mother pool, Frenzied Pterrordax, crater un'goror");

delete from pool_template where entry between @CI and @CI+11;
insert into pool_template value(@CI,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+1,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+2,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+3,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+4,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+5,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+6,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+7,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+8,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+9,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+10,1,"Group, Frenzied Pterrordax, crater un'goror");
insert into pool_template value(@CI+11,1,"Group, Frenzied Pterrordax, crater un'goror");



delete from pool_pool where pool_id between @CI and @CI+11;
insert into pool_pool values (@CI,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+1,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+2,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+3,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+4,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+5,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+6,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+7,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+8,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+9,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+10,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 
insert into pool_pool values (@CI+11,@MPI,0,"group: Frenzied Pterrordax, crater un'goror"); 


-- group 1
delete from pool_creature where guid in (74533,105419);
insert into pool_creature values (74533,@CI,0,"Frenzied Pterrordax group 1");
insert into pool_creature values (105419,@CI,0,"Frenzied Pterrordax group 1");

-- group 2
delete from pool_creature where guid in (74541,113842);
insert into pool_creature values (74541,@CI+1,0,"Frenzied Pterrordax group 2");
insert into pool_creature values (113842,@CI+1,0,"Frenzied Pterrordax group 2");

-- group 3
delete from pool_creature where guid in (74535,105563);
insert into pool_creature values (74535,@CI+2,0,"Frenzied Pterrordax group 3");
insert into pool_creature values (105563,@CI+2,0,"Frenzied Pterrordax group 3");

-- group 4
delete from pool_creature where guid in (74542,105415);
insert into pool_creature values (74542,@CI+3,0,"Frenzied Pterrordax group 4");
insert into pool_creature values (105415,@CI+3,0,"Frenzied Pterrordax group 4");

-- group 5
delete from pool_creature where guid in (74543,113748);
insert into pool_creature values (74543,@CI+4,0,"Frenzied Pterrordax group 5");
insert into pool_creature values (113748,@CI+4,0,"Frenzied Pterrordax group 5");

-- group 6
delete from pool_creature where guid in (74525,105592);
insert into pool_creature values (74525,@CI+5,0,"Frenzied Pterrordax group 6");
insert into pool_creature values (105592,@CI+5,0,"Frenzied Pterrordax group 6");

-- group 7
delete from pool_creature where guid in (74502,105580);
insert into pool_creature values (74502,@CI+6,0,"Frenzied Pterrordax group 7");
insert into pool_creature values (105580,@CI+6,0,"Frenzied Pterrordax group 7");

-- group 8
delete from pool_creature where guid in (74547,105369);
insert into pool_creature values (74547,@CI+7,0,"Frenzied Pterrordax group 8");
insert into pool_creature values (105369,@CI+7,0,"Frenzied Pterrordax group 8");

-- group 9
delete from pool_creature where guid in (74544,105962);
insert into pool_creature values (74544,@CI+8,0,"Frenzied Pterrordax group 9");
insert into pool_creature values (105962,@CI+8,0,"Frenzied Pterrordax group 9");

-- group 10
delete from pool_creature where guid in (74531,105867);
insert into pool_creature values (74531,@CI+9,0,"Frenzied Pterrordax group 10");
insert into pool_creature values (105867,@CI+9,0,"Frenzied Pterrordax group 10");

-- group 11
delete from pool_creature where guid in (74522,105983);
insert into pool_creature values (74522,@CI+10,0,"Frenzied Pterrordax group 11");
insert into pool_creature values (105983,@CI+10,0,"Frenzied Pterrordax group 11");

-- group 12
delete from pool_creature where guid in (74517,105474);
insert into pool_creature values (74517,@CI+11,0,"Frenzied Pterrordax group 12");
insert into pool_creature values (105474,@CI+11,0,"Frenzied Pterrordax group 12");









