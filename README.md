# Ahome(2024)

구디 아카데미 파이널 프로젝트: 그룹웨어

- **참여인원**: 1명 (개인프로젝트)
- **프로젝트 기간**: 7/5 ~ 8/7
- **프로젝트 주제**: 기본적인 그룹웨어 기능이 구현되어있는 사이트

## 구현기능
1. 로그인 및 회원가입
2. 인사관리
   - 직원 등록 (사번 부여)
   - 직원 목록 조회 (부서별, 직책별 필터 조회, 페이징 처리)
   - 직원 상세정보 수정
   - 직원 삭제
3. 전자결재
   - 결재 상신
     - 기안서 작성 – 휴가신청서 (결재선 선택, 연차일수 계산 등)
   - 기안문서함
     - 상신한 문서를 상태별로 조회 (결재대기, 진행중, 승인, 반려)
     - selectbox를 통한 다중 삭제
   - 결재 문서함
     - 결재자에게 온 문서들을 결재처리 (중간결재자가 모두 승인 시 최종결재자의 결재문서함에 조회됨)
     - 결재함 문서를 상태별 조회 (대기중, 승인, 반려)
     - selectbox를 통한 다중 삭제
4. 게시판: 구현 중

---

## 기술스택

### Back end/Server
- JAVA
- Spring Framework, Spring Boot
- Jsp
- Apache Tomcat 9.0
- OracleDB
- Mybatis

### Front end
- Javascript
- JQuery
- HTML5, CSS3
- Bootstrap

### Devops
- Maven
- Git
- Github

---

## DB구조(ERD)
<img width="770" alt="ERD" src="https://github.com/user-attachments/assets/54bcefd0-0382-4c6d-a10a-4065fb2ef78f">

## 로그인 및 메인화면
<img width="300" alt="로그인화면" src="https://github.com/user-attachments/assets/0a14453b-cc11-417e-8584-cdbaba3443ee">
<img width="400" alt="메인페이지" src="https://github.com/user-attachments/assets/6719c14e-fd19-413f-a150-be7a0f17c10e"><br>
1. 구현기능 설명
- 기본적인 로그인, 로그아웃
- Spring Security로 계정 권한 부여
- BCrypt 해시 함수로 비밀번호 암호화

## 인사관리 화면(직원등록,수정,삭제,조회, 근태)
<img width="350" alt="인사관리_사원수정" src="https://github.com/user-attachments/assets/2269f786-7e72-41f3-a8df-5543f5d92789">
<img width="350" alt="인사관리-사원조회" src="https://github.com/user-attachments/assets/f6043cc0-b7a3-450e-9fb5-38583ca928a0">
<img width="350" alt="인사관리_사원등록" src="https://github.com/user-attachments/assets/18a045fd-3143-46cc-a81d-06e4065ccfb9">
<img width="95" alt="근태기록" src="https://github.com/user-attachments/assets/901d8043-6264-4c71-995f-ec8491a7489e"><br>
1. 구현기능 설명
   - 조건검색을 통한 직원 검색 및 페이징 처리
   - 조회목록에서 다수 선택 후 삭제기능
   - 인사부의 특정직원 클릭시 상세페이지로 이동 후 수정(부서 수정 )처리 기능
   - 프로필사진 및 직원의 개인정보 등록/ 등록시 아이디 중복체크 및 비밀번호 정규식을 통한 체크 

## 전자결재 화면(전자결재 메인, 문서함, 작성 등)
<img width="250" alt="전자결재_메인화면" src="https://github.com/user-attachments/assets/a81866fd-93fb-4fb0-adfb-84ee5e1ff908"><br>
<img width="300" alt="결재문서함" src="https://github.com/user-attachments/assets/b78b6fba-ec11-4796-9640-822c216702c4">
<img width="250" alt="기안문서함" src="https://github.com/user-attachments/assets/337934fe-3462-4f0a-b8b5-343a7f3484e1"><br>
<img width="250" alt="지출결의서" src="https://github.com/user-attachments/assets/e7c55a4b-dbe1-4791-90cf-aef62b80ee67">
1. 구현기능 설명
   -
## 게시판 화면(게시판 글 작성, 댓글, 대댓글, 조회 수)
<img width="818" alt="게시판" src="https://github.com/user-attachments/assets/6d0c219f-789c-4a6f-b476-69258deb1292">
<img width="400" alt="게시글 상세보기_댓글" src="https://github.com/user-attachments/assets/20424746-3232-4845-9ee2-7ed8135942b6">
1. 구현기능 설명
- 자유게시판 글 작성 및 검색에 따른 페이징 처리(작성,삭)
- 글 작성 시 첨부파일 기능
- 게시판 상세보기 및 조회수 증가
- 댓글 및 대댓글 기능(자신의 댓글만 삭제가능)
