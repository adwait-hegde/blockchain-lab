// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    //2019130019 - Adwait Hegde
    mapping (address=>uint) private customer;
    address public manager;
    uint private minimumBalance;
    uint private noOfCustomers;
    
    constructor() {
        minimumBalance = 100 wei;
        manager = msg.sender;
    }
    
    modifier onlyManager(){
        require (msg.sender==manager, "Only manager can access this function..");
        _;
    }

    function deposit() public payable{
        require(msg.value >= minimumBalance, "Minimum Balance condition did not met..!");

        if (customer[msg.sender]==0){
            noOfCustomers++;
        }
        customer[msg.sender] += msg.value;
    }

    function checkBankBalance() public view onlyManager returns(uint){
        return address(this).balance;
    }

    function checkActiveCustomers() public view onlyManager returns(uint){
        return noOfCustomers;
    }

    function checkBalance() public view returns(uint){
        return customer[msg.sender];
    }

    function transfer(address _recipient, uint money) public{
        require(customer[msg.sender] - money >= minimumBalance, "Minimum Balance condition did not met..!");
        address payable recipient = payable(_recipient); 
        recipient.transfer(money);
        customer[msg.sender] -= money;
    }

    function deleteAccount() public{
        require(customer[msg.sender] > 0, "No account found..!");
        address payable recipient = payable(msg.sender);
        uint money = customer[msg.sender];
        recipient.transfer(money);
        customer[msg.sender] -= money;
        noOfCustomers -= 1;
    }
}