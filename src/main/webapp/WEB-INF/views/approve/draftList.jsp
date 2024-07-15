<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
section {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 20px;
}
.container {
    width: 90%;
    
    margin: 0 auto;
    background: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
}
h1 {
    text-align: left;
}
.status-search{
    display: flex; 
    justify-content: space-between;
}
.tabs {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
}
.tabs button {
    padding: 10px 20px;
    border: none;
    background-color: #f0f0f0;
    cursor: pointer;
}
.tabs button.active {
    background-color: #9269d4;
    color: white;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}
table, th, td {
    border: 1px solid #ddd;
    padding: 8px;
}
th {
    background-color: #f2f2f2;
}
.status-button {
    padding: 5px 10px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}
.status-pending {
    background-color: #9269d4;
    color: white;
}
.status-inprogress {
    background-color: #FFA500;
    color: white;
}
.status-completed {
    background-color: #9E9E9E;
    color: white;
}
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
}
.pagination button {
    padding: 10px 15px;
    border: 1px solid #ddd;
    background-color: #fff;
    cursor: pointer;
}
.pagination button.active {
    background-color: #9269d4;
    color: white;
    border: none;
}
.filter-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
}
.filter-section select,
.filter-section input {
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 3px;
    
}
</style>
<body>
    <section id="draftListContent">
        <div class="container">
            <h1>기안 문서함</h1>
            <div class="status-search">
                <div class="tabs">
                    <button class="active" data-status="all">전체</button>
                    <button data-status="0">대기</button>
                    <button data-status="1">진행</button>
                    <button data-status="2">완료</button>
                    <button data-status="3">반려</button>
                    
                </div>
                <div class="filter-section" style="margin-bottom: 20px;">
                    <select>
                        <option>전체기간</option>
                        <option>1</option>
                        <option>2</option>
                    </select>
                    <input type="text" placeholder="제목">
                    <button>검색</button>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>기안일</th>
                        <th>결재양식</th>
                        <th>제목</th>
                        
                        
                        <th>문서번호</th>
                        <th>결재상태</th>
                    </tr>
                </thead>
                <tbody id="documentList">
                    <c:forEach var="doc" items="${draftList}">
                        <tr>
                            <td>${doc.startDate}</td>
                            <td>${doc.docCategory}</td>
                            <td>
                            	<a href="#" class="document-link" data-doc-no="${doc.docNo}">
				                    ${doc.docTitle}
				                </a>
                            </td>
                            
                            <td>${doc.docNo}</td>
                            
                            <td>
                                <c:choose>
                                    <c:when test="${doc.docStatus == 0}">대기중</c:when>
                                    <c:when test="${doc.docStatus == 1}">진행중</c:when>
                                    <c:when test="${doc.docStatus == 2}">완료됨</c:when>
                                    <c:when test="${doc.docStatus == 3}">거부됨</c:when>
                                </c:choose>
                            </td>
                            
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                ${pageBar}
            </div>
            
        </div>
     </section>
     <script>
     $(document).ready(function() {
    	    $('.tabs button').click(function() {
    	        $('.tabs button').removeClass('active');
    	        $(this).addClass('active');
    	        // 상태에 따른 문서 필터링 로직 추가
    	        
    	        $(this).addClass('active');
                var status = $(this).data('status');
                loadDocumentsByStatus(status);
    	    });

    	    $('.filter-section button').click(function() {
    	        var filterData = {
    	            period: $('.filter-section select').val(),
    	            title: $('.filter-section input').val()
    	        };
    	        // 필터링된 문서 목록 불러오기 로직 추가
    	    });
    	});
     $(document).on('click', '.document-link', function(event) {
         event.preventDefault();
         var docNo = $(this).data('doc-no');
         
         console.log('Loading document detail for docNo:', docNo); // 디버깅용 로그
         $.ajax({
             url: '${path}/approve/documentDetail',
             type: 'GET',
             data: { 
             	docNo: docNo 
             },
             success: function(response) {
                 console.log('Document detail loaded successfully.'); // 디버깅용 로그
                 $('.content').html(response);
             },
             error: function(error) {
                 console.log('Error loading document detail:', error); // 디버깅용 로그
                 alert('문서 상세 정보를 불러오는 중 오류가 발생했습니다.');
             }
         });
     });
     
     
     
     function loadDocumentsByStatus(status) {
    	    var url = status === 'all' ? '${path}/approve/getAllDocuments' : '${path}/approve/getDocumentsByStatus';
    	    var data = status === 'all' ? {} : { status: status };
    	    
    	    $.ajax({
    	        url: url,
    	        type: 'GET',
    	        data: data,
    	        success: function(response) {
    	            console.log('AJAX response:', response); // 응답 데이터 확인
    	            var tbody = $('#documentList');
    	            tbody.empty();
    	            if (response && response.length > 0) {
    	                $.each(response, function(index, doc) {
    	                    var row = '<tr>' +
    	                        '<td>' + (new Date(doc.startDate)).toISOString().slice(0, 10) + '</td>' +
    	                        '<td>' + doc.docCategory + '</td>' +
    	                        '<td><a href="#" class="document-link" data-doc-no="' + doc.docNo + '">' + doc.docTitle + '</a></td>' +
    	                        '<td>' + doc.docNo + '</td>' +
    	                        '<td>' + getStatusText(doc.docStatus) + '</td>' +
    	                        '</tr>';
    	                    tbody.append(row);
    	                });
    	            } else {
    	                var row = '<tr><td colspan="5">No documents found.</td></tr>';
    	                tbody.append(row);
    	            }
    	        },
    	        error: function(error) {
    	            console.log('Error loading documents by status:', error); // 디버깅용 로그
    	            alert('문서 목록을 불러오는 중 오류가 발생했습니다.');
    	        }
    	    });
    	}
     function getStatusText(status) {
         switch (status) {
             case 0: return '대기중';
             case 1: return '진행중';
             case 2: return '완료됨';
             case 3: return '거부됨';
             default: return '알 수 없음';
         }
     }
     </script>
</body>
</html>