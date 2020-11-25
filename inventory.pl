:- include('character.pl').

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
decodePotion4(any,1,16,hammer_of_thor).
decodePotion5(any,1,17,dulcolax).
decodePotion6(any,1,18,temulawak).

%inventoryData(char_id,item_1, item_2, item_3, item_4, potion_1, potion_2, potion_3, potion_4, potion_5, potion_6).
initInventory :-
    user(CHARACTER,CLASS,_,_,_,_,_,_), 
    getid(CHARACTER,Char_id),
    asserta(inventoryData(Char_id,1,0,0,0,5,0,0,0,0,0)).

inventory :-
    user(CHARACTER,CLASS,_,_,_,_,_,_), 
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