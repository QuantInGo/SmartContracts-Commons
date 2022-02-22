// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract MappingStruct{
    address owner;
    constructor(){
        owner = msg.sender;
    }

    struct Payment{
        uint amount;
        uint timestamps;
    }

    struct Balance{
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    // Balance received from THAT address
    mapping(address => Balance) public balanceReceived; 

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function sendMoney() public payable{
        balanceReceived[msg.sender].totalBalance += msg.value;
        uint currentPayment = balanceReceived[msg.sender].numPayments;

        Payment memory payment = Payment(msg.value, block.timestamp);
        balanceReceived[msg.sender].payments[currentPayment] = payment;

        balanceReceived[msg.sender].numPayments++;
    }

    function withdrawSentBalance() public payable{ 
        require(balanceReceived[msg.sender].totalBalance > 0);
        uint balanceToWithdraw = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        payable(msg.sender).transfer(balanceToWithdraw);
    }

    function withdrawSomeMoney(address payable _to, uint _amount) public{
        require(balanceReceived[msg.sender].totalBalance > _amount);
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    /* =============================================================================================
        Contract Owner services 
       ============================================================================================= */

    function withdrawAllMoney(address payable _to) public{
        require(msg.sender == owner);
        _to.transfer(address(this).balance);
    }

}