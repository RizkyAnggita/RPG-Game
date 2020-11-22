
:- dynamic(enemy/9).
/* enemy(ID, Name, locX, locY, HP, attack, defense, level, lostCount )


/*Enemy default (level 1) */
enemyData(99, boss, 1000, 200, 300, 70).
enemyData(1, shredder,150, 10, 30, 1).
enemyData(2, oozma, 100, 20, 20, 1).
enemyData(3, kappa, 100, 30, 10, 1).

/* Enemy level 5 */
enemyData(4, shredder, 250, 30, 50, 5).
enemyData(5, oozma, 150, 40, 20, 5).
enemyData(6, kappa, 150, 60, 20, 5).

/* Enemy level 10 */
enemyData(7, shredder, 400, 40, 90, 10).
enemyData(8, oozma, 200, 80, 75, 10).
enemyData(9, kappa, 200, 100, 40, 10).


/* Masih agak bingung initEnemy nya */
initEnemy :- asserta(enemy(1, shredder,0,0, 150, 10, 30, 1, 0)).


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
    retract(enemy(ID,A, B, C, HP, Attack, Defense , Level, H)),
    asserta(enemy(1, A, B,C, NewHP, NewAttack, NewDefense, NewLevel, H)).


