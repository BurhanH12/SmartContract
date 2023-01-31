import { expect } from 'chai';
import { BigNumber} from "ethers";
import { ethers } from "hardhat";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import {CourseNFT, CourseNFT__factory,QCertificate, QCertificate__factory,Token, Token__factory,Token2, Token2__factory, School__factory, School } from "../typechain-types";



describe ("School",  function () {
    console.log("check ")
    // async function Deployment() {
    it("Deployment should assign the total supply of tokens to the owner", async function () {
        const [school, teacher, student] = await ethers.getSigners();
        
        const token = await ethers.getContractFactory("Token");
        const deploytoken = await token.deploy();

        console.log("TOkenAdd : ",deploytoken.address)
    });
    
    
    // const price = ethers.utils.parseEther("3");

    // const token = await ethers.getContractFactory("Token");
    // const deploytoken = await token.deploy();
    // console.log("TOkenAdd : ",deploytoken.address)
        // const Contract: School__factory = await ethers.getContractFactory("School");
        // const contract:School = await Contract.deploy();

        // const CertificateContract: QCertificate__factory = await ethers.getContractFactory("QCertificate");
        // const certificateContract = CertificateContract.attach(await contract.Qctf());

        // const CourseNFT: CourseNFT__factory = await ethers.getContractFactory("CourseNFT");
        // const courseNFT = CourseNFT.attach(await contract.cft());

        // const Token1: Token__factory = await ethers.getContractFactory("Token");
        // const token1 = Token1.attach(await contract.Token());

        // const Token2: Token__factory = await ethers.getContractFactory("Token");
        // const token2 = Token2.attach(await contract.t2());

     

        
    // }
    
})
// contract('School', (accounts: any[]) => {
//   let instance: School;

//   beforeEach(async () => {
//     instance = await School.deployed();
//   });

//   it('should allow users to buy tokens', async () => {
//     const initialBalance = await instance.balanceOf(accounts[0]);
//     await instance.buyTokens({ value: 100, from: accounts[0] });
//     const finalBalance = await instance.balanceOf(accounts[0]);

//     expect(finalBalance.toNumber()).to.be.greaterThan(initialBalance.toNumber());
//   });

//   it('should allow adding teachers', async () => {
//     const result = await instance.addTeacher(accounts[1], 'John Doe', { from: accounts[0] });
//     const teacher = await instance.teachers(accounts[1]);

//     expect(teacher[0]).to.equal(accounts[1]);
//     expect(teacher[1]).to.equal('John Doe');
//     expect(result.logs[0].event).to.equal('TeacherAdded');
//     expect(result.logs[0].args.teacher).to.equal(accounts[1]);
//   });

//   it('should allow adding courses', async () => {
//     await instance.addTeacher(accounts[1], 'John Doe', { from: accounts[0] });
//     const result = await instance.addCourse(1, 'Math 101', accounts[1], { from: accounts[0] });
//     const course = await instance.courses(1);

//     expect(course[0]).to.equal(1);
//     expect(course[1]).to.equal('Math 101');
//     expect(course[2]).to.equal(accounts[1]);
//     expect(result.logs[0].event).to.equal('CourseAdded');
//     expect(result.logs[0].args.id.toNumber()).to.equal(1);
//   });

//   it('should allow students to buy courses', async () => {
//     await instance.addTeacher(accounts[1], 'John Doe', { from: accounts[0] });
//     await instance.addCourse(1, 'Math 101', accounts[1], { from: accounts[0] });
//     const initialBalance = await instance.balanceOf(accounts[0]);
//     await instance.buyCourse(1, { from: accounts[0], value: 100 });
//     const finalBalance = await instance.balanceOf(accounts[0]);

//     const studentCourses = await instance.getStudentCourses(accounts[0]);
//     expect(studentCourses.length).to.equal(1);
//     expect(studentCourses[0].toNumber()).to.equal(1);
//     expect(finalBalance.toNumber()).to.be.lessThan(initialBalance.toNumber());
//   });

//   it('should allow students to graduate', async () => {
//     await instance.addTeacher(accounts[1], 'John Doe', { from: accounts[0] });
//     await instance.addCourse(1, 'Math 101', accounts[1], { from: accounts
//         function contract(arg0: string, arg1: (accounts: any) => void) {
//             throw new Error('Function not implemented.');
//         }

//         function contract(arg0: string, arg1: (accounts: any) => void) {
//             throw new Error('Function not implemented.');
//         }

