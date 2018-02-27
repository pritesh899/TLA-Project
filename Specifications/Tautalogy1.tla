----------------------------- MODULE Tautalogy1 -----------------------------
VARIABLES P, Q, R

F1(A, B, C) == (A <=> (B <=> C))
F2(A, B, C) == ((A <=> B) <=> C)
FormulaEquivalent == F1(P, Q ,R) <=> F2(P, Q, R)

Init ==
    /\ P \in {TRUE, FALSE}
    /\ Q \in {TRUE, FALSE}
    /\ R \in {TRUE, FALSE}

Next ==
    /\ P' \in {TRUE, FALSE}
    /\ Q' \in {TRUE, FALSE}
    /\ R' \in {TRUE, FALSE}

Spec ==
    Init /\ [][Next]_<<P, Q, R>>
    
=============================================================================
\* Modification History
\* Last modified Wed Dec 13 13:09:52 EST 2017 by priteshratnappagol
\* Created Sun Dec 03 17:07:57 EST 2017 by priteshratnappagol
