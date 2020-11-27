:- dynamic(inventoryData/11).

%decodeItemX(<character_id>,<is_item_exist>,<item_id>,<item_name>)
decodeItem1(1,1,1,dagger).
decodeItem1(2,1,1,katana).
decodeItem1(3,1,1,brass_knuckle).

decodeItem2(1,1,2,chakram).
decodeItem2(2,1,2,long_sword).
decodeItem2(3,1,2,nunchaku).

decodeItem3(1,1,3,invisible_cloth).
decodeItem3(2,1,3,helmet).
decodeItem3(3,1,3,hand_bandage).

decodeItem4(1,1,4,chain_mail).
decodeItem4(2,1,4,karuta).
decodeItem4(3,1,4,armor).

decodePotion1(any,1,13,potion_sm).
decodePotion2(any,1,14,potion_md).
decodePotion3(any,1,15,potion_xl).
decodePotion4(any,1,16,sake).
decodePotion5(any,1,17,dulcolax).
decodePotion6(any,1,18,temulawak).

/* potionPlus(Id,Plus) Plus berisi pertambahan, bisa HP, Attack, Defense,MaxHP */
potionPlus(13,30).
potionPlus(14,75).
potionPlus(15,125).
potionPlus(16,100).
potionPlus(17,100).
potionPlus(18,100).
potionPlus(99,0).


%inventoryData(char_id,item_1, item_2, item_3, item_4, potion_1, potion_2, potion_3, potion_4, potion_5, potion_6).
initInventory :-
    user(CHARACTER,_,_,_,_,_,_,_,_), 
    getid(CHARACTER,Char_id),
    asserta(inventoryData(Char_id,1,0,0,0,5,0,0,1,1,1)).

isInventoryNotFull:-
    user(CHARACTER,_,_,_,_,_,_,_,_), 
    getid(CHARACTER,Char_id),
    inventoryData(Char_id,Num_item_1, Num_item_2, Num_item_3, Num_item_4, Num_potion_1, Num_potion_2, Num_potion_3, Num_potion_4, Num_potion_5, Num_potion_6),
    Total_item is Num_item_1 + Num_item_2 + Num_item_3 + Num_item_4 + Num_potion_1 + Num_potion_2 + Num_potion_3 + Num_potion_4 + Num_potion_5 + Num_potion_6,
    !,Total_item<100.

inventory :-
    user(CHARACTER,CLASS,_,_,_,_,_,_,_), 
    getid(CHARACTER,Char_id),
    format('Inventory of ~w (~w):~n', [CHARACTER, CLASS]),
    inventoryData(Char_id,Num_item_1, Num_item_2, Num_item_3, Num_item_4, Num_potion_1, Num_potion_2, Num_potion_3, Num_potion_4, Num_potion_5, Num_potion_6),
    decodeItem1(Char_id,1,_,Item_1),!,
    decodeItem2(Char_id,1,_,Item_2),!,
    decodeItem3(Char_id,1,_,Item_3),!,
    decodeItem4(Char_id,1,_,Item_4),!,
    decodePotion1(_,1,_,Potion_1),!,
    decodePotion2(_,1,_,Potion_2),!,
    decodePotion3(_,1,_,Potion_3),!,
    decodePotion4(_,1,_,Potion_4),!,
    decodePotion5(_,1,_,Potion_5),!,
    decodePotion6(_,1,_,Potion_6),!,
    format(' |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n |- ~w: ~w~n', [Item_1,Num_item_1,Item_2, Num_item_2, Item_3, Num_item_3, Item_4, Num_item_4, Potion_1, Num_potion_1, Potion_2, Num_potion_2, Potion_3, Num_potion_3, Potion_4, Num_potion_4, Potion_5, Num_potion_5, Potion_6, Num_potion_6]).

/* Menggunakan Potion */
usePotion :-
    printPotion,nl,
    write('Jika inputan salah, maka akan diminta input ulang sampai benar.'),nl,
    write('Masukkan Id Potion yang ingin Anda gunakan : '),
    
    repeat, 
        read(Input),
    (Input=:=13; Input=:=14; Input=:=15; Input=:=16; Input=:=17; Input=:=18; Input=:=99),
    effectPotion(Input),
    (Input =:= 99 -> (!,fail); (1=:=1)), !.


