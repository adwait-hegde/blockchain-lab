// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 <0.9.0;

contract CreditLimit {
    //2019130019 - Adwait Hegde
    uint creditLimit;
    

    constructor() {
        creditLimit = 10000;
    }

    function getCreditLimit() public view returns(uint){
        return creditLimit;
    }

    function expenses(uint travel, uint food, uint stay) public {
        require( creditLimit - travel - food - stay >= 0, "Cannot proceess this txn..");
        creditLimit = creditLimit - travel - food - stay;
        //2019130019 - Adwait Hegde
    }

    function resetCreditLimit() public {
        creditLimit = 10000;
    }
}
