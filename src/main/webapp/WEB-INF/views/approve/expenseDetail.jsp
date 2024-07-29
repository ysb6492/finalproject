<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<fmt:setLocale value="ko_KR"/>

<style>
        body {
            font-family: 'Malgun Gothic', dotum, arial, tahoma;
            
            line-height: normal;
            background-color: #f8f8f8;
            
            height: 100vh;
        }
        .container {
            width: 80%;
            margin-top: 20px;
            margin-left:20px;
            border: 1px solid #ccc;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            min-height: 1000px;
        }
        .bottom-area {
        display: flex;
        margin-top: 20px;
        justify-content: start;
        
    }
    .buttons {
        display: flex;
        gap: 10px;
    }
    .buttons button {
        padding: 10px 20px;
        border: none;
        background-color: rgb(106, 90, 205);
        color: white;
        cursor: pointer;
    }
    .buttons button:hover {
        background-color: rgb(193, 184, 247);
        color: rgb(37, 22, 121);
    }
    .approval {
    
	    text-align: center;
	    width: 100%; /* 가로 정렬을 위해 넓이를 100%로 설정 */
	    height: 100%;
	    display: flex;
	    flex-direction: row; /* 가로 정렬 */
	    justify-content: end; /* 시작 위치에 정렬 */
	    align-items: start; /* 상단에 정렬 */
	    flex-wrap: wrap; /* 넘치면 다음 줄로 넘어가도록 설정 */
	}
    .approval table {
	    width: 20%; /* 각 테이블의 너비 설정 */
	    height: auto;
	    margin: 5px; /* 테이블 간의 간격 설정 */
	    border-collapse: collapse;
	}

    .approval th, .approval td {
        text-align: center;
        padding: 8px;
    }
    .approval th {
        background-color: #f0f0f0;
    }
    .approval th {
    	width:25px;
        height: 150px; 
    }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 10px;
            
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
            vertical-align: middle;
        }
        th {
            background-color: #f0f0f0;
        }
        .title {
            font-size: 25px;
            font-weight: bold;
            text-align: center;
            padding: 10px 0;
        }
        .add-remove-buttons {
            text-align: right;
            margin-top: 10px;
        }
        .add-remove-buttons button {
            background-color: #666;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            margin: 0 5px;
            cursor: pointer;
        }
        .add-remove-buttons button:hover {
            background-color: #555;
        }
        .total {
            text-align: right;
            font-weight: bold;
            padding: 10px 0;
            
        }
        .input-text {
            width: 100%;
            border: none;
            text-align: center;
            background: transparent;
        }
        .input-text:focus {
            outline: none;
        }
        textarea {
            width: 100%;
            
            border: none;
            resize: none;
        }
        textarea:focus {
            outline: none;
            
        }
        .header-table-container {
            display: flex;
            justify-content: space-between;
        }
        .header-table-container table {
            width: 30%;
        }
        
	    .approval-table {
	        width: 30%;
	    }
	    
	    
   /* 모달창 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	padding-top: 60px;
}

.modal-content {
    background-color: #ffffff;
    margin: 5% auto;
    padding: 20px;
    border: 1px solid #ddd;
    width: 80%;
    max-width: 900px;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    display: flex;
    flex-direction: column;
}

.modal-header, .modal-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
}

.modal-footer {
    display: flex;
    justify-content: space-between; /* 버튼을 양 끝으로 배치 */
    align-items: center;
    padding: 10px 0;
    border-top: 1px solid #eee;
}

.modal-header h2 {
    margin: 0;
    font-size: 1.5em;
}

.modal-header .close {
    color: #aaa;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
}

.modal-header .close:hover,
.modal-header .close:focus {
    color: #000;
    text-decoration: none;
    cursor: pointer;
}

.modal-body {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    padding: 20px 0;
}

.left-panel {
    width: 30%;
    padding-right: 20px;
    border-right: 1px solid #ddd;
    max-height: 400px; /* 원하는 높이로 설정 */
    overflow-y: auto;
}

.left-panel ul {
    list-style-type: none;
    padding: 0;
}

