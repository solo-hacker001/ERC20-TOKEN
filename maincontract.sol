// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import"./interface.sol";

contract ERC20 is IERC20 {

    string public name; //variable name of string type to hold the token’s name
    string public symbol; //variable symbol of string type to hold the token’s symbol
    uint public decimals; //variable decimals of unsigned integer type to hold the decimal value for the token division
    uint public override totalSupply; //variable totalSupply to hold the total supply of token

    mapping(address => uint) public override balanceOf; //variable balanceOf of type mapping to hold the token balance of each owner account
    mapping(address => mapping(address => uint)) public override allowance; //variable allowance of type mapping to hold addresses approved to withdraw from owner account and the withdrawal sum allowed

    // Initializing the constructor, setting name, symbol, decimals, and total supply value for the token. Declaring the total supply of the token to be equal to the owner’s balance for this token
    constructor() {
       name = "Tech4devToken";
       symbol = "T4D";
       decimals = 18;
       totalSupply = 10**6 * 10**18;
       balanceOf[msg.sender] = totalSupply;
    }    

    // function transfer which will execute the transfer of tokens from owner’s balance to recipient
    function transfer(address recipient, uint amount) external override returns(bool) {
        require(amount <= balanceOf[msg.sender]); //require that the transferring account has a sufficient balance to execute the transfer
        balanceOf[msg.sender] -= amount; //deduct inputed amount from the sender's balance
        balanceOf[recipient] += amount; //add inputed amount to recipient's balance
        emit Transfer(msg.sender, recipient, amount); //emit fires event Transfer on line 14 of interface.sol
        return true;    
    }

    //function approve lets an owner (msg.sender) to approve a spender address to withdraw tokens from his account and to transfer them to other accounts
    function approve(address spender, uint amount) external override returns(bool) {
        allowance[msg.sender][spender] = amount; //allows the owner's address to give an allowance to another address to be able to withdraw token from it
        emit Approval(msg.sender, spender, amount);//emit fires event Approval  on line 15 of interface.sol
        return true;
    }

    //function transferFrom allows a spender approved for withdrawal to transfer owner tokens to another account.
     function transferFrom(address sender, address recipient, uint amount) external override returns(bool) {
        require(amount <= balanceOf[sender]); //require that the owner has enough tokens to transfer 
        require(amount <= allowance[sender][msg.sender]); //require that the spender has approval for amount to withdraw.
        allowance[sender][msg.sender] -= amount; //subtracts amount from the spender’s allowance
        balanceOf[sender] -=amount; //deduct inputed amount from the sender's balance
        balanceOf[recipient] +=amount; //add inputed amount to recipient's balance
        emit Transfer(sender, recipient, amount); //emit fires event Approval  on line 14 of interface.sol
        return true;
    }

    //function mint creates more of an inputed amount of token 
    function mint(uint amount) public {
         balanceOf[msg.sender] += amount; //add the inputed amount to the owner's balance
         totalSupply += amount; //increase total supply by the amount inputed
         emit Transfer(address(0), msg.sender, amount); //emmit transfer, from address to the person calling the contract (msg.sender) and then the amount
     }

    //function burn decrease an inputed amount of token from totalSupply
     function burn(uint amount) public {
         balanceOf[msg.sender] -= amount; //subtract the inputed amount from the owner's balance
         totalSupply -= amount; //decrease total supply by the amount inputed
         emit Transfer(msg.sender, address(0), amount); //emmit fires event Transfer on line 14 of interface.sol
     }
}