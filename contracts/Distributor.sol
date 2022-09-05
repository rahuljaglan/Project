// SPDX-License-Identifier: MIT

// Distributor to Consumer

pragma solidity >=0.7.0 <0.9.0;


contract circularSupplyChain {

    address payable distributor;

    struct item {
        uint price;
        string desc;
        string email;
        uint phone;
        address consumer;
    }

    mapping(uint => item) public items;
    uint private counter = 0;


    modifier OnlyDistributor {
        require(msg.sender == distributor, "You are not the distributor");
        _;
    }


    modifier PaidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }


    constructor(){
        distributor = payable(msg.sender);
    }

    function add(uint _price, string memory _desc, string memory _email, uint _phone) public OnlyDistributor {
        items[counter] = item(_price, _desc, _email, _phone, address(0));
        counter ++;

    }

    function buy(uint _id) public payable PaidEnough(msg.value) {
        distributor.transfer(msg.value);
        items[_id].consumer = msg.sender;

    }


}