// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import './OwnerPack.sol';
contract ModifiersInheritanceAndImporting is OwnerPack{
    
    mapping(address => uint) public tokenBalance;
    uint tokenPrice = 1 ether;

    constructor(){
        tokenBalance[owner]= 100;
    }

    function createNewToken() public onlyOwner{
        tokenBalance[owner]++;
    }

    function burnToken() public onlyOwner{
       tokenBalance[owner]--;
    }

    function purchaseToken() public payable{
        require((tokenBalance[owner]*tokenPrice)/msg.value > 0, 'Not enough tokens.');
        tokenBalance[owner] -= msg.value/ tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

}i
