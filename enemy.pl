:- include('map.pl').

:- dynamic(enemy/9).
:- dynamic(enemiesPos/1). /* List of Enemy */
%/* enemy(ID, Name, locX, locY, HP, attack, defense, level, lostCount )


testRepeat:-
    repeat,
    write("input a number: "),
    read(X),
    X>10,
    X<15,
    write("SUCCESS!").

/* _-------_ */
/* | FAKTA | */
/* ========= */

/* BOSS */
enemyData(99, boss, 1000, 200, 300, 70).

/*Enemy default (level 1) = Stage 1 */
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

/* enemy reward */
/* enemyReward(EnemyId, GoldReward, ExpReward) */
/* Enemy default (level 1) = Stage 1 */
enemyReward(1, 15, 30).
enemyReward(2, 10, 35).
enemyReward(3, 5, 45).

/* Enemy level 5 = Stage 2*/
enemyReward(4, 25, 20).
enemyReward(5, 20, 25).
enemyReward(6, 20, 35).

/* Enemy level 10 = Stage 3*/
enemyReward(7, 45, 15).
enemyReward(8, 60, 15).
enemyReward(9, 50, 25).

/* Enemy Checker */
isNoEnemy(_,[]):-!.
isNoEnemy(New_enemy_pos,List_of_enemy_pos):-
    [X,Y|T] = New_enemy_pos,
    [X1,Y1|T1] = List_of_enemy_pos,
    \+(equalPos(X,Y,X1,Y1)),!,
    isNoEnemy(New_enemy_pos,T1).



/* Enemy Generator (Shredder, Oozma, Kappa)*/
assignEnemyPos(X,Y):-
    enemiesPos(Old_list_of_enemy_pos),
    New_list_of_enemy_pos = [X,Y|Old_list_of_enemy_pos],
    retractall(enemiesPos(_)),
    asserta(enemiesPos(New_list_of_enemy_pos)).
gsPortal(Stage) :- /*Stage = 1,2,3. Stage 1 => Lvl 1, Stage 2 => Lvl 5, Stage 3 => Lvl 10*/
    ID is Stage*3 - 2,
    %write(ID),nl,
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    enemiesPos(List_of_enemy_pos),!,
    repeat,
        random(2,8,X1),
        random(2,8,Y1),
        %write(X1),write(','),
        %write(Y1),nl,
    \+(equalPos(X1,Y1,A,B)),!,
    \+(equalPos(X1,Y1,C,D)),!,
    \+(equalPos(X1,Y1,E,F)),!,
    isNoEnemy([X1,Y1],List_of_enemy_pos),
    X is X1,
    Y is Y1,
    enemyData(ID, Name1,HP1, Atk1, Def1, Lvl1),
    asserta(enemy(ID, Name1,X1,Y1, HP1, Atk1, Def1, Lvl1, 0)),
    assignEnemyPos(X,Y).

goPortal(Stage) :-
    ID is Stage*3 - 1,
    %write(ID),nl,
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    enemiesPos(List_of_enemy_pos),!,
    repeat,
        random(2,8,X1),
        random(2,8,Y1),
        %write(X1),write(','),
        %write(Y1),nl,
    \+(equalPos(X1,Y1,A,B)),!,
    \+(equalPos(X1,Y1,C,D)),!,
    \+(equalPos(X1,Y1,E,F)),!,
    isNoEnemy([X1,Y1],List_of_enemy_pos),
    X is X1,
    Y is Y1,
    enemyData(ID, Name1,HP1, Atk1, Def1, Lvl1),
    asserta(enemy(ID, Name1,X1,Y1, HP1, Atk1, Def1, Lvl1, 0)),
    assignEnemyPos(X,Y).

gkPortal(Stage) :-
    ID is Stage*3,
    %write(ID),nl,
    locDojo(A,B),
    locHQ(C,D),
    locBoss(E,F), 
    enemiesPos(List_of_enemy_pos),!,
    repeat,
        random(2,8,X1),
        random(2,8,Y1),
        %write(X1),write(','),
        %write(Y1),nl,
    \+(equalPos(X1,Y1,A,B)),!,
    \+(equalPos(X1,Y1,C,D)),!,
    \+(equalPos(X1,Y1,E,F)),!,
    isNoEnemy([X1,Y1],List_of_enemy_pos),
    X is X1,
    Y is Y1,
    enemyData(ID, Name1,HP1, Atk1, Def1, Lvl1),
    asserta(enemy(ID, Name1,X1,Y1, HP1, Atk1, Def1, Lvl1, 0)),
    assignEnemyPos(X,Y).

generateShredder(Stage):-
    repeat,gsPortal(Stage),!.

generateOozma(Stage):-
    repeat,goPortal(Stage),!.

generateKappa(Stage):-
    repeat,gkPortal(Stage),!.


/* Inisialisasi */
initEnemyPosList:-
    retractall(enemiesPos(_)),
    asserta(enemiesPos([])).

iePortal :- /*initEnemyPortal*/
    de,
    user(_, _,_,_, _, _, _, Level,_),
    (Level =< 5 -> (Stage is 1); (1 =:= 1)),
    (Level > 5, Level =<10 -> ( Stage is 2); (1 =:= 1)),
    (Level > 10 -> (Stage is 3); (1 =:= 1)), 

    initEnemyPosList,
    generateShredder(Stage),
    generateOozma(Stage),
    generateKappa(Stage).

initEnemy:-
    repeat,iePortal,!.
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

/* Printing, Checking, and Demolishing*/
pe:- /*pe: Print Enemy*/
    enemy(ID,A, B, C, HP, Attack, Defense , Level, H),
    format('~w ~w ~w ~w ~w ~w ~w ~w ~w ', [ID, A, B, C, HP, Attack, Defense, Level, H]).

pep:- /*pep: Print Enemy Position*/
    enemiesPos(X),
    write(X),!.


de:- /*de: Demolish Enemy*/
    retractall(enemy(_,_,_,_,_,_,_,_,_)),
    initEnemyPosList.


