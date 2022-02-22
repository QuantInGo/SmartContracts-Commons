// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.12;

contract Owner{
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier requireOwner(){
        require(msg.sender == owner, 'Owner permission for execution failed.');
        _;
    }
}