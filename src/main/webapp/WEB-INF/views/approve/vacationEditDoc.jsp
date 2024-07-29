<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>

<fmt:setLocale value="ko_KR"/>
<%
    java.util.Date now = new java.util.Date();
    request.setAttribute("now", now);
    
    // 현재 날짜를 yyyy-MM-dd 형식으로 변환
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(now);
%>

<style>
    body {
        justify-content: center;
        align-items: center;
        flex-direction: column;
        height: 100vh;
    }
    .container {
        width: 90%;
        max-width: 1100px;
        background: #fff;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 5px;
        min-height: 800px; /* 최소 높이 설정 */
    }
    .approveType {
        width: 90%;
        max-width: 1100px;
    }
    .approveType>h1 {
        text-align: left;
    }
    .bottom-area {
        display: flex;
        margin-top: 20px;
        justify-content: center;
    }
    .buttons {
        display: flex;
        gap: 10px;
    }
    .buttons button {
        padding: 10px 20px;
        border: none;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
    }
    .buttons button:hover {
        background-color: #45a049;
    }
    .header-section {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
    }
    .info {
        padding: 10px;
        width: 30%;
    }
    .info table {
        width: 100%;
        border-collapse: collapse;
    }
    .info table, .info th, .info td {
        border: 1px solid #000;
    }
    .info th, .info td {
        padding: 8px;
        text-align: left;
    }
    .info th {
        background-color: #c3c3c3; /* 배경색 추가 */
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
    .approval table, .approval th, .approval td {
        border: 1px solid #000;
    }
    .approval th, .approval td {
        text-align: center;
        padding: 8px;
        
    }
    .approval th {
        background-color: #f0f0f0;
    }
    .approval th {
        width: 25px;
        height: 150px;
    }
    h1 {
        text-align: center;
        width: 100%;
    }
    .form-section {
        border: 1px solid #000;
        padding: 20px; /* 패딩을 늘려서 여유 공간 추가 */
        margin-top: 20px;
        min-height: 400px;
        background-color: #f9f9f9; /* 배경 색상 추가 */
        border-radius: 10px; /* 둥근 모서리 추가 */
    }
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 15px; /* 마진을 약간 늘림 */
    }
    .form-group label {
        width: 95px; /* 라벨의 너비를 늘려서 정렬 개선 */
        margin-right: 10px;
        font-weight: bold;
        color: #333; /* 텍스트 색상 변경 */
        font-size: 14px; /* 폰트 크기 증가 */
    }
    .form-group input, .form-group select, .form-group textarea {
        flex: 1;
        padding: 10px; /* 패딩 증가 */
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px; /* 폰트 크기 증가 */
        transition: border-color 0.3s; /* 포커스 시 테두리 색상 전환 */
    }
    .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
        border-color: #4CAF50; /* 포커스 시 테두리 색상 변경 */
        outline: none; /* 포커스 시 기본 아웃라인 제거 */
    }
    .form-group textarea {
        height: 250px;
        resize: none;
    }
    .form-notes {
        font-size: 12px; /* 폰트 크기 감소 */
        color: #555;
        margin-bottom: 20px;
        line-height: 1.5; /* 줄 간격 증가 */
        background-color: #fff;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    .file-attachment, .related-docs {
        display: flex;
	    flex-direction: column;
	    margin-bottom: 10px;
    }

    .file-attachment label, .related-docs label {
        width: 150px; /* 라벨 너비 통일 */
        margin-right: 10px;
        font-weight: bold;
        color: #333; /* 텍스트 색상 변경 */
    }

    .file-attachment input, .related-docs input {
        flex: 1;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px; /* 폰트 크기 증가 */
    }
    .info>table th, .approval>table th{
        background-color: #c3c3c3;
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
        background-color: #fefefe;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 800px;
        border-radius: 5px;
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
        border-top: 1px solid #eee;
        border-bottom: none;
    }

    .modal-header h2 {
        margin: 0;
    }

    .modal-header .close {
        color: #aaa;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }

    .modal-header .close:hover,
    .modal-header .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .modal-body {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        padding: 20px 0;
    }

    .modal-body .left-panel, .modal-body .right-panel {
        width: 45%;
    }
    .left-panel{
        text-align: start;
    }

    .modal-body .left-panel ul {
        list-style-type: none;
        padding: 0;
    }

    .modal-body .left-panel ul li {
        margin: 5px 0;
        cursor: pointer;
    }

    .modal-body .left-panel ul li:hover {
        background-color: #f0f0f0;
    }

    .modal-body .right-panel table {
        width: 100%;
        border-collapse: collapse;
    }

    .modal-body .right-panel table, .modal-body .right-panel th, .modal-body .right-panel td {
        border: 1px solid #ddd;
        padding: 8px;
    }

    .modal-body .right-panel th {
        background-color: #f2f2f2;
        text-align: left;
    }

    .modal-body .right-panel th, .modal-body .right-panel td {
        text-align: center;
    }

    .modal-footer button {
        padding: 10px 20px;
        border: none;
        cursor: pointer;
    }

    .modal-footer .confirm-btn {
        background-color: #4CAF50;
        color: white;
    }

    .modal-footer .cancel-btn {
        background-color: #f44336;
        color: white;
    }

    /* 선택된 직원 목록 항목 스타일 */
    .selected {
        background-color: #d1e7dd;
    }
    
    .approval .job-name, .approval .emp-name {
    height: 30px; /* 원하는 높이로 조정 */
}

.approval .signature {
    height: 90px; /* 원하는 높이로 조정 */
}
</style>
<body>
    <div class="approveType">
        <h1>연차신청서 수정</h1>
    </div>

    <div class="container">
        <h1>휴가신청서</h1>
        <div class="header-section">
            <div class="info">
            
                <table>
                    <tr>
                        <th>기안자</th>
                        <td><c:out value="${document.empNo.empName}"/></td>
                    </tr>
                    <tr>
                        <th>소속</th>
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
            </div>
            <div class="approval">
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
            </div>
        </div>
        <div class="form-section">
            <form id="vacationForm" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="doc-title">* 문서 제목</label>
                    <input type="text" id="doc-title" name="docTitle" value="${document.docTitle}" required>
                </div>
                <div class="form-group">
                    <label for="doc-category">* 휴가 종류</label>
                    <select id="doc-category" name="docCategory">
                        <option value="">선택</option>
                        <option value="연차" <c:if test="${leaveRequest.leaveType == '연차'}">selected</c:if>>연차</option>
                        <option value="연장근무" <c:if test="${leaveRequest.leaveType == '연장근무'}">selected</c:if>>반차</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="leave-period">* 휴가 기간</label>
                    <input type="date" id="leave-start" name="leaveStart" value="${leaveRequest.leaveStart}">
                    <span>~</span>
                    <input type="date" id="leave-end" name="leaveEnd" value="${leaveRequest.leaveEnd}">
                    <label for="usage-days">사용일수</label>
                    <input type="text" id="leave-days" name="leaveDays" value="${leaveRequest.leaveDays}" readonly>
                    <span>일</span>
                </div>
                <div class="form-group">
                    <label for="leave-reason">* 휴가 사유</label>
                    <textarea id="leave-reason" name="docContent">${leaveRequest.leaveReason}</textarea>
                </div>

                <input type="hidden" id="observers" name="observers">

                <div class="form-notes">
                    <p>[당일 반차 신청시] 시작일만 오전/오후 체크</p>
                    <p>[예비군/민방위 신청시] 동시에 스캔하여 파일 첨부</p>
                    <p>[경조휴가 신청시] 증빙서류 스캔하여 파일 첨부 (예: 청첩장 등본 등)</p>
                </div>
                <div class="file-attachment">
				    <label for="files">파일첨부</label>
				    <input type="file" id="files" name="files" multiple>
				    <c:if test="${!empty attachedFiles}">
				        <div>
				            <c:forEach var="file" items="${attachedFiles}">
				                <a href="${path}/resources/upload/approve/${file.fileRenamedName}" download="${file.fileOriginName}">
				                    ${file.fileOriginName}
				                </a><br>
				            </c:forEach>
				        </div>
				    </c:if>
				</div>

                <input type="hidden" id="docStatus" name="docStatus" value="">

                <div class="bottom-area">
                    <div class="buttons">
                        <button type="submit" onclick="submitForm(0)">결재요청</button>
                        <button type="button" onclick="applinebtn()">결재선 선택</button>
                        <button type="button" onclick="window.location.href='${path}/approve/mainapprove'">취소</button>
                    </div>
                </div>
            </form>
        </div>
    </div>  

    <!-- 모달창 -->
    <div id="approvalModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>결재선 선택</h2>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <div class="left-panel">
                    <ul>
                        <li data-dept="D2">인사팀</li>
                        <li data-dept="D3">개발팀</li>
                        <li data-dept="D4">영업팀</li>
                    </ul>
                </div>

                <div class="right-panel">
                    <table>
                        <thead>
                            <tr>
                                <th>기안자</th>
                                <th>이름</th>
                                <th>부서</th>
                                <th>직급</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>신청</td>
                                <td><c:out value="${document.empNo.empName}"/></td>
                                <td><c:out value="${document.empNo.deptCode.deptName}"/></td>
                                <td><c:out value="${document.empNo.jobCode.jobName}"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <br>
                    <table>
                        <thead>
                            <tr>
                                <th>검토자</th>
                                <th>이름</th>
                                <th>부서</th>
                                <th>직급</th>
                            </tr>
                        </thead>
                        <tbody id="referenceTableBody">
                            <c:forEach var="reviewer" items="${approvalLines}">
                                <c:if test="${reviewer.appvSequence == 1}">
                                    <tr>
                                        <td>검토자</td>
                                        <td><c:out value="${reviewer.empNo.empName}"/></td>
                                        <td><c:out value="${reviewer.empNo.deptCode.deptName}"/></td>
                                        <td><c:out value="${reviewer.empNo.jobCode.jobName}"/></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                    <br>
                    <table>
                        <thead>
                            <tr>
                                <th>결재자</th>
                                <th>이름</th>
                                <th>부서</th>
                                <th>직급</th>
                            </tr>
                        </thead>
                         <tbody id="approveTableBody">
                            <c:forEach var="approver" items="${approvalLines}">
                                <c:if test="${approver.appvSequence != 1}">
                                    <tr>
                                        <td>결재자</td>
                                        <td><c:out value="${approver.empNo.empName}"/></td>
                                        <td><c:out value="${approver.empNo.deptCode.deptName}"/></td>
                                        <td><c:out value="${approver.empNo.jobCode.jobName}"/></td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button class="confirm-btn">확인</button>
                <button class="cancel-btn">취소</button>
                <button class="reference-btn">검토자로 추가</button>
                <button class="approver-btn">결재자로 추가</button>
            </div>
        </div>
    </div>

    <script>
        let selectedEmployee = null; 
        let selectedApprover = null;
        let selectedEmployees = [];
        let reviewerSequence = 1; // 검토자들의 순번을 동일하게 설정

        function applinebtn() {
            document.getElementById("approvalModal").style.display = "block";
            const modal = document.getElementById("approvalModal");
            const span = document.getElementsByClassName("close")[0];
            const confirmBtn = document.querySelector(".modal-footer .confirm-btn");
            const cancelBtn = document.querySelector(".modal-footer .cancel-btn");
            const referenceBtn = document.querySelector(".modal-footer .reference-btn");
            const approverBtn = document.querySelector(".modal-footer .approver-btn");

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

            referenceBtn.onclick = function() {
                if (selectedEmployee) {
                    selectedEmployee.type = "reference";
                    console.log("검토자 추가: ", selectedEmployee);
                    
                    selectedEmployee.sequence = reviewerSequence; // 동일한 순번 설정

                    selectedEmployees.push(selectedEmployee);
                    
                    const newRow = "<tr>" +
                    "<td>검토자</td>" +
                    "<td>" + selectedEmployee.name + "</td>" +
                    "<td>" + selectedEmployee.dept + "</td>" +
                    "<td>" + selectedEmployee.job + "</td>" +
                    "</tr>";
                
                    $("#referenceTableBody").append(newRow); 
   				 
   				 selectedEmployee = null; // Reset 
                } else {
                    console.log("선택된 직원이 없습니다.");
                }
            }

            approverBtn.onclick = function() {
                if (selectedEmployee) {
                    selectedEmployee.type = "approver";
                    console.log("결재자 추가: ", selectedEmployee);
                    selectedEmployee.sequence = reviewerSequence + 1; // 별도의 순번 지정

                    selectedApprover = selectedEmployee;
                    
                    const newRow = "<tr>" +
                    "<td>결재자</td>" +
                    "<td>" + selectedEmployee.name + "</td>" +
                    "<td>" + selectedEmployee.dept + "</td>" +
                    "<td>" + selectedEmployee.job + "</td>" +
                    "</tr>";
   
                     $("#approveTableBody").append(newRow); 
                     
                     selectedEmployee = null; // Reset selected employee
                } else {
                    console.log("선택된 직원이 없습니다.");
                }
            }

            confirmBtn.onclick = function() {
                const approvalSection = document.querySelector(".approval");
                approvalSection.innerHTML = ""; // 기존 테이블 초기화

                let observers = [];
                
                selectedEmployees.forEach(employee => {
                    const table = document.createElement("table");
                    table.innerHTML = 
                        "<tbody>" +
                            "<tr>" +
                                "<th rowspan='3'>검토자</th>" +
                                "<td style='height:5px !important;'>" + employee.job + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='height:70px !important;'>서명</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='height:5px !important;'>" + employee.name + "</td>" +
                            "</tr>" +
                        "</tbody>";
                    approvalSection.appendChild(table);
                    
                    observers.push(employee.id + ":" + employee.sequence);
                    console.log("검토자 추가: "+observers);
                });

                if (selectedApprover) {
                    const table = document.createElement("table");
                    table.innerHTML = 
                        "<tbody>" +
                            "<tr>" +
                                "<th rowspan='3'>결재자</th>" +
                                "<td style='height:5px !important;'>" + selectedApprover.job + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='height:70px !important;'>서명</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='height:5px !important;'>" + selectedApprover.name + "</td>" +
                            "</tr>" +
                        "</tbody>";
                    approvalSection.appendChild(table);
                    
                    observers.push(selectedApprover.id + ":" + selectedApprover.sequence);
                    console.log("결재자 추가 :"+observers);
                }

                document.getElementById('observers').value = observers.join(',');

                modal.style.display = "none";
            }
        }

        $(document).ready(function() {
            $(".left-panel ul li").click(function() {
                const deptCode = $(this).data("dept");
                const $this = $(this);
                
                if ($this.next("ul").length) {
                    $this.next("ul").remove();
                } else {
                    $.ajax({
                        url: "/employee/employeelist",
                        type: "GET",
                        data: { 
                            deptCode: deptCode 
                        },
                        success: function(data) {
                            let list = "<ul>";
                            data.forEach(function(employee) {
                                list += "<li data-empid='" + employee.empNo + "' data-empname='" + employee.empName + 
                                "' data-deptname='" + employee.deptCode.deptName + 
                                "' data-jobname='" + employee.jobCode.jobName + "'>-&nbsp; " + employee.empName +"("+employee.jobCode.jobName+")</li>";
                            });
                            list += "</ul>";
                            $this.after(list);
                            
                            $this.next("ul").find("li").click(function() {
                                selectedEmployee = {
                                    id: $(this).data("empid"),    
                                    name: $(this).data("empname"),
                                    dept: $(this).data("deptname"),
                                    job: $(this).data("jobname")
                                };
                                $(this).addClass("selected").siblings().removeClass("selected");
                            });
                        },
                        error: function() {
                            alert("직원 목록을 불러오는 데 실패했습니다.");
                        }
                    });
                }
            });
        })

        $(document).ready(function(){
            const today = "<%=today%>";
            $("#leave-start").attr("min",today);
            $("#leave-end").attr("min",today);
        })
        
        const leaveStart = document.getElementById('leave-start');
        const leaveEnd = document.getElementById('leave-end');
        const leaveDays = document.getElementById('leave-days');

        leaveStart.addEventListener('change', calculateDays);
        leaveEnd.addEventListener('change', calculateDays);

        function calculateDays() {
            const startDate = new Date(leaveStart.value);
            const endDate = new Date(leaveEnd.value);

            if (startDate && endDate && startDate <= endDate) {
                const timeDiff = endDate - startDate;
                const daysDiff = timeDiff / (1000 * 3600 * 24) + 1;
                leaveDays.value = daysDiff;
            } else {
                leaveDays.value = '';
            }
        }

        function submitForm(status) {
            document.getElementById('docStatus').value = status;

            var formData = new FormData(document.getElementById('vacationForm'));
        	 // 결재선을 수정하지 않았으면 기존 결재선을 그대로 유지하도록 처리
            if (document.getElementById('observers').value === '') {
                let existingObservers = [];
                <c:forEach var="approvalLine" items="${approvalLines}">
                    existingObservers.push('${approvalLine.empNo.empNo}:${approvalLine.appvSequence}');
                </c:forEach>
                document.getElementById('observers').value = existingObservers.join(',');
            }
            $.ajax({
                url: '${path}/approve/ajaxWriteVacation',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert("기안문서가 제출되었습니다");
                    window.location.href = '${path}/approve/draftList';
                },
                error: function(error) {
                    alert('휴가 신청서 제출 중 오류가 발생했습니다.');
                }
            });
        }
    </script>
</body>
</html>
