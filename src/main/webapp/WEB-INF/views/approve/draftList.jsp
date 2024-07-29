<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
section { 
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
}
.container {
    width: 100%; 
    max-width: 1500px;
    margin: 0 ;
    padding: 20px;
}
h2 {
    text-align: left;
    font-weight: 400;
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
    table-layout: fixed; /* 고정된 테이블 레이아웃 */
    
}
table, th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
    
}
th {
    background-color: #f2f2f2;
}
th.checkbox-cell, td.checkbox-cell {
    width: 5%; /* 체크박스 열의 너비 고정 */
}
th.date-cell, td.date-cell {
    width: 15%; /* 날짜 열의 너비 고정 */
}
th.category-cell, td.category-cell {
    width: 20%; /* 결재양식 열의 너비 고정 */
}
th.title-cell, td.title-cell {
    width: 30%; /* 제목 열의 너비 고정 */
}
th.number-cell, td.number-cell {
    width: 10%; /* 문서번호 열의 너비 고정 */
}
th.status-cell, td.status-cell {
    width: 20%; /* 결재상태 열의 너비 고정 */
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
.no-underline {
	    text-decoration: none; /* 밑줄 제거 */
	    color: black; /* 글자 색상을 검정색으로 */
	}
	.no-underline:hover {
	    text-decoration: underline; /* 선택 사항: 마우스 오버 시 밑줄 표시 */
	}
</style>
<body>
    <section id="draftListContent">
        <div class="container">
            <h2>기안 문서함</h2>
            <div class="status-search">
                <div class="tabs">
                    <button class="active" data-status="-1">전체</button>
                    <button data-status="0">대기</button>
                    <button data-status="1">진행</button>
                    <button data-status="2">완료</button>
                    <button data-status="3">반려</button>
                    
                </div>
                <div class="filter-section" style="margin-bottom: 20px;">
                    
                    <input type="text" placeholder="제목">
       				<button type="button" class="btn btn-outline-primary" style="height:100%;" onclick="applyFilter()">검색</button>
                </div>
            </div>
            
            <table>
                <thead>
                    <tr>
						<th class="checkbox-cell"><input type="checkbox" id="select-all"></th>
				        <th class="date-cell">기안일</th>
				        <th class="category-cell">결재양식</th>
				        <th class="title-cell">제목</th>
				        <th class="number-cell">문서번호</th>
				        <th class="status-cell">결재상태</th>
                    </tr>
                </thead>
                <tbody id="documentList">
                    <c:forEach var="doc" items="${draftList}">
                       <tr>
				            <td class="checkbox-cell"><input type="checkbox" class="select-item" value="${doc.docNo}"></td>
				            <td class="date-cell">${doc.startDate}</td>
				            <td class="category-cell">${doc.docCategory}</td>
				            <td class="title-cell">
				                <a href="#" class="document-link no-underline" data-doc-no="${doc.docNo}">
				                    ${doc.docTitle}
				                </a>
				            </td>
				            <td class="number-cell">${doc.docNo}</td>
				            <td class="status-cell">
				                <c:choose>
				                    <c:when test="${doc.docStatus == 0}">
				                        <span style="color: black;">대기중</span>
				                    </c:when>
				                    <c:when test="${doc.docStatus == 1}">
				                        <span style="color: orange;">진행중</span>
				                    </c:when>
				                    <c:when test="${doc.docStatus == 2}">
				                        <span style="color: green;">완료됨</span>
				                    </c:when>
				                    <c:when test="${doc.docStatus == 3}">
				                        <span style="color: red;">반려됨</span>
				                    </c:when>
				                </c:choose>
				            </td>
				        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-outline-danger" style="width:80px; height:35.67px"  onclick="deleteDocuments()">삭제</button>
            
            <div class="pagination">
                ${pageBar}
            </div>
            
        </div>
     </section>
     <script>
     
     document.getElementById('select-all').addEventListener('change', function() {
    	    const isChecked = this.checked;
    	    document.querySelectorAll('.select-item').forEach(function(checkbox) {
    	        checkbox.checked = isChecked;
    	    });
    	});

    	function deleteDocuments() {
    	    const selected = [];
    	    document.querySelectorAll('.select-item:checked').forEach(function(checkbox) {
    	        selected.push(checkbox.value);
    	    });

    	    if (selected.length > 0) {
    	        if (confirm('선택된 문서를 삭제하시겠습니까?')) {
    	            $.ajax({
    	                url: '${path}/approve/deleteDocuments',
    	                type: 'POST',
    	                contentType: 'application/json',
    	                data: JSON.stringify(selected),
    	                success: function(response) {
    	                    alert('선택된 문서가 삭제되었습니다.');
    	                    location.reload();
    	                },
    	                error: function(error) {
    	                    alert('문서 삭제 중 오류가 발생했습니다.');
    	                }
    	            });
    	        }
    	    } else {
    	        alert('삭제할 문서를 선택하세요.');
    	    }
    	}
    	
    	
    	
    	$(document).ready(function() {
    	    // Tab 버튼 클릭 이벤트
    	    $('.tabs button').click(function() {
    	        $('.tabs button').removeClass('active');
    	        $(this).addClass('active');
    	        var status = $(this).data('status');
    	        loadDocumentsByStatus(status, 1);
    	    });

    	    // 페이징 버튼 클릭 이벤트
    	    $(document).on('click', '.pagination button', function() {
    	        var cPage = $(this).data('page');
    	        var status = $('.tabs button.active').data('status'); // 현재 선택된 상태를 가져옴
    	        loadDocumentsByStatus(status, cPage); // 현재 선택된 상태를 전달
    	    });

    	 	// 문서 링크 클릭 이벤트
    	    $(document).on('click', '.document-link', function(event) {
    	        event.preventDefault();
    	        var docNo = $(this).data('doc-no');
    	        $.ajax({
    	            url: '${path}/approve/documentDetail',
    	            type: 'GET',
    	            data: { 
    	                docNo: docNo 
    	            },
    	            success: function(response) {
    	                $('.content').html(response);
    	            },
    	            error: function(error) {
    	                alert('문서 상세 정보를 불러오는 중 오류가 발생했습니다.');
    	            }
    	        });
    	    });
    	});
     
     
     
     function loadDocumentsByStatus(status, cPage = 1) {
    	    var url;
    	    var data = {
    	        status: status,
    	        cPage: cPage,
    	        numPerpage: 10

    	    };

    	    if (status == -1) {
    	        url = '${path}/approve/getAllDocuments';
    	    } else {
    	        url = '${path}/approve/getDocumentsByStatus';
    	    }

    	    $.ajax({
    	        url: url,
    	        type: 'GET',
    	        data: data,
    	        success: function(response) {
    	            var tbody = $('#documentList');
    	            tbody.empty();
    	            if (response && response.documentList.length > 0) {
    	                $.each(response.documentList, function(index, doc) {
    	                    var row = '<tr>' +
	                            '<td class="checkbox-cell">' + "<input type='checkbox' class='select-item' value='" + doc.docNo + "'>" + '</td>' +
	                            '<td class="date-cell">' + (new Date(doc.startDate)).toISOString().slice(0, 10) + '</td>' +
	                            '<td class="category-cell">' + doc.docCategory + '</td>' +
	                            '<td class="title-cell"><a href="#" class="document-link no-underline" data-doc-no="' + doc.docNo + '">' + doc.docTitle + '</a></td>' +
	                            '<td class="number-cell">' + doc.docNo + '</td>' +
	                            '<td class="status-cell">' + getStatusText(doc.docStatus) + '</td>' +
	                            '</tr>';
    	                    tbody.append(row);
    	                });
    	            } else {
    	                var row = '<tr><td colspan="6" style="text-align:center">조회된 문서가 없습니다.</td></tr>';
    	                tbody.append(row);
    	            }
    	         	// 페이지 바를 업데이트합니다.
    	            $('.pagination').html(response.pageBar);
    	        },
    	        error: function(error) {
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