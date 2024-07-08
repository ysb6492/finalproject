<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    background-color: #007bff;
    color: white;
    border: none;
    cursor: pointer;
}

.approve-btn:hover {
    background-color: #45a049;
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

/* Modal styles */
.modal {
    display: none; 
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fff;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    max-width: 600px;
    text-align: center;
}

.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

.form-select {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.form-list {
    list-style: none;
    text-align: left;
    width: 30%;
}

.form-list li {
    padding: 10px;
    cursor: pointer;
    border: 1px solid #ddd;
    margin-bottom: 5px;
    transition: background-color 0.3s;
}

.form-list li:hover {
    background-color: #e0e0e0;
}

.form-preview {
    width: 65%;
}

.form-preview img {
    max-width: 100%;
}

.modal-confirm-btn, .modal-cancel-btn {
    padding: 10px 20px;
    margin: 10px;
    border: none;
    cursor: pointer;
}

.modal-confirm-btn {
    background-color: #4CAF50;
    color: white;
}

.modal-confirm-btn:hover {
    background-color: #45a049;
}

.modal-cancel-btn {
    background-color: #f44336;
    color: white;
}

.modal-cancel-btn:hover {
    background-color: #d32f2f;
}

</style>
</head>
<body>
    <div class="approval-container">
        <aside class="sidebar">
            <h2>전자결재</h2>
            <button class="new-doc-btn" onclick="openModal()">새 결재 진행</button>
            <ul class="menu">
                <li><a href="#">결재하기</a></li>
                <li>
                    <a href="#">개인 문서함</a>
                    <ul style="text-align: center;">
                        <li><a href="#" onclick="loadDraftDoc()">기안문서함</a></li>
                        <li>임시저장함</li>
                        <li>결재문서함</li>
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
	                        <tr>
	                            <td>2024-06-19</td>
	                            <td>어떤 신청서</td>
	                            <td>○</td>
	                            <td>제목부분 </td>
	                            <td><span class="status ing">진행중</span></td>
	                        </tr>
	                        
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
                    <li>업무기안신청</li>
                    <li>연장근무신청</li>
                </ul>
                <div class="form-preview">
                    이미지파일 넣기
                </div>
            </div>
            <button class="modal-confirm-btn" onclick="confirmSelection()">확인</button>
            <button class="modal-cancel-btn" onclick="closeModal()">취소</button>
        </div>
    </div>
<script>

    //기안문서함 불러오기
    function loadDraftDoc() {
        $.ajax({
            url: '${path}/approve/draftdoc',
            method: 'GET',
            success: function(response) {
                $('.content').html(response);
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    function vacationDoc(){
    	$.ajax({
    		url: '${path}/approve/vacationdoc',
    		method: 'GET',
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
	
    </script>
</body>
</html>
