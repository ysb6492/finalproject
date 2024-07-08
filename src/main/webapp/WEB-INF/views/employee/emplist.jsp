<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
    .filter-container {
        display: flex;
        justify-content: flex-end; /* 오른쪽 끝으로 배치 */
        margin-bottom: 10px;
    }
    .filter {
        display: flex;
        gap: 10px;
    }
    .filter select,
    .filter input {
        width: 150px; /* 너비 조절 */
        height: 30px; /* 높이 조절 */
        font-size: 14px; /* 글자 크기 조절 */
    }
    .filter button {
        width: 80px; /* 검색 버튼 길이 조절 */
        height: 30px; /* 높이 조절 */
        font-size: 14px; /* 글자 크기 조절 */
    }
</style>

<body>
 <div class="filter-container">
	<div class="filter" style="display:flex;">
       <select id="filterType" class="form-control">
           <option value="">필터 선택</option>
           <option value="dept">부서명</option>
           <option value="job">직책명</option>
           <option value="name">이름</option>
       </select>
       <input type="text" id="filterValue" class="form-control" placeholder="검색어 입력">
       <button type="button" class="btn btn-outline-primary" onclick="applyFilter()">검색</button>
    </div>
    </div>
	<table id="tbl-board" class="table table-striped table-hover">
            <tr>
            	<th class="checkbox-cell"><input type="checkbox" id="selectAll"></th>
                <th>사원번호</th>
                <th>부서명</th>
                <th>직책명</th>
                <th>사원이름</th>
                <th>사원아이디</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>입사일</th>
                <th>퇴사여부</th>
            </tr>
            <tbody id="employeeTableBody">
            <c:if test="${not empty employees }">
            	<c:forEach var="e" items="${employees }">
            		<tr>
            			<td class="checkbox-cell"><input type="checkbox" class="select-item" value="${e.empNo}"></td>
            			<td scope="col">${e.empNo }</td>
            			<td scope="col">${e.deptCode.deptName}</td>
						<td scope="col">${e.jobCode.jobName}</td>
						<td scope="col">
							<a href="#" onclick="loadEmpDetail('${e.empNo}')">
								<c:out value="${e.empName}"/>
							</a>
						</td>
            			<td scope="col">${e.empId}</td>
            			<td scope="col">${e.empPhone}</td>
            			
            			<td scope="col">${e.empEmail}</td>
            			<td scope="col">${e.empHiredDate}</td>
            			<td scope="col">${e.empRetiredYn}</td>
            		</tr>
            	</c:forEach>
            </c:if>
            </tbody>
        </table> 
        <div style="position: relative;">
		    <div id="pageBar" style="text-align: center;">
		        ${pageBar}
		    </div>
		    <div style="position: absolute; right: 0; top: 0;">
		        <button type="button" class="btn btn-outline-danger" onclick="deleteEmployees()">삭제</button>&nbsp;
		    </div>
		</div>
</body>
</html>
<script>
	//전체 선택 체크박스 기능
	document.getElementById('selectAll').addEventListener('change', function() {
	    const checkboxes = document.querySelectorAll('#employeeTableBody input[type="checkbox"]');
	    checkboxes.forEach(checkbox => checkbox.checked = this.checked);
	});
	function applyFilter() {
        const filterType = document.getElementById('filterType').value;
        const filterValue = document.getElementById('filterValue').value;

        $.ajax({
            url: '${path}/employee/emplist',
            type: 'GET',
            data: { 
            	filterType: filterType, filterValue: filterValue 
            },
            success: function(response) {
            	$('#employeeTableBody').html($(response).find('#employeeTableBody').html());
                $('#pageBar').html($(response).find('#pageBar').html());
            },
            error: function(error) {
                alert('검색 실패: ' + error.responseText);
            }
        });
    }
	function deleteEmployees(){
		const selectedEmployees = Array.from(document.querySelectorAll('#employeeTableBody input[type="checkbox"]:checked'))
        .map(cb => cb.value);

	    if (selectedEmployees.length === 0) {
	        alert('삭제할 직원을 선택하세요.');
	        return;
	    }
		$.ajax({
			url: '${path}/employee/deleteEmployee',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(selectedEmployees),
            success: function(response) {
                alert('삭제 성공');
                location.reload(); // 페이지를 새로고침하여 변경 사항을 반영
            },
            error: function(error) {
                alert('삭제 실패: ' + error.responseText);
            }
		})
	}
	
	function loadEmpDetail(empNo) {
        $.ajax({
            url: '${path}/employee/empdetail',
            method: 'GET',
            data: { 
            	empNo: empNo 
            },
            	
            success: function(response) {
                $('.content').html(response);
            },
            error: function(error) {
                alert('세부 정보를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
</script>