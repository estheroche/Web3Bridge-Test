// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenB is ERC20, Ownable {
    constructor() ERC20("TokenB", "TKB") {
        _mint(address(this), 1_000e8);
    }

    function mint(uint _amount) internal {
        _mint(msg.sender, _amount);
    }
}
