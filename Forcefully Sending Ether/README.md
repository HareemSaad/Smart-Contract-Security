# Forcefull Ether Sending

In this repository I have created ...
- A vunerable 7 ether game smart contract 
- A safe 7 ether game smart contract
- A contract forcefully sends ether

The Attack contract sends ether to the vunerable contract by using self destruct.

prevention: manually keep a count of the balance do not rely in address(this).balance

What happens in this Attack?

- Consider that vunerable contract has 6 ethers in it.

- Attack contract self destructs and forcefully sends 2 ethers to the vunerable contract shifting its balance from 6 to 8

- Since the deposit function is not called and the winner is not assigned the ethers are locked in the contract forver

