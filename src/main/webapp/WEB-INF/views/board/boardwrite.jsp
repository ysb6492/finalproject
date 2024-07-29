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
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            width: 100%;
            margin:40px 0 0 0px;
            height:1000px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        .form-group input[type="text"], .form-group textarea {
            width: calc(100% - 10px); /* Padding 보정 */
            padding: 15px;
            border: none;
            font-size: 14px;
            box-sizing: border-box;
            outline: none;
        }
        .form-group textarea {
            resize: none;
            height: 100%; /* 초기 높이 설정 */
        }
        .file-upload {
            border: 2px dashed #ddd;
            padding: 15px;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            transition: border-color 0.3s ease;
            position: relative;
        }
        .file-upload:hover {
            border-color: #007bff;
        }
        .file-upload input[type="file"] {
            display: none;
        }
        .file-upload label {
            background-color: white;
            color: #007bff;
            font-weight: bold;
            padding: 0 10px;
            cursor: pointer;
        }
        .file-upload span {
            color: #888;
            display: block;
            margin-top: 10px;
        }
        .buttons {
            text-align: center;
            margin-top: 30px;
        }
        .buttons button {
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .buttons .submit {
            background-color: #007bff;
            color: #fff;
            margin-right: 10px;
        }
        .buttons .submit:hover {
            background-color: #0056b3;
        }
        .buttons .draft {
            background-color: #6c757d;
            color: #fff;
        }
        .buttons .draft:hover {
            background-color: #5a6268;
        }
        
    </style>
</head>

<body>
	<h3>자유게시판</h3>
    <div class="container" style="">
        <form action="${path}/board/insertboard" method="post" enctype="multipart/form-data">
            <table style="height:800px;">
                <tr style="height:30px;">
                    <th><label for="title" >제목</label></th>
                    <td class="form-group">
                        <input type="text" id="title" name="boardTitle" placeholder="제목을 입력하세요">
                    </td>
                </tr>
                <tr style="height:30px;">
                    <th><label for="author">작성자</label></th>
                    <td class="form-group">
                        <input type="text" id="author" name="boardWriter" value="${loginEmployee.username}" readonly>
                    </td>
                </tr>
                <tr style="height:30px;">
                    <th><label for="password">비밀번호</label></th>
                    <td class="form-group">
                        <input type="password" id="password" name="boardPass">
                    </td>
                </tr>
                <tr style="height:30px;">
                    <th><label for="file-upload-input">파일 첨부</label></th>
                    <td class="form-group">
                        <div class="file-upload">
                            <label for="file-upload-input">이 곳에 파일을 드래그 하세요. 또는 파일선택</label>
                            <input type="file" id="file-upload-input" name="upFile" multiple>
                            <span id="file-upload-text">선택된 파일이 없습니다.</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="content">내용</label></th>
                    <td class="form-group">
                        <textarea id="content" name="boardContent" placeholder="내용을 입력하세요"></textarea>
                    </td>
                </tr>
                
            </table>
            <div class="buttons">
                <button type="submit" class="submit">등록</button>
                <button type="button" class="draft">임시저장</button>
            </div>
        </form>
    </div>
   	
    <script>
        
        document.getElementById('file-upload-input').addEventListener('change', function() {
            var fileNames = Array.from(this.files).map(file => file.name).join(', ');
            document.getElementById('file-upload-text').textContent = fileNames || '선택된 파일이 없습니다.';
        });
    </script>
</body>
</html>