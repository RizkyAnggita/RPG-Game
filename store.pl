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
    user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL),
    inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6),

    (GOLD >= HARGA
    ->  
        (
            (NUM =:= 1
            ->
                (
                    NEWPOTION1 is POTION1 + 1,
                    NEWGOLD is GOLD - HARGA,
                    retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)),
                    asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
                    write('Potion SM berhasil dibeli'), nl
                    
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),

            (NUM =:= 2
            ->
                (
                    NEWPOTION2 is POTION2 + 1,
                    NEWGOLD is GOLD - HARGA,
                    retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,NEWPOTION2,POTION3,POTION4,POTION5,POTION6)),
                    retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)),
                    asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
                    write('Potion MD berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),


            (NUM =:= 3
            ->
                (
                    NEWPOTION3 is POTION3 + 1,
                    NEWGOLD is GOLD - HARGA,
                    retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,NEWPOTION3,POTION4,POTION5,POTION6)),
                    retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)),
                    asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
                    write('Potion XL berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),


            (NUM =:= 4
            ->
                (
                    NEWPOTION4 is POTION4 + 1,
                    NEWGOLD is GOLD - HARGA,
                    retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,NEWPOTION4,POTION5,POTION6)),
                    retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)),
                    asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
                    write('Hammer of Thor berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),



            (NUM =:= 5
            ->
                (
                    NEWPOTION5 is POTION5 + 1,
                    NEWGOLD is GOLD - HARGA,
                    retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,NEWPOTION5,POTION6)),
                    retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)),
                    asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
                    write('Dulcolax berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),



            (NUM =:= 6
            ->
                (
                    NEWPOTION6 is POTION6 + 1,
                    NEWGOLD is GOLD - HARGA,
                    retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,NEWPOTION6)),
                    retract(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL)),
                    asserta(user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,NEWGOLD,LEVEL)),
                    write('Temulawak berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),



            (NUM =:= 7
            ->
                (
                    write('Kamu ngegacha'), nl
                    
                )
                ;
                (
                    1 =:= 1
                )
            ),
            write('duid cukup')

        )
    ;  
        (
            write('Maaf gold tidak cukupi, silahkan farming lagi'), nl
        )
     ).







    