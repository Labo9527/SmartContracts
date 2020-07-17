pragma solidity >=0.4.0 <0.7.0;

contract SmartTrading{
    address agent;
    uint bound;
    uint isEnd;
    mapping(address => uint) prices;
    mapping(address => uint) demands;
    address[] addresses;
    uint number;
    uint count;
    
    constructor(uint _bound, uint _number) public{
        agent = msg.sender;
        bound = _bound;
        number = _number;
        addresses = new address[](number);
    }
    
    function register() public payable{
        require(count<number);
        require(msg.value>=bound);
        for(uint i=0;i<count;i++){
            if(msg.sender==addresses[i]){
                return;
            }
        }
        addresses[count] = msg.sender;
        count = count + 1;
    }
    
    function setPrice(uint _price, uint _index) public{
        require(isEnd==0);
        require(msg.sender == agent);
        prices[addresses[_index]]=_price;
    }
    
    function setDemand(uint _demand) public{
        require(isEnd==0);
        for(uint i=0;i<number;i++){
            if(msg.sender==addresses[i]){
                demands[msg.sender]=_demand;
            }
        }
    }
    
    function endTranding() public{
        isEnd = 1;
        if (msg.sender == agent){
            for(uint i=0;i<number;i++){
                msg.sender.transfer(prices[addresses[i]]*demands[addresses[i]]);
                
            }
        }
        else{
            for(uint j=0;j<number;j++){
                if(msg.sender==addresses[j]){
                    msg.sender.transfer(bound-prices[addresses[j]]*demands[addresses[j]]);
                }
            }
        }
    }
    
}
