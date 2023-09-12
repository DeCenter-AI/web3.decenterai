// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.9;

 import "./MultiSigWallet.sol";

contract Payment {
    MultiSigWallet  public wallet;
    mapping(address => uint) public depositRecord;

    event Deposit(address indexed payer, uint _amount, bool status);
    event Erase(address indexed user);

    function deposit(uint _amount) external payable{
        require(msg.value == _amount, "invalid deposit amount");
        (bool success, ) = address(wallet).call{value: msg.value}(""); 
        depositRecord[msg.sender] = msg.value;

        emit Deposit(msg.sender, _amount, success);
    }

    function zeroDepositRecord(address _user) external {
        depositRecord[_user] = 0;
        emit Erase(_user);
    }
}