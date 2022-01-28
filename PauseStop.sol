// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract StartStopUpdate{
    address owner;
    bool paused;

    constructor() {
        owner = msg.sender;
    }

    function sendMoney() public payable{
        //...
    }

    function setPaused (bool _paused) public{
        require(msg.sender == owner, 'User must be the contract owner to be allowed to pause/unpause the contract.');
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to_address) public {
        require(msg.sender == owner, 'User must be the contract owner to be allowed withdrawal.');
        require(!paused, 'Contract is paused.');

        _to_address.transfer(address(this).balance);
    }

    function destroyContract(address payable _to) public{
        require(msg.sender == owner, 'User must be the contract owner to be allowed to do this.');
        selfdestruct(_to);
    }
}