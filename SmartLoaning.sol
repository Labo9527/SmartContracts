pragma solidity >=0.4.0 <0.7.0;

contract SmartLoaning{
    
    address CSP;
    address agent;
    uint gamma;
    uint V;
    uint startTime;
    uint time;
    uint bound;
    
    constructor(uint _gamma, uint _bound, uint _time) public{
        CSP = msg.sender;
        gamma = _gamma;
        time = _time;
        bound = _bound;
    }
    
    function register(uint _V) public payable{
        require(agent == address(0));
        require(msg.value >= bound);
        agent = msg.sender;
        V = _V;
    }
    
    function beginGame() public{
        require(CSP == msg.sender);
        require(agent != address(0));
        startTime = now;
    }
    
    function adjustV(uint _V) public{
        require(startTime != 0);
        V = _V;
    }
    
    function adjustGamma(uint _gamma) public{
        require(startTime != 0);
        gamma = _gamma;
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function endGame() public payable{
        require(startTime != 0);
        require(now > startTime + time);
        require(msg.sender==CSP || msg.sender == agent);
        if(msg.sender==CSP){
            msg.sender.transfer(gamma*V);
        }
        else{
            msg.sender.transfer(address(this).balance-gamma*V);
        }
    }
    
}
