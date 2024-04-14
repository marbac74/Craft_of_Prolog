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