pragma solidity ^0.4.0;

contract UserSystem {
    address public owner;

    function UserSystem() {
        owner = msg.sender;
    }

    modifier ifOwner() {
        if(msg.sender == owner) {
            throw;
        } else {
            _;
        }
    }

    function removeUser() {
        selfdestruct(owner);
    }
}

contract UserSystemFactory {
    function createUser() returns (address UserAddress) {
        return address(new UserSystem());
    }

    function removeUser(address UserAddress) {
        UserSystem(UserAddress).removeUser();
    }
}
