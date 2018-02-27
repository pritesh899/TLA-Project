----------------------------- MODULE Tautalogy -----------------------------

VARIABLES P, Q
F1(A, B) == A => B
F2(A, B) == B => A
F3(A, B) == A <=> B
FormulasEquivalent == F1(P, Q) /\ F2(P, Q) <=> F3(P, Q)

Init ==
    /\ P \in BOOLEAN
    /\ Q \in BOOLEAN
   

Next ==
    /\ P' \in BOOLEAN
    /\ Q' \in BOOLEAN


Spec ==
    Init /\ [][Next]_<<P, Q>>

=============================================================================

=============================================================================
\* Modification History
\* Last modified Mon Dec 04 12:37:43 EST 2017 by priteshratnappagol
\* Created Sat Dec 02 19:09:51 EST 2017 by priteshratnappagol