.left-panel ul li {
    margin: 5px 0;
    padding: 10px;
    cursor: pointer;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #f9f9f9;
    transition: background-color 0.3s ease;
}

.left-panel ul li.dept-name {
    font-weight: bold;
    font-size: 1.1em;
    
}

.left-panel ul li:hover {
    background-color: #e6e6e6;
}

.right-panel {
    width: 65%;
    padding-left: 20px;
}

.approval-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 10px;
}

.approval-table th, .approval-table td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}

.approval-table th {
    background-color: #f0f0f0;
    font-size: 1em;
}

.modal-footer button {
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}
.modal-footer .left-buttons {
    display: flex;
    gap: 10px; /* 버튼 간격 조정 */
}

.modal-footer .right-buttons {
    display: flex;
    gap: 10px; /* 버튼 간격 조정 */
}
.modal-footer .confirm-btn {
    background-color: #28a745;
    color: white;
}

.modal-footer .confirm-btn:hover {
    background-color: #218838;
}
.modal-footer .cancel-btn {
    background-color: #dc3545;
    color: white;
}

.modal-footer .cancel-btn:hover {
    background-color: #c82333;
}

.modal-footer .reference-btn, .modal-footer .approver-btn {
    background-color: #007bff;
    color: white;
}

.modal-footer .reference-btn:hover, .modal-footer .approver-btn:hover {
    background-color: #0069d9;
}
/* 하이라이트된 사원 스타일 */
.left-panel ul li.selected {
    background-color: rgb(180, 180, 180);
    border-color: rgb(180, 180, 180);
    color: black;
}   


.tree {
    list-style: none;
    padding-left: 20px;
    position: relative;
}

.tree::before {
    content: '';
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    width: 1px;
    background: #ccc;
}

.tree li {
    margin: 0;
    padding: 0;
    padding-left: 20px;
    line-height: 24px;
    position: relative;
}

.tree li::before {
    content: '';
    position: absolute;
    top: 12px;
    left: 0;
    width: 10px;
    height: 1px;
    background: #ccc;
}

