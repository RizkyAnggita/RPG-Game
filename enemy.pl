:- include('map.pl').

:- dynamic(enemy/9).
:- dynamic(enemiesPos/1). /* List of Enemy */
%/* enemy(ID, Name, locX, locY, HP, attack, defense, level, lostCount )


/*Enemy default (level 1) = Stage 1 */
enemyData(99, boss, 1000, 200, 300, 70).
enemyData(1, shredder,150, 10, 30, 1).
enemyData(2, oozma, 100, 20, 20, 1).
enemyData(3, kappa, 100, 30, 10, 1).

/* Enemy level 5 = Stage 2*/
enemyData(4, shredder, 250, 30, 50, 5).
enemyData(5, oozma, 150, 40, 20, 5).
enemyData(6, kappa, 150, 60, 20, 5).

/* Enemy level 10 = Stage 3*/
enemyData(7, shredder, 400, 40, 90, 10).
enemyData(8, oozma, 200, 80, 75, 10).
enemyData(9, kappa, 200, 100, 40, 10).

/* Enemy Generator*/
initEnemyList:-
    retractall(enemiesPos(_)),
    asserta(enemiesPos([])),!.

isNoEnemy(_,[]):-!.
isNoEnemy(New_enemy_pos,List_of_enemy_pos):-
    [X,Y|T] = New_enemy_pos,
    [X1,Y1|T1] = List_of_enemy_pos,
    \+(equalPos(X,Y,X1,Y1)),!,
    isNoEnemy(New_enemy_pos,T1).

assignEnemyPos(X,Y):-
    enemiesPos(Old_list_of_enemy_pos),
    New_list_of_enemy_pos = [X,Y|Old_list_of_enemy_pos],
    retractall(enemiesPos(_)),
    asserta(enemiesPos(New_list_of_enemy_pos)).

/* Test Enemy Pos*/
pep:-
    enemiesPos(X),
    write(X).


/* Enemy Generator (Shredder, Oozma, Kappa)*/
generateShredder(Stage) :-
    ID is Stage*3 - 2,
    write(ID),nl,
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    repeat,
        random(2,8,X1),
        random(2,8,Y1),
        write(X1),write(','),
        write(Y1),nl,
    \+(equalPos(X1,Y1,A,B)),!,
    \+(equalPos(X1,Y1,C,D)),!,
    \+(equalPos(X1,Y1,E,F)),!,
    enemiesPos(List_of_enemy_pos),!,
    isNoEnemy([X1,Y1],List_of_enemy_pos),
    X is X1,
    Y is Y1,
    enemyData(ID, Name1,HP1, Atk1, Def1, Lvl1),
    asserta(enemy(ID, Name1,X1,Y1, HP1, Atk1, Def1, Lvl1, 0)),
    assignEnemyPos(X,Y).

generateOozma(Stage) :-
    ID is Stage*3 - 1,
    write(ID),nl,
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    repeat,
        random(2,8,X1),
        random(2,8,Y1),
        write(X1),write(','),
        write(Y1),nl,
    \+(equalPos(X1,Y1,A,B)),!,
    \+(equalPos(X1,Y1,C,D)),!,
    \+(equalPos(X1,Y1,E,F)),!,
    enemiesPos(List_of_enemy_pos),!,
    isNoEnemy([X1,Y1],List_of_enemy_pos),
    X is X1,
    Y is Y1,
    enemyData(ID, Name1,HP1, Atk1, Def1, Lvl1),
    asserta(enemy(ID, Name1,X1,Y1, HP1, Atk1, Def1, Lvl1, 0)),
    assignEnemyPos(X,Y).

generateKappa(Stage) :-
    ID is Stage*3,
    write(ID),nl,
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    repeat,
        random(2,8,X1),
        random(2,8,Y1),
        write(X1),write(','),
        write(Y1),nl,
    \+(equalPos(X1,Y1,A,B)),!,
    \+(equalPos(X1,Y1,C,D)),!,
    \+(equalPos(X1,Y1,E,F)),!,
    enemiesPos(List_of_enemy_pos),!,
    isNoEnemy([X1,Y1],List_of_enemy_pos),
    X is X1,
    Y is Y1,
    enemyData(ID, Name1,HP1, Atk1, Def1, Lvl1),
    asserta(enemy(ID, Name1,X1,Y1, HP1, Atk1, Def1, Lvl1, 0)),
    assignEnemyPos(X,Y).


/* Belum Beres, mau aku lanjutin ^^ */
initEnemyList:-
    retractall(enemies(_)),
    asserta(enemies([])).

initEnemy :-
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    write(A), write('-'), write(B), nl,
    write(C), write('-'), write(D), nl,
    write(E), write('-'), write(F), nl,
    generateShredder(1,X1,Y1),
    repeat,
        random(2,8,X2),
        random(2,8,Y2),
        write(X2),write(','),
        write(Y2),nl,
    \+(equalPos(X2,Y2,A,B)),!,
    \+(equalPos(X2,Y2,C,D)),!,
    \+(equalPos(X2,Y2,E,F)),!,
    \+(equalPos(X2,Y2,X1,Y1)),!,
    enemyData(2, Name2,HP2, Atk2, Def2, Lvl2),
    asserta(enemy(2, Name2,X2,Y2, HP2, Atk2, Def2, Lvl2, 0)),
    repeat,
        random(2,8,X3),
        random(2,8,Y3),
        write(X3),write(','),
        write(Y3),nl,
    \+(equalPos(X3,Y3,A,B)),!,
    \+(equalPos(X3,Y3,C,D)),!,
    \+(equalPos(X3,Y3,E,F)),!,
    \+(equalPos(X3,Y3,X1,Y1)),!,
    \+(equalPos(X3,Y3,X2,Y2)),!,
    enemyData(3, Name3,HP3, Atk3, Def3, Lvl3),
    asserta(enemy(3, Name3,X3,Y3, HP3, Atk3, Def3, Lvl3, 0)).


/* Mengacak lokasi kemunculan enemy */
randomEnemyLoc(Name) :- 
    random(2,8,X1),
    random(2,8,Y1),
    retract(enemy(ID,Name,_,_,C,D,E,F,G)),
    asserta(enemy(ID,Name, X1, Y1, C, D,E,F,G)).

/* Leveling Up Enemy (tapi kayaknya gajadi pake) */
levelUpEnemy(ID) :-
    enemy(ID,A, B, C, HP, Attack, Defense , Level, H),
    NewHP is (HP+1),
    NewAttack is (Attack + 1),
    NewDefense is (Defense + 1),
    NewLevel is (Level+5),
    NewID is ID+3,
    retract(enemy(ID,A, B, C, HP, Attack, Defense , Level, H)),
    asserta(enemy(NewID, A, B,C, NewHP, NewAttack, NewDefense, NewLevel, H)).

/* Check*/
pe:-
    enemy(ID,A, B, C, HP, Attack, Defense , Level, H),
    format('~w ~w ~w ~w ~w ~w ~w ~w ~w ', [ID, A, B, C, HP, Attack, Defense, Level, H]).
    
de:-
    retractall(enemy(_,_,_,_,_,_,_,_,_)).


