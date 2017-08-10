pragma solidity ^0.4.0;

contract Bank {
    address public owner;

    mapping(address => uint) balanceOf;

    function Bank() {
        owner = msg.sender;
    }

    function deposit() payable { }

    function withdrawl(address customer, uint amount) returns (bool response) {
        if(balanceOf[customer] < amount || amount == 0) {
            return false;
        }
        balanceOf[customer] -= msg.value;
        msg.sender.send(amount);
        return true;
    }

    function getBalance() constant returns (uint) {
        return this.balance;
    }

    function remove() {
        if(msg.sender == owner) {
            selfdestruct(owner);
        }
    }
}

contract FundManager {
    address owner;
    address bank;

    function FundManager() {
        owner = msg.sender;
        bank = new Bank();
    }

    function setBank(address newBank) returns (bool response) {
      if(msg.sender != owner) {
        return false;
      }
      bank = newBank;
      return true;
    }

    function deposit() returns (bool response) {
        if(msg.value == 0) {
            return false;
        }
        if(bank == 0x0) {
            return false;
        }
        bool success = Bank(bank).deposit();

        if(!success) {
            msg.sender.send(msg.value);
        }
        return success;
    }

    function withdraw(uint amount) returns (bool response) {
        if(bank == 0x0) {
            return false;
        }
        bool success = Bank(bank).withdraw(msg.sender, amount);
        if (success) {
            msg.sender.send(amount);
        }
        return success;
    }
}
