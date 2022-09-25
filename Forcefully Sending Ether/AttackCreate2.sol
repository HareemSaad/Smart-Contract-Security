// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract AttackCreate2 {

    event adr(Attack addresss);
    
    function deploy(uint _salt, VunerableContract _address) public {
        Attack attack = Attack(new Attack{salt: bytes32(_salt)}(_address));
        emit adr(attack);
    }


    function getBytecode(VunerableContract _address) public pure returns (bytes memory) {
        bytes memory bytecode = type(Attack).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_address));
    }

    function getAddress(bytes memory bytecode, uint _salt) public view returns (address) {
        bytes32 hash = keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode)));

        return address(uint160(uint(hash)));
    }

}
