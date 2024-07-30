<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
        /* 스타일 정의 */
        section {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 100%; /* 가로 길이를 80%로 설정 */
            max-width: 1500px;
            margin:0px;
            padding: 20px;
        }
        h2 {
            text-align: left;
            font-weight: 400;
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
        .status-search{
		    display: flex; 
		    justify-content: space-between;
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
    </head>
<body>
    <section>
        <div class="container">
            <h2>임시저장 문서함</h2>
            <div class="status-search">
                <div class="filter-section" style="margin-bottom: 20px; justify-content:;">
                    <input type="text" placeholder="제목">
       				<button type="button" class="btn btn-outline-primary" style="height:100%;" onclick="applyFilter()">검색</button>
                </div>
            </div>
            <table>
                <thead>
                    <tr>
                    	<th><input type="checkbox" id="select-all"></th>
                        <th>기안일</th>
                        <th>문서번호</th>
                        <th>결재양식</th>
                        <th>제목</th>                       
                        
                    </tr>
                </thead>
                <tbody id="documentList">
                     <c:forEach var="temp" items="${tempsaveList}">
                        <tr>
                            <td><input type="checkbox" class="select-item" value="${temp.docNo}"></td>
                            <td>${temp.startDate}</td>
							<td>${temp.docNo}</td>
                            
                            <td>${temp.docCategory}</td>
                            <td>
				                <a href="#" class="document-link no-underline" data-doc-no="${temp.docNo}">
				                    ${temp.docTitle}
				                </a>
				            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button type="button" class="btn btn-outline-danger" style="width:80px; height:35.67px"  onclick="deleteDocuments()">삭제</button>
            
            <!-- 페이지바 영역 추가 -->
            <div class="pagination" style="justify-content:center;">
                ${pageBar}
            </div>
        </div>
    </section>
    </body>
</html>

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
$(document).on('click', '.document-link', function(event) {
    event.preventDefault();
    var docNo = $(this).data('doc-no');
    
    console.log('Loading document detail for docNo:', docNo); // 디버깅용 로그
    $.ajax({
        url: '${path}/approve/editTempSaveDoc',
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
</script>