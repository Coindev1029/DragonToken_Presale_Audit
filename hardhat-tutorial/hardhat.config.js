// Require necessary plugins
require("@nomicfoundation/hardhat-ethers");
require("@nomicfoundation/hardhat-toolbox");
require('hardhat-contract-sizer');
require('hardhat-coverage');

// Export the configuration
module.exports = {
  solidity: {
    compilers: [
      { version: "0.5.16", settings: {optimizer: {enabled: true,runs: 200,},}, },
      { version: "0.6.6", settings: {optimizer: {enabled: true,runs: 200,},}, },
      { version: "0.6.12", settings: {optimizer: {enabled: true,runs: 200,},}, },
      { version: "0.8.24", settings: {optimizer: {enabled: true,runs: 200,},}, },
    ],
  },
};
