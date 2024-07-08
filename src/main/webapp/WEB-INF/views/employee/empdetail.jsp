<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
   <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1700px;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
        }
        .profile {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
        .profile img {
            border-radius: 50%;
            width: 200px;
            height: 200px;
            object-fit: cover;
            margin: 20px;
        }
        .profile-info {
            flex: 1;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
           padding: 15px;
            text-align: left;
            font-size: 16px;
        }
        th {
            background-color: #f4f4f4;
        }
        
        
        input[type="text"], input[type="date"], select {
        width: calc(100% - 30px); /* input padding 적용을 위한 너비 조정 */
        padding: 10px;
        margin-top: 5px;
        margin-bottom: 5px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
    }
    input[type="text"]:focus, input[type="date"]:focus, select:focus {
        border-color: #007bff;
        outline: none;
    }
        
        .form-buttons {
            text-align: center;
            margin-top: 20px;
        }
        .form-buttons button {
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 18px;
        }
        .form-buttons .save {
            
        }
        .form-buttons .cancel {
            
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile">
            <img src="" alt="프로필 사진">
            <div class="profile-info">
                <table>
                    <tr>
                        <th>사원번호</th>
                        <td>${employee.empNo}</td>
                        <th>주민번호</th>
                        <td>${employee.empResidentNo }</td>
                    </tr>
                    <tr>
                        <th>사원이름</th>
                        <td><input type="text" name="empName" value="${employee.empName}"></td>
                        <th>사원ID</th>
                        <td><input type="text" name="empId" value="${employee.empId }"></td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td><input type="text" name="empEmail" value="${employee.empEmail }"></td>
                        <th>휴대번호</th>
                        <td><input type="text" name="empPhone" value="${employee.empPhone }"></td>
                    </tr>
                    <tr>
                        <th>부서</th>
                        <td>
                        	<select name="deptCode">
                                <option value="${employee.deptCode.deptCode}">${employee.deptCode.deptName }</option>
                                <option value="D2">인사팀</option>
                                <option value="D3">개발팀</option>
                                <option value="D4">영업팀</option>
                            </select> 
                        	
                        </td>
                        <th>직책</th>
                        <td><select name="jobCode">
                                <option value="${employee.jobCode.jobCode}">${employee.jobCode.jobName }</option>
                                <option value="J3">과장</option>
                                <option value="J4">팀장</option>
                                <option value="J5">팀원</option>
                            </select>
                         </td>
                    </tr>
                    <tr>
                        <th>입사일</th>
                        <td><input type="date" name="empHiredDate" value="${employee.empHiredDate }"></td>
                        <th>퇴사여부</th>
                        <td>
                            <select name="empRetiredYn" value="${employee.empRetiredYn }">
                                <option value="N">N</option>
                                <option value="Y">Y</option>
                            </select>    
                        </td>
                    </tr>
                    <tr>
                        <th>우편번호</th>
                        <td><input type="text" name="empPostcode" value="${employee.empPostcode }"></td>
                        <th>기본주소</th>
                        <td><input type="text" name="empAddress" value="${employee.empAddress }"></td>
                    </tr>
                    <tr>
                        <th>상세주소</th>
                        <td colspan="3"><input type="text" name="empDetailAddress" style="width: 100%;" value=${employee.empDetailAddress }></td>
                    </tr>
                </table>
            </div>
        </div>
        
        <div class="form-buttons">
        	<button type="button" class="btn btn-outline-success save" onclick="submitForm()">수정</button>
            <button type="button" class="btn btn-outline-danger" onclick="cancel()">취소</button>
        </div>
    </div>
    <script>
    // 저장 버튼 클릭 이벤트
    document.querySelector('.save').addEventListener('click', function() {
        // 폼 데이터를 가져오기
        const empNo = '${employee.empNo}';
        const empName = document.querySelector('input[name="empName"]').value;
        const empId = document.querySelector('input[name="empId"]').value;
        const empEmail = document.querySelector('input[name="empEmail"]').value;
        const empPhone = document.querySelector('input[name="empPhone"]').value;
        const deptCode = document.querySelector('select[name="deptCode"]').value;
        const jobCode = document.querySelector('select[name="jobCode"]').value;
        const empHiredDate = document.querySelector('input[name="empHiredDate"]').value;
        const empRetiredYn = document.querySelector('select[name="empRetiredYn"]').value;
        const empPostcode = document.querySelector('input[name="empPostcode"]').value;
        const empAddress = document.querySelector('input[name="empAddress"]').value;
        const empDetailAddress = document.querySelector('input[name="empDetailAddress"]').value;

        // AJAX 요청으로 서버에 데이터 전송
        $.ajax({
            url: '${path}/employee/updateEmployee',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                empNo: empNo,
                empName: empName,
                empId: empId,
                empEmail: empEmail,
                empPhone: empPhone,
                deptCode: { deptCode: deptCode }, 
                jobCode: { jobCode: jobCode },                 
                empHiredDate: empHiredDate,
                empRetiredYn: empRetiredYn,
                empPostcode: empPostcode,
                empAddress: empAddress,
                empDetailAddress: empDetailAddress
            }),
            success: function(response) {
                alert('직원 정보가 성공적으로 업데이트되었습니다.');
                window.location.href = '${path}/employee/mainemployee';
            },
            error: function(error) {
                alert('직원 정보 업데이트 중 오류가 발생했습니다: ' + error.responseText);
            }
        });
    });
    
    
    function cancel() {
        window.location.href = '${path}/employee/mainemployee';
    }
</script>
</body>
</html>
