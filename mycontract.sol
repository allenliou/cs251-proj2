// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Splitwise {

    struct currState { 
        uint currStateId;
        address debtor;
        address creditor;
        uint amount; ///ideally this should be a fixed point to account for decimals, but not sure how to implement atm. refactor?
    }

    mapping(uint => currState) private currStates; /// map currStateId to currState object (struct) 
    uint private currStateCount = 0; // initialize a currStateCount of 0


    event NewCurrentStateAdded(uint CurrentStateID, address _debtor, address _creditor, uint _amount); ///broadcast the creation of each tx
    event CurrentStateUpdated(uint CurrentStateID, address _debtor, address _creditor, uint _amount); 

    function _addIOU(address _creditor, uint32 _amount) public { ///create a new Transaction and update the mapping
        require(_creditor == address(_creditor)); //check if _creditor is valid

        //if currState does exist between debtor(msg.sender) and creditor, update amount, else add new currState.
        uint key = _getCurrStateId(msg.sender, _creditor); 
        if (key > 0 ){
            currStates[key].amount += _amount;
            emit CurrentStateUpdated(key, msg.sender, _creditor, currStates[key].amount);
        } 
        else {
            currStateCount+=1;
            currStates[currStateCount] = currState({
                currStateId: currStateCount,
                debtor:msg.sender,
                creditor:_creditor,
                amount: _amount
             });
             emit NewCurrentStateAdded(currStateCount, msg.sender, _creditor, _amount);
        }
    }

    function _getCurrStateId(address _debtor, address _creditor) private view returns (uint a) {

        for (uint i = 1; i <= currStateCount; i++) {
            if (currStates[i].debtor == _debtor && currStates[i].creditor == _creditor) { 
                return i; 
            }
        }
        return 0; 
    }    
}