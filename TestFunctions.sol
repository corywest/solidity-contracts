pragma solidity ^0.4.0;

contract TestContract {
    address public owner;
    bytes32[] array;

    function TestContract() {
        owner = msg.sender;
    }
    function equals() returns (bool) {
        bool a = true;
        bool b = false;
        return a == b;
    }

    function divide() returns (uint) {
        return 5/5;
    }

    function getBalance() constant returns (uint) {
        return this.balance;
    }

    function withdraw(uint amount) returns (uint) {
        if(owner.balance >= amount) {
            owner.send(amount);
            return this.balance;
        }
    }

    function getArraylength() constant returns (uint) {
        array.push(1);
        array.push(2);
        array.push(4);
        return array.length;
    }

    function getAddr() constant returns (address) {
        return owner;
    }

    function getString() constant returns(string) {
        return "Strings \n and stuff";
    }

    function depost() payable {

    }

    enum ActionChoices { GoRight, GoLeft, GoStraight, GoBack }
    ActionChoices choice;
    ActionChoices constant defaultChoice = ActionChoices.GoStraight;
    
    function getChoice() returns (ActionChoices) {
        return choice;
    }

    function getDefaultChoice() returns (uint) {
        return uint(defaultChoice);
    }
}

library Things {

}
