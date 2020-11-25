:- include('character.pl').
:- include('enemy.pl').


%calculate damage dealt,
userAttacking(EnemyId, Dmg):-
	user(_,_, _, UserAtt, _, _, _),
	enemyData(EnemyId, _, _, _, EnemyDef,_),
	Dmg is ((UserAtt / EnemyDef) * UserAtt).
	%rumus dmg masih belum pasti

userDefending(EnemyId, Dmg):-
	user(_,_, _, _, UserDef, _, _),
	enemyData(EnemyId, _, _, EnemyAtt, _, _),
	Dmg is ((EnemyAtt / UserDef) * EnemyAtt).
	%rumus dmg masih belum pasti
<<<<<<< HEAD


% kondisi berhenti battle adalah, run || hp player <= 0 || hp enemy <= 0
battle :-
	repeat,
		write('Num : '),
		read(X),
	(X>100; X<50),
	X < 25,
	write('Correct number!'), nl, !.
=======
>>>>>>> a87b2f40dedb71ef26f2f84a20c48a993e1aa551
