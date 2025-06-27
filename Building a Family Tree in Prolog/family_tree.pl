% ---------- Basic Facts ----------
% parent(Parent, Child)
parent(john, alice).
parent(john, bob).
parent(mary, alice).
parent(mary, bob).

parent(bob, claire).
parent(bob, dan).
parent(lisa, claire).
parent(lisa, dan).

parent(alice, emma).
parent(alice, frank).
parent(tom, emma).
parent(tom, frank).

% Gender facts
male(john).
male(bob).
male(dan).
male(frank).
male(tom).

female(mary).
female(alice).
female(claire).
female(emma).
female(lisa).

% ---------- Derived Relationships ----------

% Grandparent(X, Y): X is grandparent of Y
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

% Sibling(X, Y): X and Y share at least one parent and X ≠ Y
sibling(X, Y) :-
    parent(Z, X),
    parent(Z, Y),
    X \= Y.

% Cousin(X, Y): X and Y have parents who are siblings
cousin(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    sibling(P1, P2),
    X \= Y.

% Child(X, Y): X is child of Y
child(X, Y) :-
    parent(Y, X).

% Descendant(X, Y): X is descendant of Y (recursive)
descendant(X, Y) :-
    parent(Y, X).
descendant(X, Y) :-
    parent(Y, Z),
    descendant(X, Z).
