// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IToken {
    function approve(address spender, uint rawAmount) external returns (bool);

    function balanceOf(address _owner) external view returns (uint256 balance);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);
}

interface ISwap {
    function addLiquidity(uint256 amountA, uint256 amountB) external;

    function removeLiquidity(uint256 liquidity) external;

    function swapTokens(uint256 amountA, uint256 amountB) external;
}
