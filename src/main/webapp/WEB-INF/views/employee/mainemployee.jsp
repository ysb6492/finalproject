
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
    flex-shrink: 0; /* 사이드바 안줄어들게하는거*/
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
    text-decoration: underline;
}

.content {
    flex: 1;
    padding: 20px;
	width: calc(100% - 250px);
}



.container-fluid {
    width: 100%;
    padding: 20px;
    background: #fff;
}




</style>
</head>
<body>
    <div class="employee-container">
        <aside class="sidebar">
            <h2>인사관리</h2>
<!--             <button class="new-doc-btn" onclick="openModal()">새 결재 진행</button>
 -->           <ul class="menu">
                <li>
                	<a href="#"></a>근태관리
                	<ul style="text-align: center;">
                		<li><a href="#" onclick="loadMyPage()">나의 기본정보</a></li>
                	</ul>
                
                </li>
                <li>
                    <a href="#">인사관리</a>
                    <ul style="text-align: center;">
                        <li><a href="#" onclick="loadEmpSearchPage()">사원 조회</a></li>
                        <li><a href="#" onclick="loadEmpEnrollPage()">사원 등록</a></li>
                    </ul>
                </li>
                <li><a href="#"onclick="loadDeptPage()">부서관리</a></li>
            </ul>
        </aside>
        <div class="content">
	        <div class="container-fluid">
	            <h3>근태 및 기본정보</h3>
        	</div>
	    </div>
    </div>
<script>

    //사원조회페이지 불러오기
    function loadEmpSearchPage() {
        $.ajax({
            url: '${path}/employee/emplist',
            method: 'GET',
            success: function(response) {
                $('.content').html(response);
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    function loadEmpEnrollPage(){
    	$.ajax({
    		url: '${path}/employee/empenroll',
    		method: 'GET',
    		success: function(response){
    			$('.content').html(response);
    			
    		},
    		error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
    	});
    }
	
    
    </script>
</body>
</html>
