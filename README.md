# SWAP CONTRACT

A Constant Product Market Maker (CPMM) is a smart contract protocol used in decentralized exchanges (DEXs) like Uniswap to facilitate automated swapping of tokens. It maintains a fixed product of token reserves, ensuring that as one token is traded for another, the ratio between them changes. Users can swap tokens directly through the CPMM contract, and the system automatically calculates the exchange rate based on the current reserve balances. CPMMs provide liquidity and enable decentralized trading without relying on traditional order books, making them a crucial component of decentralized finance (DeFi) ecosystems

# CONTRACT ADDRESSES

https://sepolia.etherscan.io/address/0xbC72a571bcdDB3086823F5FA117E95E639EfACd4 = Token A

https://sepolia.etherscan.io/address/0x59dF163602D9f16587FB3FABbA5AA13b88eF37b7 = Token B

https://sepolia.etherscan.io/address/0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6 = SWAP CONTRACT

# SWAP CONTRACT FORMULA

X \* Y = K

# Function explanation:

The `addLiquidity` function you provided appears to be part of a smart contract that allows users to provide liquidity to a decentralized exchange or liquidity pool. The function is used to add two different tokens (`Token A and Token B`) to the pool, and it has some logic to handle both the initial liquidity provision and subsequent additions.

- Function Signature: function addLiquidity(`uint256 amountA, uint256 amountB`) external
  This function takes two parameters: amountA and amountB, representing the quantities of Token A and Token B that the user wants to add to the liquidity pool. It is marked as external, meaning it can be called from outside the smart contract.

- Input Validation: The function starts with a require statement to ensure that both amountA and amountB are greater than zero. This is to prevent users from adding zero or negative amounts of tokens to the pool.

- Check Pool Balance: It calculates the current balance of Token A (`poolBalanceA`) and Token B (`poolBalanceB`) held by the smart contract. This is used to determine whether this is the initial liquidity provision or a subsequent addition.

- Initial Liquidity Provision: If it's the initial liquidity provision (either the pool is empty or one of the tokens has a balance of zero), the function allows the user to transfer their tokens (`amountA and amountB`) to the smart contract. This is the first step in providing liquidity to the pool.

- Subsequent Liquidity Addition: If the pool already has liquidity, the function calculates how many liquidity tokens should be minted for the user based on their provided amounts relative to the current pool balances. It then transfers the user's tokens to the smart contract and updates their liquidity provider record with the new liquidity tokens they received. The total liquidity in the pool is also updated.

- Event Emission: Finally, an LiquidityAdded event is emitted to log the fact that the user has added liquidity to the pool. This event can be used to track liquidity additions on the blockchain.
