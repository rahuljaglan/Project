// SPDX-License-Identifier: MIT

// Consumer to Farmer

pragma solidity >=0.7.0 <0.9.0;


contract circularSupplyChain {

    address payable consumer;

    struct item {
        uint price;
        string desc;
        string email;
        uint phone;
        address farmer;
    }

    mapping(uint => item) public items;
    uint private counter = 0;


    modifier OnlyConsumer {
        require(msg.sender == consumer, "You are not the consumer");
        _;
    }

    modifier PaidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }



    constructor(){
        consumer = payable(msg.sender);
    }

    function add(uint _price, string memory _desc, string memory _email, uint _phone) public OnlyConsumer {
        items[counter] = item(_price, _desc, _email, _phone, address(0));
        counter ++;

    }

    function buy(uint _id) public payable PaidEnough(msg.value) {
        consumer.transfer(msg.value);
        items[_id].farmer = msg.sender;

    }


}