.tree li:last-child::before {
    height: 12px;
    top: 12px;
}
</style>
<body>
    <div class="container">
        <div class="title">지출결의서</div>
        <div class="header-table-container">
            <table>
                <tr>
                    <th>기안자</th>
                    <td><c:out value="${document.empNo.empName}"/></td>
                </tr>
                <tr>
                    <th>기안부서</th>
                    <td><c:out value="${document.empNo.deptCode.deptName}"/></td>
                </tr>
                <tr>
                    <th>기안일</th>
                    <td><fmt:formatDate value="${document.startDate}" pattern="yyyy-MM-dd(E)"/></td>
                </tr>
                <tr>
                    <th>문서번호</th>
                    <td id="docNoField">${document.docNo}</td>
                </tr>
            </table>   
            <div class="approval" style="width:500px; text-align:center;">
                <!-- 검토자 테이블 -->
                    <c:forEach var="approvalLine" items="${approvalLines}">
                        <c:if test="${approvalLine.appvSequence == 1}">
                            <table class="approval-table">
                                <tr>
                                    <th rowspan="3">검토자</th>
                                    <td class="job-name" style="text-align:center; height:5px;">${approvalLine.empNo.jobCode.jobName}</td>
                                </tr>
                                <tr>
                                    <td class="signature" style="text-align:center">
                                        <c:if test="${approvalLine.appvStatusCode == 3}">
                                            <img src="${path}/resources/images/approval_stamp.png" alt="승인 도장" width="50" height="50" />
                                        </c:if>
                                        <c:if test="${approvalLine.appvStatusCode == 1}">
                                            <img src="${path}/resources/images/reject_stamp.png" alt="반려 도장" width="50" height="50" />
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="emp-name" style="text-align:center; height:5px;">${approvalLine.empNo.empName}</td>
                                </tr>
                            </table>
                        </c:if>
                    </c:forEach>

                    <!-- 결재자 테이블 -->
                    <c:forEach var="approvalLine" items="${approvalLines}">
                        <c:if test="${approvalLine.appvSequence != 1}">
                            <table class="approval-table">
                                <tr>
                                    <th rowspan="3">결재자</th>
                                    <td class="job-name" style="text-align:center; height:5px;">${approvalLine.empNo.jobCode.jobName}</td>
                                </tr>
                                <tr>
                                    <td class="signature" style="text-align:center">
                                        <c:if test="${approvalLine.appvStatusCode == 3}">
                                            <img src="${path}/resources/images/approval_stamp.png" alt="승인 도장" width="50" height="50" />
                                        </c:if>
                                        <c:if test="${approvalLine.appvStatusCode == 1}">
                                            <img src="${path}/resources/images/reject_stamp.png" alt="반려 도장" width="50" height="50" />
                                        </c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="emp-name" style="text-align:center; height:5px;">${approvalLine.empNo.empName}</td>
                                </tr>
                            </table>
                        </c:if>
                    </c:forEach>
            </div>
        </div>
		<form id="expenseForm" method="post" enctype="multypart/form-data">
		    <input type="hidden" id="docStatus" name="docStatus" value="0">
		
	        <table style="height:500px;">
	            <tr class="form-group" style="height:25px;">
	                <th>제목</th>
	                <td colspan="7"><c:out value="${document.docTitle}"/></td>
	            </tr>
	            <tr class="form-group" style="height:25px;">
	                <th>작성일자</th>
	                <td colspan="3"><fmt:formatDate value="${document.startDate}" pattern="yyyy-MM-dd(E)"/></td>
	                <th>소속</th>
	                <td colspan="3"><c:out value="${document.empNo.deptCode.deptName}"/></td>
	            </tr>
	            <tr style="height:25px;">
	                <th>작성자</th>
	                <td colspan="3"><c:out value="${document.empNo.empName}"/></td>
	                <th>금액</th>
	                <td colspan="3">
	                	<c:if test="${not empty expenseRequest}">
			                <c:out value="${expenseRequest[0].totalExpense}"/>원
			            </c:if>
	                </td>
	            </tr>
	            <tr>
	                <th>지출사유</th>
	                <td colspan="7">
	                	<c:forEach var="expense" items="${expenseRequest}">
	                		<c:out value="${expense.expenseReason}"/>
	                	</c:forEach>
	                </td>
	            </tr>
	        </table>
	        
	        <input type="hidden" id="observers" name="observers">
	        
	        <table id="detailsTable">
	            <thead>
	                <tr>
	                    <th>일자</th>
	                    <th>분류</th>
	                    <th>사용 내역</th>
	                    <th>금액</th>
	                    <th>비고</th>
	                </tr>
	            </thead>
	            <tbody id="detailsBody">
			        <c:forEach var="expense" items="${expenseRequest}">
			            <tr>
			                <td><input type="date" class="input-text" name="expenseDate" value="${expense.expenseDate}" readonly></td>
			                <td><input type="text" class="input-text" name="expenseType" value="${expense.expenseType}" readonly></td>
			                <td><input type="text" class="input-text" name="useInformation" value="${expense.useInformation}" readonly></td>
			                <td><input type="text" class="input-text" name="expenseCost" value="${expense.expenseCost}" readonly></td>
			                <td><input type="text" class="input-text" name="expenseEtc" value="${expense.expenseEtc}" readonly></td>
			            </tr>
			        </c:forEach>
			    </tbody>
	        </table>
	        
	        <table style="margin-top: 10px;">
	            <tr>
	                <th>합계</th>
	                <td colspan="4" class="total" id="totalAmount">
	                	<c:if test="${not empty expenseRequest}">
			                <c:out value="${expenseRequest[0].totalExpense}"/>원
			            </c:if>
	                </td>
	            </tr>
	        </table>
	        <p>* 영수증 별도 제출</p>
		</form>	
    </div>
    
        <div class="approval-buttons">
            <c:if test="${not empty approvalLines}">
                <c:forEach var="line" items="${approvalLines}">
                    <c:if test="${line.empNo.empNo == loginEmployee.empNo && line.appvStatusCode == 0}">
                        <form id="approveForm"  style="display:inline;">
                            <input type="hidden" name="docNo" value="${document.docNo}">
                            <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
                            <input type="hidden" name="appvSequence" value="${line.appvSequence}">
                            <input type="hidden" name="appvStatusCode" value="3">
                   			<button type="button" onclick="submitApproveForm()">승인</button>
                        </form>
                        <form id="rejectForm"  style="display:inline;">
                            <input type="hidden" name="docNo" value="${document.docNo}">
                            <input type="hidden" name="empNo" value="${loginEmployee.empNo}">
                            <input type="hidden" name="appvSequence" value="${line.appvSequence}">
                  			<input type="hidden" name="appvStatusCode" value="1">
                  			
                  			<button type="button" onclick="openRejectModal()">반려</button>
                        </form>
                    </c:if>
                </c:forEach>
            </c:if>
       <!-- 반려 메시지 표시 -->
            <c:if test="${not empty comments}">
			    <table class="rejectMessage" style="border:1px solid black; border-collapse: collapse; width: 50%;">
			        <tr>
			            <th style="border:1px solid black; text-align: center; background-color: #ddd; width:20%;">반려자</th>
			            <td style="border:1px solid black; text-align: center; text-align:start;">
			                <c:forEach var="comment" items="${comments}">
			                    ${comment.empNo.empName}<br>
			                </c:forEach>
			            </td>
			        </tr>
			        <tr>
			            <th style="border:1px solid black; text-align: center; background-color: #ddd; width:20%;">반려메세지</th>
			            <td style="border:1px solid black; text-align: center; text-align:start; ">
			                <c:forEach var="comment" items="${comments}">
			                    ${comment.commentContent}<br>
			                </c:forEach>
			            </td>
			        </tr>
			        <tr>
			            <th style="border:1px solid black; text-align: center; background-color: #ddd; width:20%;">반려일</th>
			            <td style="border:1px solid black; text-align: center; text-align:start;">
			                <c:forEach var="comment" items="${comments}">
			                    <fmt:formatDate value="${comment.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/><br>
			                </c:forEach>
			            </td>
			        </tr>
			    </table>
			</c:if>
        </div>
        
        
        <!-- 반려 메시지 입력 모달 -->
    <div id="rejectModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>반려 메시지 입력</h2>
            <textarea id="rejectMessage" rows="4" style="width: 100%;"></textarea>
            <div class="modal-footer">
                <button id="cancelRejectBtn">취소</button>
                <button id="confirmRejectBtn">반려</button>
            </div>
        </div>
    </div>
   <script>
    function submitApproveForm() {
        $.ajax({
            url: '${path}/approve/ajaxApproveDocument',
            type: 'POST',
            data: $('#approveForm').serialize(),
            success: function(response) {
                alert('승인되었습니다.');

                loadPendingDocs(); // 승인 후 결재문서함 로드
            },
            error: function(error) {
                alert('승인 처리 중 오류가 발생했습니다.');
            }
        });
    }

    
    
 // 모달 관련 스크립트
    var modal = document.getElementById("rejectModal");
    var span = document.getElementsByClassName("close")[0];
    var cancelBtn = document.getElementById("cancelRejectBtn");
    var confirmBtn = document.getElementById("confirmRejectBtn");

    function openRejectModal() {
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    cancelBtn.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    confirmBtn.onclick = function() {
        var rejectMessage = document.getElementById("rejectMessage").value;
        var formData = $('#rejectForm').serialize() + '&rejectMessage=' + encodeURIComponent(rejectMessage);
		
        $.ajax({
            url: '${path}/approve/ajaxRejectDocument ',
            type: 'POST',
            data:formData,
            success: function(response) {
            	if (response.startsWith('error:')) {
                    alert('반려 처리 중 오류가 발생했습니다: ' + response);
                } else {
                    alert('반려되었습니다.');
                    loadPendingDocs(); // 반려 후 결재문서함 로드
                }
            },
            error: function(error) {
                alert('반려 처리 중 오류가 발생했습니다.');
            }
        });
        
        modal.style.display = "none";
    }

    </script>
</body>
</html>