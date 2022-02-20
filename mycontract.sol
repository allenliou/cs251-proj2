// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Splitwise {

    struct Transaction { 
        uint transactionId;
        address debtor;
        address creditor;
        uint amount; ///ideally this should be a fixed point to account for decimals, but not sure how to implement atm. refactor?
    }

    event NewTransaction(uint transactionID, address _debtor, address _creditor, uint _amount); ///broadcast the creation of each tx

    mapping(uint => Transaction) public transactions; /// map transactionID to Transaction object (struct) 
    uint public transactionCount = 0; // initialize a transactionCount of 0

    function _addIOU(address _creditor, uint32 _amount) public { ///create a new Transaction and update the mapping
        require(_creditor == address(_creditor)); //check if _creditor is valid
        transactionCount+=1;
        transactions[transactionCount] = Transaction({
            transactionId: transactionCount,
            debtor:msg.sender,
            creditor:_creditor,
            amount: _amount
        });
        emit NewTransaction(transactionCount, msg.sender, _creditor, _amount);
    }

    function _updateAmountOwed (uint32 _transactionId, uint32 _amount) public {
        transactions[_transactionId].value = _amount; ///edit the original transaction's value based on info passed from client
        if(transactions[_transactionId].value == 0) { /// if the new value is 0, remove the transaction from the mapping...
            delete transactions[_transactionId];
        }
    }

    function _getTransactionsOfInterest (address _creditor, address _debtor) public view {
        uint32[] memory transactionsOfInterest;
        for (uint i = 0; i<transactions.length; i++) {
            if (transactions[i].debtor == _debtor || transactions[i].creditor == _creditor) { 
                transactionsOfInterest.push(transactions[i].transactionID);
            }
        }
        if (transactionsOfInterest.length == 0) {
            return 0;
        }
        else {
            return transactionsOfInterest; ///need to return a set here, but not yet sure how to implement
        }
    }
}