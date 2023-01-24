// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "./Courses.sol";
import "./Token.sol";

contract School is Courses{


    uint256 baseTermS = 40;
//    uint256 baseTermT;
    address private Owner;
    IERC20 token;

        constructor(IERC20 _token){
        Owner = msg.sender;
        token = _token;
        }

    modifier OnlyOwner {
        require(msg.sender == Owner, "You're not the owner");
        _;
    }

    uint16 public tax = 3;
    uint256 price = 1000;
    uint256 public numberoftokens;
     mapping (address => bool) student;


    function buy() public payable {
        numberoftokens = msg.value * price;
        token.transfer(msg.sender,numberoftokens);     //This Line gives an Error when passing msg.value as Ether
        student[msg.sender] = true;  

    }

    Courses coursenft = new Courses();


    struct Teacher {
        string name;
        uint256 Id;
        bool registered;
    }

    mapping(address => Teacher) public teachers;

    function addTeacher(address _address, string memory _name, uint256 _Id) public OnlyOwner{
        require(teachers[_address].registered == false, "Teacher already registered");
        teachers[_address] = Teacher(_name, _Id, true);
    }

    modifier isTeacher {
        require(teachers[msg.sender].registered == true, "You are not a teacher");
        _;
    }

    function setBaseTerm(uint256 _baseTerm) public OnlyOwner {
        baseTermS = _baseTerm; 
    }
    

    uint256 courseprice;

    struct Course {
        uint256 courseID;
        string courseName;
        address teacher;
        bool courseregistered;
        uint256 _baseTermT;
        uint256 basePrice;
    }

    mapping(uint256 => Course) public courses;  //75

    function addCourse(uint256 _courseID, string memory _courseName, address _teacher, uint256 _baseTermT, uint256 _baseprice) public isTeacher{
        require(courses[_courseID].courseregistered == false, "Course already registered");
        require(_baseTermT <= baseTermS, "Base Term cannot be more than base term set by school");
        courses[_courseID] = Course(_courseID, _courseName, _teacher, true, _baseTermT, _baseprice);
        coursenft.Mint(_teacher, _courseName);
    }   

    function graduate(address _student /*, uint256 _CourseID */) public isTeacher {
        require(student[_student] = true, "The address is not a student");
    }

        function buyCourse(uint256 _courseId) public {
        require(_courseId != 0, "Not a valid course ID");
        require(balanceOf(msg.sender) >= courseprice, "Not enough tokens");
        token.transfer(address(Owner), price);

        
    }


    }


/*
    //ERRORS THAT I'M WORKING ON
    1) to access the variable from the addcourse function & the struct for calculation
    2) To make another nft as certificate and mint it at the time of student graduating 
    3) The token.transfer line above gives an error

    */