// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public totalLiquidity;
    uint256 public constant k = 1000; // CPMM constant, adjust as needed

    struct LiquidityProvider {
        uint256 amount1;
        uint256 amount2;
    }

    mapping(address => LiquidityProvider) public liquidityProviders;

    event TokensSwapped(
        address indexed user,
        uint256 amountA,
        uint256 amountB,
        uint256 amountAReceived,
        uint256 amountBReceived
    );
    event LiquidityAdded(
        address indexed provider,
        uint256 amountA,
        uint256 amountB
    );
    event LiquidityWithdrawn(
        address indexed provider,
        uint256 amountA,
        uint256 amountB
    );

    constructor(IERC20 _tokenA, IERC20 _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    function addLiquidity(uint256 amountA, uint256 amountB) external {
        require(
            amountA > 0 && amountB > 0,
            "Both amounts must be greater than zero"
        );

        uint256 poolBalanceA = tokenA.balanceOf(address(this));
        uint256 poolBalanceB = tokenB.balanceOf(address(this));

        if (totalLiquidity == 0 || poolBalanceA == 0 || poolBalanceB == 0) {
            require(
                tokenA.transferFrom(msg.sender, address(this), amountA),
                "Transfer of Token A failed"
            );
            require(
                tokenB.transferFrom(msg.sender, address(this), amountB),
                "Transfer of Token B failed"
            );
        } else {
            uint256 liquidityMinted = (amountA * totalLiquidity) / poolBalanceA;
            require(liquidityMinted > 0, "Insufficient liquidity to mint");

            uint256 newLiquidity = totalLiquidity + liquidityMinted;
            require(
                tokenA.transferFrom(msg.sender, address(this), amountA),
                "Transfer of Token A failed"
            );
            require(
                tokenB.transferFrom(msg.sender, address(this), amountB),
                "Transfer of Token B failed"
            );

            liquidityProviders[msg.sender].amount1 +=
                (amountA * totalLiquidity) /
                poolBalanceA;
            liquidityProviders[msg.sender].amount2 +=
                (amountB * totalLiquidity) /
                poolBalanceB;
            totalLiquidity = newLiquidity;
        }

        emit LiquidityAdded(msg.sender, amountA, amountB);
    }

    function removeLiquidity(uint256 liquidity) external {
        require(
            liquidity > 0 &&
                liquidityProviders[msg.sender].amount1 >= liquidity &&
                liquidityProviders[msg.sender].amount2 >= liquidity,
            "Invalid liquidity amount"
        );

        uint256 poolBalanceA = tokenA.balanceOf(address(this));
        uint256 poolBalanceB = tokenB.balanceOf(address(this));

        uint256 amountA = (liquidity * poolBalanceA) / totalLiquidity;
        uint256 amountB = (liquidity * poolBalanceB) / totalLiquidity;

        require(
            tokenA.transfer(msg.sender, amountA),
            "Transfer of Token A failed"
        );
        require(
            tokenB.transfer(msg.sender, amountB),
            "Transfer of Token B failed"
        );

        liquidityProviders[msg.sender].amount1 -= amountA;
        liquidityProviders[msg.sender].amount2 -= amountB;
        totalLiquidity -= liquidity;

        emit LiquidityWithdrawn(msg.sender, amountA, amountB);
    }

    function swapTokens(uint256 amountA, uint256 amountB) external {
        require(
            amountA > 0 && amountB > 0,
            "Both amounts must be greater than zero"
        );

        uint256 poolBalanceA = tokenA.balanceOf(address(this));
        uint256 poolBalanceB = tokenB.balanceOf(address(this));
        uint256 amountAReceived = (amountB * poolBalanceA) /
            (poolBalanceB + amountB);
        uint256 amountBReceived = (amountA * poolBalanceB) /
            (poolBalanceA + amountA);

        require(
            amountAReceived > 0 && amountBReceived > 0,
            "Swap would result in zero tokens received"
        );

        require(
            tokenA.transferFrom(msg.sender, address(this), amountA),
            "Transfer of Token A failed"
        );
        require(
            tokenB.transferFrom(msg.sender, address(this), amountB),
            "Transfer of Token B failed"
        );
        require(
            tokenA.transfer(msg.sender, amountAReceived),
            "Transfer of Token A to user failed"
        );
        require(
            tokenB.transfer(msg.sender, amountBReceived),
            "Transfer of Token B to user failed"
        );

        emit TokensSwapped(
            msg.sender,
            amountA,
            amountB,
            amountAReceived,
            amountBReceived
        );
    }
}
