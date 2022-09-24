// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/* Simple bank contract
 * Users can deposit their eth
 * Users can withdraw their eth
 */
contract Bank {
    mapping (address => uint) balance;
    
    fallback() external payable {}
    receive() external payable {}
    
    function deposit(address _sender, uint _amount) public payable {
        require(_sender != address(0));
        balance[_sender] += _amount;
    }

    function withdraw(address _sender, uint _amount) public payable {
        require(_sender != address(0), "address 0");
        require(balance[_sender] != 0, "account empty");
        require(balance[_sender] >= _amount, "amount exceeds balance");
        balance[_sender] -= _amount;
        (bool sent, ) = _sender.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    
}
