%% 8 Puzzle
%% 
%% 

goal(board(row(1,  2,  3),
           row(8,blank,4),
           row(7,  6,  5))).

%%initial(board(row(blank,  8,  1),
%%            row(    2,  4,  3),
%%            row(    7,  6,  5))).
%%
initial(board(row(    2,  8,  1),
              row(blank,  4,  3),
              row(    7,  6,  5))).
%%
%%initial(board(row(    8,  1,  2),
%%            row(    4,  3,  5),
%%            row(    7,blank,6))).

move(BoardIn,BoardOut,up):-
   up(BoardIn,BoardOut).

move(BoardIn,BoardOut,left):-
   left(BoardIn,BoardOut).


move(BoardIn,BoardOut,down):-
% move down is same as move up in reverse
   up(BoardOut,BoardIn).

move(BoardIn,BoardOut,right):-
% move right is same as move left in reverse
   left(BoardOut,BoardIn).

move(StateIn, StateOut, Operator, 1):-
   move(StateIn, StateOut, Operator).

up(board(row(R1C1,R1C2,R1C3),
         row(blank,R2C2,R2C3),
         Row3),
   board(row(blank,R1C2,R1C3),
         row(R1C1,R2C2,R2C3),
         Row3)).
    
up(board(row(R1C1,R1C2,R1C3),
         row(R2C1,blank,R2C3),
         Row3),
     board(row(R1C1,blank,R1C3),
           row(R2C1,R1C2,R2C3),
           Row3)).
    
up(board(row(R1C1,R1C2,R1C3),
         row(R2C1,R2C2,blank),
         Row3),
   board(row(R1C1,R1C2,blank),
         row(R2C1,R2C2,R1C3),
         Row3)).
    
up(board(R1,
         row(R2C1,R2C2,R2C3),
         row(blank,R3C2,R3C3)),
   board(R1,
         row(blank,R2C2,R2C3),
         row(R2C1,R3C2,R3C3))).

up(board(R1,
         row(R2C1,R2C2,R2C3),
         row(R3C1,blank,R3C3)),
   board(R1,
         row(R2C1,blank,R2C3),
         row(R3C1,R2C2,R3C3))).

up(board(R1,
         row(R2C1,R2C2,R2C3),
         row(R3C1,R3C2,blank)),
   board(R1,
         row(R2C1,R2C2,blank),
         row(R3C1,R3C2,R2C3))).






left(board(row(C1,blank,C3),
           Rx,
           Ry),
     board(row(blank,C1,C3),
           Rx,
           Ry)).

left(board(row(C1,C2,blank),
           Rx,
           Ry),
     board(row(C1,blank,C2),
           Rx,
           Ry)).

left(board(Rx,
           row(C1,blank,C3),
           Ry),
     board(Rx,
           row(blank,C1,C3),
           Ry)).

left(board(Rx,
           row(C1,C2,blank),
           Ry),
     board(Rx,
           row(C1,blank,C2),
           Ry)).

left(board(Rx,
           Ry,
           row(C1,blank,C3)),
     board(Rx,
           Ry,
           row(blank,C1,C3))).

left(board(Rx,
           Ry,
           row(C1,C2,blank)),
     board(Rx,
           Ry,
           row(C1,blank,C2))).
