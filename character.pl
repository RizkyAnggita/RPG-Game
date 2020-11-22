/* =====================
    Deklarasi Fakta 
====================== */

/* Character */
character(1,leonardo,samurai,120,120,120,10).
character(2,michelangelo,fighter,130,110,120,10).
character(3,raphael,assassin,120,130,110,10).


/* User */
:- dynamic(user/7).


/* Stats */
printstats :-
    user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL),
    write('Character Name   : '),
    write(CHARACTER), nl,
    write('Chacter Class    : '),
    write(CLASS), nl,
    write('Level            : '),
    write(LEVEL), nl,
    write('Health           : '),
    write(HEALTH), nl,
    write('Attack           : '),
    write(ATTACK), nl,
    write('Defence          : '),
    write(DEFENCE), nl,
    write('Gold             : '),
    write(GOLD), nl.


/* Level Up */
levelup :-
    user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL),
    write('Congratulations! Level up'),
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
        retract(user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)), 
        asserta(user(CHARACTER,CLASS,NEWHEALTH,NEWATTACK,NEWDEFENCE,GOLD,NEWLEVEL)),
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
    write('     =>  '),
    write(NEWATTACK), nl,

    /* Defence Up*/
    write(' Defence          : '),
    write(DEFENCE),
    write('     =>  '),
    write(NEWDEFENCE), nl,
    
    write(' Gold             : '),
    write(GOLD), nl.


/* Add Gold */
addgold :-
    user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL),
    write('Gold gained'), nl,
        NEWGOLD is GOLD + 20,
        retract(user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)), 
        asserta(user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
    write('Total gold : '),
    write(NEWGOLD).


/* Pemilihan Karakter*/
character :- 
    write('Character selection '), nl,
    write(' 1. Leonardo (Samurai)'), nl,
    write(' 2. Michelangelo (Fighter)'), nl,
    write(' 3. Raphael (Assassin)'), nl,
    write('Choose Your Character : '),

    /* Membaca input berupa angka*/
    read(NUM), nl,
    /* Mencari karakter sesuai angka*/       
    character(NUM,CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD),
    /* Assign karakter dan level ke user */
    asserta(user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,1)),
    user(CHARACTER,CLASS,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL),

    write('Your character is    : '),
    write(CHARACTER), nl,
    write('Current level        : '),
    write(LEVEL), nl.










