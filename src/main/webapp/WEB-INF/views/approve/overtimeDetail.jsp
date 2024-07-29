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
        width: 90%;
        margin-top: 20px;
        margin-left:20px;
        padding: 20px;
        border: 1px solid #ccc;
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
	    width: 17%; /* 각 테이블의 너비 설정 */
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
    .title {
        font-size: 22px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
    }
    .header-table-container {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;
    }
 	 table {
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: center;
    }
    th {
        background-color: #f0f0f0;
        width: 20%;
    }
    
	.input-text, .time-select {
	    width: auto;
	    border: none;
	    text-align: left;
	    background: transparent;
	    margin: 0 5px;
	}
	.input-text:focus, .time-select:focus {
	    outline: none;
	}
    
    textarea {
        width: 100%;
        border: none;
        resize: none;
        height: 250px;
    }
    textarea:focus {
        outline: none;
    }

    
    


.date-input {
    width: 150px;
    margin-right: 10px;
}

.time-input-container {
    display: flex;
    align-items: center;
    gap: 10px;
}

.time-input {
    width: 40px;
    text-align: center;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
    margin: 0 2px;
}

.inline-input {
    display: flex;
    height:100%;
    
}

.time-input::placeholder {
    color: #999;
}

.time-input-container > span {
    margin: 0 2px;
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
/*모달  */
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
<div class="container">
        <div class="title">연장근무신청서</div>
        <div class="header-table-container">
            <table style="width: 400px;">
                <tr>
                    <th style="width:100px;">기안자</th>
                    <td>${loginEmployee.empName}</td>
                </tr>
                <tr>
                    <th style="width:100px;">기안부서</th>
                    <td>${loginEmployee.deptCode.deptName}</td>
                </tr>
                <tr>
                    <th style="width:100px;">기안일</th>
                    <td><fmt:formatDate value="${document.startDate}" pattern="yyyy-MM-dd(E)"/></td>
                </tr>
                <tr>
                    <th style="width:100px;">문서번호</th>
                   <td id="docNoField">${document.docNo}</td>
                </tr>
            </table>
            <div class="approval" style=" text-align:center;">
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
        <form id="overtimeForm" method="post" action="${path}/approve/ajaxWriteOvertime">
        	<input type="hidden" id="docStatus" name="docStatus" value="0">
        	 <input type="hidden" id="observers" name="observers">
        
            <table style="height:600px;">
            	<tr>
                    <th style="">*제목</th>
                    <td>
                       <c:out value="${document.docTitle}"/>
                    </td>
                </tr>
                <tr>
                    <th style="">*근무구분</th>
                    <td>
                         <input type="radio" name="overtimeType" value="연장" <c:if test="${overtimeRequest.overtimeType == '연장'}">checked</c:if>> 연장
                    <input type="radio" name="overtimeType" value="야간" <c:if test="${overtimeRequest.overtimeType == '야간'}">checked</c:if>> 야간
                    <input type="radio" name="overtimeType" value="휴일" <c:if test="${overtimeRequest.overtimeType == '휴일'}">checked</c:if>> 휴일
                    </td>
                </tr>
                <tr>
				    <th>*근무일시</th>
				    <td class="inline-input">
				        <input type="date" name="overtimeDate" class="input-text date-input" value="${overtimeRequest.overtimeDate}">
				        <div class="time-input-container" style="margin-left:10px;">
	                         <input type="text" name="startTimeHour" class="time-input" placeholder="hour" maxlength="2" value="${overtimeRequest.overtimeStartTime.hour}" oninput="formatTime(this)">시
	                        <input type="text" name="startTimeMinute" class="time-input" placeholder="min" maxlength="2" value="${overtimeRequest.overtimeStartTime.minute}" oninput="formatTime(this)">분 ~
	                        <input type="text" name="endTimeHour" class="time-input" placeholder="hour" maxlength="2" value="${overtimeRequest.overtimeEndTime.hour}" oninput="formatTime(this)">시
	                        <input type="text" name="endTimeMinute" class="time-input" placeholder="min" maxlength="2" value="${overtimeRequest.overtimeEndTime.minute}" oninput="formatTime(this)">분
	                    </div>
				    </td>
				</tr>
                <tr>
                    <th>*근무시간</th>
                    <td>
                        <c:out value="${overtimeRequest.overtime}"/>
                    </td>
                </tr>
                <tr>
                    <th>*신청 사유</th>
                    <td>
                    	<textarea name="overtimeReason" class="input-text" placeholder="내용을 기재해주세요" readonly>${overtimeRequest.overtimeReason}</textarea>
                    </td>
                </tr>
            </table>
            
        
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