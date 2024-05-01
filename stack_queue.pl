% A digression based on chapter 2 of O'Keefe dealing with implementing
% stacks and queues in Prolog. Related to the problem of search strategies
:- dynamic stack/1, queue/1.

% Creating an empty stack
stack([]).

% Implementing the two stack operations: push and pop
push(Item, stack(S)) :-
    stack(S),
    append([Item], S, NewS),
    retract(stack(S)),
    assertz(stack(NewS)).

pop(Item, stack(S)) :-
    stack([Item|NewS]),
    retract(stack(S)),
    assertz(stack(NewS)).

% Creating an empty queue
queue([]).

% Implementing the two queue operations: enqueue and dequeue
enqueue(Item, queue(Q)) :-
    queue(Q),
    append(Q, [Item], NewQ),
    retract(queue(Q)),
    assertz(queue(NewQ)).

dequeue(Item, queue(Q)) :-
    queue([Item|NewQ]),
    retract(queue(Q)),
    assertz(queue(NewQ)).

% Implementing the same data type (a queue) using two lists
empty_queue([]/[]).

% Enqueuing here means prepending to the back list
enqueue(Item, Front/Back, Front/[Item|Back]).

% Dequeuing here means popping the first item from the front list.
% If the front list is empty: we reverse the back list, return the first element from it 
% and move the rest to the front adding a new empty back list
dequeue(Item, [Item|Front]/Back, Front/Back).
dequeue(Item, []/Back, Front/[]) :-
    reverse(Back, [Item|Front]).

% Implementing a queue using a difference list
empty_q(L-L).

% Enqueuing
enqueue_q(Item, L-[Item|Z], L-Z).

% Dequeuing
dequeue_q(Item, [Item|T]-Z, T-Z).