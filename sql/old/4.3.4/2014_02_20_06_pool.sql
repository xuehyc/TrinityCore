
-- crater un'goro  Living Blaze

set @MPI = 14632; 
set @CI = @MPI+1;

delete from pool_template where entry=@MPI;
insert into pool_template value(@MPI,1,"Mother pool, Living Blaze, crater un'goror");

delete from pool_template where entry between @CI and @CI+15;
insert into pool_template value(@CI,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+1,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+2,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+3,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+4,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+5,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+6,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+7,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+8,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+9,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+10,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+11,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+12,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+13,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+14,1,"Group, Living Blaze, crater un'goror");
insert into pool_template value(@CI+15,1,"Group, Living Blaze, crater un'goror");


delete from pool_pool where pool_id between @CI and @CI+15;
insert into pool_pool values (@CI,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+1,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+2,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+3,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+4,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+5,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+6,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+7,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+8,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+9,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+10,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+11,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+12,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+13,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+14,@MPI,0,"group: Living Blaze, crater un'goror"); 
insert into pool_pool values (@CI+15,@MPI,0,"group: Living Blaze, crater un'goror"); 


-- group 1
delete from pool_creature where guid in (74076,105655);
insert into pool_creature values (74076,@CI,0,"Living Blaze group 1");
insert into pool_creature values (105655,@CI,0,"Living Blaze group 1");

-- group 2
delete from pool_creature where guid in (74081,113758);
insert into pool_creature values (74081,@CI+1,0,"Living Blaze group 2");
insert into pool_creature values (113758,@CI+1,0,"Living Blaze group 2");

-- group 3
delete from pool_creature where guid in (74085,106005);
insert into pool_creature values (74085,@CI+2,0,"Living Blaze group 3");
insert into pool_creature values (106005,@CI+2,0,"Living Blaze group 3");

-- group 4
delete from pool_creature where guid in (74071,113880);
insert into pool_creature values (74071,@CI+3,0,"Living Blaze group 4");
insert into pool_creature values (113880,@CI+3,0,"Living Blaze group 4");

-- group 5
delete from pool_creature where guid in (74093,74074);
insert into pool_creature values (74093,@CI+4,0,"Living Blaze group 5");
insert into pool_creature values (74074,@CI+4,0,"Living Blaze group 5");

-- group 6
delete from pool_creature where guid in (74070,113664);
insert into pool_creature values (74070,@CI+5,0,"Living Blaze group 6");
insert into pool_creature values (113664,@CI+5,0,"Living Blaze group 6");

-- group 7
delete from pool_creature where guid in (74069,113637);
insert into pool_creature values (74069,@CI+6,0,"Living Blaze group 7");
insert into pool_creature values (113637,@CI+6,0,"Living Blaze group 7");

-- group 8
delete from pool_creature where guid in (74086,113624);
insert into pool_creature values (74086,@CI+7,0,"Living Blaze group 8");
insert into pool_creature values (113624,@CI+7,0,"Living Blaze group 8");

-- group 9
delete from pool_creature where guid in (74092,105412);
insert into pool_creature values (74092,@CI+8,0,"Living Blaze group 9");
insert into pool_creature values (105412,@CI+8,0,"Living Blaze group 9");

-- group 10
delete from pool_creature where guid in (74083,113910);
insert into pool_creature values (74083,@CI+9,0,"Living Blaze group 10");
insert into pool_creature values (113910,@CI+9,0,"Living Blaze group 10");

-- group 11
delete from pool_creature where guid in (74084,105932);
insert into pool_creature values (74084,@CI+10,0,"Living Blaze group 11");
insert into pool_creature values (105932,@CI+10,0,"Living Blaze group 11");

-- group 12
delete from pool_creature where guid in (74089,105894);
insert into pool_creature values (74089,@CI+11,0,"Living Blaze group 12");
insert into pool_creature values (105894,@CI+11,0,"Living Blaze group 12");

-- group 13
delete from pool_creature where guid in (74090,105903);
insert into pool_creature values (74090,@CI+12,0,"Living Blaze group 13");
insert into pool_creature values (105903,@CI+12,0,"Living Blaze group 13");

-- group 14
delete from pool_creature where guid in (74094,105496);
insert into pool_creature values (74094,@CI+13,0,"Living Blaze group 14");
insert into pool_creature values (105496,@CI+13,0,"Living Blaze group 14");

-- group 15
delete from pool_creature where guid in (74064,105486);
insert into pool_creature values (74064,@CI+14,0,"Living Blaze group 15");
insert into pool_creature values (105486,@CI+14,0,"Living Blaze group 15");

-- group 16
delete from pool_creature where guid in (74077,105360);
insert into pool_creature values (74077,@CI+15,0,"Living Blaze group 16");
insert into pool_creature values (105360,@CI+15,0,"Living Blaze group 16");


