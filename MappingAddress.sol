// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract MappingAddress{
    address owner;
    constructor(){
        owner = msg.sender;
    }

    // Balance received from THAT address
    mapping(address => uint) public balanceReceived; 

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawAllMoney(address payable _to) public{
        require(msg.sender == owner);
        _to.transfer(address(this).balance);
    }

    function withdrawSentBalance() public payable{
        require(balanceReceived[msg.sender]>0);
        uint balanceToWithdraw = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;
        payable(msg.sender).transfer(balanceToWithdraw);
    }

    function withdrawSomeMoney(address payable _to, uint _amount) public{
        require(balanceReceived[msg.sender] > _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}