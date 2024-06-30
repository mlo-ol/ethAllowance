// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract StudentAllowance {
    mapping(address => uint256) public allowance;

    function setAllowance(address _student, uint256 _amount) public {
        allowance[_student] = _amount;
    }

    function spendAllowance(address _student, uint256 _spendAmount) public {
        require(_spendAmount > 0, "Spend amount must be greater than zero");
        require(_spendAmount <= allowance[_student], "Insufficient allowance");

        allowance[_student] -= _spendAmount;

        // Using assert to ensure remaining allowance is greater than or equal to zero
        assert(allowance[_student] >= 0);
    }

    function checkAllowance(address _student, uint256 _spendAmount) public view returns (bool) {
        // Using revert to handle insufficient allowance
        if (_spendAmount > allowance[_student]) {
            revert("Insufficient allowance to spend");
        }

        return true;
    }
}
