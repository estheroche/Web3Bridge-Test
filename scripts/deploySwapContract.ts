import { ethers } from 'hardhat'

async function main() {
  const Swap = await ethers.deployContract("TokenSwap", [
    "0xbC72a571bcdDB3086823F5FA117E95E639EfACd4",
    "0xD6C4A6a1d9A0Ddf25431881a2EBF75609A523882"]);
  Swap.waitForDeployment();

  console.log(Swap.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// TokenA.=	0xbC72a571bcdDB3086823F5FA117E95E639EfACd4
// TokenB.= 0xD6C4A6a1d9A0Ddf25431881a2EBF75609A523882

// SwapAddr = 0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6