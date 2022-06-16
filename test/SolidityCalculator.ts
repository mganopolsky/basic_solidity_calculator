import {ethers, waffle} from 'hardhat';

import _ from "@nomiclabs/hardhat-waffle";

import chai from 'chai';

import SolidityCalculatorArtifact from '../artifacts/contracts/SolidityCalculator.sol/SolidityCalculator.json';
import {SolidityCalculator} from '../typechain/SolidityCalculator';
import {SignerWithAddress} from '@nomiclabs/hardhat-ethers/signers';

const {deployContract} = waffle;
const {expect} = chai;

describe('SolidityCalculator Contract', () => {
  let owner: SignerWithAddress;
  
  let calc: SolidityCalculator;

  let transactionCounter = 0;
  let additionCounter = 0;
  let subCounter = 0;
  let multCounter = 0;
  let divisionCounter = 0;
  let powerCounter = 0;
  let moduloCounter = 0;

  beforeEach( async () => {
    transactionCounter = 0;
    additionCounter = 0;
    subCounter = 0;
    multCounter = 0;
    powerCounter = 0;
    moduloCounter = 0;
    divisionCounter = 0;
    [owner] = await ethers.getSigners();
    calc = (await deployContract(owner, SolidityCalculatorArtifact)) as SolidityCalculator;
    
    //1. Setup, just call the name of your contract (contract name), not the file name.
    //const OurContract = await ethers.getContractFactory("SolidityCalculator");

    //2. Deploy our contract using deploy and deployed function from nomiclabs/hardhat-ethers
    // const calc = (await OurContract.deploy()) as SolidityCalculator;
    await calc.deployed();

    //3. Call our functions to test    
    //expect(await calc.getTotalCalculationCount()).to.equal(0);
  });

  describe('Test Failures First', () => {
    it(`Should fail with divide by 0`, async () => { 
      expect (calc).to.not.be.undefined;
      //await expect ( calc.connect(owner).divide(5, 0)).to.be.revertedWith("Can't Divide by 0!");
      await expect (calc.divide(5,0)).to.be.revertedWith("Can't Divide by 0!");
    });

    it(`Should fail with subtracting larger number`, async () => { 
        //await expect ( calc.connect(owner).divide(5, 0)).to.be.revertedWith("Can't Divide by 0!");
        await expect (calc.subtract(3,12)).to.be.revertedWith("Cannot subtract uints to result in negative numbers");
    });
  });

  describe('Test Addition', () => {
    
      const input1 = Math.round(Math.random()*100 + 2);
      const input2 = Math.round(Math.random()*100 + 89);
      it(`Should pass addition `, async () => { 

          //console.log(`element[0] = ${input1} and element[1] = ${input2}`);
          const tx = await calc.add(input1, input2);
          expect(tx).to.not.be.undefined;
          //console.log("tx is : ", tx.toString());
          
          const receipt = await tx.wait();
          //console.log(`receipt is : ${receipt}`);
          expect(receipt).to.not.be.undefined;
          expect(receipt.events).to.not.be.undefined;

          additionCounter++;
          transactionCounter++;

          if (receipt && receipt.events) {
              for (const event of receipt.events) {
                  //console.log(`Event ${event.event} with args ${event.args}`);
                  expect(event.args).to.not.be.undefined;
                  if (event.args) {
                    switch(event.event) {
                      case "AdditionTxnCount":
                        expect(event.args[0]).to.equal(additionCounter);
                        break;
                      case "TotalTxnCount":
                        expect(event.args[0]).to.equal(transactionCounter);
                        break;
                      case "CalculationResult":
                        expect(event.args[0]).to.equal(input1+input2);
                        break;
                    }
                  }
              }
          } 
          
          const totalTxCount = await calc.getTotalCalculationCount();
          console.log(`Total txn count is ${totalTxCount}`);
      });
  });

  describe('Test Subtraction', () => {
      const input1 = 20156;
      const input2 = 621;
      it(`Should pass subtraction `, async () => { 

        //console.log(`element[0] = ${input1} and element[1] = ${input2}`);
        const tx = await calc.subtract(input1, input2);
        expect(tx).to.not.be.undefined;
        //console.log("tx is : ", tx.toString());
        
        const receipt = await tx.wait();
        //console.log(`receipt is : ${receipt}`);
        expect(receipt).to.not.be.undefined;
        expect(receipt.events).to.not.be.undefined;

        subCounter++;
        transactionCounter++;

        if (receipt && receipt.events) {
            for (const event of receipt.events) {
                console.log(`Event ${event.event} with args ${event.args}`);
                expect(event.args).to.not.be.undefined;
                if (event.args) {
                  switch(event.event) {
                    case "SubtractionTxnCount":
                      expect(event.args[0]).to.equal(subCounter);
                      break;
                    case "TotalTxnCount":
                      expect(event.args[0]).to.equal(transactionCounter);
                      break;
                    case "CalculationResult":
                      expect(event.args[0]).to.equal(input1-input2);
                      break;
                  }
                }
            }
        } 

        const totalTxCount = await calc.getTotalCalculationCount();
        console.log(`Total txn count is ${totalTxCount}`);        
      });
  });

  describe('Test Miltiplication', () => {
    const input1 = 396;
    const input2 = 908;
    it(`Should pass multiplication `, async () => { 

      //console.log(`element[0] = ${input1} and element[1] = ${input2}`);
      const tx = await calc.multiply(input1, input2);
      expect(tx).to.not.be.undefined;
      //console.log("tx is : ", tx.toString());
      
      const receipt = await tx.wait();
      //console.log(`receipt is : ${receipt}`);
      expect(receipt).to.not.be.undefined;
      expect(receipt.events).to.not.be.undefined;

      multCounter++;
      transactionCounter++;

      if (receipt && receipt.events) {
          for (const event of receipt.events) {
              console.log(`Event ${event.event} with args ${event.args}`);
              expect(event.args).to.not.be.undefined;
              if (event.args) {
                switch(event.event) {
                  case "MultiplicationTxnCount":
                    expect(event.args[0]).to.equal(multCounter);
                    break;
                  case "TotalTxnCount":
                    expect(event.args[0]).to.equal(transactionCounter);
                    break;
                  case "CalculationResult":
                    expect(event.args[0]).to.equal(input1*input2);
                    break;
                }
              }
          }
      } 

      const totalTxCount = await calc.getTotalCalculationCount();
      console.log(`Total txn count is ${totalTxCount}`);        
    });
  });

  describe('Test Division', () => {
    const input1 = 52921;
    const input2 = 101;
    it(`Should pass division `, async () => { 

      //console.log(`element[0] = ${input1} and element[1] = ${input2}`);
      const tx = await calc.divide(input1, input2);
      expect(tx).to.not.be.undefined;
      //console.log("tx is : ", tx.toString());
      
      const receipt = await tx.wait();
      //console.log(`receipt is : ${receipt}`);
      expect(receipt).to.not.be.undefined;
      expect(receipt.events).to.not.be.undefined;

      divisionCounter++;
      transactionCounter++;

      if (receipt && receipt.events) {
          for (const event of receipt.events) {
              console.log(`Event ${event.event} with args ${event.args}`);
              expect(event.args).to.not.be.undefined;
              if (event.args) {
                switch(event.event) {
                  case "DivisionTxnCount":
                    expect(event.args[0]).to.equal(divisionCounter);
                    break;
                  case "TotalTxnCount":
                    expect(event.args[0]).to.equal(transactionCounter);
                    break;
                  case "CalculationResult":
                    expect(event.args[0].toNumber()).to.be.approximately(input1/input2, 1);
                    break;
                }
              }
          }
      } 

      const totalTxCount = await calc.getTotalCalculationCount();
      console.log(`Total txn count is ${totalTxCount}`);        
    });
  });

  describe('Test Modulo', () => {
    const input1 = 52921;
    const input2 = 101;
    it(`Should pass modulus `, async () => { 

      //console.log(`element[0] = ${input1} and element[1] = ${input2}`);
      const tx = await calc.modulo(input1, input2);
      expect(tx).to.not.be.undefined;
      //console.log("tx is : ", tx.toString());
      
      const receipt = await tx.wait();
      //console.log(`receipt is : ${receipt}`);
      expect(receipt).to.not.be.undefined;
      expect(receipt.events).to.not.be.undefined;

      moduloCounter++;
      transactionCounter++;

      if (receipt && receipt.events) {
          for (const event of receipt.events) {
              //console.log(`Event ${event.event} with args ${event.args}`);
              expect(event.args).to.not.be.undefined;
              if (event.args) {
                switch(event.event) {
                  case "ModuloTxnCount":
                    expect(event.args[0]).to.equal(moduloCounter);
                    break;
                  case "TotalTxnCount":
                    expect(event.args[0]).to.equal(transactionCounter);
                    break;
                  case "CalculationResult":
                    expect(event.args[0].toNumber()).to.be.approximately(input1 % input2, 1);
                    break;
                }
              }
          }
      } 

      const totalTxCount = await calc.getTotalCalculationCount();
      console.log(`Total txn count is ${totalTxCount}`);        
    });
  });

  describe('Test Power Of', () => {
    const input1 = 121;
    const input2 = 4;
    it(`Should pass modulus `, async () => { 

      //console.log(`element[0] = ${input1} and element[1] = ${input2}`);
      const tx = await calc.raiseToThePower(input1, input2);
      expect(tx).to.not.be.undefined;
      //console.log("tx is : ", tx.toString());
      
      const receipt = await tx.wait();
      //console.log(`receipt is : ${receipt}`);
      expect(receipt).to.not.be.undefined;
      expect(receipt.events).to.not.be.undefined;

      powerCounter++;
      transactionCounter++;

      if (receipt && receipt.events) {
          for (const event of receipt.events) {
              //console.log(`Event ${event.event} with args ${event.args}`);
              expect(event.args).to.not.be.undefined;
              if (event.args) {
                switch(event.event) {
                  case "PowerTxnCount":
                    expect(event.args[0]).to.equal(powerCounter);
                    break;
                  case "TotalTxnCount":
                    expect(event.args[0]).to.equal(transactionCounter);
                    break;
                  case "CalculationResult":
                    expect(event.args[0].toNumber()).to.be.approximately(input1 ^ input2, 1);
                    break;
                }
              }
          }
      } 

      const totalTxCount = await calc.getTotalCalculationCount();
      console.log(`Total txn count is ${totalTxCount}`);        
    });
  });

});
