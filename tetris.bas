10 rem initialize --------------------
20 gcls
30 s=20 ; x=4 ; y=0
40 rem @(0)-@(27) is brock area
50 @(0)=0;@(1)=6;@(2)=6;@(3)=0;
60 @(4)=4;@(5)=4;@(6)=4;@(7)=4;
70 @(8)=0;@(9)=4;@(10)=4;@(11)=6;
80 @(12)=0;@(13)=4;@(14)=4;@(15)=12;
90 @(16)=0;@(17)=4;@(18)=14;@(19)=0;
100 @(20)=0;@(21)=4;@(22)=12;@(23)=8;
110 @(24)=0;@(25)=8;@(26)=12;@(27)=4;
120 rem @(28)-@(32) is current block
130 gosub 1300
140 rem @(33)-@(40) is screen buffer
150 rem @(41)-@(53) is stage area
160 gosub 2100
200 rem main routine --------------------
210 if e==0 gosub 1200
220 if e==1 gosub 1300
230 gosub 1900
240 if z==1 gosub 2000
300 rem fall block --------------------
310 y = y + 1
320 gosub 1900
330 if z==1 e=1
340 y = y + 1
350 gosub 1900
360 y = y - 1
370 if z==1 e=1
500 rem rotate block --------------------
510 if (e==0)&&(button(4)*f*a) gosub 1400
520 if button(4)==1 a=0
530 if button(4)==0 a=1
600 rem move block --------------------
610 if (e==0)&(button(2)*l) gosub 1600
620 if (e==0)&(button(3)*r) gosub 1700
630 if (e==0)&(button(1)) gosub 1800
640 if button(2)==1 l=0
650 if button(3)==1 r=0
670 if button(2)==0 l=1
680 if button(3)==0 r=1
700 rem draw block --------------------
710 for i=0 to 4
715 j=41+i+y/s
720 if j<=51 @(j) = @(j)|(@(28+i)<<x)
730 next i
800 rem delete line --------------------
810 for i=44 to 51
820 if (e==1)&&(@(i)==4095) gosub 2200
830 next i
900 rem loop --------------------
910 gosub 1100
920 goto 200
1000 rem sub routine
1100 rem draw stage --------------------
1110 for i=0 to 7
1120 for j=0 to 7
1130 if @(44+i)>>(j+2)&1 gpset j,i
1140 if (@(44+i)>>(j+2)&1)==0 gpreset j,i
1150 next j
1160 next i
1170 wait 1
1180 return
1200 rem erace block --------------------
1210 for i=0 to 4
1215 j = 41+i+y/s
1220 if j<=51 @(j) = @(j)&((@(28+i)<<x)^4095)
1230 next i
1240 return
1300 rem new block --------------------
1310 f = rnd(7)-1
1320 for i=0 to 3
1330 @(28+i)=@(f*4+i)
1340 next i
1350 @(32)=0
1360 x=4 ; y=0 ; e=0
1370 return
1400 rem rotate --------------------
1410 m=@(28) ; n=@(29) ; o=@(30) ; p=@(31) ; q=@(32)
1420 @(28) = (m>>4&1&1) | (n>>4&1)<<1 | (o>>4&1)<<2 | (p>>4&1)<<3 | (q>>4&1)<<4
1430 @(29) = (m>>3&1&1) | (n>>3&1)<<1 | (o>>3&1)<<2 | (p>>3&1)<<3 | (q>>3&1)<<4
1440 @(30) = (m>>2&1&1) | (n>>2&1)<<1 | (o>>2&1)<<2 | (p>>2&1)<<3 | (q>>2&1)<<4
1450 @(31) = (m>>1&1&1) | (n>>1&1)<<1 | (o>>1&1)<<2 | (p>>1&1)<<3 | (q>>1&1)<<4
1460 @(32) = (m>>0&1&1) | (n>>0&1)<<1 | (o>>0&1)<<2 | (p>>0&1)<<3 | (q>>0&1)<<4
1470 gosub 1900
1480 if z == 1 @(28) = m
1490 if z == 1 @(29) = n
1500 if z == 1 @(30) = o
1510 if z == 1 @(31) = p
1520 if z == 1 @(32) = q
1530 return
1600 rem left key --------------------
1610 x = x-1
1620 if x<0 x=0
1630 gosub 1900
1640 if z==1 x=x+1
1650 return
1700 rem right key --------------------
1710 x = x+1
1720 gosub 1900
1730 if z==1 x=x-1
1740 return
1800 rem down key --------------------
1810 y=y+20
1820 gosub 1900
1830 if z==1 y=y-20
1840 return
1900 rem Collision detection --------------------
1910 z = 0
1920 for i=0 to 4
1930 j=41+i+y/s
1940 if @(j)&(@(28+i)<<x) z=1
1950 next i
1960 return
2000 rem game over --------------------
2010 gosub 2100
2020 return
2100 rem make stage --------------------
2110 for i=41 to 51
2120 @(i)= 3075
2130 next i
2140 @(52) = 4095
2150 @(53) = 4095
2160 return
2200 rem delete line --------------------
2210 for j=i to 42 step -1
2220 @(j)=@(j-1)
2230 next j
2240 @(41)=3075
2250 return
