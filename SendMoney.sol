// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.7.6;

contract SendMoney {

    uint public balanceReceived; 

    function receiveMoney() public payable {
        balanceReceived = msg.value;
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable addressToSend = msg.sender;

        addressToSend.transfer(address(this).balance);

    }
}
