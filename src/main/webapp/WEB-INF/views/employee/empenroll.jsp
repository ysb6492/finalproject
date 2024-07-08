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
		<input type="text" class="form-control" placeholder="사원 이름" name="empName" id="empName_" required>
		<input type="password" class="form-control" placeholder="비밀번호" name="empPw" id="password_" required>
<!-- 		<input type="password" class="form-control" placeholder="비밀번호확인" id="empPw2" required>
 -->		<input type="text" class="form-control" placeholder="주민번호" name="empResidentNo" id="empResidentNo_" required>
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
</script>