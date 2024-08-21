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

% A ordered_list predicate leaving a choice point and consing uselessly
ordered_list([]).
ordered_list([_]).
ordered_list([A, B|Rest]) :-
    A =< B,
    ordered_list([B|Rest]).

% A second version of ordered_list
ordered_list1([]).
ordered_list1([Head|Tail]) :-
    ordered_list1(Tail, Head).

ordered_list1([], _).
ordered_list1([Head|Tail], Prev) :-
    Prev =< Head,
    ordered_list1(Tail, Head).

% A predicate for merging two ordered lists
merge(L1, [X|L2], [X|M1]) :-
    less_than_head(X, L1),
    !,
    merge(L1, L2, M1).
merge([X|L1], L2, [X|M1]) :-
    merge(L1, L2, M1).
merge([], L2, L2).

less_than_head(X, [H|_]) :-
    X < H.

% Computing the size of a tree
size_of_tree(Tree, Size) :-
    size_of_tree(Tree, 0, Size).

size_of_tree([], Size, Size).
size_of_tree(node(_, _, Lson, Rson), Size0, Size) :-
    Size1 is Size0 + 1,
    size_of_tree(Lson, Size1, Size2),
    size_of_tree(Rson, Size2, Size).

tree(node(parent, 'a', 
        node(parent, 'b', 
            node(parent, 'd', 
                node(parent, 'h', [], []), node(parent, 'i', [], [])),
            node(parent, 'e', 
                node(parent, 'j', [], []), node(parent, 'k', [], []))),
        node(parent, 'c',
            node(parent, 'f', 
                node(parent, 'l', [], []), node(parent, 'm', [], [])),
            node(parent, 'g', 
                node(parent, 'n', [], []), node(parent, 'o', [], []))))).