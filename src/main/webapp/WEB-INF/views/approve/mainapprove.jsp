<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
.approval-container {
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
    background-color: rgb(106, 90, 205);
    color: white;
    border: none;
    cursor: pointer;
}

.new-doc-btn:hover {
    background-color: rgb(193, 184, 247);
    color: rgb(37, 22, 121);
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

.pending-doc, .doc-list {
    margin-bottom: 20px;
}

.pending-doc h3, .doc-list h3 {
    font-size: 20px;
    margin-bottom: 10px;
}

.doc-info {
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 10px;
}

.doc-info p {
    margin-bottom: 10px;
}

.approve-btn {
    padding: 10px 20px;
    background-color: rgb(106, 90, 205);
    color: white;
    border: none;
    cursor: pointer;
}

.approve-btn:hover {
    background-color: rgb(193, 184, 247);
    color: rgb(37, 22, 121);
}

table {
    width: 100%;
    border-collapse: collapse;
}

table th, table td {
    padding: 10px;
    text-align: left;
    border: 1px solid #ddd;
}

.status {
    padding: 5px 10px;
    border-radius: 5px;
    color: white;
}

 .status.ing {
    color: #FFA500;
}

.status.complete {
   color: #4CAF50;
} 

/* 모달창 */
.modal {
    display: none; 
    position: fixed; 
    z-index: 1000; 
    left: 0; 
    top: 0; 
    width: 100%; 
    height: 100%; 
    overflow: auto; 
    background-color: rgba(0,0,0,0.5); 
    
}

.modal-content {
    background-color: #ffffff; 
    margin: 10% auto; 
    padding: 20px; 
    border: 1px solid #888; 
    width: 80%; 
    max-width: 600px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.3);
    position: relative;
    animation: modalopen 0.5s;
}

@keyframes modalopen {
    from {transform: scale(0.8); opacity: 0;}
    to {transform: scale(1); opacity: 1;}
}

.close {
    color: #aaa; 
    position: absolute;
    right: 20px;
    top: 15px;
    font-size: 28px; 
    font-weight: bold; 
}

.close:hover,
.close:focus {
    color: #333; 
    text-decoration: none; 
    cursor: pointer; 
}

.form-select {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    gap: 20px;
}

.form-list {
    list-style: none;
    padding: 0;
    margin: 0;
    width: 40%;
    text-decoration: none;
}
.form-list li a {
    text-decoration: none;
}
.form-list li {
    padding: 12px;
    cursor: pointer;
    border: 1px solid #ddd;
    margin-bottom: 10px;
    transition: color 0.3s, border-color 0.3s;
    border-radius: 8px;
    font-weight: bold;
    color: #333;
    
}

.form-list li:hover {
    color: #007bff;
    border-color: #007bff;
}

.form-preview {
    width: 55%;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid #ddd;
    padding: 20px;
    border-radius: 8px;
    background-color: #f8f9fa;
    color: #666;
    font-size: 18px;
    font-style: italic;
}

.modal-confirm-btn,
.modal-cancel-btn {
    padding: 12px;
    width: 30%;
    border: none;
    cursor: pointer;
    border-radius: 8px;
    transition: background-color 0.3s;
    font-size: 16px;
    margin: 10px 5px;
}

.modal-confirm-btn {
    background-color: rgb(28, 70, 221);
    color: white;
}

.modal-confirm-btn:hover {
    background-color: rgb(64, 86, 251);
}

.modal-cancel-btn {
    background-color: #dc3545;
    color: white;
}

.modal-cancel-btn:hover {
    background-color: #c82333;
}

.button-container {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
}



