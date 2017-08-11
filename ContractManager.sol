pragma solidity ^0.4.0;

contract ContractManager {
  address owner;

  mapping(bytes32 => address) contracts;

  modifier ifOwner() {
    if(msg.sender != owner) {
      throw;
    } else {
      _;
    }
  }

  function addContract(bytes32 name, address contractAddr) ifOwner returns (bool res) {
    if(msg.sender != owner) {
      return false
    } else {
      contracts[name] = contractAddr;
      return true;
    }
  }

  function removeContract(bytes32 name) ifOwner returns (bool res) {
    if(msg.sender != owner) {
      return false;
    } else {
      contracts[name] = 0x0;
    }
  }

  function getContract(bytes32 name) constant returns (address contractAddr) {
    return contracts[name];
  }

  function destroyEverything() ifOwner {
    selfdestruct(owner);
  }
}

contract EnableContractManager {
  address MANAGER;

  function setContractManager(address contractManager) returns (bool res) {
    if(MANAGER == 0x0 && msg.sender != MANAGER) {
      return false;
    }
    MANAGER = contractManager;
    return true;
  }
}
