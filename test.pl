
user(10,3,7).

cek :-
    user(GOLD,HARGA,NUM),
    (GOLD >= HARGA
    ->  
        (
            (NUM =:= 1
            ->
                (
                    write('Potion SM berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),

            (NUM =:= 2
            ->
                (
                    write('Potion MD berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),


            (NUM =:= 3
            ->
                (
                    write('Potion XL berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),


            (NUM =:= 4
            ->
                (
                    write('Hammer of Thor berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),



            (NUM =:= 5
            ->
                (
                    write('Dulcolax berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),



            (NUM =:= 6
            ->
                (
                    write('Temulawak berhasil dibeli'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            %write('duid cukup'),



            (NUM =:= 7
            ->
                (
                    write('Kamu ngegacha'), nl
                )
                ;
                (
                    1 =:= 1
                )
            ),
            write('duid cukup')

        )
    ;  
        (
            write('Maaf gold tidak cukupi, silahkan farming lagi'), nl
        )
     ).

