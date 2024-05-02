% * represents the empty tile
start(board(1, 5, 4, *, 2, 6, 8, 3, 7)).

goal(board(*, 1, 2, 3, 4, 5, 6, 7, 8)).
goal(board(1, 2, 3, 8, *, 4, 7, 6, 5)).
goal(board(1, 2, 3, 4, 5, 6, 7, 8, *)).

%To move right in any row there are two cases:
%Case_1: empty tile in the second column
%Case_2: empty tile in the third column

% move right in the top row
move(board(X1, *, X2, X3, X4, X5, X6, X7, X8), board(*, X1, X2, X3, X4, X5, X6, X7, X8)). %second

move(board(X1, X2, *, X3, X4, X5, X6, X7, X8), board(X1, *, X2, X3, X4, X5, X6, X7, X8)). %third


% move right in the middle row
move(board(X1, X2, X3, X4, *, X5, X6, X7, X8), board(X1, X2, X3, *, X4, X5, X6, X7, X8)). %second

move(board(X1, X2, X3, X4, X5, *, X6, X7, X8), board(X1, X2, X3, X4, *, X5, X6, X7, X8)). %third

% move right in the bottom row
move(board(X1, X2, X3, X4, X5, X6, X7, *, X8), board(X1, X2, X3, X4, X5, X6, *, X7, X8)). %second

move(board(X1, X2, X3, X4, X5, X6, X7, X8, *), board(X1, X2, X3, X4, X5, X6, X7, *, X8)). %third

% To move left in any row there are two cases:
% Case_1: empty tile in the first column.
% Case_2: empty tile in the second column.

% move left in the top row
move(board(*, X1, X2, X3, X4, X5, X6, X7, X8), board(X1, *, X2, X3, X4, X5, X6, X7, X8)). %first

move(board(X1, *, X2, X3, X4, X5, X6, X7, X8), board(X1, X2, *, X3, X4, X5, X6, X7, X8)). %seond

%% move left in the middle row
move(board(X1, X2, X3, *, X4, X5, X6, X7, X8), board(X1, X2, X3, X4, *, X5, X6, X7, X8)). %first

move(board(X1, X2, X3, X4, *, X5, X6, X7, X8), board(X1, X2, X3, X4, X5, *, X6, X7, X8)). %second

%% move left in the bottom row
move(board(X1, X2, X3, X4, X5, X6, *, X7, X8), board(X1, X2, X3, X4, X5, X6, X7, *, X8)). %first

move(board(X1, X2, X3, X4, X5, X6, X7, *, X8), board(X1, X2, X3, X4, X5, X6, X7, X8, *)). %second

% It is possible to move up only when the empty tile is either
% in the top row or in the middle row, so moving up will be possible 
% only from the middle and the bottom rows from the three columns.

%% move up from the middle row
move(board(*, X1, X2, X3, X4, X5, X6, X7, X8), board(X3, X1, X2, *, X4, X5, X6, X7, X8)). %first

move(board(X1, *, X2, X3, X4, X5, X6, X7, X8), board(X1, X4, X2, X3, *, X5, X6, X7, X8)). %second

move(board(X1, X2, *, X3, X4, X5, X6, X7, X8), board(X1, X2, X5, X3, X4, *, X6, X7, X8)).  %third

%% move up from the bottom row
move(board(X1, X2, X3, *, X4, X5, X6, X7, X8), board(X1, X2, X3, X6, X4, X5, *, X7, X8)). %first

move(board(X1, X2, X3, X4, *, X5, X6, X7, X8), board(X1, X2, X3, X4, X7, X5, X6, *, X8)). %second

move(board(X1, X2, X3, X4, X5, *, X6, X7, X8), board(X1, X2, X3, X4, X5, X8, X6, X7, *)). %third

% It is possible to move down only when the empty tile is either
% in the middle row or in the bottom row, so moving down will be possible 
% only from the top and the middle rows from the three columns.

%  move down from the top row
move(board(X1, X2, X3, *, X4, X5, X6, X7, X8), board(*, X2, X3, X1, X4, X5, X6, X7, X8)). %first

