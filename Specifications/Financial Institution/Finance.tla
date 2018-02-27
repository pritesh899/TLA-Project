------------------------------- MODULE QUIZ6 -------------------------------
CONSTANT FI 
(***************************************************************************
message - it is the initial message that the FI wants to sent 
message - either encrypted or decrypted

fiState - This is the state of the FI, it has to register first, which is
Mentioned in the initial state
fiState - Sent(State of the FI changes to Sent,when a FI decides to send the
report)
fiState - Received, the state changes to Received from sent once the TIC
decides to send the received report from an FI

mState is the message State, Whether it has been signed by the FI or not

 ***************************************************************************)
VARIABLE fiState, message, mState
(***************************************************************************
Invariant to be checked
 ***************************************************************************)
TypeOK == /\ fiState \in [FI ->{"Register", "Sent", "Received"}]
          /\ message \in {"message", "encrypted", "decrypted"}
          /\ mState \in {"unsigned", "signed", "verified", "notVerified"} 
         

(***************************************************************************
This is the initial state of the system, all the FI's will register with 
The TIC before Communication, this registration is abstract, we are not
concerned with how it happens
 ***************************************************************************)    
TCInit == /\ fiState = [ r \in FI |-> "Register"]
          /\ message =  "message"
          /\ mState = "unsigned"  
(***************************************************************************
This is for the send event, once a FI wants to submit a report to the TIC, 
The State changes to Sent, Message will be encrypted and then Signed by the 
FI
 ***************************************************************************)
send(r) == /\ fiState[r] = "Register"
           /\ fiState' = [fiState EXCEPT ![r] = "Sent"]
           /\ message = "message"
           /\ message' = "encrypted"
           /\ mState = "unsigned"
           /\ mState' = "signed"
           
(***************************************************************************
During the receive, the FI needs to verify the message has been received from 
a legitimate TIC and then it decrypts the original message
The state of FI changes from sent to received.

 ***************************************************************************)                      
receive(r) == /\ fiState[r] = "sent"
              /\ fiState' = [fiState EXCEPT ![r] = "Received"]
              /\ mState = "notVerified"
              /\ mState' = "verified" 
              /\ message = "message"
              /\ message' = "decrypted"
              
(***************************************************************************
The next state that is to be decided between send or receive
 ***************************************************************************)              
TCNext == \E r \in FI : send(r) \/ receive(r)
           
           



=============================================================================

