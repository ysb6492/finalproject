<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<!-- 이부분 수정하기 꼭 아이디에서 이름과 직책으로 -->

    <style>
        body {
            font-family: 'Malgun Gothic', sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 100%; /* 가로 길이를 80%로 설정 */
            max-width: 1500px;
            padding: 20px;
            margin: 0px;
            background-color: white;
        }
        .post-header {
            border-bottom: 1px solid #ddd;
            padding-bottom: 15px;
        }
        .post-header h1 {
            margin: 0;
            font-size: 24px;
        }
        .post-meta {
            margin: 10px 0;
            color: #666;
            font-size: 14px;
        }
        .post-meta img {
            vertical-align: middle;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            margin-right: 10px;
        }
        .post-content {
            margin: 20px 0;
        }
        .post-content img {
            max-width: 100%;
            height: auto;
        }
        .post-content p {
            line-height: 1.6;
        }
        .post-footer {
            border-top: 1px solid #ddd;
            padding-top: 15px;
        }
        .post-footer span {
            display: inline-block;
            margin-right: 10px;
            font-size: 14px;
            color: #666;
        }
        .comment-section {
        margin-top: 20px;
    }
    .comment {
        border-bottom: 1px solid #ddd;
        padding: 10px 0;
    }
    .comment img {
        vertical-align: middle;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        margin-right: 10px;
    }
    .comment-content {
        display: inline-block;
        vertical-align: middle;
        max-width: 90%;
    }
    .comment-content p {
        margin: 0;
    }
    .comment-input {
        display: flex;
        align-items: center;
        margin-top: 20px;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 10px;
        background-color: #fff;
    }
    .comment-input img {
        border-radius: 50%;
        width: 40px;
        height: 40px;
        margin-right: 10px;
    }
    .comment-input textarea {
        flex-grow: 1;
        border: none;
        padding: 10px;
        resize: none;
        font-size: 14px;
        height: 60px;
        border-radius: 5px;
        outline: none;
    }
    .comment-input textarea::placeholder {
        color: #ccc;
    }
    .comment-input .icons {
        display: flex;
        align-items: center;
        margin-right: 10px;
    }
    .comment-input .icons span {
        display: inline-block;
        margin-right: 5px;
        font-size: 18px;
        color: #ccc;
        cursor: pointer;
    }
    .comment-input button {
        border: none;
        background: none;
        font-size: 14px;
        color: #007bff;
        cursor: pointer;
    }
    .comment-input button:hover {
        text-decoration: underline;
    }
    </style>
<body>
    <div class="container" >
        <div class="post-header">
            <h1>${board.boardTitle}</h1>
            <div class="post-meta">
                <c:choose>
                    <c:when test="${not empty board.writerProfileReName}">
			            <img src="${path}/resources/upload/employee/${board.writerProfileReName}" alt="Profile Picture" width="30" height="30">
			        </c:when>
                    <c:otherwise>
                        <img src="${path}/resources/images/basicprofile.png" alt="Basic Profile Picture" width="30" height="30">
                    </c:otherwise>
                </c:choose>
                <span>${board.boardWriter} </span>
                <span><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span>
            </div>
        </div>
        <div class="post-content">
            <p>${board.boardContent}</p>
            <c:forEach var="attachment" items="${board.files}">
            
                <c:choose>
           			 <c:when test="${fn:endsWith(attachment.bfileOriName, '.jpg') || fn:endsWith(attachment.bfileOriName, '.png') || fn:endsWith(attachment.bfileOriName, '.gif')}">
                        <img src="${path}/resources/upload/board/${attachment.bfileReName}" alt="${attachment.bfileOriName}" />
                    </c:when>
                    <c:otherwise>
                        <a href="${path}/board/download?fileNo=${attachment.bfileNo}">${attachment.bfileOriName}</a><br/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>       
        </div>
        <div class="post-footer">
            <span>댓글 ${board.comments.size()}개</span>
            <span>조회 ${board.boardHits}</span>
            <span>좋아요 누른 사람 0명</span>
        </div>
        <div class="buttons">
            <button class="edit" onclick="location.href='${path}/board/edit/${board.boardNo}'">수정</button>
            <button class="delete" onclick="deletePost(${board.boardNo})">삭제</button>
        </div>
        <div class="comment-section">
            <div id="commentList">
		        <c:forEach var="comment" items="${board.comments}">
    <div class="comment" id="comment-${comment.commentNo}" style="margin-left: ${comment.commentLevel * 20}px;">
        <c:choose>
            <c:when test="${not empty comment.writerProfileReName}">
                <img src="${path}/resources/upload/employee/${comment.writerProfileReName}" alt="Profile Picture" width="30" height="30">
            </c:when>
            <c:otherwise>
                <img src="${path}/resources/images/basicprofile.png" alt="Basic Profile Picture" width="30" height="30">
            </c:otherwise>
        </c:choose>
        <div class="comment-content">
            <p class="comment-author"><strong>${comment.commentWriter}</strong></p>
            <p class="comment-date"><strong><fmt:formatDate value="${comment.createdAt}" pattern="yyyy-MM-dd HH:mm"/></strong></p>
            <p class="comment-content">${comment.commentContent}</p>
            <c:if test="${comment.commentWriter == loginEmployee.empId}">
                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
            </c:if>
    <button onclick="showReplyForm(${comment.commentNo}, ${comment.commentLevel})">답글</button>
        </div>
         <div id="replyForm-${comment.commentNo}" style="display: none;">
        <textarea id="replyContent-${comment.commentNo}" placeholder="답글을 남겨보세요"></textarea>
        <button onclick="addReply(${comment.commentNo}, ${comment.commentLevel + 1})">답글 작성</button>
    </div>
    </div>
