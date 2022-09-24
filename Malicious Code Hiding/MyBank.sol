// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* Takes an instance of bank as input
 * If this contract takes the address of a fraud contract
 * This contract then excutes malicous code
 */
contract MyBank {
    Bank bank;

    constructor(Bank _bank) {
        bank = Bank(_bank);
    }

    fallback() external payable {}
    receive() external payable {}

    function deposit() public payable {
        bank.deposit(msg.sender, msg.value);
    }

    function withdraw(uint _amount) public payable {
        bank.withdraw(msg.sender, _amount);
    }
}
