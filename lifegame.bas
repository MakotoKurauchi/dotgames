10 REM *** Initialize ***
20 FOR I=0 TO 63
30 @(I)=0
40 NEXT I
50 X=0; Y=0
60 IF BUTTON(4)GOTO 60
100 REM *** Dots Setting ***
110 IF BUTTON(2)==1 X=X-1
120 IF BUTTON(3)==1 X=X+1
130 IF BUTTON(0)==1 Y=Y-1
140 IF BUTTON(1)==1 Y=Y+1
150 IF (X<0)X=0
160 IF (X>7)X=7
170 IF (Y<0)Y=0
180 IF (Y>7)Y=7
190 IF BUTTON(4)@(X+Y*8)=1
200 GCLS
210 FOR I=0 TO 63
220 IF @(I)GPSET I%8,I/8
230 NEXT I
240 IF BUTTON(5)GOTO 300
250 GPSET X,Y
260 WAIT 2
270 GOTO 100
300 REM *** Dots Check ***
310 D=0
320 FOR I=0 TO 63
330 IF GSPOIT(I%8,I/8)D=1
340 NEXT I
350 IF D GOTO 500
400 REM *** Random ***
410 FOR I=0 TO 63
420 GPSET I%8,I/8,RND(1)
430 NEXT I
500 REM *** Dead or Alive ***
510 FOR I=0 TO 63
520 C=0
530 FOR Y=-1 TO 1
540 FOR X=-1 TO 1
550 P=I+Y*8+X
560 A=0
570 IF (X==0&&Y==0)GOTO 610
580 IF (P>=0&&P<=63)&&((X==-1&&I%8==0||X==1&&I%8==7)==0)A=1
590 IF (A)B=GSPOIT(P%8,P/8)
600 IF (A&&B)C=C+1
610 NEXT X
620 NEXT Y
630 @(I)=0
640 IF GSPOIT(I%8,I/8)==1&&(C==2||C==3)@(I)=1
650 IF GSPOIT(I%8,I/8)==0&&C==3 @(I)=1
660 NEXT I
700 REM *** Draw Stage ***
710 GCLS
720 FOR I=0 TO 63
730 GPSET I%8,I/8,@(I)
740 NEXT I
750 WAIT 1
760 IF BUTTON(4)GOTO 10
770 GOTO 500
