// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Splitwise {

    // struct AmountOwed {
    //     address debtor;
	//     address creditor;
    //     uint32 amount;
    // }

    event NewTransaction(string key, address _debtor, address _creditor, uint _amount);

    // Transaction[] public transactions; 
    mapping (string => uint32) currentState;

    function _addIOU(address _creditor, uint32 _amount) public {
        string memory key = string(abi.encodePacked(msg.sender, _creditor));
        currentState[key] = _amount;
        emit NewTransaction(key, msg.sender, _creditor, currentState[key]);
    }

    function _lookup (address _creditor, address _debtor) public view returns (uint) {
        string memory key = string(abi.encodePacked(_debtor, _creditor));
        return uint(currentState[key]);
    }
}