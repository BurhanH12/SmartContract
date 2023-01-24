import { ethers } from "hardhat";
import { Token, Token__factory } from "../typechain-types"

async function main() {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  
  const contract = await deploy("Token", { from: deployer });

  console.log("Deployed contract to address:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
