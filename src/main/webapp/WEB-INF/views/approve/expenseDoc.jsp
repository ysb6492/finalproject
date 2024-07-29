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
<body>
	<div class="approveType">
        <h3>지출결의서 신청</h3>
    </div>
    <div class="bottom-area">
        <div class="buttons">
            <button type="submit" onclick="submitForm(0)">결재요청</button>
            <button type="submit" onclick="submitForm(4)">임시저장</button>
            <button  onclick="applinebtn()">결재선 선택</button>
			<button type="button" onclick="window.location.href='${path}/approve/mainapprove'">취소</button>
        </div>
	</div>
    <div class="container">
        <div class="title">지출결의서</div>
        <div class="header-table-container">
            <table>
                <tr>
                    <th>기안자</th>
                    <td><c:out value="${loginEmployee.empName}"/></td>
                </tr>
                <tr>
                    <th>소속</th>
                    <td><c:out value="${loginEmployee.deptCode.deptName}"/></td>
                </tr>
                <tr>
                    <th>기안일</th>
                    <td><fmt:formatDate value="${now}" pattern="yyyy-MM-dd(E)"/></td>
                </tr>
                <tr>
                    <th>문서번호</th>
                    <td id="docNoField">${nextDocNo}</td>
                </tr>
            </table>   
            <div class="approval" style="width:500px; text-align:center;">
                <table style="width: 150px;" >
                	<tbody>
	                    <tr>
	                        <th rowspan="3" style="background-color: #f0f0f0; width: 10px; ">결재자</th>
	                        <td style="height: 30px; padding: 0; text-align:center;">직급</td>
	                    </tr>
	                    <tr>
	                        <td style="height: 70px; text-align:center;">서명</td>
	                    </tr>
	                    <tr>
	                        <td style="height: 30px; padding: 0px; text-align:center;">이름</td>
	                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
		<form id="expenseForm" method="post" enctype="multypart/form-data">
		    <input type="hidden" id="docStatus" name="docStatus" value="0">
		
	        <table style="height:500px;">
	            <tr class="form-group" style="height:25px;">
	                <th>제목</th>
	                <td colspan="7"><input type="text" class="input-text" id="doc-title" name="docTitle"></td>
	            </tr>
	            <tr class="form-group" style="height:25px;">
	                <th>작성일자</th>
	                <td colspan="3"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd(E)"/></td>
	                <th>소속</th>
	                <td colspan="3"><c:out value="${loginEmployee.deptCode.deptName}"/></td>
	            </tr>
	            <tr style="height:25px;">
	                <th>작성자</th>
	                <td colspan="3"><c:out value="${loginEmployee.empName}"/></td>
	                <th>금액</th>
	                <td colspan="3"><input type="text" class="input-text" id="totalField" name="totalExpense"></td>
	            </tr>
	            <tr>
	                <th>지출사유</th>
	                <td colspan="7">
	                	<textarea id="expense-reason" name="docContent" style="height: 100%;" placeholder="내용을 기재해주세요"></textarea>
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
				    <tr>
				        <td><input type="date" class="input-text" name="expenseDate" min="<%=today%>"></td>
				        <td>
				            <select class="input-text" name="expenseType">
				                <option>선택하세요</option>
				                <option value="물품구입비">물품구입비</option>
				                <option value="교통비">교통비</option>
				                <option value="식비">식비</option>
				            </select>
				        </td>
				        <td><input type="text" class="input-text" name="useInformation" placeholder="내용을 작성해주세요"></td>
				        <td><input type="text" class="input-text" name="expenseCost"></td>
				        <td><input type="text" class="input-text" name="expenseEtc"></td>
				    </tr>
				</tbody>
	        </table>
	        <div class="add-remove-buttons">
	            <button type="button" onclick="addRow()">추가</button>
				<button type="button" onclick="removeRow()">삭제</button>
	        </div>
	        <table style="margin-top: 10px;">
	            <tr>
	                <th>합계</th>
	                <td colspan="4" class="total" id="totalAmount"></td>
	            </tr>
	        </table>
	        <p>* 영수증 별도 제출</p>
		</form>
    </div>





