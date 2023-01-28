// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "./Courses.sol";
import "./Token.sol";

contract School is Ownable{


    uint256 baseTermS = 10;
    uint public constant tax = 3;
    uint256 price = 1000;
    uint256 public numberoftokens;
//  uint256 baseTermT;
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

    function setBaseTerm(uint256 _baseTerm) public OnlyOwner {
        baseTermS = _baseTerm; 
    }


    function buyTokens() public payable {
       // require(msg.value >= 1 ether, "Cannot buy less than 1 Ether");
        numberoftokens = msg.value * price;
        token.transferFrom(Owner,msg.sender,numberoftokens);     
        student[msg.sender] = true;  

    }   

    function addTeacher(address _address, string memory _name, uint256 _Id) public OnlyOwner{
        require(teachers[_address].registered == false, "Teacher already registered");
        teachers[_address] = Teacher(_name, _Id, true);
    }

    function addCourse(uint256 _courseID, string memory _courseName, address _teacher, uint256 _baseTermT, uint256 _baseprice) public isTeacher{
        require(courses[_courseID].courseregistered == false, "Course already registered");
        require(baseTermS<=100-_baseTermT,"Base term should be greater than school terms");
        courses[_courseID] = Course(_courseID, _courseName, _teacher, true, _baseTermT, _baseprice);
        courseprice[_courseID] = calcCP(_baseprice, _baseTermT);
        cft.Mint(_teacher, _courseName); 
    }   

    
    function buyCourse(uint256 _courseId) public {
        require(courses[_courseId].courseregistered == true, "Not a valid course ID");
        require(token.balanceOf(msg.sender) >= courseprice[_courseId], "Not enough funds");
        //require(balanceOf(msg.sender) >= courseprice, "Not enough tokens");
        token.transferFrom(msg.sender,address(Owner), courseprice[_courseId]);
        t2.mint();
        studentenroll[t2.counter()][_courseId]=msg.sender;
    }


    function graduate(address _student , uint256 _courseid ) public isTeacher {
        require(student[_student] = true, "The address is not a student");
        require(studentenroll[t2.counter()][_courseid] == _student, "The student is not enrolled in this course");
        Qctf.mint(msg.sender);
        t2.burn();
        
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


/*
    //ERRORS THAT I'M WORKING ON
    1) N/A

    */