/**

 Programmer: David Whipple
 Date:       02/20/2016
 Purpose:    This was assignment #4 in Intro. To AI @ Drexel
 
 Overview:
 
 This is to implement Problem 7.10 in Artificial Intelligence: A Modern Approach
 by Russell & Norvig.

 */
 % Initial facts for family tree
 % Males
male(george).
male(philip).
male(spencer).
male(charles).
male(mark).
male(andrew).
male(edward).
male(william).
male(harry).
male(peter).
male(james).
% Females
female(mum).
female(elizabeth).
female(margaret).
female(kydd).
female(diana).
female(anne).
female(sarah).
female(sophie).
female(zara).
female(beatrice).
% eugenie looks like female name?  assuming
female(eugenie).
female(louise).
% spouse-marriage relationships, must be defined both ways
spouse(george, mum).
spouse(mum, george).
spouse(elizabeth, philip).
spouse(philip, elizabeth).
spouse(spencer, kydd).
spouse(kydd, spencer).
spouse(diana, charles).
spouse(charles, diana).
spouse(anne, mark).
spouse(mark, anne).
spouse(andrew, sarah).
spouse(sarah, andrew).
spouse(edward, sophie).
spouse(sophie, edward).
% child relationships
child(margaret, mum).
child(margaret, george).
child(elizabeth, mum).
child(elizabeth, george).
child(diana, spencer).
child(diana, kydd).
child(charles, elizabeth).
child(charles, philip).
child(anne, elizabeth).
child(anne, philip).
child(andrew, elizabeth).
child(andrew, philip).
child(edward, elizabeth).
child(edward, philip).
child(william, diana).
child(william, charles).
child(harry, diana).
child(harry, charles).
child(peter, anne).
child(peter, mark).
child(zara, anne).
child(zara, mark).
child(beatrice, andrew).
child(beatrice, sarah).
child(eugenie, andrew).
child(eugenie,sarah).
child(louise, edward).
child(louise, sophie).
child(james, edward).
child(james, sophie).
%
% Son and Daughter rules
%
daughter(X, Y) :- child(X, Y), female(X).
son(X, Y)      :- child(X, Y), male(X).
%
% Mother and Father rules
%
mother(X, Y) :- female(X), child(Y, X).
father(X, Y) :- male(X), child(Y, X).
%
% Parent rule
%
parent(X, Y) :- mother(X, Y).
parent(X, Y) :- father(X, Y).
%
% Wife and Husband rules
%
wife(X, Y)    :- spouse(X, Y), female(X).
husband(X, Y) :- spouse(X, Y), male(X).
%
% Sibling rule (I used this later)
%
% I used some PROLOG syntax here to remove duplicates.
% I first generate all results with duplicates, remove the duplicates, then create the results
% without duplicates.
sibling(X,Y)  :- setof((X,Y), P^(parent(P,X),parent(P,Y), \+X=Y), Sibs),
                 member((X,Y), Sibs),
                 \+ (Y@<X, member((Y,X), Sibs)).
%
% Brother and Sister rules
%
brother(X, Y)  :- parent(A, X), parent(B, X), parent(A, Y), parent(B, Y), male(X), X\=Y.
sister(X, Y)   :- parent(A, X), parent(B, X), parent(A, Y), parent(B, Y), female(X), X\=Y.
%
% ancestor rule (I used this later also)
%
ancestor(X,Y) :- parent(Z,Y), ancestor(X,Z).
ancestor(X,Y) :- parent(X,Y).
%
% Aunt and Uncle rules
%
aunt(X, Y) :- (parent(A, Y), sister(X, A));(parent(A, Y),brother(B, A), spouse(B, Y)).
uncle(X, Y):- (parent(A, Y), brother(X, A));(parent(A, Y),sister(B, A), spouse(B, Y)).
%
% Sisterinlaw and Brotherinlaw rules
% 
% I used some PROLOG syntax here to remove duplicates.
% I first generate all results with duplicates, remove the duplicates, then create the results
% without duplicates.
sisterinlaw(Y, X) :- setof((X,Y), P^(spouse(X, Z), sister(Y, Z), \+X=Y), Inlaws),
                     member((X,Y), Inlaws),
                     \+ (Y@<X, member((Y,X), Inlaws)).
% 
% I used some PROLOG syntax here to remove duplicates.
% I first generate all results with duplicates, remove the duplicates, then create the results
% without duplicates.
brotherinlaw(Y, X) :- setof((X,Y), P^(spouse(X, Z), brother(Y, Z), \+X=Y), Inlaws),
                      member((X,Y), Inlaws),
                      \+ (Y@<X, member((Y,X), Inlaws)).
%
% Grandchild rule
% 
grandchild(X, Y):- child(X, Z), child(Z, Y).
%
% Grandparent rule
%
greatgrandparent(X, Y) :- parent(X, Z), parent(Z, T), parent(T, Y).
%
% Firstcousin rule (I rewrote this one and still had some issues with it returning duplicates.)
% I used the same PROLOG trick here, but it still seems to generating duplicates.
% not sure why.
% OLD VERSION
%firstcousin(X, Y) :- setof((X,Y), P^(parent(Z, X), parent(P, Z), parent(F, Z), parent(B, Y), parent(P, B), parent(F, B), Z\=B, X\=Y, P\=F, \+X=Y), Cousins),
%                     member((X,Y), Cousins),
%                     \+ (Y@<X, member((Y,X), Cousins)).
%
% NEW VERSION
firstcousin(X, Y) :- setof((X,Y), P^(grandchild(X, G), grandchild(Y, G), \+X=Y), Cousins),
                 member((X,Y), Cousins),
                 \+ (Y@<X, member((Y,X), Cousins)).
%

mthcousin_n_removed(0, 0, X, Y) :- siblings(X, Y).
mthcousin_n_removed(1, 1, X, Y) :- firstcousin(X, Y).
mthcousin_n_removed(M, 1, X, Y) :- mthcousin(M, X, Y).

mthcousin(1, X, Y) :- firstcousin(X, Y).
%mthcousin(M, X, Y) :- I is M-1,                     
%                      granchild(X, G), grandchild(Y, G).

%nth_removed()

    