move(board(X1, X2, X3, X4, *, X5, X6, X7, X8), board(X1, *, X3, X4, X2, X5, X6, X7, X8)). %second

move(board(X1, X2, X3, X4, X5, *, X6, X7, X8), board(X1, X2, *, X4, X5, X3, X6, X7, X8)). %third

%% move down from the middle row
move(board(X1, X2, X3, X4, X5, X6, *, X7, X8), board(X1, X2, X3, *, X5, X6, X4, X7, X8)). %first

move(board(X1, X2, X3, X4, X5, X6, X7, *, X8), board(X1, X2, X3, X4, *, X6, X7, X5, X8)). %second

move(board(X1, X2, X3, X4, X5, X6, X7, X8, *), board(X1, X2, X3, X4, X5, *, X7, X8, X6)). %third


% Searching with breadth-first search

moves(State, Moves) :-
    findall(Next, move(State, Next), Moves).

breadth_first(Answer) :-
    start(Start),
    queue(Start, Open),
    breadth_star(Open, /*Closed*/[Start], Answer),
    goal(Answer),
    !.
    
breadth_star(Open, Closed, Y) :-
    queue_head(X, Open1, Open),
    (   Y = X
    ;   moves(X, Moves),
        ord_union(Closed, Moves, Closed1, Moves1),
        queue_last_list(Moves1, Open1, Open2),
        breadth_star(Open2, Closed1, Y)
    ).

% An implementation of greedy best-first search algorithm
% making use of the heap/priority queue data structure

best_first(Answer) :-
    start(Start),
    initial_heap(Start, Heap),
    best_star(/*Open*/Heap, /*Closed*/[Start], Answer),
    % writeln(Answer), /* Here I add a writeln to print the order in which solutions are searched not only the final result */
    goal(Answer).

initial_heap(Start, Heap) :-
    goal(Goal),
    hamming(Start, Goal, Estimate),
    empty_heap(Empty),
    add_to_heap(Empty, Estimate, Start, Heap).

best_star(Heap, Closed, Answer) :-
    get_from_heap(Heap, _, Node, Heap1),
    (   Answer = Node
    ;   moves_4(Node, Closed, Closed1, Heap1, Heap2),
        best_star(Heap2, Closed1, Answer)
    ).

ordered_moves(State, Closed, Closed1, OrdPairs) :-
    moves(State, MovesSet),
    ord_union(Closed, MovesSet, Closed1, NewMoves),
    compute_ranks(NewMoves, RawPairs),
    keysort(RawPairs, OrdPairs).

compute_ranks([], []).
compute_ranks([Move|Moves], [Estimate-Move|Pairs]) :-
    goal(Goal),
    hamming(Move, Goal, Estimate),
    compute_ranks(Moves, Pairs).
      
moves_4(State, Closed, Closed1, Heap, Heap1) :-
    ordered_moves(State, Closed, Closed1, OrdPairs),
    add_moves(OrdPairs, Heap, Heap1).

add_moves([], Heap, Heap).
add_moves([Estimate-Move|Moves], Heap0, Heap) :-
    add_to_heap(Heap0, Estimate, Move, Heap1),
    add_moves(Moves, Heap1, Heap).

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

% Hamming heuristic function
hamming(Board, Goal, HammingValue) :-
    board_to_list(Board, List),
    board_to_list(Goal, GoalList),
    hamming_calc(List, GoalList, 0, HammingValue).

board_to_list(board(X1, X2, X3, X4, X5, X6, X7, X8, X9), [X1, X2, X3, X4, X5, X6, X7, X8, X9]).

hamming_calc([], [], Hamming, Hamming).
hamming_calc([H|Tail1], [H|Tail2], Acc, Hamming) :-
    hamming_calc(Tail1, Tail2, Acc, Hamming).
hamming_calc([Head1|Tail1], [Head2|Tail2], Acc, Hamming) :-
    Head1 \= Head2,
    NewAcc is Acc + 1,
    hamming_calc(Tail1, Tail2, NewAcc, Hamming).