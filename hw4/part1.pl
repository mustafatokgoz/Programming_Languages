%knowledge base

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


%rules


check(Start ,End, Passed) :- flight(Start,A) ,not(member(A, Passed)),
                                                  (End=A ; check(A,End,[Start|Passed])).

route(Start,End) :- check(Start,End,[]).
