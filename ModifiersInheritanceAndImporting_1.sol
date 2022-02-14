// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract OwnerPack{
    address owner;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, 'Not owner : not allowed to execute this action.');
        _;
    }
}

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

}
