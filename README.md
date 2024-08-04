# Ahome(2024)

구디 아카데미 파이널 프로젝트: 그룹웨어(Groupware)

- **참여인원**: 1명 (개인프로젝트)
- **프로젝트 기간**: 7/5 ~ 7/30
- **프로젝트 주제**: 그룹웨어 사이트

## 구현기능
1. 로그인 및 회원가입
2. 인사관리
3. 전자결재
4. 게시판

---

## 기술스택

### Back end/Server
- JAVA ![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
- Spring, Spring Boot ![Spring](https://img.shields.io/badge/spring-%236DB33F.svg?style=for-the-badge&logo=spring&logoColor=white)
- Apache Tomcat 9.0 ![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)
- OracleDB 	![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)
- Mybatis, Jsp

### Front end
- Javascript 	![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
- JQuery ![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
- Json ![JWT](https://img.shields.io/badge/Json-black?style=for-the-badge&logo=JSON%20web%20tokens)
- HTML5, CSS3 ![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white) ![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
- Bootstrap ![Bootstrap](https://img.shields.io/badge/bootstrap-%238511FA.svg?style=for-the-badge&logo=bootstrap&logoColor=white)

### Devops
- Maven ![Apache Maven](https://img.shields.io/badge/Apache%20Maven-C71A36?style=for-the-badge&logo=Apache%20Maven&logoColor=white)
- Git/ Github ![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
- Eclips ![Eclipse](https://img.shields.io/badge/Eclipse-FE7A16.svg?style=for-the-badge&logo=Eclipse&logoColor=white)
---

## DB구조(ERD)
<img width="770" alt="ERD" src="https://github.com/user-attachments/assets/54bcefd0-0382-4c6d-a10a-4065fb2ef78f">

- OracleDB를 이용하여 SQL문을 통해 테이블 생성 및 데이터 삽입,삭제,수정,조회, 트리거 등을 활용

---
## 로그인 및 메인화면
<img width="300" alt="로그인화면" src="https://github.com/user-attachments/assets/0a14453b-cc11-417e-8584-cdbaba3443ee">
<img width="400" alt="메인페이지" src="https://github.com/user-attachments/assets/6719c14e-fd19-413f-a150-be7a0f17c10e"><br>

**구현기능 설명**
- 기본적인 로그인, 로그아웃
- Spring Security로 계정 권한 부여
- BCrypt 해시 함수로 비밀번호 암호화

---
## 인사관리 화면(직원등록,수정,삭제,조회, 근태)
<img width="350" alt="인사관리_사원수정" src="https://github.com/user-attachments/assets/2269f786-7e72-41f3-a8df-5543f5d92789">
<img width="350" alt="인사관리-사원조회" src="https://github.com/user-attachments/assets/f6043cc0-b7a3-450e-9fb5-38583ca928a0">
<img width="350" alt="인사관리_사원등록" src="https://github.com/user-attachments/assets/18a045fd-3143-46cc-a81d-06e4065ccfb9">
<img width="95" alt="근태기록" src="https://github.com/user-attachments/assets/901d8043-6264-4c71-995f-ec8491a7489e"><br>

**구현기능 설명**
- 조건검색을 통한 직원 검색 및 페이징 처리
- 조회목록에서 다수 선택 후 삭제기능
- 인사부의 특정직원 클릭시 상세페이지로 이동 후 수정(부서 수정 )처리 기능
- 프로필사진 및 직원의 개인정보 등록/ 등록시 아이디 중복체크 및 비밀번호 정규식을 통한 체크 
- 근태 관리 구현중(현재 출근퇴근버튼 누를시 DB에 저장되어 불러오기까지-> 근태이력 조회 구현중)

---
## 전자결재 화면(전자결재 메인, 문서함, 작성 등)
<img width=""600 alt="전자결재_메인화면" src="https://github.com/user-attachments/assets/a81866fd-93fb-4fb0-adfb-84ee5e1ff908"><br>
<img width="600" alt="결재문서함" src="https://github.com/user-attachments/assets/b78b6fba-ec11-4796-9640-822c216702c4"><br>
<img width="600" alt="지출결의서" src="https://github.com/user-attachments/assets/e7c55a4b-dbe1-4791-90cf-aef62b80ee67"><br>

**구현기능 설명**
- 기본적인 내용작성 후 결재유형별 기안하기(휴가신청서-연차일수 계산, 지출결의서-지출항목,금액합계 계산, 연장근무신청서-시간계산)
- 결재라인별 해당부서의 사원조회 및 결재자 선택(최종결재자는 과장급만 선택가능O, 팀장,대리급 선택X)
- 결재상태별 대기중, 진행중, 반려됨, 승인됨 구분
- 팀장,대리급 결재자의 결재반려시 과장급 최종결재자의 결재문서함에 미표시
- 팀장,대리급 결재자의 결재승인이 모두 이루어지면 최종결재자의 결재문서함에 표시(승인시->기안자의 기안문서함에 문서상태 '승인')
- 결재할 문서의 임시저장기능(임시저장 문서함) 및 내용보완 후 다시 결재요청기능
- selectbox를 통한 다중 삭제 및 페이징 처리

---
## 게시판 화면(게시판 글 작성, 댓글, 대댓글, 조회 수)
<img width="818" alt="게시판" src="https://github.com/user-attachments/assets/6d0c219f-789c-4a6f-b476-69258deb1292">
<img width="374" alt="image" src="https://github.com/user-attachments/assets/6ce4bc0d-0d81-4f33-9460-2eb98c90fadd">
**구현기능 설명**
- 자유게시판 글 작성 및 검색에 따른 페이징 처리(작성,삭)
- 글 작성 시 첨부파일 기능
- 게시판 상세보기 및 조회수 증가
- 댓글 및 대댓글 기능(자신의 댓글만 삭제가능)
