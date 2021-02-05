
element(E,S):- member(E,S).


union_create([],[],[]).
union_create(L,[],L).
union_create(L, [H|T], [H|Output]):-
    not(member(H,L)), union_create(L,T,Output).
union_create(L, [H|T], Output):-
    member(H,L), union_create(L,T,Output).

union(S1,S2,S3):- union_create(S1,S2,X) , permutation(X,S3),! .


intersect_create([],_,[]).
intersect_create([X|L1],L2,[X|L3]):- member(X,L2), intersect_create(L1, L2, L3).
intersect_create([_|L1],L2,L3):- intersect_create(L1, L2, L3).

intersect(S1,S2,S3):- intersect_create(S1,S2,R) , permutation(R,S3), !.

equivalent(S1,S2):- permutation(S1,S2), !.
