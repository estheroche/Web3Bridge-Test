import { ethers } from "hardhat";

const main = async () => {
  const Link = await ethers.getContractAt("TokenA");
  const tokenA = await TokenA.deploy();
  await tokenA.deployed();

  const TokenB = await ethers.getContractAt("TokenB");
  const tokenB = await TokenB.deploy();
  await tokenB.deployed();

  const Swap = await ethers.getContractAt("Swap");
  const swap = await Swap.deploy(tokenA.address, tokenB.address);

  await swap.deployed();

  console.log("Swap Contract deployed to:", swap.address);

  

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});