:- include('character.pl').

:- dynamic(inventoryData/7).


%decodeItemX(<character_id>,<is_item_exist>,<item_id>,<item_name>)
decodeItem1(1,1,1,dagger).
decodeItem1(2,1,2,katana).
decodeItem1(3,1,3,brass_knuckle).

decodeItem2(1,1,4,chakram).
decodeItem2(2,1,5,long_sword).
decodeItem2(3,1,6,nunchaku).

decodeItem3(1,1,7,invisible_cloth).
decodeItem3(2,1,8,helmet).
decodeItem3(3,1,9,hand_bandage).

decodeItem4(1,1,10,chain_mail).
decodeItem4(2,1,11,karuta).
decodeItem4(3,1,12,armor).

decodeItem4(_,1,13,potion_sm).
decodeItem4(_,1,14,potion_md).
decodeItem4(_,1,15,potion_xl).
decodeItem4(_,1,16,hammer_of_thor).
decodeItem4(_,1,17,dulcolax).
decodeItem4(_,1,18,temulawak).

%inventoryData(char_id,item_1, item_2, item_3, item_4, potion_1, potion_2, potion_3, potion_4, potion_5, potion_6).
initInventory :-
    asserta(inventoryData(1,1,0,0,0,5,0,0,0,0,0)),
    asserta(inventoryData(2,1,0,0,0,5,0,0,0,0,0)),
    asserta(inventoryData(3,1,0,0,0,5,0,0,0,0,0)).

printInventory :-
    user(CHARACTER,CLASS,_,_,_,_,_,_), 
    getid(CHARACTER,Char_id),
    format('Inventory of ~w (~w):~n', [CHARACTER, CLASS]),
    inventoryData(Char_id,Num_item_1, Num_item_2, Num_item_3, Num_item_4, Num_potion_1, Num_potion_2, Num_potion_3, Num_potion_4, Num_potion_5, Num_potion_6),
    decodeItem1(Char_id,1,Item_1),
    decodeItem2(Char_id,1,Item_2),
    decodeItem3(Char_id,1,Item_3),
    decodeItem4(Char_id,1,Item_4),
    format(' ~w: ~w~n ~w: ~w~n ~w: ~w~n ~w: ~w~n Small Health Potion: ~w~n Big Health Potion: ~w~n', [Item_1,Num_item_1,Item_2, Num_item_2, Item_3, Num_item_3, Item_4, Num_item_4, Num_potion_1, Num_potion_2]).