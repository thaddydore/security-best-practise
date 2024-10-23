// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity ^0.8.17;

// lacks access control 
contract HelloWord {
   string public greeting = "Hello world";

   function setGreetings(string memory _greeting) public {
      greeting = _greeting;
   }
}

//  for safe mathematical operations
contract SafeMathExample {
   using SafeMath for uint256;

   uint256 public totalSupply;

   function addToken(uint256 _amount) public{
      totalSupply = totalSupply.add(_amount);
   }
}


// vulnerable Code for retrancy attack
contract VunerableBank {
   mapping(address => uint256) public balances;

   function withdraw(uint256 _amount) public {
      if (balances[msg.sender] >= _amount) {
         (bool sent, ) = msg.sender.call{value: _amount}("");
         require(sent, "Failed to send Ether");
         balances[msg.sender]  -= _amount;
      }
   }
}


// Secure  Code for retrancy attack     jason do some change here
contract SecureBank {
   mapping(address => uint256) public balances;

   function withdraw(uint256 _amount) public {
      require(balances[msg.sender] >= _amount, "Insufficient balance");
         balances[msg.sender]  -= _amount;
         (bool sent, ) = msg.sender.call{value: _amount}("");
         require(sent, "Failed to send Ether");
      
   }
}



// Proper Access Control
// vulnerable Coode

contract AccessControl {
   address public owner;

   function setOwner(address _owner) public {
      owner = _owner;
   }
}


// Secure Code 
contract AccessControl {
   address public owner;

   constructor() {
      owner = msg.sender;
   }


   modifier onlyOwner( ) {
      require(msg.sender == owner, "Not Authorize");
      _;
   }

   function setOwner(address _owner) public  onlyOwner {
      owner = _owner;
   }
}


// unsecure code
contract Visibility {
   uint256 counter;

   function increment() {
      counter += 1;
   }
}

// secure code 
contract Visibility {
   uint256 counter;

   function increment() public{
      counter += 1;
   }
}


contract EventLogger {
   event DataChange(address indexed _by, uint256 _value)

   uint256 public data;

   function setData(uint256 _data) public {
      data = _data;
      emit DataChange(msg.sender, _data);
   }
}











