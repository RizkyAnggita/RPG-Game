:- dynamic(locPlayer/2).

/*Map 10x10*/
pagar(0,Y) :- Y>(-1), Y<10.
pagar(9,Y) :- Y>(-1), Y<10.
pagar(X,0) :- X>(-1), X<10.
pagar(X,9) :- X>(-1), X<10.
areaPlay(X,Y):- X>0, X<9, Y>0, Y<9.


locDojo(3,4).
locHQ(5,6).
locBoss(8,8).

initLocPlayer :- asserta(locPlayer(1,1)).

/* Pergerakan Player */

kiri :- locPlayer(1,_), print_mentok, !.
kiri :- locPlayer(X,Y), X1 is X-1, retract(locPlayer(X,Y)), asserta(locPlayer(X1,Y)), print_kiri.
kanan :- locPlayer(8,_), print_mentok, !.
kanan :- locPlayer(X,Y), X1 is X+1, retract(locPlayer(X,Y)), asserta(locPlayer(X1,Y)), print_kanan.
atas :- locPlayer(1,_), print_mentok, !.
atas :- locPlayer(X,Y), Y1 is Y-1, retract(locPlayer(X,Y)), asserta(locPlayer(X,Y1)), print_atas.
bawah :- locPlayer(8,_), print_mentok, !.
bawah :- locPlayer(X,Y), Y1 is Y+1, retract(locPlayer(X,Y)), asserta(locPlayer(X,Y1)), print_bawah.

/* Mencetak movement */
print_kiri :- write('Anda bergerak 1 blok ke arah barat.'), nl.
print_kanan :- write('Anda bergerak 1 blok ke arah timur.'), nl.
print_atas :- write('Anda bergerak 1 blok ke arah utara.'), nl.
print_bawah :- write('Anda bergerak 1 blok ke arah selatan.'), nl.
print_mentok :- write('Oops! Anda sudah berada di batas map.'), nl.

/* Perintah gerak, input dari user */
w :- atas.
a :- kiri.
s :- bawah.
d :- kanan.

/* Jika posisi player sama dengan posisi Dojo atau HeadQuarter */ 

printMap(X,Y) :- locPlayer(X,Y), write('P').
printMap(X,Y) :- pagar(X,Y), write('#').
printMap(X,Y) :- locDojo(X,Y), write('D').
printMap(X,Y) :- locHQ(X,Y), write('H').
printMap(X,Y) :- locBoss(X,Y), write('B').
printMap(X,Y) :- areaPlay(X,Y), write('-').


map :-
    write('---MAP----'), nl,
    forall(between(0,9,Y), (forall(between(0,9,X), printMap(X,Y)), nl)),nl.
