// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./Courses.sol";
import "./Token.sol";

contract School is Ownable{


    uint256 baseTermS = 10;
    uint public constant tax = 3;
    uint256 price = 1000;
    uint256 public numberoftokens;
    address private Owner;
    
    IERC20 token;
    Token2 public t2;
    CourseNFT public cft;
    QCertificate public Qctf;
    
   

    constructor(IERC20 _token, address _nft, address _token2, address _cert){
        Owner = msg.sender;
        token = _token;
        t2 = Token2(_token2);
        cft =  CourseNFT(_nft);
        Qctf = QCertificate(_cert);
        }

    modifier OnlyOwner {
        require(msg.sender == Owner, "You're not the owner");
        _;
    }

    modifier isTeacher {
        require(teachers[msg.sender].registered == true, "You are not a teacher");
        _;
    }

   
    mapping(address => Teacher) public teachers;
    mapping (address => bool) student;
    mapping(uint256 => Course) public courses;  
    mapping (uint256 => mapping (uint256 => address)) studentenroll;
    mapping (uint256 => uint256) courseprice;


    
    struct Course {
        uint256 courseID;
        string courseName;
        address teacher;
        bool courseregistered;
        uint256 _baseTermT;
        uint256 basePrice;
    }

    struct Teacher {
        string name;
        uint256 Id;
        bool registered;
    }

    event TeacherAdded(address indexed teacher);
    event CourseAdded(address indexed teacher,uint256 CourseID, string CourseName, uint256 price);
    event Enrolled(address indexed student, uint256 CourseID);
    event Graduated(address indexed student, uint256 CourseID);


    function setBaseTerm(uint256 _baseTerm) public OnlyOwner {
        baseTermS = _baseTerm; 
    }


    function buyTokens() public payable {
        require(msg.value != 0 ether, "Invalid Input");
        numberoftokens = msg.value * price;
        token.transferFrom(Owner,msg.sender,numberoftokens);     
        student[msg.sender] = true;  

    }   

    function addTeacher(address _address, string memory _name, uint256 _Id) public OnlyOwner{
        require (_address != address (0), "Invalid Address");
        require(teachers[_address].registered == false, "Teacher already registered");
        teachers[_address] = Teacher(_name, _Id, true);
        emit TeacherAdded(_address);
    }

    function addCourse(uint256 _courseID, string memory _courseName, address _teacher, uint256 _baseTermT, uint256 _baseprice) public isTeacher{
        require(courses[_courseID].courseregistered == false, "Course already registered");
        require(baseTermS<=100-_baseTermT,"Base term should be greater than school terms");
        require (_teacher != address (0), "Invalid Address");
        require (_baseprice != 0) ;
        require (_baseTermT != 0) ;
        courses[_courseID] = Course(_courseID, _courseName, _teacher, true, _baseTermT, _baseprice);
        courseprice[_courseID] = calcCP(_baseprice, _baseTermT);
        cft.Mint(_teacher, _courseName); 
        emit CourseAdded(_teacher, _courseID, _courseName, _baseprice);
    }   

    
    function buyCourse(uint256 _courseId) public {
        require(courses[_courseId].courseregistered == true, "Not a valid course ID");
        require(token.balanceOf(msg.sender) >= courseprice[_courseId], "Not enough funds");
        token.transferFrom(msg.sender,address(Owner), courseprice[_courseId]);
        t2.mint(msg.sender);
        studentenroll[t2.counter()][_courseId]=msg.sender;
        emit Enrolled(msg.sender, _courseId);
    }


    function graduate(address _student , uint256 _courseid ) public isTeacher {
        require(student[_student] = true, "The address is not a student");
        require(studentenroll[t2.counter()][_courseid] == _student, "The student is not enrolled in this course");
        Qctf.mint(_student);
        t2.burn(_student);
        emit Graduated(_student, _courseid);
        
    }

    function calulatePercent(uint base, uint share) pure private returns (uint) {
        return(base * 100) / share;
    }

    function calcCP(uint _baseprice, uint _shareT) pure private returns (uint) {
        return(calulatePercent(_baseprice,_shareT) + calcTax(calulatePercent(_baseprice,_shareT)));
        
    }

    function calcTax(uint amount) pure private returns (uint) {
        return amount * tax / 100;
        
    }

    function ViewPrice(uint256 _ID) public view returns(uint256) {
         return courseprice[_ID];
    }
}
