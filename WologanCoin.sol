pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT

contract WologanCoin {

    address public owner;
    mapping(address => uint) public gasBalances;

    struct People {
        uint256 PeopleId; // Kullanılması gerekebilir
        address Adress;
        uint256 salary;
        uint256 nextDistribution;
} 
    //stok eventi
    event stockUpdated(uint _gasBlance,address _owner);

    constructor() {
        owner = msg.sender;
        //başlangıçta 100000 ile sınırlıdır
        gasBalances[address(this)] = 100000;
    }

    //Miktar?
    function getStationGasBalance() public view returns(uint) {
        return gasBalances[address(this)];
    }
    
    //Güncelleme
    function restock(uint amount) checkSender() public {
        gasBalances[address(this)] += amount; 
        emit stockUpdated(gasBalances[address(this)], msg.sender);
    }

    
    function purchase(uint amount) checkGasBlance(amount) public payable{
        //1l=10ether
        require(msg.value >= amount * 1 ether,"adet icin 1 eth");
        gasBalances[address(this)] -= amount;
        gasBalances[msg.sender] += amount;
    }

    modifier checkSender() {
        require(msg.sender == owner, "sahibi icin gecerli");
        _;
    }
    modifier checkGasBlance(uint _amount) {
        require(gasBalances[address(this)] >= _amount, "yetersiz");
        _;
    }
} 