---------------------------- MODULE FinancialInstitution -------------------------
CONSTANT FI 
VARIABLE fiState, message, mState

TypeOK == /\ fiState \in [FI ->{"Register", "Sent", "Received"}]
         /\ message \in {"message", "encrypted", "decrypted"}
         /\ mState \in {"unsigned", "signed", "verified"} 
        
TCInit == /\ fiState = [ r \in FI |-> "Register"]
         /\ message =  "message"
         /\ mState = "unsigned"  

send(r) == /\ fiState[r] = "Register"
          /\ fiState' = [fiState EXCEPT ![r] = "Sent"]
          /\ message = "message"
          /\ message' = "encrypted"
          /\ mState = "unsigned"
          /\ mState' = "signed"
          
receive(r) == /\ fiState[r] = "Register"
             /\ fiState' = [fiState EXCEPT ![r] = "Received"]
             /\ mState = "signed"
             /\ mState' = "verified" 
             /\ message = "encrypted"
             /\ message' = "decrypted"
             
TCNext == \E r \in FI :  send(r) \/ receive(r) 
=================================================================
