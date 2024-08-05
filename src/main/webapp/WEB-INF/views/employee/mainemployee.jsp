
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
    
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="" value="헤더"/>
</jsp:include>
<style>
body {
    background-color: #f8f9fa;
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    width: 100%;
}
.employee-container {
     display: flex;
     min-height: 100vh;
     width: 100%;
 }
.sidebar {
    width: 250px;
    background-color: #f4f4f4;
    padding: 20px;
    border-right: 0.5px solid rgb(202, 202, 202);
    flex-shrink: 0; /* 사이드바 안줄어들게하는거 */
}
.sidebar h2 {
    font-size: 24px;
    margin-bottom: 20px;
    font-weight: bold;
}
.sidebar ul.menu {
    padding: 0;
}

.sidebar ul.menu li {
    list-style: none;
    margin-bottom: 10px;
}

.sidebar ul.menu li a {
    display: block;
    padding: 10px;
    color: #333;
    background-color: #e9ecef;
    border-radius: 5px;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

.sidebar ul.menu li a:hover {
    background-color: rgb(193, 184, 247);
    color: rgb(37, 22, 121);
}

.sidebar ul.menu ul {
    padding: 0;
    display: none;
    margin-top: 10px;
}

.sidebar ul.menu ul li {
    margin-bottom: 0;
}

.sidebar ul.menu ul li a {
    background-color: #f4f4f4;
    color: #333;
}

.sidebar ul.menu ul li a:hover {
    background-color: rgb(193, 184, 247);
    color: rgb(37, 22, 121);
}

.sidebar ul.menu .submenu-toggle::after {
    content: " ▼";
    float: right;
}

.sidebar ul.menu .submenu-toggle.active::after {
    content: " ▲";
}

.sidebar ul.menu .submenu-toggle.active + ul {
    display: block;
}
.sidebar h2 {
    font-size: 24px;
    margin-bottom: 20px;
}

.new-doc-btn {
    display: block;
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
}

.new-doc-btn:hover {
    background-color: #45a049;
}

.menu {
    list-style: none;
}

.menu li {
    margin-bottom: 10px;
}

.menu a {
    text-decoration: none;
    color: #333;
}

.menu a:hover {
    text-decoration:none;
}

.content {
    
    padding: 20px;
	width: 100%;
	background: #fff;
	
}



.container-fluid {
    width: 100%;
    padding: 20px;
    background: #fff;
}
</style>

<body>
    <div class="employee-container">
        <aside class="sidebar">
            <h2 >인사관리</h2>
           	<ul class="menu">
			    <li>
			        <a href="" class="submenu-toggle">근태관리</a>
			        <ul style="text-align: center;">
			            <li><a href="#" onclick="loadMyWorktimePage()">나의 근태현황</a></li>
			            <li><a href="#" onclick="loadMyInfoPage()">나의 기본정보</a></li>
			            <li><a href="#" onclick="loadMyCommutePage()">나의 연차내역</a></li>
			            
			        </ul>
			    </li>
			    <li>
			        <a href="#" class="submenu-toggle">인사관리</a>
			        <ul style="text-align: center;">
			            <li><a href="#" onclick="loadEmpSearchPage()">사원 조회</a></li>
			            <li><a href="#" onclick="loadEmpEnrollPage()">사원 등록</a></li>
			        </ul>
			    </li>

			</ul>
        </aside>
        <div class="content" >
	        <div class="container-fluid">
	            <h3>근태 및 기본정보</h3>
        	</div>
	    </div>
    </div>
<script>
	$(document).ready(function() {
	    $('.submenu-toggle').click(function(e) {
	        e.preventDefault();
	        var $submenu = $(this).next('ul');
	
	        if ($(this).hasClass('active')) {
	            $submenu.slideUp();
	            $(this).removeClass('active');
	        } else {
	            $('.submenu-toggle.active').next('ul').slideUp();
	            $('.submenu-toggle.active').removeClass('active');
	            $submenu.slideDown();
	            $(this).addClass('active');
	        }
	    });
	});

    //사원조회페이지 불러오기
    function loadEmpSearchPage() {
        $.ajax({
            url: '${path}/employee/emplist',
            method: 'GET',
            success: function(response) {
                $('.content').html(response);
            },
            error: function(xhr, status, error) {
            	if (xhr.status === 403) {
                    alert('접근 권한이 없습니다.');
                } else {
                    alert('문서를 불러오는 중 오류가 발생했습니다.');
                }
            }
        });
    }
    //사원등록 페이지
    function loadEmpEnrollPage(){
    	$.ajax({
    		url: '${path}/employee/empenroll',
    		method: 'GET',
    		success: function(response){
    			$('.content').html(response);
    			
    		},
    		error: function(xhr, status, error) {
    			if (xhr.status === 403) {
                    alert('접근 권한이 없습니다.');
                } else {
                    alert('문서를 불러오는 중 오류가 발생했습니다.');
                }
            }
    	});
    }
    function loadMyInfoPage(){
    	$.ajax({
    		url: '${path}/commute/myinformation',
    		method: 'GET',
    		success: function(response){
    			$('.content').html(response);
    			
    		},
    		error: function(xhr, status, error) {
    			if (xhr.status === 403) {
                    alert('접근 권한이 없습니다.');
                } else {
                    alert('문서를 불러오는 중 오류가 발생했습니다.');
                }
            }
    	});
    }
    function loadMyCommutePage(){
    	$.ajax({
    		url: '${path}/commute/mycommute',
    		method: 'GET',
    		success: function(response){
    			$('.content').html(response);
    			
    		},
    		error: function(xhr, status, error) {
    			if (xhr.status === 403) {
                    alert('접근 권한이 없습니다.');
                } else {
                    alert('문서를 불러오는 중 오류가 발생했습니다.');
                }
            }
    	});
    }
    function loadMyWorktimePage(){
    	$.ajax({
    		url: '${path}/commute/myworktime',
    		method: 'GET',
    		success: function(response){
    			$('.content').html(response);
    			
    		},
    		error: function(xhr, status, error) {
    			if (xhr.status === 403) {
                    alert('접근 권한이 없습니다.');
                } else {
                    alert('문서를 불러오는 중 오류가 발생했습니다.');
                }
            }
    	});
    }
	
    
    </script>
</body>
</html>
