import { ethers } from "hardhat";
import { Token, Token__factory } from "../typechain-types"
import { schoolSol } from "../typechain-types/contracts";

async function main() {
  const { deploy } = School;
  const { deployer } = await getNamedAccounts();
  
  const contract = await deploy("Token", { from: deployer });

  console.log("Deployed contract to address:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
