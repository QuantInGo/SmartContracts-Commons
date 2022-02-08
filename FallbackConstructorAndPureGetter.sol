// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract FunctionsEx{

    mapping(address => uint) public balanceReceived;

    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function destroyContract() public{
        require(msg.sender == owner);
        selfdestruct(owner); // Disable contract and send residual funds to owner
    }

    function sendMoney() public payable{
        assert(balanceReceived[msg.sender] + msg.value>= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoneyTo(address payable _to, uint _amount) public{
        require(_amount <= balanceReceived[msg.sender], 'Not enough money to make transfer.');
        assert(balanceReceived[msg.sender] <= balanceReceived[msg.sender]-_amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    /* The new fallback function is called when no other function matches (if the receive
       ether function does not exist then this includes calls with empty call data).
       You can make this function payable or not. If it is not payable then transactions
       not matching any other function which send value will revert.  */
    fallback() external payable{
        sendMoney();
    } 

    /* If present, the receive ether function is called whenever the call data is empty 
       (whether or not ether is received). This function is implicitly payable. */
    receive() external payable{
    }
}
