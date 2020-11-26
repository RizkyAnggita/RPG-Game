/* =====================
    Deklarasi Fakta 
====================== */

/* Character */
character(1,leonardo,samurai,120,40,120,10,0).
character(2,michelangelo,fighter,130,110,120,10,0).
character(3,raphael,assassin,120,130,110,10,0).


/* Get Id Character*/
getid(leonardo,1).
getid(michelangelo,2).
getid(raphael,3).

/* User */
:- dynamic(user/9).


/* =====================
    Deklarasi Rule 
====================== */

/* Stats */
printstats :-
    user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL,XP),
    write('Character Name   : '),
    write(CHARACTER), nl,
    write('Chacter Class    : '),
    write(CLASS), nl,
    write('Level            : '),
    write(LEVEL), nl,
    write('Health           : '),
    write(CURRENTHEALTH),
    write('/'),
    write(HEALTH), nl,
    write('Attack           : '),
    write(ATTACK), nl,
    write('Defence          : '),
    write(DEFENCE), nl,
    write('Gold             : '),
    write(GOLD), nl,
    write('XP               : '),
    write(XP), nl.


/* Level Up */
conditionLevelUp :-
    user(_,_,_,_,_,_,_,_,XP),
    XP < 100, !.

conditionLevelUp :-
    user(_,_,_,_,_,_,_,_,XP),
    XP >= 100,
    levelup.

levelup :-
    user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL,XP),
    write('Congratulations! Level up'),nl,
    write(' Character Name   : '),
    write(CHARACTER), nl,
    write(' Chacter Class    : '),
    write(CLASS), nl,
    /* Level Up */
    write(' Level            : '),
    write(LEVEL),
        NEWLEVEL is LEVEL + 1,
        NEWHEALTH is HEALTH + 10,
        NEWATTACK is ATTACK + 10,
        NEWDEFENCE is DEFENCE + 10,
        NEWXP is XP-100,
        retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL,XP)), 
        asserta(user(CHARACTER,CLASS,NEWHEALTH,NEWHEALTH,NEWATTACK,NEWDEFENCE,GOLD,NEWLEVEL,NEWXP)),
    write('       =>  '),
    write(NEWLEVEL), nl,

    /* Health Up */
    write(' Health           : '),
    write(HEALTH), 
    write('     =>  '),
    write(NEWHEALTH), nl,

    /* Attack Up */
    write(' Attack           : '),
    write(ATTACK),
    write('      =>  '),
    write(NEWATTACK), nl,

    /* Defence Up*/
    write(' Defence          : '),
    write(DEFENCE),
    write('     =>  '),
    write(NEWDEFENCE), nl,
    
    write(' Gold             : '),
    write(GOLD), nl,

    write(' XP               : '),
    write(NEWXP), nl.


/* Add Gold */
addgold(GOLDADDED) :-
    user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL),
    write('Gold gained'), nl,
        NEWGOLD is GOLD + GOLDADDED,
        retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)), 
        asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
    write('Total gold : '),
    write(NEWGOLD).


/* Pemilihan Karakter*/
initCharacter :- 
    write('Character selection '), nl,
    write(' 1. Leonardo (Samurai)'), nl,
    write(' 2. Michelangelo (Fighter)'), nl,
    write(' 3. Raphael (Assassin)'), nl,
    write('Choose Your Character : '),

    /* Membaca input berupa angka*/
    read(NUM), nl,
    /* Mencari karakter sesuai angka*/       
    character(NUM,CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,XP),
    /* Assign karakter dan level ke user */
    asserta(user(CHARACTER,CLASS,HEALTH,HEALTH,ATTACK,DEFENCE,GOLD,6,XP)),
    user(CHARACTER,CLASS,_,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL,XP),

    write('Your character is    : '),
    write(CHARACTER), nl,
    write('Current level        : '),
    write(LEVEL), nl.
