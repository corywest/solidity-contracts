pragma solidity ^0.4.0;

contract Bank {
  address owner;
  mapping(address => uint) balanceOf;

  function Bank() {
    owner = msg.sender;
  }

  modifier ifBankOwner() {
    if(msg.sender != owner) {
      throw;
    } else {
      _;
    }
  }

  function setBankOwner(address newOwner) returns (bool res) {
    if(owner != 0x0 || msg.sender != owner) {
      return false;
    } else {
      owner = newOwner;
      return true;
    }
  }

  function deposit(address customer) returns (bool res){
    if(msg.sender != owner) {
      return false;
    } else {
      balanceOf[customer] += msg.value;
      return true;
    }
  }

  function withdraw(address customer, uint _amount) returns (bool response) {
    if(_amount >= balanceOf[customer] || amount == 0) {
      return false;
    } else {
      msg.sender.send(amount);
      return true;
    }
  }

  function getBankBalance() constant ifBankOwner returns (uint) {
    return this.balance;
  }

  function destroyBank() {
    if(msg.sender == owner) {
      selfdestruct(owner);
    }
  }
}

contract FundManager {
  address owner;
  address bank;
  mapping (address => uint) permissions;

  event LogNotEnoughFunds(string _message);

  function FundManager() {
    owner = msg.sender;
    bank = new Bank();
    Bank(bank).setOwner(address(this));
  }

  function setBank(address newBank) returns (bool) {
    if(msg.sender != owner) {
      return false;
    } else {
      newBank = bank;
    }
  }

  function setPermission(address user, uint permissions) constant returns (bool res) {
    if (msg.sender != owner){
        return false;
    }
    permissions[user] = permissions;
    return true;
}

  function deposit(address customer, uint amount) returns (bool) {
    if(msg.value == 0) {
      return false;
    }
    if(bank == 0x0) {
      return false;
    }

    if(permissions[customer] != 1) {
      return false;
    }
    
    bool success = Bank(bank).deposit();

    if(!success) {
      msg.sender.send(msg.value);
    }
    return success;
  }

  function withdraw(address customer, uint amount) returns (bool) {
    if(amount == 0) {
      return false;
    }

    if(bank == 0x0) {
      return false;
    }

    if(permissions[customer] != 1) {
      return false;
    }

    if(amount >= balanceOf[msg.sender]) {
      LogNotEnoughFunds("You do not have enough to withdraw");
      return false;
    }
    bool success = Bank(bank).withdraw(msg.sender, amount);

    if(!success) {
      msg.sender.send(msg.value);
      return false;
    }
    return success;
  }

  function destroy(address bankAddr) returns (bool res){
    if(msg.sender != owner) {
      return false;
    } else {
      Bank(bankAddr).remove();
      return true;
    }
  }

  modifier ifFundOwner() {
    if(msg.sender != owner) {
      throw;
    } else {
      _;
    }
  }
}
