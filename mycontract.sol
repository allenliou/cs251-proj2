// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Splitwise {

    event NewTransaction(uint key, address _debtor, address _creditor, uint _amount);
    // Transaction[] public transactions; 
    mapping (uint => uint32) currentState;

    function _addIOU(address _creditor, uint32 _amount) public {
        uint key = uint(keccak256(abi.encodePacked(msg.sender, _creditor)));
        currentState[key] = _amount;
        emit NewTransaction(key, msg.sender, _creditor, currentState[key]);
    }

    function _lookup (address _creditor, address _debtor) public view returns (uint, uint) {
        ///this needs to be called multiple times by the client in order to get all relevant txs between parties
        uint key = uint(keccak256(abi.encodePacked(_debtor, _creditor)));
        return (uint(currentState[key]), uint(key));
    }
}
