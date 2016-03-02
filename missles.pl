/**

 Programmer: David Whipple
 Date:       02/20/2016
 Purpose:    This was assignment #4 in Intro. To AI @ Drexel
 
 Overview:
 Simple PROLOG program for logical inference problem top
 prove that Colonel West is a criminal

 The following facts and rules exist:
 
  - It is a crime for an American to sell weapons to hostile nations.
  - The country of Nono has some missles.
  - All of Nono's missiles were sold to it by Colonel West.
  - Missles are Weapons.
  - An enemy of America counts as "hostile".
  - Colonel West is American.
  - Nono is an enemy of America.
 
 Part 2 was to add the facts:
 
	- A country is an ally if that country helps America attack an enemy country.
	- Nono has helped America by attacking the country of Whoknew.
	- Whoknew is an enemy of America.
	- It is patriotic to sell weapons to an ally.
	
 */

 % Part 1 Facts
owns(nono, m1).
missle(m1).
american(west).
% put this in to test that dave is not a criminal and not a patriot.
american(dave).
%
enemy(nono, america).
enemy(whoknew, america).
% Part 1 rules
sells(west, X, nono):-missle(X), owns(nono, X).
hostile(X):- enemy(X, america).
weapon(X):-missle(X).
criminal(X):-american(X), weapon(Y), sells(X, Y, Z), hostile(Z).

% Just run criminal(west). to prove Colonel west is a criminal, and criminal(dave). to show that works also.

% Part 2 facts and rules

attacks(nono, america, whoknew).
ally(X):-attacks(X, america, Y), enemy(Y, america).
patriot(X):-sells(X, Y, Z), ally(Z).

% Just run patriot(west). to prove Colonel west is a patriot, and patriot(dave). to show that works also.

