// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Wallet {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function deposit() public payable{
        require(owner==msg.sender);
    }

    function transfer(address payable _to, uint _amount) public {
        require(tx.origin == owner, "Not owner");

        (bool sent, ) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    function balanceOf(address _address) public view returns(uint256) {
        return _address.balance;
    }
}