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

% a heuristic function that maps each node to an estimate 
% of how far that node is to the solution (low values are best)

estimated_distance_to_goal(a, 10).
estimated_distance_to_goal(b, 9).
estimated_distance_to_goal(c, 8).
estimated_distance_to_goal(d, 7).
estimated_distance_to_goal(e, 7).
estimated_distance_to_goal(h, 6).
estimated_distance_to_goal(i, 6).
estimated_distance_to_goal(j, 6).
estimated_distance_to_goal(k, 6).
estimated_distance_to_goal(f, 4).
estimated_distance_to_goal(g, 5).
estimated_distance_to_goal(l, 0).
estimated_distance_to_goal(m, 3).
estimated_distance_to_goal(n, 4).
estimated_distance_to_goal(o, 4).

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

children(ParentNode, ChildrenSet) :-
    findall(ChildNode, child(ParentNode, ChildNode), ChildrenNodes),
    sort(ChildrenNodes, ChildrenSet).

depth_first_1(Answer) :-
    start(Start),
    depth_star_1(/*Open*/[Start], Answer),
    writeln(Answer), /* Here I add writeln to print the order in which solutions are searched not only the final result */
    solution(Answer).

depth_star_1([X|_], X).
depth_star_1([X|Open1], Y) :-
    children(X, Children),
    append(Children, Open1, Open2),
    depth_star_1(Open2, Y).

% Searching with breadth-first search

breadth_first_1(Answer) :-
    start(Start),
    breadth_star_1(/*Open*/[Start], Answer),
    writeln(Answer), /* Here I add a writeln to print the order in which solutions are searched not only the final result */
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

% With a pair of lists

empty_queue_2([]+[]).

queue_head_2(Head, L1+R1, L2+R2) :-
    queue_head_2(L2, R2, L1, R1, Head).
queue_head_2([Head|L], R, L, R, Head).
queue_head_2([], R, L, [], Head) :-
    reverse(R, [Head|L]).

queue_last_2(Last, L1+R1, L2+R2) :-
    queue_head_2(R2, L2, R1, L1, Last).

% With difference lists

empty_queue_3(Queue-Queue).

queue_head_3(Head, Front-Back, [Head|Front]-Back).
queue_last_3(Last, Front-[Last|Back], Front-Back).

% Queue package used in the chapter

% queue(Queue) is true when Queue is an empty queue
queue(q(0, B, B)).

% queue(X, Queue) is true when Queue is a queue with one element
queue(X, q(s(0), [X|B], B)).

% queue_head(X, Queue1, Queue0) is true when Queue0 and Queue1 have
% the same elements except that Queue0 has in addition X at the front.
% Used both for enqueuing and dequeuing
queue_head(X, q(N, F, B), q(s(N), [X|F], B)).

% queue_head_list(List, Queue1, Queue0) is true when append(List, Queue1, Queue0)
% would be true if only Queue1 and Queue0 were lists instead of queues
queue_head_list([], Queue, Queue).
queue_head_list([X|Xs], Queue, Queue0) :-
    queue_head(X, Queue1, Queue0),
    queue_head_list(Xs, Queue, Queue1).

% queue_last(X, Queue1, Queue0) is true when Queue0 and Queue1 have
% the same elements except that Queue0 has in addition X at the end.
queue_last(X, q(N, F, [X|B]), q(s(N), F, B)).

% queue_last_list(List, Queue1, Queue0) is true when append(Queue1, List, Queue0)
% would be true if only Queue1 and Queue0 were lists instead of queues
queue_last_list([], Queue, Queue).
queue_last_list([X|Xs], Queue1, Queue) :-
    queue_last(X, Queue1, Queue2),
    queue_last_list(Xs, Queue2, Queue).

% list_queue(List, Queue) is true when List is a list and Queue is a queue and
% they represente the same sequence
list_queue(List, q(Count, Front, Back)) :-
    list_queue(List, Count, Front, Back).

list_queue([], 0, B, B).
list_queue([X|Xs], s(N), [X|F], B) :-
    list_queue(Xs, N, F, B).

% queue_length(Queue, Length) is true when Length is the number of elements in
% Queue. This version cannot be used to generate a queue, only to determine the length
queue_length(q(Count, Front, Back), Length) :-
    queue_length(Count, Front, Back, 0, Length).

queue_length(0, Back, Back, Length, Length).
queue_length(s(N), [_|Front], Back, L0, Length) :-
    L1 is L0 + 1,
    queue_length(N, Front, Back, L1, Length).

% New depth-first and breadth-first predicates based on the queue package above
% In this version we work with two lists: the Open set of nodes to visit and
% the Closed set of nodes already visited and not to be generated again. This
% allows us to work not only with trees, but also with graphs containing cycles
% thus preventing non-termination

depth_first(Answer) :-
    start(Start),
    depth_star(/*Open*/[Start], /*Closed*/[Start], Answer),
    solution(Answer).

depth_star([X|_], _, X).
depth_star([X|Open1], Closed, Y) :-
    children(X, Children),
    ord_union(Closed, Children, Closed1, Children1),
    append(Children1, Open1, Open2),
    depth_star(Open2, Closed1, Y).
    
breadth_first(Answer) :-
    start(Start),
    queue(Start, Open),
    breadth_star(Open, /*Closed*/[Start], Answer),
    solution(Answer).

breadth_star(Open, Closed, Y) :-
    queue_head(X, Open1, Open),
    (   Y = X
    ;   children(X, Children),
        ord_union(Closed, Children, Closed1, Children1),
        queue_last_list(Children1, Open1, Open2),
        breadth_star(Open2, Closed1, Y)
    ).

% An implementation of greedy best-first search algorithm
% making use of the heap/priority queue data structure

best_first(Answer) :-
    start(Start),
    initial_heap(Start, Heap),
    best_star(/*Open*/Heap, /*Closed*/[Start], Answer),
    writeln(Answer), /* Here I add a writeln to print the order in which solutions are searched not only the final result */
    solution(Answer).

initial_heap(Start, Heap) :-
    estimated_distance_to_goal(Start, Estimate),
    empty_heap(Empty),
    add_to_heap(Empty, Estimate, Start, Heap).

best_star(Heap, Closed, Answer) :-
    get_from_heap(Heap, _, Node, Heap1),
    (   Answer = Node
    ;   children_4(Node, Closed, Closed1, Heap1, Heap2),
        best_star(Heap2, Closed1, Answer)
    ).

ordered_children(ParentNode, Closed, Closed1, OrdPairs) :-
    children(ParentNode, ChildrenSet),
    ord_union(Closed, ChildrenSet, Closed1, NewChildren),
    compute_ranks(NewChildren, RawPairs),
    keysort(RawPairs, OrdPairs).

compute_ranks([], []).
compute_ranks([Child|Children], [Estimate-Child|Pairs]) :-
    estimated_distance_to_goal(Child, Estimate),
    compute_ranks(Children, Pairs).
      
children_4(ParentNode, Closed, Closed1, Heap, Heap1) :-
    ordered_children(ParentNode, Closed, Closed1, OrdPairs),
    add_children(OrdPairs, Heap, Heap1).

add_children([], Heap, Heap).
add_children([Estimate-Child|Children], Heap0, Heap) :-
    add_to_heap(Heap0, Estimate, Child, Heap1),
    add_children(Children, Heap1, Heap).