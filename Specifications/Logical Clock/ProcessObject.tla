--------------------------- MODULE ProcessObject ---------------------------

EXTENDS Integers

VARIABLE clock, recv, send, msg

POTypeOK == /\ clock \in Int
            /\ recv \in Int
            /\ send \in Int
            /\ msg \in {0, 1}

POInit == /\ clock = 0
          /\ recv = 0
          /\ send = 0
          /\ msg = 0

\* Increment the clock by one
Internal == /\ clock' = clock + 1
            /\ UNCHANGED recv
            /\ UNCHANGED send
            /\ UNCHANGED msg

\* Set send to the clock value
\* Increment clock
SendClock == /\ clock' = clock + 1
             /\ UNCHANGED recv
             /\ send' = clock
             /\ UNCHANGED msg

\* set msg to 1
RecieveMessage == /\ UNCHANGED clock
                  /\ UNCHANGED recv
                  /\ UNCHANGED send
                  /\ msg' = 1

\* Check if there's a message first!
\* Add recv to clock
\* set msg to 0
ProcessMessage == IF msg = 1
                    THEN /\ recv' \in -20..20
                         /\ clock' = clock + recv' + 1
                         /\ UNCHANGED send
                         /\ msg' = 0
                    ELSE /\ clock' = clock + 1
                         /\ UNCHANGED recv
                         /\ UNCHANGED send
                         /\ UNCHANGED msg
                         
Next == \/ Internal
        \/ SendClock
        \/ RecieveMessage
        \/ ProcessMessage

=============================================================================

