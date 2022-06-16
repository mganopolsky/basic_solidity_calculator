//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

/**
    @title SolidityCalculator
    @author Marina Ganopolsky, @mganopolsky
    @notice This is a solidity calculator that will be able to :
        * add
        * subtract
        * multiple
        * divide 
        * raise numbers to powers
        * take Modulus of numbers

    The parameters will be UINTS only

    The contract will also keep a mapping of how many times each calculation has been performed
 */
contract SolidityCalculator {
    
    // mapping that will store the count of how many times this has been performed per calc type
    mapping (string => uint) calculationHistory;

    uint totalCalcCount = 0;

    // Events that will be emited when calculations are performed 
    // to update calculation counts
    event TotalTxnCount(uint _count);
    event AdditionTxnCount(uint _count);
    event SubtractionTxnCount(uint _count);
    event MultiplicationTxnCount(uint _count);
    event DivisionTxnCount(uint _count);
    event ModuloTxnCount(uint _count);
    event PowerTxnCount(uint _count);
    event CalculationResult(uint _result);

    // types of calculations that will be performed
    // these will be used as the keys to the calculationHistory mapping
    string public constant additionName = "add";
    string public constant subtractionName = "subtraction";
    string public constant divisionName = "division";
    string public constant multiplicationName = "multiplication";
    string public constant moduloName = "modulo";
    string public constant powerOfName = "powerOf";

    constructor() {
        // initialization of the mapping counts
        calculationHistory[additionName] = 0;
        calculationHistory[subtractionName] = 0;
        calculationHistory[divisionName] = 0;
        calculationHistory[multiplicationName] = 0;
        calculationHistory[moduloName] = 0;
        calculationHistory[powerOfName] = 0;
    }

    /**
    Addition function
    @param _param1 - the number the function will be adding to _param2
    @param _param2 - the number the function will be adding to _param1
    @return uint
     */
    function add(uint _param1, uint _param2) public returns(uint) {
        // increase the addition calculation count
        calculationHistory[additionName] ++;
        // emit updated count
        emit AdditionTxnCount(calculationHistory[additionName]);
        // increate the total txn count
        totalCalcCount ++;
        // emit updated count
        emit TotalTxnCount(totalCalcCount);

        uint result = _param1 + _param2;

        // emit the result of the calculation
        emit CalculationResult(result);

        return result;
    }

    /**
    Subtraction function
    @param _param1 - the number the function will be subtracting from
    @param _param2 - the number the function will be subtracting from _param1
    @return uint
     */
    function subtract(uint _param1, uint _param2) public returns(uint) {
        // since we're dealing with unsigned ints, we should throw an error 
        //here if param2 is larger then param1
        require (_param1 >= _param2, "Cannot subtract uints to result in negative numbers");
        // increase the calculation count
        calculationHistory[subtractionName] ++;
        
        // emit updated count
        emit SubtractionTxnCount(calculationHistory[subtractionName]);
        // increate the total txn count
        totalCalcCount ++;
        // emit updated count
        emit TotalTxnCount(totalCalcCount);

        uint result = _param1 - _param2;

        // emit the result of the calculation
        emit CalculationResult(result);

        return result;
    }

    /**
    Multiplication function
    @param _param1 - the first number the function will be multiplying 
    @param _param2 - the second number the function will be multiplying by _param1
    @return uint
     */
    function multiply(uint _param1, uint _param2) public returns(uint) {
        // increase the calculation count
        calculationHistory[multiplicationName] ++;
        // emit updated count
        emit MultiplicationTxnCount(calculationHistory[multiplicationName]);
        // increate the total txn count
        totalCalcCount ++;
        // emit updated count
        emit TotalTxnCount(totalCalcCount);

        uint result = _param1 * _param2;
        // emit the result of the calculation
        emit CalculationResult(result);
        return result;
    }

    /**
    Division function
    @param _param1 - numerator
    @param _param2 - denominator
    @return unit the result of the division
     */
    function divide(uint _param1, uint _param2) public returns(uint) {
        //since we can't divide by a 0, have to check for this
        require(_param2 != 0, "Can't Divide by 0!");
        // increase the calculation count
        calculationHistory[divisionName] ++;
        // emit updated count
        emit DivisionTxnCount(calculationHistory[divisionName]);
        // increate the total txn count
        totalCalcCount ++;
        // emit updated count
        emit TotalTxnCount(totalCalcCount);
        uint result = _param1 / _param2;
        // emit the result of the calculation
        emit CalculationResult(result);
        return result;
    }

    /**
    Raising to a pwer function
    @param _number - base number
    @param _power - the power the base number is being raised to
    @return unit the result of the calculation
     */
    function raiseToThePower(uint _number, uint _power) public  returns(uint) {
        // increase the calculation count
        calculationHistory[powerOfName] ++;
        // emit updated count
        emit PowerTxnCount(calculationHistory[powerOfName]);
        // increate the total txn count
        totalCalcCount ++;
        // emit updated count
        emit TotalTxnCount(totalCalcCount);

        uint result = _number ^ _power;
        // emit the result of the calculation
        emit CalculationResult(result);
        return result;
    }

    /**
    Modulus function
    @param _param1 - the original number
    @param _param2 - the modulus 
    @return unit the result of the calculation
     */
    function modulo(uint _param1, uint _param2) public returns(uint) {
        // increase the calculation count
        calculationHistory[moduloName] ++;
        // emit updated count
        emit ModuloTxnCount(calculationHistory[moduloName]);
        // increate the total txn count
        totalCalcCount ++;
        // emit updated count
        emit TotalTxnCount(totalCalcCount);

        uint result = _param1 % _param2;
        // emit the result of the calculation
        emit CalculationResult(result);
        return result;
    }

    /**
     @return  uint the count of addition transactions
     */
    function getAddCount() public view returns(uint) {
        return calculationHistory[additionName];
    }

    /**
     @return  uint the count of subtraction transactions
     */
    function getSubtractionCount() public view returns(uint) {
        return calculationHistory[subtractionName];
    }

    /**
     @return  uint the count of division transactions
     */
    function getDivisionCount() public view returns(uint) {
        return calculationHistory[divisionName];
    }

    /**
     @return  uint the count of multiplication transactions
     */
    function getMultiplicationCount() public view returns(uint) {
        return calculationHistory[multiplicationName];
    }

    /**
     @return  uint the count of modulo transactions
     */
    function getModuloCount() public view returns(uint) {
        return calculationHistory[moduloName];
    }

    /**
     @return  uint the count of power-to transactions
     */
    function getPowerOfCount() public view returns(uint) {
        return calculationHistory[powerOfName];
    }

    // returns the total transaction count
    function getTotalCalculationCount() public view returns(uint) {
        return totalCalcCount;
    }
}