// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;

contract SimpleMapping{
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function enableInt2BoolMapping(uint _index) public{
        myMapping[_index] = true;
    }

    function authAddress() public{
        myAddressMapping[msg.sender] = true;
    }

}