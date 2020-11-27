:- dynamic(locPlayer/2).

/*Map 10x10*/
pagar(0,Y) :- Y>(-1), Y<10.
pagar(9,Y) :- Y>(-1), Y<10.
pagar(X,0) :- X>(-1), X<10.
pagar(X,9) :- X>(-1), X<10.
areaPlay(X,Y):- X>0, X<9, Y>0, Y<9.


/* Lokasi Statis */
locDojo(3,4).
locHQ(5,6).
locBoss(8,8).


/* position checker */
equalPos(X,Y,A,B):-
    X=:=A,
    Y=:=B.

/* Inisialiasi Lokasi Awal Player pada Map */
initLocPlayer :- asserta(locPlayer(1,1)).


/* Pergerakan Player */
kiri :- locPlayer(1,_), print_mentok, !.
kiri :- locPlayer(X,Y), X1 is X-1, retract(locPlayer(X,Y)), asserta(locPlayer(X1,Y)), print_kiri.
kanan :- locPlayer(8,_), print_mentok, !.
kanan :- locPlayer(X,Y), X1 is X+1, retract(locPlayer(X,Y)), asserta(locPlayer(X1,Y)), print_kanan.
atas :- locPlayer(_,1), print_mentok, !.
atas :- locPlayer(X,Y), Y1 is Y-1, retract(locPlayer(X,Y)), asserta(locPlayer(X,Y1)), print_atas.
bawah :- locPlayer(_,8), print_mentok, !.
bawah :- locPlayer(X,Y), Y1 is Y+1, retract(locPlayer(X,Y)), asserta(locPlayer(X,Y1)), print_bawah.


/* Perintah gerak, input dari user */
w :- 
	atas, 
	currentlocPlayer.
a :- 
	kiri, 
	currentlocPlayer.
s :- 
	bawah, 
	currentlocPlayer.
d :- 
	kanan, 
	currentlocPlayer.

/* Untuk mengecek locPlayer(X,Y) dan sameLoc(X,Y) */
currentlocPlayer:- 
    write('Posisi Anda sekarang di '), 
    locPlayer(X,Y),
    print(X), write(','), print(Y), nl, 
    sameLoc(X,Y).

/* Jika posisi player sama dengan posisi Dojo, HeadQuarter atau 
Enemy(tinggal masuk ke mode battle) */ 

sameLoc(X,Y) :-
    locPlayer(X,Y),
    locDojo(X,Y),
    shop, !.

sameLoc(X,Y) :-
    locPlayer(X,Y),
    locHQ(X,Y),
    statsQuest(S), S =:= 1,
    nl, printWelcomeQuest,
    (questDone ->
    	progressQuest(QuestId, _, _, _),
    	quest(QuestId, _, _, _, GoldReward, ExpReward),
    	addgold(GoldReward),
	addxp(ExpReward),
	resetProgressQuest,
	write('Selamat! Anda telah menyelesaikan quest!'),nl,nl
	;
	write('Anda masih memiliki Quest!'), nl,
	print_getQuest, nl,
	write('Selesaikan misi tersebut!')	
    ), !.
    
sameLoc(X,Y) :-
    locPlayer(X,Y),
    locHQ(X,Y),   
    statsQuest(S), S =:= 0,
    nl, printWelcomeQuest,    
    write('Anda mendapatkan sebuah Quest!'), nl,
    getQuest,
    write('Quest Anda adalah mendapatkan '),
    print_getQuest,	write('Selamat berburu!'), nl, !.

sameLoc(X,Y) :-
    locPlayer(X,Y),
    locBoss(X,Y),
    write('Bertemu Boss!'),nl, 
    battle(99),!.

sameLoc(X,Y) :-
    locPlayer(X,Y),
	random(1, 5, EnemyChance),  
	(EnemyChance =:= 1 -> (
        user(_, _,_,_, _, _, _, Level,_),
        (Level =< 5 -> (
            random(1, 4, EnemyId),
		    battle(EnemyId)); (1 =:= 1)
        ),
        
        (Level > 5, Level =<10 -> (
            random(4, 7, EnemyId),
		    battle(EnemyId)); (1 =:= 1)
        ),
        
        (Level > 10 -> (
            random(7, 10, EnemyId),
		    battle(EnemyId)); (1 =:= 1)
        )

        ); 1 =:= 1),!.
	
	


/*
sameLoc(X,Y) :-
    locPlayer(X,Y),
    enemy(Id,Name,X,Y,_,_,_,_,_),
    nl, battle(Id),!.
*/

/* Teleport */

teleport(X,Y) :-
    areaPlay(X,Y),
    retract(locPlayer(_,_)),
    asserta(locPlayer(X,Y)),
    write('Anda berhasil teleport ke lokasi ('),
    print(X), write(','), print(Y), write(') !'),nl,
    sameLoc(X,Y).

teleport(X,Y) :-
    \+(areaPlay(X,Y)),
    write('Oops! Anda teleport ke area luar map!'), nl,
    write('Anda kami kembalikan ke posisi sebelumnya'),nl,!.

/* Mencetak Map */
printMap(X,Y) :- locPlayer(X,Y), write('P').
printMap(X,Y) :- pagar(X,Y), write('#').
printMap(X,Y) :- locDojo(X,Y), write('D').
printMap(X,Y) :- locHQ(X,Y), write('H').
printMap(X,Y) :- locBoss(X,Y), write('B').
printMap(X,Y) :- areaPlay(X,Y), write('-').


/* Mencetak movement */
print_kiri :- write('Anda bergerak 1 blok ke arah barat.'), nl.
print_kanan :- write('Anda bergerak 1 blok ke arah timur.'), nl.
print_atas :- write('Anda bergerak 1 blok ke arah utara.'), nl.
print_bawah :- write('Anda bergerak 1 blok ke arah selatan.'), nl.
print_mentok :- write('Oops! Anda sudah berada di batas map.'), nl.


map :-
    write('---MAP----'), nl,
    forall(between(0,9,Y), (forall(between(0,9,X), printMap(X,Y)), nl)),nl.