<!-- 모달창 -->
<div id="approvalModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 style="font-weight: bold;">결재선 선택</h3>
            <span class="close">&times;</span>
        </div>
        <div class="modal-body">
            <div class="left-panel">
                <ul>
                    <li class="dept-name" data-dept="D2">인사팀</li>
                    <li class="dept-name" data-dept="D3">개발팀</li>
                    <li class="dept-name" data-dept="D4">영업팀</li>
                </ul>
            </div>
            <div class="right-panel">
                <table class="approval-table">
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
                            <td><c:out value="${loginEmployee.empName}"/></td>
                            <td><c:out value="${loginEmployee.deptCode.deptName}"/></td>
                            <td><c:out value="${loginEmployee.jobCode.jobName}"/></td>
                        </tr>
                    </tbody>
                </table>
                <br>
                <table class="approval-table">
                    <thead>
                        <tr>
                            <th>검토자</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th colspan='2'>직급</th>
                        </tr>
                    </thead>
                    <tbody id="referenceTableBody">
                    </tbody>
                </table>
                <br>
                <table class="approval-table">
                    <thead>
                        <tr>
                            <th>결재자</th>
                            <th>이름</th>
                            <th>부서</th>
                            <th colspan='2'>직급</th>
                            
                        </tr>
                    </thead>
                    <tbody id="approveTableBody">
                    </tbody>
                </table>
            </div>
        </div>
	    <div class="modal-footer">
		    <div class="left-buttons">
		        <button class="reference-btn">검토자로 추가</button>
		        <button class="approver-btn">결재자로 추가</button>
		    </div>
		    <div class="right-buttons">
		        <button class="confirm-btn">확인</button>
		        <button class="cancel-btn">취소</button>
		    </div>
		</div>
    </div>
