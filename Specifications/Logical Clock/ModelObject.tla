---------------------------- MODULE ModelObject ----------------------------

EXTENDS Integers

VARIABLES clock, send, rcv

MOTypeOk == /\ clock \in Int
            /\ send \in Int
            /\ rcv \in Int
           
MOInit == /\ clock = 0
          /\ send = 0
          /\ rcv = 0

Internal == /\ clock' = clock + 1
            /\ UNCHANGED send
            /\ UNCHANGED rcv

Receive == /\ rcv' \in 0..99
           /\ clock' = clock + rcv' + 1
           /\ UNCHANGED send

Send == /\ clock' = clock + 1
        /\ send' \in -20..20
        /\ UNCHANGED rcv

Next == \/ Internal
        \/ Receive
        \/ Send

=============================================================================

