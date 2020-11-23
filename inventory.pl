:- include('character.pl').

:- dynamic(inventory/7).

%Inventory:

%Inventory List

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

%inventory(char_id,item_1, item_2, item_3, item_4, potion_1, potion_2).
initInventory :-
    asserta(inventory(1,1,0,0,0,5,0)),
    asserta(inventory(2,1,0,0,0,5,0)),
    asserta(inventory(3,1,0,0,0,5,0)).

show_inventory :-
    user(Name,_,_,_,_,_,_,_), 
    character(Char_code,Name,_,_,_,_,_),
    write('Inventory '), write(Name), write(': '), nl,
    inventory(Char_code,Item_1, Item_2, Item_3, Item_4, Potion_1, Potion_2),
    nl.