const { ethers } = require("ethers");
const CryptoJS = require("crypto-js");
const readlineSync = require("readline-sync");
const fs = require("fs");

function encrypt() {
  const wallet = ethers.Wallet.createRandom();
  const privateKey = wallet.privateKey;
  const publicKey = wallet.publicKey;
  const address = wallet.address;
  const mnemonic = wallet.mnemonic.phrase;

  // Solicite ao usuário que defina a chave de criptografia
  const encryptionKey = readlineSync.question("Defina sua chave de criptografia: ", {
    hideEchoBack: true, // oculta a entrada do usuário para maior segurança
  });

  // Crie um objeto para armazenar as informações
  const data = {
    publicKey,
    privateKey,
    address,
    mnemonic,
  };

  // Converta o objeto em uma string JSON
  const jsonString = JSON.stringify(data);

  // Criptografe a string JSON com o CryptoJS
  const encryptedData = CryptoJS.AES.encrypt(jsonString, encryptionKey);

  // Salve o texto criptografado em um arquivo
  fs.writeFileSync("wallet.exe", encryptedData.toString());

  console.log("As informações foram criptografadas e salvas com sucesso no arquivo 'wallet.exe'");
}

function decrypt() {
  // Leia o conteúdo do arquivo
  const encryptedData = fs.readFileSync("wallet.exe").toString();

  // Solicite ao usuário que insira a chave de criptografia
  const encryptionKey = readlineSync.question("Insira a chave de criptografia: ", {
    hideEchoBack: true, // oculta a entrada do usuário para maior segurança
  });

  // Descriptografe o texto com o CryptoJS
  const decryptedData = CryptoJS.AES.decrypt(encryptedData, encryptionKey);

  // Converta a string descriptografada em um objeto JSON
  const data = JSON.parse(decryptedData.toString(CryptoJS.enc.Utf8));

  // Acesse as informações
  console.log("Public Key:", data.publicKey);
  console.log("Private Key:", data.privateKey);
  console.log("Endereço da conta:", data.address);
  console.log("Mnemonic:", data.mnemonic);
}

// Solicite ao usuário que escolha uma opção
const option = readlineSync.question(
  "Escolha uma opção:\n1 - Criptografar informações\n2 - Descriptografar informações\n"
);

if (option === "1") {
  encrypt();
} else if (option === "2") {
  decrypt();
} else {
  console.log("Opção inválida. Por favor, escolha 1 ou 2.");
}
