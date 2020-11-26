:- include('character.pl').
:- include('enemy.pl').

:- dynamic(enemyCurrHP/1).
:- dynamic(userSpecialAttackCD/1).
:- dynamic(enemySpecialAttackCD/1).
:- dynamic(runStatus/1).

hurtEnemy(Dmg) :-
	enemyCurrHP(EnemyCurrentHP),
	EnemyCurrentHPNew is EnemyCurrentHP - Dmg,
	retract(enemyCurrHP(EnemyCurrentHP)),
	asserta(enemyCurrHP(EnemyCurrentHPNew)),!.
	
hurtUser(Dmg) :-
	user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP),
	UserCurrHPNew is UserCurrHP - Dmg,
	retract(user(Char, Class, UserCurrHP, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),
	asserta(user(Char, Class, UserCurrHPNew, UserHP, UserAtt, UserDef, Gold, Lvl, XP)),!.

increaseUserCD :-
	userSpecialAttackCD(SpecialAttackCD),
	retract(userSpecialAttackCD(SpecialAttackCD)),
	asserta(userSpecialAttackCD(3)),!.

decreaseUserCD :-
	userSpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =\= 0,
	NewSpecialAttackCD is SpecialAttackCD - 1,
	retract(userSpecialAttackCD(SpecialAttackCD)),
	asserta(userSpecialAttackCD(NewSpecialAttackCD)),!.

decreaseUserCD.
	
increaseEnemyCD :-
	enemySpecialAttackCD(SpecialAttackCD),
	retract(enemySpecialAttackCD(SpecialAttackCD)),
	asserta(enemySpecialAttackCD(3)),!.

decreaseEnemyCD:-
	enemySpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =\= 0,
	NewSpecialAttackCD is SpecialAttackCD - 1,
	retract(enemySpecialAttackCD(SpecialAttackCD)),
	asserta(enemySpecialAttackCD(NewSpecialAttackCD)),!.
	
decreaseEnemyCD.

%calculate damage dealt,
userAttacking(EnemyId, Dmg):-
	user(_,_, _, _, UserAtt, _, _, _,_),
	enemyData(EnemyId, _, _, _, EnemyDef,_),
	Dmg is (UserAtt),
	decreaseUserCD,
	hurtEnemy(Dmg),!.
	%rumus dmg masih belum pasti
	
userSpecialAttacking(EnemyId, Dmg):-
	userSpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =:= 0,
	user(_,_, _, _, UserAtt, _, _, _,_),
	enemyData(EnemyId, _, _, _, EnemyDef,_),
	Dmg is (UserAtt * 2),
	increaseUserCD, 
	hurtEnemy(Dmg),!.
	%rumus dmg masih belum pasti

userSpecialAttacking(EnemyId, Dmg):-
	userSpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =\= 0,
	Dmg is 0,
	write('Special Attack masih dalam cooldown!\n'),!.	
	

enemyAttacking(EnemyId, Dmg):-
	user(_,_, _, _, _, UserDef, _, _,_),
	enemyData(EnemyId, _, _, EnemyAtt, _, _),
	enemySpecialAttackCD(EnemyCD),
	(EnemyCD =:= 0 ->
		random(1, 4, X),
		(X =:= 1 ->
			Dmg is (EnemyAtt * 2),
			increaseEnemyCD
			;
			Dmg is (EnemyAtt),
			decreaseEnemyCD
		)
		;
		Dmg is (EnemyAtt),
		decreaseEnemyCD	
	),
	hurtUser(Dmg),!.
	%rumus dmg masih belum pasti

printBattleEnemyStat(EnemyId) :-
	enemyCurrHP(CurrHP),
	enemyData(EnemyId, _, HP, Att, Def, Lvl),
	format('Level: ~d\n', [Lvl]),
	format('Health: ~d/~d\n', [CurrHP, HP]),
	format('Attack: ~d\n', [Att]),
	format('Defense: ~d', [Def]),!.
	

printBattleUserStat :-
	user(_, _, UserCurrHP, _, _, _, _, _,_),
	format('Your HP : ~d', [UserCurrHP]).


printBattleMenu :-
	userSpecialAttackCD(SpecialAttackCD),
	write('What will you do?'),nl,nl,
	write('|-----------------|-----------------|'),nl,
	format('|      Attack     |Special Attack(~d)|', [SpecialAttackCD]),nl,
	write('|-----------------|-----------------|'),nl,
	write('|      Potion     |       Run       |'),nl,
	write('|-----------------|-----------------|').


battleCommand(attack, EnemyId) :-
	userAttacking(EnemyId, UserDmg),
	format('You dealt ~d damage!\n', [UserDmg]),
	enemyCurrHP(EnemyCurrentHP),
	(EnemyCurrentHP > 0 ->
		enemyAttacking(EnemyId, EnemyDmg),
		enemyData(EnemyId, EnemyName, _, _, _, _),
		format('~w dealt ~d damage!\n', [EnemyName, EnemyDmg])
		;
		write('Enemy defeated!\n')
	), !.

battleCommand(specialAttack, EnemyId) :-
	userSpecialAttacking(EnemyId, Dmg),
	(Dmg =:= 0 -> 
		write('Use other action!\n') 
		; 
		format('Your special attack dealt ~d damage!\n', [Dmg]),
		enemyCurrHP(EnemyCurrentHP),
		(EnemyCurrentHP > 0 ->
			enemyAttacking(EnemyId, EnemyDmg),
			enemyData(EnemyId, EnemyName, _, _, _, _),
			format('~w dealt ~d damage!\n', [EnemyName, EnemyDmg])
			;
			write('Enemy defeated!\n')
		)	 
	),!.

battleCommand(run, EnemyId) :-
	random(1, 4, X),
	(X =:= 1 ->
		runStatus(RunStatus),
		retract(runStatus(RunStatus)),
		asserta(runStatus(1))
		;
		enemyAttacking(EnemyId, EnemyDmg),
		enemyData(EnemyId, EnemyName, _, _, _, _),
		format('~w dealt ~d damage!\n', [EnemyName, EnemyDmg])	
	), !.
	
battleCommand(potion, EnemyId) :-
	usePotion,
	decreaseUserCD,
	enemyAttacking(EnemyId, EnemyDmg),
	enemyData(EnemyId, EnemyName, _, _, _, _),
	format('~w dealt ~d damage!\n', [EnemyName, EnemyDmg]).


% kondisi berhenti battle adalah, run || HP player <= 0 || HP enemy <= 0
battle(EnemyId):-
	enemyData(EnemyId, EnemyName, EnemyHP, _, _, _),
	format('You found a ~w\n', [EnemyName]),
	asserta(enemyCurrHP(EnemyHP)),
	asserta(userSpecialAttackCD(0)),
	asserta(enemySpecialAttackCD(0)),
	asserta(runStatus(0)),
	repeat,
		printBattleEnemyStat(EnemyId),nl,nl,
		printBattleUserStat,nl,nl,
		printBattleMenu,nl,nl,
		read(Command),
		battleCommand(Command, EnemyId),
		enemyCurrHP(EnemyCurrentHPNew),
		user(_, _, UserCurrentHPNew, _, _, _, _, _,_),
		runStatus(RunStatus),
		nl,
	(EnemyCurrentHPNew =< 0; UserCurrentHPNew =< 0; RunStatus =:= 1),
	(EnemyCurrentHPNew =< 0 ->
		(EnemyId =:= 99 ->
<<<<<<< HEAD
			(1 =:= 1,
			printGoalState, quit
			);
=======
			1 =:= 1
			/*Insert tampilan goal state dan quit disini*/
			;
>>>>>>> 27dcdd90d6a081c19e63a2dbb2dfc438154d444e
			enemyReward(EnemyId, GoldReward, ExpReward),
			addgold(GoldReward),
			addxp(ExpReward),
			addKillCount(EnemyName)	
		)
		;
		1 =:= 1
	),
	(UserCurrentHPNew =< 0 ->
<<<<<<< HEAD
		(1 =:= 1,
		printFailState, quit
		);
=======
		1 =:= 1
		/* insert tampilan fail state dan quit disini */
		;
>>>>>>> 27dcdd90d6a081c19e63a2dbb2dfc438154d444e
		retract(enemyCurrHP(EnemyCurrentHPNew)),
		retract(runStatus(RunStatus)),
		userSpecialAttackCD(UserCD),
		enemySpecialAttackCD(EnemyCD),
		retract(userSpecialAttackCD(UserCD)),
		retract(enemySpecialAttackCD(EnemyCD)),
		conditionLevelUp
		;
		1 =:= 1		
	).

<<<<<<< HEAD
printGoalState :-
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
	write('%                                                                             %'),nl,
    write('%   IIIIII   IIIIII  I            I       II      II       I      IIIIIIIII   %'),nl,
    write('%   I        I       I           I I      I I    I I      I I         I       %'),nl,
    write('%   IIIIII   IIIIII  I          I   I     I  I  I  I     I   I        I       %'),nl,
    write('%        I   I       I         I III I    I   II   I    I III I       I       %'),nl,
    write('%   IIIIII   IIIIII  IIIIII   I       I   I        I   I       I      I       %'),nl,
	write('%                                                                             %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
	write('% Kamu berhasil menyelamatkan Donatello.                                      %'),nl,
	write('% Tapi jangan berpuas diri, masih banyak kejahatan yang menanti               %'),nl,
	write('% untuk diselesaikan                                                          %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.

printFailState :-
	write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
	write('%                                                                             %'),nl,
    write('%        IIIIII        I       IIIIII        I       I                        %'),nl,
    write('%        I            I I      I            I I      I                        %'),nl,
    write('%        IIIIIII     I   I     IIIIIII     I   I     I                        %'),nl,
    write('%        I     I    I III I    I     I    I III I    I                        %'),nl,
    write('%        IIIIIII   I       I   IIIIIII   I       I   IIIIII                   %'),nl,
	write('%                                                                             %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl,
	write('% Kamu tidak berhasil menyelamatkan Donatello dan dia terbunuh.                 %'),nl,
	write('% Kamu gagal, langkah apa yang akan kamu lakukan?                               %'),nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'),nl.
=======

>>>>>>> 27dcdd90d6a081c19e63a2dbb2dfc438154d444e

	
%['battle.pl']. character. 1. battle(1).
