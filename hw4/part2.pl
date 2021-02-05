% knowledge base

flight(istanbul, antalya).
flight(antalya, istanbul).

flight(istanbul, izmir).
flight(izmir, istanbul).

flight(istanbul, ankara).
flight(ankara, istanbul).

flight(istanbul, gaziantep).
flight(gaziantep, istanbul).

flight(istanbul, rize).
flight(rize, istanbul).

flight(istanbul, van).
flight(van, istanbul).

flight(rize, van).
flight(van,rize).

flight(van, ankara).
flight(ankara,van).

flight(ankara, konya).
flight(konya, ankara).

flight(konya, antalya).
flight(antalya, konya).

flight(gaziantep, antalya).
flight(antalya, gaziantep).

flight(isparta, izmir).
flight(izmir, isparta).

flight(isparta, burdur).
flight(burdur,isparta).

flight(edirne, edremit).
flight(edremit, edirne).
flight(edremit, erzincan).
flight(erzincan,edremit).


distance(istanbul,izmir,328).
distance(istanbul,antalya,482).
distance(istanbul,gaziantep,847).
distance(istanbul,ankara,351).
distance(istanbul,rize,967).
distance(istanbul,van,1262).

distance(edirne,edremit,251).

distance(edremit,edirne,251).
distance(edremit,erzincan,992).

distance(erzincan,edremit,992).

distance(izmir,istanbul,328).
distance(izmir,isparta,308).

distance(isparta,izmir,308).
distance(isparta,burdur,24).

distance(burdur,isparta,24).

distance(antalya,istanbul,482).
distance(antalya,konya,192).
distance(antalya,gaziantep,592).


distance(konya,ankara,227).
distance(konya,antalya,192).

distance(gaziantep,istanbul,847).
distance(gaziantep,antalya,592).


distance(ankara,istanbul,351).
distance(ankara,konya,227).
distance(ankara,van,920).

distance(van,ankara,920).
distance(van,istanbul,1262).
distance(van,rize,373).

distance(rize,van,373).
distance(rize,istanbul,967).


% rules
sroute(Start,End,X) :-
       goTo(Start,End,[Start],_,X).

goTo(Start,End,Res,[End|Res],X) :-
       flight(Start,End),
       distance(Start,End,X), !.

goTo(Start,End,Passed,Road,X) :-
       flight(Start,A),
       End \== A,
       not(member(A,Passed)),
       distance(Start,A,D),
       goTo(A,End,[A|Passed],Road,D_2),
       X is D + D_2, !.
