const { ethers } = require("ethers");
const wallet = ethers.Wallet.createRandom();
console.log("Nova conta criada. Endereço da conta:", wallet.address);
console.log("Mnemonic:", wallet.mnemonic.phrase);
