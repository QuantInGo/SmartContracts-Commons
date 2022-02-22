// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ModifiersInheritanceAndImporting{
    
    mapping(address => uint) public tokenBalance;
    address owner;
    uint tokenPrice = 1 ether;

    constructor(){
        owner = msg.sender;
        tokenBalance[owner]= 100;
    }

    function createNewToken() public{
        require(msg.sender == owner, 'Not the owner : not allowed to create a token.');
        tokenBalance[owner]++;
    }

    function burnToken() public{
       require(msg.sender == owner, 'Not the owner : not allowed to burn tokens.');
       tokenBalance[owner]--;
    }

    function purchaseToken() public payable{
        require((tokenBalance[owner]*tokenPrice)/msg.value > 0, 'Not enough tokens.');
        tokenBalance[owner] -= msg.value/ tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

}
