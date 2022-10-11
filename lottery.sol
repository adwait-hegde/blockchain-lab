// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 <0.9.0;

//2019130019 - Adwait Hegde
contract Lottery {
    address public manager;
    address payable[] public participants;

    constructor() {
        manager = msg.sender;
    }

    modifier onlyOwner(){
        require (msg.sender == manager, "Only manager can access this function..");
        _;
    }

    receive() external payable{
        require (msg.value == 1 ether, "Invalid amount, send 1 ether only..");
        participants.push(payable(msg.sender));
    }

    function getBalance() public onlyOwner view returns(uint){
        return address(this).balance;

    }

    function random() public view returns(uint){
        return uint( keccak256( abi.encodePacked( block.timestamp, block.difficulty, participants.length) ) );
    }

    function selectWinner() public onlyOwner returns (address){
        require( participants.length >= 3, "Less than 3 participants.. Let other join");
        address payable winner;
        uint r = random();
        uint index = r % participants.length;
        winner = participants[index];
        winner.transfer(getBalance());
        participants = new address payable[](0);
        return winner;
    }

}