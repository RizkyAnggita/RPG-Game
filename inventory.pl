:- include('character.pl').

:- dynamic(inventoryData/7).


%decodeItemX(<character_id>,<is_item_exist>,<item_name>)
decodeItem1(1,1,dagger).
decodeItem1(2,1,katana).
decodeItem1(3,1,brass_knuckle).
decodeItem1(Any,0,no_item).

decodeItem2(1,1,chakram).
decodeItem2(2,1,long_sword).
decodeItem2(3,1,nunchaku).
decodeItem2(Any,0,no_item).

decodeItem3(1,1,invisible_cloth).
decodeItem3(2,1,helmet).
decodeItem3(3,1,hand_bandage).
decodeItem3(Any,0,no_item).

decodeItem4(1,1,chain_mail).
decodeItem4(2,1,karuta).
decodeItem4(3,1,armor).
decodeItem4(Any,0,no_item).

%inventoryData(char_id,item_1, item_2, item_3, item_4, potion_1, potion_2).
initInventory :-
    asserta(inventoryData(1,1,0,0,0,5,0)),
    asserta(inventoryData(2,1,0,0,0,5,0)),
    asserta(inventoryData(3,1,0,0,0,5,0)).

inventory :-
    user(Name,Class,_,_,_,_,_,_), 
    getid(Name,Char_id),
    format('Inventory of ~w (~w):~n', [Name, Class]),
    inventoryData(Char_id,Num_item_1, Num_item_2, Num_item_3, Num_item_4, Num_potion_1, Num_potion_2),
    decodeItem1(Char_id,1,Item_1),
    decodeItem2(Char_id,1,Item_2),
    decodeItem3(Char_id,1,Item_3),
    decodeItem4(Char_id,1,Item_4),
    format(' ~w: ~w~n ~w: ~w~n ~w: ~w~n ~w: ~w~n Small Health Potion: ~w~n Big Health Potion: ~w~n', [Item_1,Num_item_1,Item_2, Num_item_2, Item_3, Num_item_3, Item_4, Num_item_4, Num_potion_1, Num_potion_2]).