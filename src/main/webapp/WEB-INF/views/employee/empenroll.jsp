<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
	div#enroll-container{width:400px; margin:0 auto; text-align:center;}
	div#enroll-container input, div#enroll-container select {margin-bottom:10px;}
	.error{
		color:red;
		font-weight:bolder;
	}
</style>
<div id="enroll-container">
	<form name="memberEnrollFrm" action="${path }/employee/empenrollend" method="post" >
		<input type="text" class="form-control" placeholder="사원 아이디" name="empId" id="empId_" required>
		<div id="idCheckMessage" class="error"></div>
		
		<input type="text" class="form-control" placeholder="사원 이름" name="empName" id="empName_" required>
		<input type="password" class="form-control" placeholder="비밀번호" name="empPw" id="password_" required>
		<div id="passwordCheckMessage" class="error"></div>
		
		<input type="text" class="form-control" placeholder="주민번호" name="empResidentNo" id="empResidentNo_" required>
		<input type="text" class="form-control" placeholder="전화번호" name="empPhone" id="empPhone_">
		<input type="email" class="form-control" placeholder="이메일" name="empEmail" id="empEmail_" required>
		<input type="text" class="form-control" placeholder="우편번호" name="empPostcode" id="empPostcode_">
		<input type="text" class="form-control" placeholder="기본주소" name="empAddress" id="empAddress_">
		<input type="text" class="form-control" placeholder="상세주소" name="empDetailAddress" id="empDetailAddress_">
<!-- 		<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" required> -->
		<select class="form-control" name="deptCode.deptCode" id="deptCode" required>
			<option value="" disabled selected>부서</option>
			<option value="D2">인사팀</option>
			<option value="D3">개발팀</option>
			<option value="D4">영업팀</option>
		</select>
		<select class="form-control" name="jobCode.jobCode" id="jobCode" required>
			<option value="" disabled selected>직책</option>
			<option value="J3">과장</option>
			<option value="J4">팀장</option>
			<option value="J5">팀원</option>
		</select>
		
		<br />
		<button type="button" class="btn btn-outline-success" onclick="submitForm()">등록</button>&nbsp;
		<button type="button" class="btn btn-outline-danger" onclick="cancel()">취소</button>	
	</form>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
function submitForm() {
    var formData = {
    	empId: $('#empId_').val(),
        empName: $('#empName_').val(),
        empPw: $('#password_').val(),
        empResidentNo: $('#empResidentNo_').val(),
        empPhone: $('#empPhone_').val(),
        empEmail: $('#empEmail_').val(),
        empPostcode: $('#empPostcode_').val(),
        empAddress: $('#empAddress_').val(),
        empDetailAddress: $('#empDetailAddress_').val(),
        deptCode: { deptCode: $('#deptCode').val() },
        jobCode: { jobCode: $('#jobCode').val() }
    };

    $.ajax({
        url: '${path}/employee/empenrollend',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(formData),
        success: function(response) {
            alert('등록 성공');
            window.location.href = '${path}/employee/mainemployee';
        },
        error: function(error) {
            alert('등록 실패: ' + error.responseText);
        }
    });
}
function cancel() {
    window.location.href = '${path}/employee/mainemployee';
}


//아이디 중복체크, 비밀번호 유효성검사
$(document).ready(function() {
    $('#empId_').on('keyup', function() {
        checkIdAvailability();
    });
    $('#password_').on('keyup', function() {
        checkPasswordStrength();
    });
});
function checkIdAvailability() {
    const empId = $('#empId_').val();
    if (empId === '') {
        $('#idCheckMessage').text('');
        return;
    }

    $.ajax({
        url: '${path}/employee/checkId',
        type: 'GET',
        data: { empId: empId },
        success: function(response) {
            if (response) {
                $('#idCheckMessage').text('사용 가능한 아이디입니다.').css('color', 'green');
            } else {
                $('#idCheckMessage').text('이미 사용 중인 아이디입니다.').css('color', 'red');
            }
        },
        error: function() {
            $('#idCheckMessage').text('아이디 중복 체크 중 오류가 발생했습니다.').css('color', 'red');
        }
    });
}
function checkPasswordStrength() {
    const password = $('#password_').val();
    const message = $('#passwordCheckMessage');
    const criteria = [
        { regex: /.{8,}/, message: '8자 이상' },
        { regex: /[a-z]/, message: '소문자 포함' },
        { regex: /[A-Z]/, message: '대문자 포함' },
        { regex: /[0-9]/, message: '숫자 포함' },
        { regex: /[^a-zA-Z0-9]/, message: '특수문자 포함' }
    ];

    let valid = true;
    let errorMessage = '비밀번호는 ';
    criteria.forEach((criterion, index) => {
        if (!criterion.regex.test(password)) {
            valid = false;
            errorMessage += criterion.message;
            if (index < criteria.length - 1) {
                errorMessage += ', ';
            }
        }
    });

    if (valid) {
        message.text('안전한 비밀번호입니다.').removeClass('error').addClass('valid');
    } else {
        message.text(errorMessage).removeClass('valid').addClass('error');
    }
}
</script>