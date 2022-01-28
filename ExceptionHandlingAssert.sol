// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract ExceptionHandling{
    mapping(address => uint64) public balanceReceived;

    function sendMoney() public payable{
        assert(balanceReceived[msg.sender] + uint64(msg.value) >= balanceReceived[msg.sender]);

        balanceReceived[msg.sender] += uint64(msg.value);
    }

    function withdrawSomeMoney(address payable _to, uint64 _amount) public{
        require(_amount <= balanceReceived[msg.sender], 'Not enough funds to do it.');
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);

        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}