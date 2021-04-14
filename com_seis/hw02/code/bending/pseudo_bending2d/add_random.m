function [vx,vy] = add_random(row,col)
row = 100; col =100;
level = 0.3;
vx = level*(2*rand(row,col)-1);
vy = level*(2*rand(row,col)-1);
