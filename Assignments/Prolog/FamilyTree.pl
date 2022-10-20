% Byron Dowling
% 5113 - A.P.L.C
% Program #2 - Prolog
% 	Write 10-20 facts and the four required rules plus 2 or more of my own.
%
%	Facts:
%		- 8 Male Facts
%		- 7 Female Facts
%		- 10 Father Facts
%		- 10 Mother Facts
%
%	Rules:
%		- child(x,Y)
%		- brother(X,Y)
%		- sister(X,Y)
%		- aunt(X,Y)
%		- uncle(X,Y)
%		- grandparent(X,Y)


% Male Facts
male(glynn).			% My late grandfather
male(max).				% My grandfather
male(bryan).			% My dad
male(phillip).			% My uncle
male(baxter).			% My brother
male(byron).			% Me, myself, and I
male(brock).			% My brother
male(tyler).			% My brother-in-law

% Female Facts
female(joanne).			% My late grandmother
female(gwen).			% My grandmother
female(glynda).			% My mom
female(tanna).			% My aunt
female(brynlee).		% My sister
female(elisha).			% My niece
female(eden).			% My niece

% Father Facts
father(glynn,glynda).
father(max,bryan).
father(max,tanna).
father(max,phillip).
father(bryan,byron).
father(bryan,baxter).
father(bryan,brock).
father(bryan,brynlee).
father(tyler,elisha).
father(tyler,eden).

% Mother Facts
mother(joanne,glynda).
mother(gwen,bryan).
mother(gwen,tanna).
mother(gwen,phillip).
mother(glynda,byron).
mother(glynda,baxter).
mother(glynda,brock).
mother(glynda,brynlee).
mother(brynlee,elisha).
mother(brynlee,eden).

% Child rule, essentially identifies who the child's parents are by doing an or
% on if the father or mother belong to the child or not.
%
% Sample: child(byron,X) should return: X = Bryan, X = Glynda
% indicating that I am a child to my parents Bryan and Glynda
%
child(X,Y):- father(Y,X); mother(Y,X).

% https://www.swi-prolog.org/pldoc/man?predicate=once/1 - using 'once' in Prolog
% Once keyword used since siblings could have the same mother and father and this would return
% a duplicate result.
% 
% If Y is a male or female respectfully, if X and Y share the same mother or they share the 
% same father, then they are brothers or sisters. This use of or, allows for half-siblings.
% Additionally the X\=Y means that X != Y so byron can't be byron's brother etc.
% 
% Sample: brother(X,byron) should return: X = Baxter, X = Brock
% indicating that Baxter and Brock are my brothers
% 
% Sample: sister(X,byron) should return: X = Brynlee
% indicating that Brynlee is my sister
%
brother(Y,X):- male(Y), once((father(Z,Y), father(Z,X); mother(Z,Y), mother(Z,X))), X\=Y.
sister(Y,X):- female(Y), once((father(Z,Y), father(Z,X); mother(Z,Y), mother(Z,X))), X\=Y.

% Aunt and uncle rules. 
% The rule essentially starts by confirming the genders of the aunt or uncle as female or male
% respectfully. Then we use do two or conditions where for uncle, the mother of X must be a
% sister to Y, or the father of X must be a brother to Y. Similar pattern for the aunt.
%
% Sample: aunt(X,byron) should return: X = tanna
% indicating that Tanna is my aunt
% 
% Sample: uncle(X,elisha), uncle(X,eden) should return: X = baxter, byron, brock
% indicating that us three brothers are the uncles to Eli and Eden 
%
uncle(Y,X):- male(Y), (mother(Z,X), sister(Z,Y); father(Z,X), brother(Z,Y)), X\=Y.
aunt(Y,X):- female(Y), (mother(Z,X), sister(Y,Z); father(Z,X), sister(Y,Z)), X\=Y.


% Grandparent rule
% If Z is a father to Y and then X is a father to Z, then X would be Y's grandfather.
% Likewise, this rule is also true if Z is a mother to Y and then X is a mother to Z.
% Additionally, this works when identifying the grandfather being the father to X's mother
% and the grandmother being the mother to X's father etc.
% 
% Sample: grandparent(X,eden), grandparent(X,elisha) should return: X = glynda, X = bryan
% indicating that my parents are the grandparents to my nieces Eden and Eli
%
grandparent(X,Y):-(father(Z,Y), father(X,Z));
                  (mother(Z,Y), mother(X,Z)); 
                  (mother(Z,Y), father(X,Z));
                  (father(Z,Y), mother(X,Z)).
