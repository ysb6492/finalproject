<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="path" value="${pageContext.request.contextPath}"/>

    <style>
      
        .container {
            width: 1200px;
            background: white;
            border: 1px solid black;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            min-height: 1300px;
        }
        table {
        
            width: 100%;
            border-collapse: collapse;
            margin: 10px;
            table-layout: fixed;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
        th {
        	
            background-color: #ddd;
            border: 1px solid black; /* th 간의 테두리 */
            
        }
        td {
	        border: none; /* td의 불필요한 테두리 제거 */
	    }
        .vacation-header {
            text-align: center;
            font-size: 50px;
            font-weight: bold;
        }
        .approval-line {
        	border:none;
            text-align: right;
            display: flex;
        }
        /* jobName과 empName의 세로 높이를 줄임 */
		.approval-line .approval-table .job-name, .approval-line .approval-table .emp-name {
		    border: 1px solid black;
		    
		    height: 5px !important; /* 원하는 높이로 설정 */
		}
		
		/* 서명 td의 높이를 길게 설정 */
		.approval-line .approval-table .signature {
			border: 1px solid black;
		    height: 80px !important; /* 원하는 높이로 설정 */
		}
        .approval-line th{
        	border: 1px solid black;
        	width:35px;
        }
        .approval-line .sign_type1_inline {
            display: inline-block;
            margin-right: 10px;
        }
        .footer-note {
            background-color: #ddd;
            padding: 10px;
            font-size: 10px;
        }
        .important {
            color: red;
            font-weight: bold;
        }
        .approval-table {
        	margin: 10px;
        	border: 1px solid black; /* approval-table의 테두리 */
        	
	    }
	    .document-info {
	        width: 50%; /* 원하는 가로 길이로 설정 */
	    }
	    .document-info th, .document-info td {
	    	border: 1px solid black; /* approval-table의 테두리 */
	    
	        width: 50%; /* th와 td의 너비를 고정 */
	    }
	    .leave-reason {
	    
	        height: 500px; /* 원하는 높이로 설정 */
	    }
	    .leave-info-table th {
	   		 border: 1px solid black;
	    	text-align: center;
	        width: 20%; /* th의 가로 길이 조정 */
	    }
	    .leave-info-table td{
	   		 border: 1px solid black;
	    }
	    .attached-file {
        margin-top: 10px;
    }
    .attached-file img {
        max-width: 100%;
        height: auto;
    }
    
    
    /* 모달창 */
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
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
            max-width: 500px; 
            border-radius: 5px;
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

        .modal-footer {
            display: flex;
            justify-content: flex-end;
        }

        .modal-footer button {
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <table>
            <tr>
                <td colspan="2" class="vaction-header">연차 신청서</td>
            </tr>
            <tr>
                <td style="border:none;">
                	<div class="document-info">
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
	                            <td><c:out value="${document.docNo}"/></td>
	                        </tr>
	                    </table>
                	</div>
                </td>
                <td class="approval-line">
                    <!-- 검토자 테이블 -->
                    <c:forEach var="approvalLine" items="${approvalLines}">
                        <c:if test="${approvalLine.appvSequence == 1}">
                            <table class="approval-table">
                                <tr>
                                    <th rowspan="3">검토자</th>
                                    <td class="job-name" style="text-align:center">${approvalLine.empNo.jobCode.jobName}</td>
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
                                    <td class="emp-name" style="text-align:center">${approvalLine.empNo.empName}</td>
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
                                    <td class="job-name" style="text-align:center">${approvalLine.empNo.jobCode.jobName}</td>
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
                                    <td class="emp-name" style="text-align:center">${approvalLine.empNo.empName}</td>
                                </tr>
                            </table>
                        </c:if>
                    </c:forEach>
                </td>
            </tr>
        </table>
        <br>
        <table class="leave-info-table">
            <tr>
                <th>휴가 종류</th>
                <td><c:out value="${leaveRequest.leaveType}"/></td>
            </tr>
            <tr>
                <th>기간 및 일시</th>
                <td>
                    <fmt:formatDate value="${leaveRequest.leaveStart}" pattern="yyyy-MM-dd"/> ~ 
                    <fmt:formatDate value="${leaveRequest.leaveEnd}" pattern="yyyy-MM-dd"/>
                    <span id="usingPointArea"></span>
                </td>
            </tr>
            
            <tr>
                <th>연차 일수</th>
                <td>
                    <c:out value="${leaveRequest.leaveDays}"/>일
                </td>
            </tr>
            <tr>
                <th ><span class="important">*</span> 휴가 사유</th>
                <td class="leave-reason"><c:out value="${leaveRequest.leaveReason}"/></td>
				
            </tr>
            <tr>
                <th>첨부 파일</th>
                <td>
                	<c:choose>
				        <c:when test="${empty attachedFiles}">
				            첨부파일 없음
				        </c:when>
				        <c:otherwise>
				            <c:forEach var="file" items="${attachedFiles}">
				                <a href="${path}/resources/upload/approve/${file.fileRenamedName}" download="${file.fileOriginName}">
				                    ${file.fileOriginName}
				                </a><br>
				            </c:forEach>
				        </c:otherwise>
				    </c:choose>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="footer-note" style="font-size:14px;">
                    1. 연차의 사용은 근로기준법에 따라 전년도에 발생한 개인별 잔여 연차에 한하여 사용함을 원칙으로 한다. 단, 최초 입사시에는 근로 기준법에 따라 발생 예정된 연차를 차용하여 월 1회 사용 할 수 있다.<br>
                    2. 경조사 휴가는 행사일을 증명할 수 있는 가족 관계 증명서 또는 등본, 청첩장 등 제출<br>
                    3. 공가(예비군/민방위)는 사전에 통지서를, 사후에 참석증을 반드시 제출
                </td>
            </tr>
        </table>
        
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