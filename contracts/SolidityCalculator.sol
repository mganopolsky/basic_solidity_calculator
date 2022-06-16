//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

/**
    @notice This is a calculator that will be able to :
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

    event TotalTxnCount(uint _count);
    event AdditionTxnCount(uint _count);
    event SubtractionTxnCount(uint _count);
    event MultiplicationTxnCount(uint _count);
    event DivisionTxnCount(uint _count);
    event ModuloTxnCount(uint _count);
    event PowerTxnCount(uint _count);
    event CalculationResult(uint _result);

    // types of calculations that will be performed
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

    function getAddCount() public view returns(uint) {
        return calculationHistory[additionName];
    }

    function getSubtractionCount() public view returns(uint) {
        return calculationHistory[subtractionName];
    }

    function getDivisionCount() public view returns(uint) {
        return calculationHistory[divisionName];
    }

    function getMultiplicationCount() public view returns(uint) {
        return calculationHistory[multiplicationName];
    }

    function getModuloCount() public view returns(uint) {
        return calculationHistory[moduloName];
    }

    function getPowerOfCount() public view returns(uint) {
        return calculationHistory[powerOfName];
    }

    function getTotalCalculationCount() public view returns(uint) {
        return totalCalcCount;
    }
}