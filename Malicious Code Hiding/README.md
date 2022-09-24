
# Malicious Code Hiding

In this repository I have created ...
- A Bank smart contract 
- A Malicous Bank smart contract (Build is same as Bank contract excpet the code within the function which is altered)
- A contract that hides the malicous code

The MyBank contract Poses to be the Bank contract but it actually contains an instance of the MaliciousBank contract. Hence it runs its faulty functions

So always verify the instances a smart contract contains aswell.

What happens in this scam?

- MaliciousBank copies the code of the bank contract and changes it function's code (in this example, in withdraw function instead of transferring funds to the rightful owner it transfers it to the wrong address)

- MyBank then instantiates and intance of the MaliciousBank contract so now it hides the malicious functions and the user in none the wiser.

Since the user doesn't verify the instance's contract the malicious function are exceuted resulting in stolen funds.
