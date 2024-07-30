# Ahome(2024)

구디 아카데미 파이널 프로젝트: 그룹웨어

- **참여인원**: 1명 (개인프로젝트)
- **프로젝트 기간**: 7/5 ~ 8/7
- **프로젝트 주제**: 기본적인 그룹웨어 기능이 구현되어있는 사이트

## 구현기능
1. 로그인 및 회원가입
   - 기본적인 로그인, 로그아웃
   - 스프링 시큐리티로 계정 권한 부여
   - BCrypt 해시 함수로 비밀번호 암호화
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

## DB구조
<img width="800" alt="erd" src="https://github.com/user-attachments/assets/d7518334-ee7b-4931-a196-7f3617bb1d18">

## 로그인화면 및 메인화면
<img width="300" alt="login" src="https://github.com/user-attachments/assets/7422d290-7f4f-408a-8d9f-e56b9eef6c05">