effectPotion(Id) :-
    inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6),
    user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP),
    potionPlus(Id, Plus),
    (Id =:= 13 -> 
        (   
            A is UserCurrHP + Plus,
            (A > UserHP -> NewCurrHP is UserHP ; NewCurrHP is A),
            POTION1 > 0,
            NEWPOTION1 is POTION1 - 1,
            retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            asserta(user(Char, Class, NewCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
            asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,NEWPOTION1,POTION2,POTION3,POTION4,POTION5,POTION6))
        ); (1 =:= 1)
    ),    
    (Id =:= 14 
    -> 
        (   
            A is UserCurrHP + Plus,
            (A > UserHP -> NewCurrHP is UserHP ; NewCurrHP is A),
            POTION2 > 0,
            NEWPOTION2 is POTION2 - 1,
            retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            asserta(user(Char, Class, NewCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
            asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,NEWPOTION2,POTION3,POTION4,POTION5,POTION6))
        )
        ; (1 =:= 1)
    ),
    (Id =:= 15 
    -> 
        (   
            A is UserCurrHP + Plus,
            (A > UserHP -> NewCurrHP is UserHP ; NewCurrHP is A),
            POTION3 > 0,
            NEWPOTION3 is POTION3 - 1,
            retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            asserta(user(Char, Class, NewCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
            asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,NEWPOTION3,POTION4,POTION5,POTION6))
        )
        ; (1 =:= 1)
    ),
    (Id =:= 16 
    -> 
        (   
            NEWATTACK is UserAtt + 100,
            POTION4 > 0,
            NEWPOTION4 is POTION4 - 1,
            retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            asserta(user(Char, Class, UserCurrHP, UserHP, NEWATTACK, UserDef, Gold, Lvl, XP)),
            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
            asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,NEWPOTION4,POTION5,POTION6))
        )
        ; (1 =:= 1)
    ),
    (Id =:= 17 
    -> 
        (   
            NEWDEFENSE is UserDef+100,
            POTION5 > 0,
            NEWPOTION5 is POTION5 - 1,
            retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            asserta(user(Char, Class, UserCurrHP, UserHP, UserAtt, NEWDEFENSE, Gold, Lvl, XP)),
            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
                    asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,NEWPOTION5,POTION6))
        )
        ; (1 =:= 1)
    ),
    (Id =:= 18 
    -> 
        (   
            NEWMAXHP is UserHP+100,
            POTION6 > 0,
            NEWPOTION6 is POTION6 - 1,
            retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
            asserta(user(Char, Class, UserCurrHP, NEWMAXHP, UserAtt, UserDef, Gold, Lvl, XP)),
            retract(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6)),
            asserta(inventoryData(ID,ITEM1,ITEM2,ITEM3,ITEM4,POTION1,POTION2,POTION3,POTION4,POTION5,NEWPOTION6))
        )
        ; (1 =:= 1)
    ),
    (Id =:= 99 
    -> 
        (  nl,write('Tidak jadi menggunakan Potion'), nl
        )
        ; (1 =:= 1)
    )
    .


printPotion:-
    write('Potion yang Anda miliki :'),nl, nl,
    inventoryData(_,_,_,_,_,POTION1,POTION2,POTION3,POTION4,POTION5,POTION6),
    decodePotion1(_,_,IdPotion1,NamaPotion1),
    decodePotion2(_,_,IdPotion2,NamaPotion2),
    decodePotion3(_,_,IdPotion3,NamaPotion3),
    decodePotion4(_,_,IdPotion4,NamaPotion4),
    decodePotion5(_,_,IdPotion5,NamaPotion5),
    decodePotion6(_,_,IdPotion6,NamaPotion6),
    potionPlus(IdPotion1, PlusHP1),
    potionPlus(IdPotion2, PlusHP2),
    potionPlus(IdPotion3, PlusHP3),
    potionPlus(IdPotion4, PlusHP4),
    potionPlus(IdPotion5, PlusHP5),
    potionPlus(IdPotion6, PlusHP6),
    write('Id  Jumlah    Nama Potion             Efek      '),nl,
    print(IdPotion1), write('    '), print(POTION1), write('        '), print(NamaPotion1), write('            +'), print(PlusHP1), write(' HP'), nl,
    print(IdPotion2), write('    '), print(POTION2), write('        '), print(NamaPotion2), write('            +'), print(PlusHP2), write(' HP'), nl,
    print(IdPotion3), write('    '), print(POTION3), write('        '), print(NamaPotion3), write('            +'), print(PlusHP3), write(' HP'),nl,
    print(IdPotion4), write('    '), print(POTION4), write('        '), print(NamaPotion4), write('       +'), print(PlusHP4) ,write(' Attack'), nl,
    print(IdPotion5), write('    '), print(POTION5), write('        '), print(NamaPotion5), write('             +'), print(PlusHP5), write(' Defence'),nl,
    print(IdPotion6), write('    '), print(POTION6), write('        '), print(NamaPotion6), write('            +'), print(PlusHP6),write(' Max HP'),nl,
    write('99    Cancel'),nl.



    
