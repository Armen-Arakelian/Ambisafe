pragma solidity ^0.4.0;
contract DepositHandling {

    struct Deposit {
        uint balance;
        bool lended;
        address host;
    }
   
    mapping(address => Deposit) public deposit;
    event Borrow(address receiver, uint amount);
    event Refund(address receiver, uint amount);
    
    
    function borrowMoney(uint amount, address _host) public {
        if(deposit[msg.sender].lended == true)
            revert();
        deposit[msg.sender].host = _host;
        deposit[msg.sender].balance += amount;
        if(amount > 0)
            deposit[msg.sender].lended = true;
        Borrow(msg.sender, amount);
    }
    
    function RefundMoney(uint amount, address receiver)public {
        if (deposit[receiver].lended == false)
            revert();
        if(amount > deposit[receiver].balance)
            revert();
        if(msg.sender != deposit[receiver].host)
            revert();
        deposit[receiver].balance -= amount;
        if(deposit[receiver].balance == 0)
            deposit[receiver].lended = false;
        Refund(receiver, amount);
    }
}