// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//ERC20 Token Standard Interface
interface IERC20 {
    function totalSupply() external view returns(uint); //total number of token
    function balanceOf(address account) external view returns(uint); //the balance of the given account
    function transfer(address recipient, uint amount) external returns(bool); //takes address and amount you are transfering
    function allowance(address owner, address spender) external view returns(uint); //the owner of the wallet is allowing another person to be able to spend from the wallet
    function approve(address spender, uint amount) external returns(bool); //the amount the owner of the wallet is approving for another person to spend from the wallet
    function transferFrom(address sender, address recipient, uint amount) external returns(bool); //transfers the amount from an owner's account to the reciever's account that has been previously approved by the owner

    //Events: these events will be emmitted when a user is granted rights to withdraw tokens from this account and after the tokens are transferred.
    event Transfer(address indexed from, address indexed to, uint amount); // The indexed parameters for logged events will allow you to search for these events using the indexed parameters as filters. Only relevant to logged events.
    event Approval(address indexed owner, address indexed spender, uint amount);
}