</c:forEach>
		    </div>
        </div>
        <div class="comment-input">
		    <textarea id="commentContent" placeholder="댓글을 남겨보세요"></textarea>
		    <button onclick="addComment(${board.boardNo})">댓글 작성</button>
		</div>
		<div id="replyForm" style="display: none;">
		    <textarea id="replyContent" placeholder="답글을 입력하세요"></textarea>
		    <button onclick="addReply()">답글 작성</button>
		    <input type="hidden" id="parentId">
		    <input type="hidden" id="replyLevel">
		</div>
    </div>
    <script>
    const path = "${path}";
    const loginEmpProfileReName = "${loginEmployee.empProfileReName}";
    const loginEmpId = "${loginEmployee.empId}";
    const boardNo = ${board.boardNo};  // boardNo를 JavaScript 변수로 설정

    	//게시글 삭제 fetch써서
	    function deletePost(boardNo) {
	        if (confirm('정말 삭제하시겠습니까?')) {
	            fetch(path+"/board/delete", {
	                method: 'POST',
	                headers: {
	                    "Content-Type": "application/json"
	                },
	                body: JSON.stringify({ boardNo: boardNo })
	            }).then(response => response.json())
	            .then(data => {
	                alert(data.msg);
	                if (data.success) {
	                    location.href = path+"/board/mainboard";
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	                alert('삭제 중 오류가 발생했습니다.');
	            });
	        }
	    }
    	//댓글달기 fetch써서
	    function addComment(boardNo) {
	        const content = document.getElementById('commentContent').value;
	        if(content.trim() === '') {
	            alert('댓글 내용을 입력하세요.');
	            return;
	        }
	        console.log('댓글 내용:', content);
	        
	        fetch(path+'/board/addComment', {
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
	            	const commentList = document.getElementById('commentList');
	                const newComment = document.createElement('div');
	                newComment.classList.add('comment');
	                newComment.setAttribute('id', 'comment-' + data.commentNo);
	                newComment.style.marginLeft = (data.commentLevel * 20) + 'px';

	                
	             	// 프로필 이미지 경로 처리
	                let profileImagePath;
	                if (data.writerProfileReName === null || data.writerProfileReName === '' || data.writerProfileReName === 'basicprofile.png') {
	                    profileImagePath = path + "/resources/images/basicprofile.png";
	                } else {
	                    profileImagePath = path + "/resources/upload/employee/" + data.writerProfileReName;
	                }
	                // 삭제버튼 댓글 작성하자마자 같이 나오게
	                let deleteButton = '';
	                if (data.commentWriter === loginEmpId) {
	                    deleteButton = '<button onclick="deleteComment(' + data.commentNo + ')">삭제</button>';
	                }
	                
	                
	                newComment.innerHTML =
	                    "<img src=\"" + profileImagePath + "\" alt=\"Profile Picture\" width=\"30\" height=\"30\">" +
	                    "<div class=\"comment-content\">" +
	                        "<p class=\"comment-author\"><strong>" + data.commentWriter + "</strong></p>" +
	                        "<p class=\"comment-date\"><strong>" + data.createdAt + "</strong></p>" +
	                        "<p class=\"comment-content\">" + data.commentContent + "</p>" +
	                        deleteButton +
	                    "</div>";
	                commentList.appendChild(newComment);
	                document.getElementById('commentContent').value = '';
	                
	             	// 댓글 개수 업데이트
	                updateCommentCount(1);
	            } else {
	                alert('댓글 작성에 실패했습니다.');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	            alert('댓글 작성 중 오류가 발생했습니다.');
	        });
	    }
    	
    	//댓글 삭제
	    function deleteComment(commentNo) {
	        if (confirm('댓글을 삭제하시겠습니까?')) {
	            fetch(path + "/board/deleteComment", {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify({ commentNo: commentNo })
	            })
	            .then(response => response.json())
	            .then(data => {
	                if (data.success) {
	                    const commentElement = document.getElementById('comment-' + commentNo);
	                    /* commentElement.remove();
	                    alert('댓글이 삭제되었습니다.'); */
	                    if (commentElement) {
	                        commentElement.remove();
	                        alert('댓글이 삭제되었습니다.');
	                    }
	                    updateCommentCount(-1);
	                } else {
	                    alert('댓글 삭제에 실패했습니다.');
	                }
	            })
	            .catch(error => {
	                console.error('Error:', error);
	                alert('서버 오류로 댓글 삭제에 실패했습니다.');
	            });
	        }
	    }
    	
    	
	    function updateCommentCount(change) {
	        const commentCountSpan = document.querySelector('.post-footer span:first-child');
	        
	        let text = commentCountSpan.textContent;
	        let numberText = text.replace('댓글 ', '').replace('개', '').trim();
	        let currentCount = parseInt(numberText);
	        
	        currentCount += change;
	        
	        commentCountSpan.textContent = '댓글 ' + currentCount + '개';
	    }
	    
	    
	    function showReplyForm(parentId, commentLevel) {
	    	const replyForm = document.getElementById('replyForm-' + parentId);
	        if (replyForm) {
	            replyForm.style.display = 'block';
	            const replyButton = replyForm.querySelector('button');
	            replyButton.setAttribute('onclick', 'addReply(' + parentId + ', ' + (commentLevel + 1) + ')');
	        }
	    }
	    
	    function addReply(parentId, commentLevel) {
	        console.log('Adding reply to commentNo:', parentId);  // 디버깅 로그 추가
	        console.log('Reply level:', commentLevel);  // 디버깅 로그 추가

	        var replyContentElement = document.getElementById('replyContent-' + parentId);
	        if (!replyContentElement) {
	            console.error('Reply content element not found for parentId:', parentId);
	            return;
	        }

	        var content = replyContentElement.value;

	        if (content.trim() === '') {
	            alert('답글 내용을 입력하세요.');
	            return;
	        }

	        fetch(path + '/board/addComment', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                boardNo: boardNo,
	                commentContent: content,
	                parentId: parentId,
	                commentLevel: commentLevel
	            })
	        }).then(function(response) {
	            return response.json();
	        }).then(function(data) {
	            if (data.success) {
	            	var parentCommentElement = document.getElementById('comment-' + parentId);
	                var newComment = document.createElement('div');
	                newComment.classList.add('comment');
	                newComment.setAttribute('id', 'comment-' + data.commentNo);
	                newComment.style.marginLeft = (data.commentLevel * 20) + 'px'; // 줄간격 수정

	                var profileImagePath;
	                if (data.writerProfileReName === null || data.writerProfileReName === '' || data.writerProfileReName === 'basicprofile.png') {
	                    profileImagePath = path + "/resources/images/basicprofile.png";
	                } else {
	                    profileImagePath = path + "/resources/upload/employee/" + data.writerProfileReName;
	                }
	                var deleteButton = '';
	                if (data.commentWriter === loginEmpId) {
	                    deleteButton = '<button onclick="deleteComment(' + data.commentNo + ')">삭제</button>';
	                }

	                newComment.innerHTML =
	                    '<img src="' + profileImagePath + '" alt="Profile Picture" width="30" height="30">' +
	                    '<div class="comment-content">' +
	                        '<p class="comment-author"><strong>' + data.commentWriter + '</strong></p>' +
	                        '<p class="comment-date"><strong>' + data.createdAt + '</strong></p>' +
	                        '<p class="comment-content">' + data.commentContent + '</p>' +
	                        deleteButton +
	                    '</div>';

	                parentCommentElement.parentNode.insertBefore(newComment, parentCommentElement.nextSibling);
	                replyContentElement.value = '';
	                document.getElementById('replyForm-' + parentId).style.display = 'none';
	                updateCommentCount(1);
	            } else {
	                alert('답글 작성에 실패했습니다.');
	            }
	        }).catch(function(error) {
	            console.error('Error:', error);
	            alert('답글 작성 중 오류가 발생했습니다.');
	        });
	    }
	    
    </script>
</body>
</html>
