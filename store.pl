:- include('character.pl').
:- include('inventory.pl').

/* Buat hilangin warning gaje */
:- discontiguous character/7.
:- discontiguous getid/2.
:- discontiguous printstats/0.
:- discontiguous levelup/0. 
:- discontiguous addgold/0. 
:- discontiguous character/0.



/* =====================
    Deklarasi Fakta 
====================== */
% shopitem(ID, nama item, harga)
shopitem(1,potion_sm,30).
shopitem(2,potion_md,60).
shopitem(3,potion_xl,100).
shopitem(4,hammer_of_thor,1000).
shopitem(5,dulcolax,1000).
shopitem(6,temulawak,500).

/* =====================
    Deklarasi Rule 
====================== */
shop :-
    write('Selamat datang di BukaPedia'), nl,
    write('Berikut item yang kami jual : '), nl,
    write(' 1. Potion SM        (+30 HP)                  30   Gold'), nl,
    write(' 2. Potion MD        (+75 HP)                  60   Gold'), nl,
    write(' 3. Potion XL        (+125 HP)                 100  Gold'), nl,
    write(' 4. Hammer of Thor   (+100 Attack)             1000 Gold'), nl,
    write(' 5. Dulcolax         (+100 Defence)            1000 Gold'), nl,
    write(' 6. Temulawak        (+100 Max HP)             1000 Gold'), nl,
    write(' 7. Gacha            (Menjanjikan kekuatan)    500  Gold'), nl,
    write('Item yang ingin dibeli : '),
    read(NUM), nl,

    shopitem(NUM,NAMAITEM,HARGA),
    write(NAMAITEM), write(HARGA),
    user(CHARACTER,CLASS,_,_,_,_,GOLD,_),
    (GOLD >= HARGA
    /* Gold Cukup */
    -> write('duid cukup'); 
    /* Gold kurang */
    write('Gold kurang')).






    