// SPDX-License-Identifier: MIT

// Middleman to Distributor

pragma solidity >=0.7.0 <0.9.0;


contract circularSupplyChain {

    address payable middleman;

    struct item {
        uint price;
        string desc;
        string email;
        uint phone;
        address distributor;
    }

    mapping(uint => item) public items;
    uint private counter = 0;

    modifier OnlyMiddleman {
        require(msg.sender == middleman, "You are not the Middleman");
        _;
    }


    modifier PaidEnough(uint _price) {
        require(msg.value >= _price);
        _;
    }


    constructor(){
        middleman = payable(msg.sender);
    }

    function add(uint _price, string memory _desc, string memory _email, uint _phone) public OnlyMiddleman {
        items[counter] = item(_price, _desc, _email, _phone, address(0));
        counter ++;

    }

    function buy(uint _id) public payable PaidEnough(msg.value) {
        middleman.transfer(msg.value);
        items[_id].distributor = msg.sender;

    }


}