//SPDX-License-Identifier:MIT
pragma solidity ^ 0.8.0;

contract dapp{

    string name;
    string email;
    uint contact;
    string college;
    address owner;
    
    constructor() {
        owner = msg.sender;
    }

    function set (string memory _name, string memory _email, uint256 _contact, string memory _college) public {
        name = _name;
        email = _email;
        contact = _contact;
        college = _college;

    }

    function retrieve () public view returns(string memory, string memory, uint256, string memory) {
        return (name, email, contact, college, owner);

    }

}