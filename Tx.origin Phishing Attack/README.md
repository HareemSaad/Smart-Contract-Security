
In this repository I have created ...
- A vunerable smart contract 
- An attacker contract to attack it

The Attack is succesful because the vunerable contract uses tx.origin to verify the owner, which is a bad idea since a contract can also act on your behalf if you use it to verify access.

So always use msg.sender to verify access.

What happens in this function?

- Attacker **tricks** a person to transfering them some crypto

- User sends the attacker contract some eth / tokens hence triggering their fall back function

- The fallback function calls the attack() function

- The attack function then tranfers all their balance to themselves

Since the Transaction is originated from the victim's address it passes the check
