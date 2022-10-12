// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PiggyBank {
    bytes32 private _key = 0x8a43269e72a43ef4568900f5815e7b4cb112e35fa644d623914e63e3773e22f7;

    constructor() payable {}

    function withdraw(string memory key) public payable {
        if (keccak256(abi.encodePacked(msg.sender, key)) == _key) {
            (bool sent, bytes memory data) = msg.sender.call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
        }
    }

}
