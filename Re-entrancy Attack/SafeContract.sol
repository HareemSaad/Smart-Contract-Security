// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract ReentrySafe {
    //this is a rinkeby faucet -> one user can use the faucet once for 1 eth only
    //through this contract people can transfer rinkeby ETH to their account

    mapping (address => bool) canWithdraw;

    constructor() payable {
        (bool sent, bytes memory data) = address(this).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function safeWithdrawUsingEarlyMappingUpdate() public payable{
        require(canWithdraw[msg.sender] == false, "Cannot withdraw more than once");
        canWithdraw[msg.sender] = true;
        (bool sent, bytes memory data) = msg.sender.call{value: 1000000000000000000}("");
        require(sent, "Failed to send Ether");
    }

    modifier Safe() {
        bool isActive = true;
        require(isActive == false);
        _;
        isActive = false;
    }

    function safeWithdrawUsingModifier() public payable Safe() {
        require(canWithdraw[msg.sender] == false, "Cannot withdraw more than once");
        canWithdraw[msg.sender] = true;
        (bool sent, bytes memory data) = msg.sender.call{value: 1000000000000000000}("");
        require(sent, "Failed to send Ether");
    }
}
