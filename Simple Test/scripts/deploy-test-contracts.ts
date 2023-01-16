import { ethers } from "hardhat";
import { SolidityTest, SolidityTest__factory } from "../typechain-types";


async function main() {

    const SolidityTest:SolidityTest__factory = await ethers.getContractFactory("SolidityTest")
    const solidityTest:SolidityTest = await SolidityTest.deploy();

    await solidityTest.deployed();


    console.log("SolidityTest deployed to:", solidityTest.address);

    console.log("Juice is ", await solidityTest.getJuice());

    console.log("Is Juice Extra-Large ", await solidityTest.verifyJuice());
    


    await solidityTest.updateJuiceSize(3);

    console.log("Juice is ", await solidityTest.getJuice());

    console.log("Is Juice Extra-Large ", await solidityTest.verifyJuice());




}

  


    /*
    const data = await solidityTest.age();
    console.log("Age = ",data.toString());

    const txt1 = await solidityTest.updateName();
    txt1.wait();


    const data = await solidityTest.age();
    console.log("Age = ",data.toString());

    const txt1 = await solidityTest.updateAge();
    txt1.wait();
    console.log("update done");

    const data1 = await solidityTest.age();
    
    console.log("Update Age is = ",data1.toString());

    */

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });