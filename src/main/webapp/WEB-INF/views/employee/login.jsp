<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
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

	<section class="login-container">
        <div class="login-div">
            <div class="logo-div">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPnxefHYLnvWuIF1nChEInB3ekM6BbxYGzHA&s">
            </div>
            <h4>회사명</h4>
            <form>
                <div class="row mb-3">
                  <label for="inputEmpNo" class="col-form-label">사원번호</label>
                  <div class="col">
                    <input type="text" class="form-control" id="inputEmpNo">
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="inputPassword" class="col-form-label">비밀번호</label>
                  <div class="col">
                    <input type="password" class="form-control" id="inputPassword">
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
            </form>
        </div>
        <div class="side-img-container">
            <img src="./jpg/city.jpg" alt="City">
        </div>
    </section>
</body>
</html>