</div>
    <script>
 	let selectedEmployee = null; 
    let selectedApprover = null;
    let selectedEmployees = [];
    let reviewerSequence = 1; // 검토자들의 순번을 동일하게 설정

	
    //결재버튼 눌러서 모달창 띄우기
	function applinebtn(){
		document.getElementById("approvalModal").style.display = "block";
		const modal = document.getElementById("approvalModal");
		const span = document.getElementsByClassName("close")[0];
        const confirmBtn = document.querySelector(".modal-footer .confirm-btn");
        const cancelBtn = document.querySelector(".modal-footer .cancel-btn");
        const referenceBtn = document.querySelector(".modal-footer .reference-btn");
        const approverBtn = document.querySelector(".modal-footer .approver-btn");
     	// 엑스버튼 눌러서 닫는거
        span.onclick = function() {
            modal.style.display = "none";
        }
    	// 닫기버튼 눌러서 닫기
        cancelBtn.onclick = function() {
            modal.style.display = "none";
        }
        // 모달창 밖에 클릭해도 닫히게
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
     	// 중간결재자로 추가 버튼 클릭 시
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
                "<td><button onclick='removeReviewer(this)'>삭제</button></td>" + // 삭제 버튼 추가
                "</tr>";
            
				 /* document.querySelector("#referenceTableBody").insertAdjacentHTML("beforeend", newRow); */
				 $("#referenceTableBody").append(newRow); 
				 
				 selectedEmployee = null; // Reset 
				 
           	} else {
                console.log("선택된 직원이 없습니다.");
            }
        }
    	 // 결재자로 추가 버튼 클릭 시
   	    approverBtn.onclick = function() {
            if (selectedEmployee) {
            	if (selectedEmployee.job !== "과장") {
                    alert("최종 결재자는 과장만 선택할 수 있습니다.");
                    return;
                }
            	
            	selectedEmployee.type = "approver";
                console.log("결재자 추가: ", selectedEmployee);
                selectedEmployee.sequence = reviewerSequence+ 1; // 별도의 순번 지정

                selectedApprover = selectedEmployee;
                
                const newRow = "<tr>" +
                "<td>결재자</td>" +
                "<td>" + selectedEmployee.name + "</td>" +
                "<td>" + selectedEmployee.dept + "</td>" +
                "<td>" + selectedEmployee.job + "</td>" +
                "<td><button onclick='removeApprover(this)'>삭제</button></td>" + // 삭제 버튼 추가
                "</tr>";

                 $("#approveTableBody").append(newRow); 
                 
                 selectedEmployee = null; // Reset selected employee
            } else {
                console.log("선택된 직원이 없습니다.");
            }
        }
        // 확인버튼 눌럭서 닫기
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
         	// 결재자 정보를 hidden 필드에 설정
            document.getElementById('observers').value = observers.join(',');

            modal.style.display = "none";
        }
    }
	// 검토자 삭제 함수
	function removeReviewer(button) {
	    const row = button.parentElement.parentElement;
	    const index = Array.from(row.parentElement.children).indexOf(row);
	    selectedEmployees.splice(index, 1);
	    row.remove();
	    console.log("검토자 삭제: ", selectedEmployees);
	}

	// 결재자 삭제 함수
	function removeApprover(button) {
	    const row = button.parentElement.parentElement;
	    selectedApprover = null;
	    row.remove();
	    console.log("결재자 삭제");
	}
	
	//모달창에서 부서별 직원리스트
	$(document).ready(function() {
        $(".left-panel ul li").click(function() {
            const deptCode = $(this).data("dept");
            const $this = $(this);
        	 // 기존에 명단이 있다면 제거
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
                    	// 직급 순서 배열
                        const jobOrder = ["과장","팀장", "팀원"];
                    	 // 직급에 따라 정렬
                        data.sort(function(a, b) {
                            return jobOrder.indexOf(a.jobCode.jobName) - jobOrder.indexOf(b.jobCode.jobName);
                        });
                        let list = "<ul class='tree'>";
                       
                        data.forEach(function(employee) {
 								list += "<li data-empid='" + employee.empNo + "' data-empname='" + employee.empName + 
 								"' data-deptname='" + employee.deptCode.deptName + 
 								"' data-jobname='" + employee.jobCode.jobName + "'><svg xmlns='http://www.w3.org/2000/svg' width='20' height='20' fill='currentColor' class='bi bi-person-fill' viewBox='0 0 16 16'>" +
 									  "<path d='M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6'/>"+
 										 "</svg>&nbsp; " + employee.empName +" ["+employee.jobCode.jobName+"]</li>";
                        });
                        list += "</ul>";
                        console.log("나온 HTML:", list);
                   
                        $this.after(list);


                        // 클릭 시 토글
                        $this.next("ul").find("li").click(function() {
                        	if ($(this).hasClass("selected")) {
                                $(this).removeClass("selected");
                                selectedEmployee = null;
                            } else {
                            selectedEmployee = {
                            	id: $(this).data("empid"),	
                            		
                                name: $(this).data("empname"),
                                dept: $(this).data("deptname"),
                                job: $(this).data("jobname")
                            };
                            console.log("selectedEmploye: ",selectedEmployee)
                            $(this).addClass("selected").siblings().removeClass("selected");
                            }
                        });
                        
                    },
                    error: function() {
                        alert("직원 목록을 불러오는 데 실패했습니다.");
                   	}
               	});
            }
       });
	});	
	
    
    
    
    
    
    
    
    
    
    
    ////////////////////////////////////////////기본
        function addRow() {
        	 event.preventDefault();
            var table = document.getElementById('detailsBody');
            var newRow = table.insertRow();
            for (var i = 0; i < 5; i++) {
                var newCell = newRow.insertCell();
                if (i === 0) {
                    var input = document.createElement('input');
                    input.type = 'date';
                    input.className = 'input-text';
                    input.name = 'expenseDate'; // name 속성 추가

                    input.min = new Date().toISOString().split('T')[0]; // 현재 날짜 이전 선택 불가

                    newCell.appendChild(input);
                } else if (i === 1) {
                    var select = document.createElement('select');
                    select.className = 'input-text';
                    select.name = 'expenseType'; // name 속성 추가

                    var options = ['선택하세요', '물품구입비', '교통비', '식비'];
                    for (var option of options) {
                        var opt = document.createElement('option');
                        opt.value = option;
                        opt.text = option;
                        select.appendChild(opt);
                    }
                    newCell.appendChild(select);
                } else if (i == 2) {
                    var input = document.createElement('input');
                    input.type = 'text';
                    input.className = 'input-text';
                    input.name = 'useInformation'; // name 속성 추가

                    input.placeholder = "내용을 작성해주세요 "
                    newCell.appendChild(input);
                }else if (i == 3) {
                    var input = document.createElement('input');
                    input.type = 'text';
                    input.className = 'input-text';
                    input.name = 'expenseCost'; // name 속성 추가
                    newCell.appendChild(input);
                } else {
                    var input = document.createElement('input');
                    input.type = 'text';
                    input.className = 'input-text';
                    input.name = 'expenseEtc'; // name 속성 추가
                    newCell.appendChild(input);
                }
            }
            calculateTotal();
        }

        function removeRow() {
        	 event.preventDefault();
            var table = document.getElementById('detailsBody');
            if (table.rows.length > 0) {
                table.deleteRow(-1);
                calculateTotal();
            }
        }

        function calculateTotal() {
            var table = document.getElementById('detailsBody');
            var total = 0;
            for (var i = 0; i < table.rows.length; i++) {
                var amount = table.rows[i].cells[3].querySelector('input').value;
                if (amount) {
                    total += parseFloat(amount.replace(/,/g, '')) || 0;
                }
            }
            document.getElementById('totalAmount').innerText = total.toLocaleString();
            document.getElementById('totalField').value = total.toLocaleString(); // 합계를 지정된 입력 필드에도 업데이트

        }

        document.addEventListener('input', function(e) {
            if (e.target.closest('#detailsBody')) {
                calculateTotal();
            }
        });

        window.onload = calculateTotal;
        
        
        
        
     	// 문서가 로드된 후 첫 번째 날짜 필드에 min 값을 설정
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('expense-date').min = today;
            document.querySelectorAll('input[type="date"]').forEach(function(input) {
                input.min = today;
            });
        });
	   	
        function submitForm(status) {
        	document.getElementById('docStatus').value = status;
            var formData = new FormData(document.getElementById('expenseForm'));
            
            var detailsTable = document.getElementById('detailsBody');
            var details = [];

            for (var i = 0; i < detailsTable.rows.length; i++) {
                var row = detailsTable.rows[i];
                var expenseDate = row.cells[0].querySelector('input').value;
                
                var detail = {
                    expenseDate: row.cells[0].querySelector('input').value,
                    expenseType: row.cells[1].querySelector('select').value,
                    useInformation: row.cells[2].querySelector('input').value,
                    expenseCost: row.cells[3].querySelector('input').value.replace(/,/g, ''),
                    expenseEtc: row.cells[4].querySelector('input').value
                };
                details.push(detail);
            }

            var jsonData = {
                params: Object.fromEntries(formData.entries()),
                observers: document.getElementById('observers').value,
                docStatus: status,
                details: details
            };
    	    $.ajax({
    	        url: '${path}/approve/ajaxWriteExpense',
    	        type: 'POST',
    	        data: JSON.stringify(jsonData),
    	        contentType: 'application/json; charset=UTF-8',
    	        success: function(response) {
    	        	if (status == 4) {
                    	$('.content').html(response);
                        alert("문서가 임시 저장되었습니다.");
                    } else {
                    	$('.content').html(response);
                        alert("기안문서가 제출되었습니다");
                        
                    }
    	        },
    	        error: function(error) {
    	            alert('지출결의서 제출 중 오류가 발생했습니다.');
    	        }
    	    });
    	}
    </script>
</body>
</html>
