// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Splitwise {

    struct Transaction { 
        uint transactionId;
        address debitor;
        address creditor;
        uint amount; ///ideally this should be a fixed point to account for decimals, but not sure how to implement atm. refactor?
    }

    event NewTransaction(uint transactionID, address _debtor, address _creditor, uint _amount); ///broadcast the creation of each tx

    mapping(uint => Transaction) transactions; /// map transactionID to Transaction object (struct) 
    uint public transactionCount = 0;

    function _addIOU(address _creditor, uint32 _amount) public { ///create a new Transaction and update the mapping
        transactionCount+=1;
        Transaction memory currentTransaction = Transaction({
            id: transactionCount,
            debtor:msg.sender,
            creditor:_creditor,
            amount: _amount,
        });
        transactions[transactionCount] = currentTransaction;
    }

    function _updateAmountOwed (uint _transactionID, uint32 _amount) public {
        transactions[_transactionID].value = _amount; ///edit the original transaction's value based on info passed from client
        (if transactions[_transactionID].value == 0) { /// if the new value is 0, remove the transaction from the mapping...
            delete trasactions[_transactionID] 
        }
    }
    }

    function _lookup (address _creditor, address _debtor) public view returns (uint, uint) {

    }
}
