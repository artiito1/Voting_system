// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract Token is ERC20 { 
    constructor()ERC20("Ahmet Tit","ATNEU"){
        _mint(msg.sender,9000000*10**18);
    }
}
