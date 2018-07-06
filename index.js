const Web3 = require('web3');
const config = require('./config/config');
const web3 = new Web3(new Web3.providers.HttpProvider(config.chain.httpProvider));
const abi = require('./contracts/HelloWorld.abi.json');

// Contract Instance
let HelloWorldContract = web3.eth.contract(abi);
let HelloWorldContractInstance = HelloWorldContract.at(config.chain.contractAddress);

let saveMessage = (message) => {
  try {
    HelloWorldContractInstance.saveMessage(message, { gas: 5000000, from: web3.eth.accounts[0] });
  } catch(e) {
    console.log(e);
  }
}

let getMessage = () => {
  return HelloWorldContractInstance.getMessage({from: web3.eth.accounts[0]});
}

let getSenders = () => {
  return HelloWorldContractInstance.getSenders();
}

// saveMessage('Hello, UHac');
console.log(getMessage());
console.log(getSenders());