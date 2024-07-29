<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
           width: 100%; /* 가로 길이를 80%로 설정 */
            max-width: 1500px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .enroll-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .enroll-header h1 {
            margin: 0;
            font-size: 28px;
            color: #333;
        }
        .profile-container {
		    display: flex;
		    border: 1px solid #ccc;
		    align-items: center;
		    margin-bottom: 30px;
		    gap: 20px; /* 추가된 부분: 프로필 사진과 입력 필드 사이의 간격을 조정 */
		}
		.profile-photo {
		    flex-basis: 20%; /* 추가된 부분: 프로필 사진이 차지하는 비율을 설정 */
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		}
        .profile-container .profile-photo {
            margin-left:40px;
            margin-right:20px;
        }
        .profile-container img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #ccc;
        }
        .profile-container input[type="file"] {
            display: none;
        }
        .profile-container label {
            display: block;
            margin-top: 10px;
            cursor: pointer;
            color: #007bff;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
            vertical-align: middle;
        }
        th {
            background-color: #f4f4f4;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn-group {
            text-align: center;
            margin-top: 20px;
            display: flex; /* 추가된 부분 */
    		justify-content: center; /* 추가된 부분 */
    		width: 15%; /* 추가된 부분: 버튼 그룹의 가로 길이를 설정 */
		    margin-left: auto; /* 추가된 부분: 중앙 정렬 */
		    margin-right: auto; /* 추가된 부분: 중앙 정렬 */
        }
        .btn-group button {
            padding: 10px 20px;
            margin: 0 5px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
             flex-grow: 1;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .error {
            color: red;
            font-weight: bold;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<h3 style="font-weight:700;" >사원 등록 페이지</h3>
    <div class="container">
        <div class="enroll-header">
            <h2 style="font-weight:600;">사원 등록</h2>
        </div>
        <form name="memberEnrollFrm" action="${path}/employee/empenrollend" method="post" enctype="multipart/form-data">
            <div class="profile-container">
                <div class="profile-photo">
                    <img src="https://via.placeholder.com/100" alt="Profile Picture" id="profilePicturePreview">
                    <label for="profilePicture" style="color:black;">프로필 사진 업로드</label>
                    <input type="file" class="form-control" name="profilePicture" id="profilePicture" accept="image/*" onchange="previewProfilePicture(event)">
                </div>
                <div style="flex-grow: 1;">
                    <table>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" class="form-control" placeholder="사원 이름" name="empName" id="empName_" required></td>
                            <th>사원 아이디</th>
                            <td>	
                            	<input type="text" class="form-control" placeholder="사원 아이디" name="empId" id="empId_" required>
                            	 <div id="idCheckMessage" class="error"></div> <!-- 이 줄 추가 -->
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><input type="email" class="form-control" placeholder="이메일" name="empEmail" id="empEmail_" required></td>
                            <th>전화번호</th>
                            <td><input type="text" class="form-control" placeholder="전화번호" name="empPhone" id="empPhone_"></td>
                        </tr>
                        <tr>
                            <th>부서</th>
                            <td>
                                <select class="form-control" name="deptCode.deptCode" id="deptCode" required>
                                    <option value="" disabled selected>부서 선택</option>
                                    <option value="D2">인사팀</option>
                                    <option value="D3">개발팀</option>
                                    <option value="D4">영업팀</option>
                                </select>
                            </td>
                            <th>직책</th>
                            <td>
                                <select class="form-control" name="jobCode.jobCode" id="jobCode" required>
                                    <option value="" disabled selected>직책 선택</option>
                                    <option value="J3">과장</option>
                                    <option value="J4">팀장</option>
                                    <option value="J5">팀원</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th>주민번호</th>
                            <td><input type="text" class="form-control" placeholder="주민번호" name="empResidentNo" id="empResidentNo_" required></td>
                            <th>비밀번호</th>
                            <td><input type="password" class="form-control" placeholder="비밀번호" name="empPw" id="password_" required></td>
                        </tr>
                        <tr>
                            <th>우편번호</th>
                            <td><input type="text" class="form-control" placeholder="우편번호" name="empPostcode" id="empPostcode_"></td>
                            <th>기본주소</th>
                            <td><input type="text" class="form-control" placeholder="기본주소" name="empAddress" id="empAddress_"></td>
                        </tr>
                        <tr>
                            <th>상세주소</th>
                            <td colspan="3"><input type="text" class="form-control" placeholder="상세주소" name="empDetailAddress" id="empDetailAddress_"></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">등록</button>
                <button type="button" class="btn btn-secondary" onclick="cancel()">취소</button>
            </div>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        function previewProfilePicture(event) {
            const reader = new FileReader();
            reader.onload = function() {
                const output = document.getElementById('profilePicturePreview');
                output.src = reader.result;
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        function cancel() {
            window.location.href = '${path}/employee/mainemployee';
        }

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
</body>
</html>
