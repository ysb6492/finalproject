<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
        }
        .table-container {
            margin-top: 20px;
        }
        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        .table a {
            color: #007bff;
            text-decoration: none;
        }
        .table a:hover {
            text-decoration: underline;
        }
        .page-link {
            color: #007bff;
        }
        .page-link:hover {
            color: #0056b3;
        }
        .action-buttons {
            margin-bottom: 10px;
        }
        .action-buttons button {
            margin-right: 10px;
        }
        .checkbox-cell {
            width: 3%;
        }
        .table th:nth-child(1), .table td:nth-child(1) { width: 3%; }
        .table th:nth-child(2), .table td:nth-child(2) { width: 5%; }
        .table th:nth-child(3), .table td:nth-child(3) { width: 60%; }
        .table th:nth-child(4), .table td:nth-child(4) { width: 8%; }
        .table th:nth-child(5), .table td:nth-child(5) { width: 14%; }
        .table th:nth-child(6), .table td:nth-child(6) { width: 5%; }
        .search-bar {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .search-bar select,
        .search-bar input,
        .search-bar button {
            margin-right: 10px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .search-bar input {
    flex: 1;
    max-width: 200px;
}

.search-bar select {
    max-width: 150px;
}

.search-bar button {
    max-width: 100px;
}
</style>
<body>
	 <div class="d-flex justify-content-between align-items-center mb-3">
         <h2>게시판</h2>
     </div>
     <div class="action-buttons">
         <button class="btn btn-primary" onclick="createNewPost()">새글쓰기</button>
         <button class="btn btn-secondary">삭제</button>
         <button class="btn btn-secondary">공지로 등록</button>
     </div>
     <div class="table-container">
         <table class="table table-hover table-bordered">
             <thead>
                 <tr>
                     <th class="checkbox-cell"><input type="checkbox" id="selectAll"></th>
                     <th>번호</th>
                     <th>제목</th>
                     <th>작성자</th>
                     <th>작성일</th>
                     <th>조회</th>
                     <th>좋아요</th>
                 </tr>
             </thead>
             <tbody id="postTableBody">
                 <!-- JavaScript로 게시글 목록을 여기에 추가합니다 -->
             </tbody>
         </table>
     </div>
     <nav>
         <ul class="pagination">
             <li class="page-item">
                 <a class="page-link" href="#" aria-label="Previous">
                     <span aria-hidden="true">&laquo;</span>
                 </a>
             </li>
             <li class="page-item active"><a class="page-link" href="#">1</a></li>
           
             <li class="page-item">
                 <a class="page-link" href="#" aria-label="Next">
                     <span aria-hidden="true">&raquo;</span>
                 </a>
             </li>
         </ul>
     </nav>
     <div class="search-bar">
         <select>
             <option>전체기간</option>
             <!-- Add more options as needed -->
         </select>
         <select>
             <option>제목+내용</option>
             <!-- Add more options as needed -->
         </select>
         <input type="text" placeholder="검색">
         <button class="btn btn-secondary">검색</button>
      </div>
</body>
</html>