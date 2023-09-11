import { ethers } from "hardhat";

async function main() {

    // TokenA.=	0xbC72a571bcdDB3086823F5FA117E95E639EfACd4
//    TokenB.= 0xD6C4A6a1d9A0Ddf25431881a2EBF75609A523882
// SwapAddr = 0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6

  const Swap = await ethers.getContractAt(
    "ISwap",
    "0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6"
  );

  const TokenA = await ethers.getContractAt(
    "IToken",
    "0xbC72a571bcdDB3086823F5FA117E95E639EfACd4"
  );

  const TokenB = await ethers.getContractAt(
    "IToken",
    "0xD6C4A6a1d9A0Ddf25431881a2EBF75609A523882"
  );

  const TokenAamount = ethers.parseUnits("500", 8);

  const TokenBamount = ethers.parseUnits("500", 8);

  await TokenA.approve(
    "0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6",
    TokenAamount
  );

  await TokenB.approve(
    "0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6",
    TokenBamount
  );
  // console.log(swapContract);
  console.log(
    await TokenA.allowance(
      "0xe9999a29B116cB45444621EcD1CE52CA013243E4",
      "0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6"
    )
  );
  console.log(
    await TokenB.allowance(
      "0xe9999a29B116cB45444621EcD1CE52CA013243E4",
      "0xa929dFDB43Cd2C9Ddeb60B39Ec387662a69e78e6"
    )
  );
  await Swap.addLiquidity(
    ethers.parseUnits("100", 8),
    ethers.parseUnits("100", 8)
  );
 
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});