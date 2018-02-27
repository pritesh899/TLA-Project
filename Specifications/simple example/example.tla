------------------------------ MODULE example ------------------------------
EXTENDS Integers

(* --algorithm example
variables x \in 1..100
begin
 Multiply:
  x := x * 2; 
end algorithm; *)

\* BEGIN TRANSLATION
VARIABLES x, pc

vars == << x, pc >>

Init == (* Global variables *)
        /\ x \in 1..100
        /\ pc = "Multiply"

Multiply == /\ pc = "Multiply"
            /\ x' = x * 2
            /\ pc' = "Done"

Next == Multiply
           \/ (* Disjunct to prevent deadlock on termination *)
              (pc = "Done" /\ UNCHANGED vars)

Spec == Init /\ [][Next]_vars

Termination == <>(pc = "Done")

\* END TRANSLATION

=============================================================================
\* Modification History
\* Last modified Mon Dec 04 13:43:56 EST 2017 by priteshratnappagol
\* Created Sat Dec 02 11:32:43 EST 2017 by priteshratnappagol
