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
            width: 80%;
            margin: auto;
            padding: 40px;
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
        .buttons .edit {
            background-color: #007bff;
            color: #fff;
            margin-right: 10px;
        }
        .buttons .edit:hover {
            background-color: #0056b3;
        }
        .buttons .delete {
            background-color: #dc3545;
            color: #fff;
        }
        .buttons .delete:hover {
            background-color: #c82333;
        }
        .comments {
            margin-top: 30px;
        }
        .comment {
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }
        .comment .comment-author {
            font-weight: bold;
        }
        .comment .comment-date {
            color: #999;
            font-size: 12px;
        }
        .comment .comment-content {
            margin-top: 10px;
        }
        .new-comment {
            margin-top: 30px;
        }
        .new-comment textarea {
            width: calc(100% - 10px); /* Padding 보정 */
            padding: 15px;
            border: 1px solid #ddd;
            font-size: 14px;
            box-sizing: border-box;
            resize: none;
            height: 100px;
        }
        .new-comment button {
            margin-top: 10px;
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            background-color: #28a745;
            color: #fff;
            transition: background-color 0.3s ease;
        }
        .new-comment button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <table>
            <tr>
                <th>제목</th>
                <td>${board.boardTitle}</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${board.boardWriter}</td>
            </tr>
            <tr>
                <th>작성일</th>
                <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></td>
            </tr>
            <tr>
                <th>내용</th>
                <td>${board.boardContent}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${board.boardHits}</td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td>
                    <c:forEach var="file" items="${board.files}">
                        <a href="${path}/board/download?fileNo=${file.bfileNo}">${file.bfileOriName}</a><br/>
                    </c:forEach>
                </td>
            </tr>
        </table>
        <div class="buttons">
            <button class="edit" onclick="location.href='${path}/board/edit/${board.boardNo}'">수정</button>
            <button class="delete" onclick="deletePost(${board.boardNo})">삭제</button>
        </div>

        <div class="comments">
            <h3>댓글</h3>
            <c:forEach var="comment" items="${board.comments}">
                <div class="comment">
                    <div class="comment-author">${comment.commentWriter}</div>
                    <div class="comment-date"><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm"/></div>
                    <div class="comment-content">${comment.commentContent}</div>
                </div>
            </c:forEach>
        </div>

        <div class="new-comment">
            <h3>새 댓글</h3>
            <textarea id="commentContent" placeholder="댓글을 입력하세요"></textarea>
            <button onclick="addComment(${board.boardNo})">댓글 작성</button>
        </div>
    </div>

    <script>
        function deletePost(boardNo) {
            if(confirm('정말 삭제하시겠습니까?')) {
                fetch('${path}/board/delete/' + boardNo, {
                    method: 'POST'
                }).then(response => {
                    if(response.ok) {
                        location.href = '${path}/board/list';
                    } else {
                        alert('삭제에 실패했습니다.');
                    }
                });
            }
        }

        function addComment(boardNo) {
            const content = document.getElementById('commentContent').value;
            if(content.trim() === '') {
                alert('댓글 내용을 입력하세요.');
                return;
            }

            fetch('${path}/board/addComment', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    boardNo: boardNo,
                    commentContent: content
                })
            }).then(response => response.json())
              .then(data => {
                  if(data.success) {
                      location.reload();
                  } else {
                      alert('댓글 작성에 실패했습니다.');
                  }
              });
        }
    </script>
</body>
</html>
