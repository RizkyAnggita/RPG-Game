:- include('character.pl').
:- include('map.pl').
:- include('inventory.pl').
:- include('quest.pl').
:- include('enemy.pl').

save:-
    write('%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('%  SIMPAN PROGRESSMU  %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%'),nl,
    write('Nama File: '), read(File),
    atom_concat(File, '.txt', Filename),
    atom_concat('./gameMemory/', Filename, Path),
    open(Path, write, Stream), 
    user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL,XP),
    write(Stream, user(CHARACTER,CLASS,CURRENTHEALTH,HEALTH,ATTACK,DEFENCE,GOLD,LEVEL,XP)),write(Stream, '.\n'),
    locPlayer(X,Y),
    write(Stream, locPlayer(X,Y)), write(Stream, '.\n'),
    inventoryData(Char_id, Item_1, Item_2, Item_3, Item_4, Potion_1, Potion_2, Potion_3, Potion_4, Potion_5, Potion_6),
    write(Stream, inventoryData(Char_id, Item_1, Item_2, Item_3, Item_4, Potion_1, Potion_2, Potion_3, Potion_4, Potion_5, Potion_6)), write(Stream, '.\n'),
    progressQuest(QuestId, ShredderCount, OozmaCount, KappaCount),
    write(Stream, progressQuest(QuestId, ShredderCount, OozmaCount, KappaCount)), write(Stream, '.\n'),
    statsQuest(A),
    write(Stream, statsQuest(A)), write(Stream, '.\n'),
    enemy(EID, EName, ElocX, ElocY, EHP, Eattack, Edefense, Elevel, ElostCount ),
    write(Stream, enemy(EID, EName, ElocX, ElocY, EHP, Eattack, Edefense, Elevel, ElostCount )), write(Stream, '.\n'),
    enemiesPos(EPos),
    write(Stream, enemiesPos(EPos)), write(Stream, '.'),
    close(Stream).