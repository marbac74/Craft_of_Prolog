% Cases and structural induction

abs_diff(X, Y, Diff) :-
    compare(R, X, Y),
    abs_diff(R, X, Y, Diff).

abs_diff(<, X, Y, Diff) :- Diff is Y - X.
abs_diff(>, X, Y, Diff) :- Diff is X - Y.
abs_diff(=, _, _, 0).

my_member(X, [X|_]).
my_member(X, [_|L]) :-
    my_member(X, L).

% Inputs, outputs and argument order convention

birthday(byron, date(feb, 4)).
birthday(noelene, date(dec, 25)).
birthday(richard, date(oct, 11)).
birthday(clare, date(sep, 15)).

min(X, Y, X) :- X < Y.
min(X, Y, Y) :- X >= Y.

min_and_max(X, Y, X, Y) :- X < Y.
min_and_max(X, Y, Y, X) :- X >= Y.

% Context Arguments

% Reducing a list of numbers

reduce(List, Result) :-
    reduce(List, 0, Result).

reduce([], Result, Result).
reduce([H|T], Partial, Result) :-
    NewPartial is Partial + H,
    reduce(T, NewPartial, Result).

% Mapping a list of numbers

scale([], _, []).
scale([X|Xs], Multiplier, [Y|Ys]) :-
    Y is X * Multiplier,
    scale(Xs, Multiplier, Ys).

% Filtering a list of numbers

big_elements(Input, Output) :-
    big_elements(Input, 10, Output).

big_elements([], _, []).
big_elements([Num|Nums], Bound, Bigs) :-
    Num < Bound,
    big_elements(Nums, Bound, Bigs).
big_elements([Num|Nums], Bound, [Num|Bigs]) :-
    Num >= Bound,
    big_elements(Nums, Bound, Bigs).

% Counting the length of a list

len(List, N) :-
    len(List, 0, N).

len([], N, N).
len([_|T], Old, N) :-
    New is Old + 1,
    len(T, New, N).

% Reversing a list

rev(List, Reverse) :-
    rev(List, [], Reverse).

rev([], Reverse, Reverse).
rev([Head|Tail], OutList, Reverse) :-
    rev(Tail, [Head|OutList], Reverse).

% Summing positive and negative elements of a list separately

sum_pos_neg(List, Pos, Neg) :-
    sum_pos_neg(List, 0, Pos, 0, Neg).

sum_pos_neg([], Pos, Pos, Neg, Neg).
sum_pos_neg([X|Xs], Pos0, Pos, Neg0, Neg) :-
    X >= 0,
    Pos1 is Pos0 + X,
    sum_pos_neg(Xs, Pos1, Pos, Neg0, Neg).
sum_pos_neg([X|Xs], Pos0, Pos, Neg0, Neg) :-
    X < 0,
    Neg1 is Neg0 + X,
    sum_pos_neg(Xs, Pos0, Pos, Neg1, Neg).

% Summing the elements of a list and summing their squares

sum_and_ssq(List, Sum, SSQ) :-
    sum_and_ssq(List, 0, Sum, 0, SSQ).

sum_and_ssq([], Sum, Sum, SSQ, SSQ).
sum_and_ssq([X|Xs], Sum0, Sum, SSQ0, SSQ) :-
    Sum1 is Sum0 + X,
    SSQ1 is SSQ0 + X*X,
    sum_and_ssq(Xs, Sum1, Sum, SSQ1, SSQ).

% Predicates to check whether Term is a proper list or a partial one
% Useful in determining the value of partial data structures in Prolog

is_proper_list(Term) :-
    classify_list(Term, proper, proper).

is_partial_list(Term) :-
    classify_list(Term, proper, partial).

is_list(Term) :-
    classify_list(Term, partial, partial).

classify_list(V, _, X) :-
    var(V),
    !,
    X = partial.
classify_list([], X, X).
classify_list([_|T], X0, X) :-
    classify_list(T, X0, X).