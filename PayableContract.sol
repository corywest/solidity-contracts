pragma solidity ^0.4.0;

contract PayableContract {
    address client;
    bool public _switch = false;

    event UpdateStatus(string _message);
    event UserStatus(string _message, address user, uint _amount);

    function PayableContract() {
        client = msg.sender;
    }

    modifier ifClient() {
        if(msg.sender != client) {
            throw;
        }
            _;

    }

    function depositFunds() payable {
        UserStatus("User has deposited some ether", msg.sender, msg.value);
    }

    function getBalance() ifClient constant returns (uint) {
        return this.balance;
    }

    function withdrawFunds(uint amount) ifClient {
        if(client.send(amount)) {
            UpdateStatus("User has withdrawn some ether");
            _switch = true;
        }
        _switch;
    }
}
