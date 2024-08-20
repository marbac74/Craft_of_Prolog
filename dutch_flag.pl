% A Prolog program to rearrange the elements of a list according to a certain criterion
dutch_national_flag(Input, Output) :-
    red_items(Input, Output, Output1),
    white_items(Input, Output1, Output2),
    blue_items(Input, Output2, []).

red_items([], Rest, Rest).
red_items([red(Item)|Items], [Item|Subset], Rest) :-
    red_items(Items, Subset, Rest).
red_items([white(_)|Items], Subset, Rest) :-
    red_items(Items, Subset, Rest).
red_items([blue(_)|Items], Subset, Rest) :-
    red_items(Items, Subset, Rest).

white_items([], Rest, Rest).
white_items([red(_)|Items], Subset, Rest) :-
    white_items(Items, Subset, Rest).
white_items([white(Item)|Items], [Item|Subset], Rest) :-
    white_items(Items, Subset, Rest).
white_items([blue(_)|Items], Subset, Rest) :-
    white_items(Items, Subset, Rest).

blue_items([], Rest, Rest).
blue_items([red(_)|Items], Subset, Rest) :-
    blue_items(Items, Subset, Rest).
blue_items([white(_)|Items], Subset, Rest) :-
    blue_items(Items, Subset, Rest).
blue_items([blue(Item)|Items], [Item|Subset], Rest) :-
    blue_items(Items, Subset, Rest).