<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<p>로그인한 사번: ${loginEmployee.empNo}</p>

<style>
        /* 스타일 정의 */
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
    </style>
</head>
<body>
    <section>
        <div class="container">
            <h1>결재 문서함</h1>
            <div class="status-search">
                <div class="tabs">
                <!-- 0대기중, 1진행중, 2승인됨, 3반려됨 -->
                    <button class="tab-button active" data-status="all">전체</button>
                    <button class="tab-button" data-status="0">대기</button>
                    <button class="tab-button" data-status="approved">승인</button>
                    <button class="tab-button" data-status="rejected">반려</button>
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
                    	<th><input type="checkbox" id="select-all"></th>
                        <th>기안일</th>
                        <th>결재양식</th>
                        <th>제목</th>                       
                        <th>문서번호</th>
                        <th>결재상태</th>
                    </tr>
                </thead>
                <tbody id="documentList">
                    <c:forEach var="doc" items="${pendingList}">
                        <tr>
                            <td><input type="checkbox" class="select-item" value="${doc.docNo}"></td>
                            <td>${doc.startDate}</td>
                            <td>${doc.docCategory}</td>
                            <td>
				                <a href="#" class="document-link" data-doc-no="${doc.docNo}">
				                    ${doc.docTitle}
				                </a>
				            </td>
                            
                            <td>${doc.docNo}</td>
					        <c:if test="${doc.docStatus == 0}">
					            <td>대기중</td>
					        </c:if>
					        <c:if test="${doc.docStatus == 1}">
					            <td>진행중</td>
					        </c:if>
					        <c:if test="${doc.docStatus == 2}">
					            <td>완료됨</td>
					        </c:if>
					        <c:if test="${doc.docStatus == 3}">
					            <td>거부됨</td>
					        </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button onclick="deleteDocuments()">삭제</button>
            
            <!-- 페이지바 영역 추가 -->
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
            
            const status = $(this).data('status');
            if (status === "all") {
                loadAllDocuments();
            } else if (status === "0") {
                loadDocumentsByStatus(status);
            } else if (status === "approved") {
                loadApprovedDocuments();
            } else if (status === "rejected") {
                loadRejectedDocuments();
            }
        });

        $('#select-all').click(function() {
            $('.select-item').prop('checked', this.checked);
        });

        $('.select-item').click(function() {
            if (!$(this).prop('checked')) {
                $('#select-all').prop('checked', false);
            }
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

        $('.filter-section button').click(function() {
            var filterData = {
                period: $('.filter-section select').val(),
                title: $('.filter-section input').val()
            };
            // 필터링된 문서 목록 불러오기 로직 추가
        });
    });

    function loadAllDocuments() {
    	 $.ajax({
             url: '${path}/approve/pendingList',
             type: 'GET',
             success: function(response) {
                 const documentList = $('#documentList');
                 documentList.empty();
                 $(response).find('#documentList tr').each(function() {
                     documentList.append($(this));
                 });
                 const pagination = $(response).find('.pagination').html();
                 $('.pagination').html(pagination);
             },
             error: function(error) {
                 alert('문서를 불러오는 중 오류가 발생했습니다.');
             }
         });
    }

    function loadDocumentsByStatus(status) {
        $.ajax({
            url: '${path}/approve/getDocumentsByStatus',
            type: 'GET',
            data: { 
            	status: status 
            },
            success: function(response) {
                const documentList = $('#documentList');
                documentList.empty();
                response.forEach(function(doc) {
                	 var row = '<tr>' +
                     '<td><input type="checkbox" class="select-item" value="' + doc.docNo + '"></td>' +
                     '<td>' + doc.startDate + '</td>' +
                     '<td>' + doc.docCategory + '</td>' +
                     '<td>' +
                         '<a href="#" class="document-link" data-doc-no="' + doc.docNo + '">' +
                             doc.docTitle +
                         '</a>' +
                     '</td>' +
                     '<td>' + doc.docNo + '</td>';
                 
                 if (doc.docStatus == 0) {
                     row += '<td>대기중</td>';
                 } else if (doc.docStatus == 1) {
                     row += '<td>진행중</td>';
                 } else if (doc.docStatus == 2) {
                     row += '<td>완료됨</td>';
                 } else if (doc.docStatus == 3) {
                     row += '<td>거부됨</td>';
                 }
                 
                 row += '</tr>';
                    documentList.append(row);
                });
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    
    function loadApprovedDocuments() {
        $.ajax({
            url: '${path}/approve/getApprovedDocuments',
            type: 'GET',
            success: function(response) {
                const documentList = $('#documentList');
                documentList.empty();
                response.forEach(function(doc) {
                	 var row = '<tr>' +
                     '<td><input type="checkbox" class="select-item" value="' + doc.docNo + '"></td>' +
                     '<td>' + doc.startDate + '</td>' +
                     '<td>' + doc.docCategory + '</td>' +
                     '<td>' +
                         '<a href="#" class="document-link" data-doc-no="' + doc.docNo + '">' +
                             doc.docTitle +
                         '</a>' +
                     '</td>' +
                     '<td>' + doc.docNo + '</td>';
                 
                 if (doc.docStatus == 0) {
                     row += '<td>대기중</td>';
                 } else if (doc.docStatus == 1) {
                     row += '<td>승인됨</td>';
                 } else if (doc.docStatus == 2) {
                     row += '<td>완료됨</td>';
                 } else if (doc.docStatus == 3) {
                     row += '<td>거부됨</td>';
                 }
                 
                 row += '</tr>';
                    documentList.append(row);
                });
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

    function loadRejectedDocuments() {
        $.ajax({
            url: '${path}/approve/getRejectedDocuments',
            type: 'GET',
            success: function(response) {
                const documentList = $('#documentList');
                documentList.empty();
                response.forEach(function(doc) {
                	 var row = '<tr>' +
                     '<td><input type="checkbox" class="select-item" value="' + doc.docNo + '"></td>' +
                     '<td>' + doc.startDate + '</td>' +
                     '<td>' + doc.docCategory + '</td>' +
                     '<td>' +
                         '<a href="#" class="document-link" data-doc-no="' + doc.docNo + '">' +
                             doc.docTitle +
                         '</a>' +
                     '</td>' +
                     '<td>' + doc.docNo + '</td>';
                 
                 if (doc.docStatus == 0) {
                     row += '<td>대기중</td>';
                 } else if (doc.docStatus == 1) {
                     row += '<td>승인됨</td>';
                 } else if (doc.docStatus == 2) {
                     row += '<td>완료됨</td>';
                 } else if (doc.docStatus == 3) {
                     row += '<td>거부됨</td>';
                 }
                 
                 row += '</tr>';
                    documentList.append(row);
                });
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

    function deleteDocuments() {
        const selectedDocuments = Array.from(document.querySelectorAll('.select-item:checked'))
            .map(cb => cb.value);

        if (selectedDocuments.length === 0) {
            alert('삭제할 문서를 선택하세요.');
            return;
        }

        $.ajax({
            url: '${path}/approve/deleteDocuments',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(selectedDocuments),
            success: function(response) {
                alert('삭제 성공');
                location.reload();
            },
            error: function(error) {
                alert('삭제 실패: ' + error.responseText);
            }
        });
    }
    </script>
</body>
</html>