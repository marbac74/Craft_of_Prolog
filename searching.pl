% Depth-first search
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


answer(Y) :-
    start(X),
    child_star(X, Y),
    solution(Y).

child_star(X, X).
child_star(X, Z) :-
    child(X, Y),
    child_star(Y, Z).

% Explicit depth-first search

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

% Breadth-first search

breadth_first_1(Answer) :-
    start(Start),
    breadth_star_1(/*Open*/[Start], Answer),
    solution(Answer).

breadth_star_1([X|_], X).
breadth_star_1([X|Open1], Y) :-
    children(X, Children),
    append(Open1, Children, Open2),
    breadth_star_1(Open2, Y).