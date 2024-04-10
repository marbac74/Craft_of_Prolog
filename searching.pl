% A graph

start(a).
solution(l).

child(a, b).
child(a, c).
child(b, d).
child(b, e).
child(c, f).
child(c, g).
child(d, h).
child(d, i).
child(e, j).
child(e, k).
child(f, l).
child(f, m).
child(g, n).
child(g, o).

% Searching using "natural" Prolog depth-first search strategy

answer(Y) :-
    start(X),
    child_star(X, Y),
    solution(Y).

child_star(X, X).
child_star(X, Z) :-
    child(X, Y),
    child_star(Y, Z).

% Searching with explicit depth-first search

children(ParentNode, ChildrenNodes) :-
    findall(ChildNode, child(ParentNode, ChildNode), ChildrenNodes).

depth_first(Answer) :-
    start(Start),
    depth_star(/*Open*/[Start], Answer),
    solution(Answer).

depth_star([X|_], X).
depth_star([X|Open1], Y) :-
    children(X, Children),
    append(Children, Open1, Open2),
    depth_star(Open2, Y).

% Searching with breadth-first search

breadth_first_1(Answer) :-
    start(Start),
    breadth_star_1(/*Open*/[Start], Answer),
    solution(Answer).

breadth_star_1([X|_], X).
breadth_star_1([X|Open1], Y) :-
    children(X, Children),
    append(Open1, Children, Open2),
    breadth_star_1(Open2, Y).

% Implementing a queue in Prolog
% Adding items one at a time

empty_queue_1([]).
queue_head_1(Head, Queue, [Head|Queue]).
queue_last_1(Last, Queue, NewQueue) :-
    append(Queue, [Last], NewQueue).

% Adding items in groups

queue_head_list_1(Heads, Queue, NewQueue) :-
    append(Heads, Queue, NewQueue).
queue_last_list_1(Lasts, Queue, NewQueue) :-
    append(Queue, Lasts, NewQueue).

% With list pairs

empty_queue_2([]+[]).

queue_head_2(Head, L1+R1, L2+R2) :-
    queue_head_2(L2, R2, L1, R1, Head).
queue_head_2([], R, L, [], Head) :-
    reverse(R, [Head|L]).
queue_head_2([Head|L], R, L, R, Head).

queue_last_2(Last, L1+R1, L2+R2) :-
    queue_head_2(R2, L2, R1, L1, Last).