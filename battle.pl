:- include('character.pl').
:- include('enemy.pl').

:- dynamic(enemyCurrHP/1).
:- dynamic(userSpecialAttackCD/1).


increaseSpecialAttackCD(userCD) :-
	userSpecialAttackCD(SpecialAttackCD),
	retract(userSpecialAttackCD(SpecialAttackCD)),
	asserta(userSpecialAttackCD(3)).

decreaseSpecialAttackCD(userCD) :-
	userSpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =\= 0,
	NewSpecialAttackCD is SpecialAttackCD - 1,
	retract(userSpecialAttackCD(SpecialAttackCD)),
	asserta(userSpecialAttackCD(NewSpecialAttackCD)),!.
	
decreaseSpecialAttackCD(userCD).

%calculate damage dealt,
userAttacking(EnemyId, Dmg):-
	user(_,_, _, _, UserAtt, _, _, _),
	enemyData(EnemyId, _, _, _, EnemyDef,_),
	Dmg is (UserAtt),
	decreaseSpecialAttackCD(userCD).
	%rumus dmg masih belum pasti
	
userSpecialAttacking(EnemyId, Dmg):-
	userSpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =:= 0,
	user(_,_, _, _, UserAtt, _, _, _),
	enemyData(EnemyId, _, _, _, EnemyDef,_),
	Dmg is (UserAtt * 2),
	increaseSpecialAttackCD(userCD), !.
	%rumus dmg masih belum pasti

userSpecialAttacking(EnemyId, Dmg):-
	userSpecialAttackCD(SpecialAttackCD),
	SpecialAttackCD =\= 0,
	Dmg is 0,
	write('Special Attack masih dalam cooldown!\n').	
	

enemyAttacking(EnemyId, Dmg):-
	user(_,_, _, _, _, UserDef, _, _),
	enemyData(EnemyId, _, _, EnemyAtt, _, _),
	Dmg is (EnemyAtt).
	%rumus dmg masih belum pasti

printBattleEnemyStat(EnemyId) :-
	enemyCurrHP(CurrHP),
	enemyData(EnemyId, _, HP, Att, Def, Lvl),
	format('Level: ~d\n', [Lvl]),
	format('Health: ~d/~d\n', [CurrHP, HP]),
	format('Attack: ~d\n', [Att]),
	format('Defense: ~d', [Def]).
	
hurtEnemy(Dmg) :-
	enemyCurrHP(EnemyCurrentHP),
	EnemyCurrentHPNew is EnemyCurrentHP - Dmg,
	retract(enemyCurrHP(EnemyCurrentHP)),
	asserta(enemyCurrHP(EnemyCurrentHPNew)),!.


printBattleMenu :-
	userSpecialAttackCD(SpecialAttackCD),
	write('What will you do?'),nl,nl,
	write('|-----------------|-----------------|'),nl,
	format('|      Attack     |Special Attack(~d)|', [SpecialAttackCD]),nl,
	write('|-----------------|-----------------|'),nl,
	write('|      Potion     |       Run       |'),nl,
	write('|-----------------|-----------------|').


battleCommand(attack, EnemyId) :-
	userAttacking(EnemyId, Dmg),
	format('You dealt ~d damage!\n', [Dmg]),
	hurtEnemy(Dmg),!.

battleCommand(specialAttack, EnemyId) :-
	userSpecialAttacking(EnemyId, Dmg),
	(Dmg =:= 0 -> write('Use other action!\n') ; format('Your special attack dealt ~d damage!\n', [Dmg])),
	hurtEnemy(Dmg),!.



% kondisi berhenti battle adalah, run || HP player <= 0 || HP enemy <= 0
battle(EnemyId):-
	enemyData(EnemyId, EnemyName, EnemyHP, _, _, _),
	format('You found a ~w\n', [EnemyName]),
	asserta(enemyCurrHP(EnemyHP)),
	asserta(userSpecialAttackCD(0)),
	repeat,
		printBattleEnemyStat(EnemyId),nl,
		printBattleMenu,nl,nl,
		read(Command),
		battleCommand(Command, EnemyId),
		enemyCurrHP(EnemyCurrentHPNew),
		nl,
	(EnemyCurrentHPNew =< 0),
	retract(enemyCurrHP(EnemyCurrentHPNew)).



	
%['battle.pl']. character. 1. battle(1).
