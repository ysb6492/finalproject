<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    * {
        padding: 0;
        margin: 0;
        list-style: none;
        box-sizing: border-box;
    }
    body {
        font-family: 'Arial', sans-serif;
        background: #f0f4f8;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        color: #333;
    }
    .login-container {
        display: flex;
        background: #fff;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        border-radius: 15px;
        overflow: hidden;
        max-width: 900px;
        width: 100%;
        position: relative;
    }
    .login-div {
	    width: 50%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: center;
	    padding: 40px;
	    background: linear-gradient(to left, #ffffff 0%, #ffffff 10%, rgba(255, 255, 255, 0) 50%);
	    z-index: 1;
	}
    .logo-div {
        display: flex;
        justify-content: center;
        width: 100%;
        margin-bottom: 20px;
    }
    .logo-div img {
        max-width: 150px;
    }
    h4 {
        margin-bottom: 20px;
        color: #007bff;
        font-weight: bold;
    }
    .side-img-container {
        width: 50%;
        position: relative;
        background: url('${path}/upload/login/city.jpg') no-repeat center center;
        background-size: cover;
    }
    .side-img-container::after {
	    content: "";
	    position: absolute;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    background: linear-gradient(to left, rgba(255, 255, 255, 0) 40%, #ffffff 100%);
	    opacity: 0.8; /* Adjust the opacity as needed */
	}
    .form-control {
        border-radius: 30px;
        padding: 10px 20px;
        border: 1px solid #ddd;
        transition: all 0.3s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }
    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
        border-radius: 30px;
        padding: 10px 20px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 8px rgba(0, 123, 255, 0.2);
    }
    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #004085;
        box-shadow: 0 6px 12px rgba(0, 86, 179, 0.3);
    }
    .form-check-label {
        margin-left: 10px;
        color: #555;
    }
    a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
        margin-top: 10px;
        display: block;
        transition: color 0.3s ease;
    }
    a:hover {
        text-decoration: underline;
        color: #0056b3;
    }
</style>
</head>
<body>
    <section class="login-container">
        <div class="login-div">
            <div class="logo-div">
                <!-- <img src="" alt="Company Logo"> -->
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
                 
                  </div>
                </div>
                <div class="text-center d-grid gap-2 col-8 mx-auto">
                    <button type="submit" class="btn btn-primary">로그인</button>
                </div>
                <div style="text-align:center;">
                	<a href="">비밀번호 찾기</a>
                </div>
            </form>
        </div>
        <div class="side-img-container">
        </div>
    </section>
</body>
</html>
