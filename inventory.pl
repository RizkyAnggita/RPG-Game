:- include('character.pl').

:- dynamic(inventory/7).

%Inventory:

%Inventory List

%decodeItemX(<character_id>,<is_item_exist>,<item_name>)
decodeItem1(1,1,dagger).
decodeItem2(1,1,chakram).
decodeItem3(1,1,invisible_cloth).
decodeItem4(1,1,chain_mail).

decodeItem1(2,1,katana).
decodeItem2(2,1,long_sword).
decodeItem3(2,1,helmet).
decodeItem4(2,1,karuta).

decodeItem1(3,1,brass_knuckle).
decodeItem2(3,1,nunchaku).
decodeItem3(3,1,hand_bandage).
decodeItem4(3,1,armor).

decodeItem1(Any,0,no_item).
decodeItem2(Any,0,no_item).
decodeItem3(Any,0,no_item).
decodeItem4(Any,0,no_item).

%inventory(char_id,item_1, item_2, item_3, item_4, potion_1, potion_2).
inventory(1,1,0,0,0,5,0).
inventory(2,1,0,0,0,5,0).
inventory(3,1,0,0,0,5,0).

show_inventory(Char_code) :- 
    character(Char_code,Name,_,_,_,_,_,_),
    write(Char_code), write(': '), write(Name),
    inventory(Char_code,Item_1, Item_2, Item_3, Item_4, Potion_1, Potion_2),
    write('Inventory:'), nl.