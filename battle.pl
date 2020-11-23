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
