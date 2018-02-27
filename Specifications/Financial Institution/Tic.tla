------------- MODULE Tic ----------------
EXTENDS Integers
CONSTANT TIC, FI
VARIABLES ticState, fiState, message, mState 
TICTypeOK == /\ fiState \in [FI ->{"Registered", "Sent",           "Received"}]
         /\ message \in {"encrypted", "decrypted"}
         /\ mState \in {"signed", "verified", "notVerified"} 
        
TICInit == /\ ticState = "init"
           /\ fiState = [ r \in FI |-> "Registered"]
           /\ message = "encrypted"
           /\ mState = "signed"

Receive(r) == \//\ fiState[r] = "Registered"
              /\ fiState' = [fiState EXCEPT ![r] = "Sent"]
              /\ UNCHANGED <<ticState>>
              /\ mState = "signed"
              /\ mState' = "verified"
              /\ message = "encrypted"
              /\ message' = "decrypted"
            
Send(r) == /\ ticState = "init"
           /\ ticState' = "ready"
           /\ fiState[r] = "Sent"
           /\ fiState' = [fiState EXCEPT ![r] = "Sent"]
           /\ message = "decrypted"
           /\ message' = "encrypted"
           /\ mState = "verified"
           /\ mState' = "signed"
          
          
TICNext == \E r \in TIC : Receive(r) \/ Send(r)
================================================