/* 사이드바 */
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
    background-color: rgb(106, 90, 205);
    color: white;
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
    padding: 10px 20px;
    display: block;
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
</style>
</head>
<body>
    <div class="approval-container">
        <aside class="sidebar">
		    <h2>전자결재</h2>
		    <button class="new-doc-btn" onclick="openModal()">새 결재 진행</button>
		    <ul class="menu">
		        <li>
		            <a href="#" class="submenu-toggle">개인 문서함</a>
		            <ul style="text-align: center;">
		                <li><a href="#" onclick="loadDraftDoc()">기안문서함</a></li>
		                <li><a href="#" onclick="load()">임시저장함</a></li>
		                <li><a href="#" onclick="loadPendingDocs()">결재문서함</a></li>
		            </ul>
		        </li>
		        <li><a href="#">부서 문서함</a></li>
		    </ul>
		</aside>
        <div class="content">
	        <div class="container-fluid">
	            <div class="d-flex justify-content-between align-items-center mb-3">
	                <h2>전자결재 홈</h2>
	            </div>
	            <div class="pending-doc">
	                <h3>진행중</h3>
	                <div class="doc-info">
	                    <p><strong>문서제목:</strong> 휴가신청서</p>
	                    <p><strong>기안자:</strong> 직원이름</p>
	                    <p><strong>기안일:</strong> 2024-06-24</p>
	                    <p><strong>결재상태:</strong> 휴가신청서</p>
	                    <button class="approve-btn">결재하기</button>
	                </div>
	            </div>
	            <div class="doc-list">
	                <h3>기안 진행 문서</h3>
	                <table>
	                    <thead>
	                        <tr>
	                            <th>기안일</th>
	                            <th>결재양식</th>
	                            <th>긴급</th>
	                            <th>제목</th>
	                            <th>결재상태</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="doc" items="${approvalList}">
                                <tr>
                                    <td>${doc.startDate}</td>
                                    <td>${doc.docCategory}</td>
                                    <td>${doc.urgent}</td>
                                    <td>${doc.docTitle}</td>
                                    <td><span class="status ${doc.docStatus}">${doc.docStatus}</span></td>
                                </tr>
                            </c:forEach>
	                        
	                    </tbody>
	                </table>
	            </div>
	            <div class="doc-list">
	                <h3>완료 문서</h3>
	                <table>
	                    <thead>
	                        <tr>
	                            <th>기안일</th>
	                            <th>결재양식</th>
	                            <th>긴급</th>
	                            <th>제목</th>
	                            <th>문서번호</th>
	                            <th>결재상태</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr>
	                            <td>2024-06-19</td>
	                            <td>업무기안</td>
	                            <td>○</td>
	                            <td>가나다라마바</td>
	                            <td>11111-1111</td>
	                            <td><span class="status complete">완료</span></td>
	                        </tr>
	                        <tr>
	                            <td>2024-06-19</td>
	                            <td>업무기안</td>
	                            <td>○</td>
	                            <td>사아자차카타</td>
	                            <td>22222-2222</td>
	                            <td><span class="status complete">완료</span></td>
	                        </tr>
	                        
	                    </tbody>
	                </table>
	            </div>
        	</div>
	    </div>
    </div>

    <!-- 모달창 -->
<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>결재양식 선택</h2>
        <div class="form-select">
            <ul class="form-list">
                <li><a href="#" onclick="vacationDoc()">휴가신청</a></li>
                <li><a href="#" onclick="overtimeDoc()">연장근무신청</a></li>
                <li><a href="#" onclick="expenseDoc()">지출결의서</a></li>
            </ul>
            <div class="form-preview">
                이미지 파일 넣기
            </div>
        </div>
        <div class="button-container">
            <button class="modal-confirm-btn" onclick="confirmSelection()">확인</button>
            <button class="modal-cancel-btn" onclick="closeModal()">취소</button>
        </div>
    </div>
</div>
<script>
	$(document).ready(function() {
		// 서브메뉴 토글
	    $('.submenu-toggle').click(function(e) {
	        e.preventDefault();
	        var $submenu = $(this).next('ul');
	
	        $submenu.slideToggle();
	        $(this).toggleClass('active');
	    });
	});

    //기안문서함 불러오기
    function loadDraftDoc() {
        $.ajax({
            url: '${path}/approve/draftList',
            method: 'GET',
            success: function(response) {
                $('.content').html(response);
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    //결재문서함 불러오기
    function loadPendingDocs() {
        $.ajax({
            url: '${path}/approve/pendingList',  
            method: 'GET',
            success: function(response) {
                $('.content').html(response);
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.???');
            }
        });
    }
    function vacationDoc(){
        $.ajax({
            url: '${path}/approve/selectDoc',
            method: 'GET',
            data: { docType: 'vacation' },
            success: function(response){
                $('.content').html(response);
                closeModal();  
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    function overtimeDoc(){
        $.ajax({
            url: '${path}/approve/selectDoc',
            method: 'GET',
            data: { docType: 'overtime' },
            success: function(response){
                $('.content').html(response);
                closeModal();  
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

    function expenseDoc(){
        $.ajax({
            url: '${path}/approve/selectDoc',
            method: 'GET',
            data: { docType: 'expense' },
            success: function(response){
                $('.content').html(response);
                closeModal();  
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

        // 모달 열기
    function openModal() {
        document.getElementById('modal').style.display = 'block';
    }

    // 모달 닫기
    function closeModal() {
        document.getElementById('modal').style.display = 'none';
    }

    // 결재 양식 선택 확인
    function confirmSelection() {
        alert('결재 양식이 선택되었습니다.');
        closeModal();
    }

    // 모달 닫기 이벤트
    window.onclick = function(event) {
        if (event.target == document.getElementById('modal')) {
            closeModal();
        }
    }
    $(document).ready(function() {
        // 휴가 신청서 제출 시 AJAX로 처리
        $('#vacationForm').submit(function(event) {
            event.preventDefault(); // 폼의 기본 제출 동작을 막습니다.

            var formData = new FormData(this);
            $.ajax({
                url: '${path}/approve/ajaxWriteVacation',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    $('.content').html(response); // draftList.jsp를 .content div에 로드합니다.
                },
                error: function(error) {
                    alert('휴가 신청서 제출 중 오류가 발생했습니다.');
                }
            });
        });
    });
    </script>
</body>
</html>
