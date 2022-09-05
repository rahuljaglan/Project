// SPDX-License-Identifier: MIT

// Farmer to Middleman

pragma solidity >=0.7.0 <0.9.0;


contract circularSupplyChain {

    address payable farmer;

    struct item {
        uint price;
        string desc;
        string email;
        uint phone;
        address middleman;
    }


    mapping(uint => item) public items;
    uint private counter = 0;

    modifier OnlyFarmer {
        require(msg.sender == farmer, "You are not the farmer");
        _;
    }

    modifier PaidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }


    constructor(){
        farmer = payable(msg.sender);
    }

    function add(uint _price, string memory _desc, string memory _email, uint _phone) public OnlyFarmer {
        items[counter] = item(_price, _desc, _email, _phone, address(0));
        counter ++;

    }

    function buy(uint _id) public payable PaidEnough(msg.value) {
        farmer.transfer(msg.value);
        items[_id].middleman = msg.sender;

    }


}