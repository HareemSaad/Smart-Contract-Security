// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract ReentryVunerable {
    //this is a rinkeby faucet -> one user can use the faucet once
    //through this contract people can transfer rinkeby ETH to their account

    mapping (address => bool) canWithdraw;

    constructor() payable {
        (bool sent, bytes memory data) = address(this).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function withdraw() public payable{
        console.log("withdraw");
        require(canWithdraw[msg.sender] == false, "Cannot withdraw more than once");
        console.log("require");
        (bool sent, bytes memory data) = msg.sender.call{value: 1000000000000000000}("");
        console.log("call");
        require(sent, "Failed to send Ether");
        console.log("require call");
        canWithdraw[msg.sender] = true;
        console.log("update");
    }
}