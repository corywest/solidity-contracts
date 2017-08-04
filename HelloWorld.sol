pragma solidity ^0.4.0;

contract HelloWorldContract {
    string word = "Hello world!";
    address public owner;

    function HelloWorldContract() {
        owner = msg.sender;
    }

    modifier ifOwner() {
        if(owner != msg.sender) {
            revert();
        }
        else {
            _;
        }
    }

    function getWord() constant returns (string) {
        return word;
    }

    function setWord(string newWord) ifOwner returns (string) {
        word = newWord;
        return word;
    }
}
