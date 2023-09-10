// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TokenA.sol";
import "./TokenB.sol";

contract Swap {
    struct LiquidityProvider {
        uint amount1;
        uint amount2;
    }

    IERC20 TokenA;
    IERC20 TokenB;

    constructor(IERC20 _tokenA, IERC20 _tokenB) {
        TokenA = IERC20(_tokenA);
        TokenB = IERC20(_tokenB);
    }

    mapping(address => LiquidityProvider) public _liquidityProvider;

    function addLiquidity(uint256 amount1, uint256 amount2) external {
        uint provider; // counter
        LiquidityProvider storage ego = _liquidityProvider[msg.sender];
        require(this.balance >= amount1, "ERC20 insuficient balance");
        ego.amount1 += amount1;
        ego.amount2 += amount2;
        uint reserveA;
        uint reserveB;

        bool status = IERC20(TokenA).transferFrom(
            msg.sender,
            address(this),
            amount1
        );
        require(status == true, "transfer Failed");
        IERC20(TokenB).transferFrom(msg.sender, address(this), amount2);
    }

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function withdrawA(uint amount) external {
        uint LiquidityProvided = _liquidityProvider[msg.sender];
        require(totalProvided >= amount, "insufficent liquidity amount");
        LiquidityProvider storage ego = _liquidityProvider[msg.sender];
        ego.amount2 -= amount;
        TokenA.transfer(msg.sender, amount);
    }

    function withdrawB(uint amount) external {
        uint LiquidityProvided = _liquidityProvider(msg.sender);
        require(_liquidityProvider >= amount, "insufficent liquidity amount");
        LiquidityProvider storage ego = _liquidityProvider(msg.sender);
        ego.amount2 -= amount;
        TokenB.transfer(msg.sender, amount);
    }

    // // /*
    //  * Convert an amount of input token_ to an equivalent amount of the output token
    //  token_ address of token to swap
    //  amount amount of token to swap/receive
    //  */
    function swapp(address token_, uint256 amount) private {
        require(
            IERC20(token_).transferFrom(msg.sender, address(this), amount),
            "ERC20: Error on transfer"
        );
        require(TokenB.transfer(msg.sender, amount), "Error");
    }

    /*
     * Convert an amount of the output token to an equivalent amount of input token_
     token_ address of token to receive
     amount amount of token to swap/receive
     */
    function _unswap(address token_, uint256 amount) private {
        require(
            TokenB.transferFrom(msg.sender, address(this), amount),
            "ERC20: Error on transfer"
        );
        require(
            IERC20(token_).transfer(msg.sender, amount),
            "ERC20: Error on transfer"
        );
    }

    function transferToken(
        IERC20 tokenToTransfer,
        address from,
        address to,
        uint256 amount
    ) private {
        bool sent = tokenToTransfer.transferFrom(from, to, amount);
        require(sent, "Failed");
    }
}
