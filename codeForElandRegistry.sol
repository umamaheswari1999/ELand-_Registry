pragma solidity ^0.4.21;

contract Land {
    struct LandRecord{
        address  owner;
        uint  Price;
    }
    mapping (uint => LandRecord) public LandRecords;
    
    // event that notifies when a transfer has completed
    event Delivered (address from, address to, uint amount) ;
    
    function land(uint landId,uint _price) public payable{                    //constructor
        LandRecords[landId].owner = msg.sender;
        LandRecords[landId].Price = _price;             //the initial price is set by the 1st owner i.e. the creator of the contract
    }
    
    modifier IfOwner(uint landid){
        require (LandRecords[landid].owner == msg.sender);
        _;
    }
    


    function Transfer(uint landid,address receiver, uint amount) IfOwner(landid) public {//the owner will receive the amount offline and will update the contract
        require(LandRecords[landid].Price <= amount);           //if the amount is greater than or equal to the last price than proced 
        LandRecords[landid].owner = receiver;                   //new owner
        LandRecords[landid].Price = amount;                     //new amount
        Delivered(msg.sender, receiver, amount);                    //log entry
    }
}
