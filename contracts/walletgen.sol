// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@nomiclabs/hardhat-etherscan/contracts/implementation/Contract.sol";
import "@nomiclabs/hardhat-etherscan/contracts/interfaces/IContract.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

interface IERC20 {
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract WalletGenerator is Ownable {
    using SafeMath for uint256;
    using Address for address;
    using EnumerableSet for EnumerableSet.AddressSet;

    address public constant ETH_ADDRESS = address(0);
    uint256 public constant MAX_WALLETS = 100;

    EnumerableSet.AddressSet private _wallets;
    mapping(address => bool) private _isWalletGenerated;

    event WalletGenerated(address indexed wallet, address indexed owner);

    constructor() {}

    function generateWallet() public {
        require(_wallets.length() < MAX_WALLETS, "WalletGenerator: max wallets reached");
        require(!_isWalletGenerated[msg.sender], "WalletGenerator: wallet already generated");

        bytes32 salt = bytes32(uint256(msg.sender));
        address wallet = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(abi.encodePacked(msg.sender)),
            bytes32(0x0)
        )))));

        _wallets.add(wallet);
        _isWalletGenerated[msg.sender] = true;

        emit WalletGenerated(wallet, msg.sender);
    }

    function getWallets() public view returns (address[] memory) {
        uint256 length = _wallets.length();
        address[] memory wallets = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            wallets[i] = _wallets.at(i);
        }
        return wallets;
    }

    function isWalletGenerated(address wallet) public view returns (bool) {
        return _isWalletGenerated[wallet];
    }

    function withdraw(address token, uint256 amount) public onlyOwner {
        if (token == ETH_ADDRESS) {
            payable(owner()).transfer(amount);
        } else {
            IERC20(token).transfer(owner(), amount);
        }
    }
}
