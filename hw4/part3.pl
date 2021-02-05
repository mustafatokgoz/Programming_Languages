%facts
when(102,10).
when(108,12).
when(341,14).
when(455,16).
when(452,17).

where(102,z23).
where(108,z11).
where(341,z06).
where(455,207).
where(452,207).


enroll(a,102).
enroll(a,108).
enroll(b,108).
enroll(c,108).
enroll(d,341).
enroll(e,455).

%predicates
schedule(S,P,T) :- enroll(S,P), when(P,T), write('\n').

usage(P,T) :- where(X,P),when(X,T).

conflict(X,Y) :-(where(X,ClassroomX), where(Y,ClassroomY) , X \= Y , ClassroomX == ClassroomY),!  ;
                  (when(X,TimeX),when(Y,TimeY), X \= Y , TimeX == TimeY),! .

meet(X,Y) :- enroll(X,ClassX) , enroll(Y,ClassY) , where(ClassX,RoomX) ,where(ClassY,RoomY),
              when(ClassX,TimeX), when(ClassY,TimeY), ((RoomX==RoomY) , (TimeX==TimeY)).
