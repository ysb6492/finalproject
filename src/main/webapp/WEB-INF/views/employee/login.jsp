<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    * {
        padding: 0px;
        margin: 0px;
        list-style: none;
    }
    .login-container {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        
    }
    .login-div {
        width: 400px;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    .logo-div {
        display: flex;
        justify-content: center;
        width: 100%;
        margin-bottom: 20px;
    }
    .logo-div img {
        max-width: 100px;
    }
    .side-img-container {
        margin-left: 0px;
    }
    .side-img-container img {
        max-width: 500px; 
        height: 400px;
    }
</style>
<body>
    <section class="login-container">
        <div class="login-div">
            <div class="logo-div">
                <img src="">
            </div>
            <h4>회사명</h4>
            <form action="${path}/loginproc" method="post">
                <div class="row mb-3">
                  <label for="inputEmpNo" class="col-form-label">아이디</label>
                  <div class="col">
                    <input type="text" class="form-control" id="inputEmpNo" name="empId" placeholder="ID">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="inputPassword" class="col-form-label">비밀번호</label>
                  <div class="col">
                    <input type="password" class="form-control" id="inputPassword" name="empPw" placeholder="Password">
                  </div>
                </div>
                
                <div class="row mb-3">
                  <div class="col-sm-7 ">
                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" id="remember-me">
                      <label class="form-check-label" for="remember-me">
                        로그인 저장
                      </label>
                    </div>
                    <div>
                    	<a href="/joinForm">사원 등록 신청</a>
                    </div>
                  </div>
                </div>
                <div class="text-center d-grid gap-2 col-8 mx-auto">
                    <button type="submit" class="btn btn-primary">로그인</button>
                </div>
            </form>
        </div>
        <div class="side-img-container">
            <img src="" alt="City">
        </div>
    </section>
</body>
</html>