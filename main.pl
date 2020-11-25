:- include('map.pl').
:- include('character.pl').
:- include('quest.pl').
:- include('enemy.pl').
:- include('inventory.pl').
:- include('battle.pl').


print_start :-
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%                              ~Find Donatello~                                %'),nl,
    write('% 1. start     : untuk memulai petualanganmu                                   %'),nl,
    write('% 2. map       : menampilkan peta                                              %'),nl,
    write('% 3. status    : menampilkan status pemain                                     %'),nl,
    write('% 4. w         : gerak ke utara 1 langkah                                      %'),nl,
    write('% 5. a         : gerak ke barat 1 langkah                                      %'),nl,
    write('% 6. s         : gerak ke selatan 1 langkah                                    %'),nl,
    write('% 7. d         : gerak ke timur 1 langkah                                      %'),nl,
    write('% 8. inventory : menampilkan inventory                                         %'),nl,
    write('% 9. help      : menampilkan segala bantuan                                    %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,nl.




start :-
    print_start,
    initLocPlayer,
    initProgressQuest,
    initEnemy,
    initInventory,
    character.

status :-
    printstats.

inventory:-
    printInventory.


help :-
    print_start.