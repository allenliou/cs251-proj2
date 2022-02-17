// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Splitwise {

    struct Transaction {
        address debtor;
	    address creditor;
        uint32 amount;
    }

    event NewTransaction(address _debtor, address _creditor, uint _amount);

    Transaction[] public transactions; 

    function _addIOU(address _creditor, uint32 _amount) public {
        transactions.push(Transaction(msg.sender, _creditor, _amount));
        emit NewTransaction(msg.sender, _creditor, _amount);
    }

    function _lookup (address _creditor, address _debtor) public view {

    }
}