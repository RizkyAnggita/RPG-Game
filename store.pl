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
shopitem(6,temulawak,1000).
shopitem(7,gacha,500).

decodeItem(1,1,1,dagger).
decodeItem(1,1,2,chakram).
decodeItem(1,1,3,invisible_cloth).
decodeItem(1,1,4,chain_mail).

decodeItem(2,1,1,katana).
decodeItem(2,1,2,long_sword).
decodeItem(2,1,3,helmet).
decodeItem(2,1,4,karuta).

decodeItem(3,1,1,brass_knuckle).
decodeItem(3,1,2,nunchaku).
decodeItem(3,1,3,hand_bandage).
decodeItem(3,1,4,armor).



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
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,NEWPOTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
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


            (NUM =:= 7
            ->
                (
                    random(1,5,ANGKA),
                    decodeItem(ID,1,ANGKA,HASIL),
                    write('Selamat ! kamu mendapatkan '),
                    write(HASIL), nl,

                    (ANGKA =:= 1
                    ->
                        (
                            NEWITEM1 is ITEM1 + 1,
                            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                            asserta(inventoryData(ID,NEWITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                            write('HuAHa, gachamu ampas mas'), nl
                        )
                        ;
                        (
                            1 =:= 1
                        )
                    
                    
                    ),

                    (ANGKA =:= 2
                    ->
                        (
                            NEWITEM2 is ITEM2 + 1,
                            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                            asserta(inventoryData(ID,ITEM1,NEWITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6))
                        )
                        ;
                        (
                            1 =:= 1
                        )
                    
                    
                    ),

                    (ANGKA =:= 3
                    ->
                        (
                            NEWITEM3 is ITEM3 + 1,
                            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                            asserta(inventoryData(ID,ITEM1,ITEM2,NEWITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6))
                        )
                        ;
                        (
                            1 =:= 1
                        )
                    
                    
                    ),

                    (ANGKA =:= 4
                    ->
                        (
                            NEWITEM4 is ITEM4 + 1,
                            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                            asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,NEWITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6))
                        )
                        ;
                        (
                            1 =:= 1
                        )
                    )
                )
                ;
                (
                    1 =:= 1
                )
            )
            %write('duid cukup')

        )
    ;  
        (
            write('Maaf gold tidak cukup, silakan farming lagi'), nl
        )
     ).







    