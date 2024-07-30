<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
        
.table-container {
    margin-top: 20px;
}
.table th, .table td {
    text-align: center;
    vertical-align: middle;
}

.btn-primary {
    background-color: rgb(106, 90, 205);
    border-color: none;
}
.btn-primary:hover {
    background-color:rgb(193, 184, 247);
    border-color: none;
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



.pagination-container {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
</style>
<body>
	 <div class="d-flex justify-content-between align-items-center mb-3">
         <h2>게시판</h2>
     </div>
     <div class="action-buttons">
         <button class="btn btn-secondary">삭제</button>
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
                 </tr>
             </thead>
             <tbody id="postTableBody">
                 <c:forEach var="board" items="${boards}">
                     <tr>
                         <td class="checkbox-cell"><input type="checkbox" name="boardNo" value="${board.boardNo}"></td>
                         <td>${board.boardNo}</td>
                         <td>
                         
                         	<a href="#" onclick="loadBoardView(${board.boardNo})">${board.boardTitle}</a>
                         </td>
                         <td>${board.boardWriter}</td>
                         <td><fmt:formatDate value="${board.createdAt}" pattern="yyyy-MM-dd"/></td>
                         <td>${board.boardHits}</td>
                     </tr>
                 </c:forEach>
             </tbody>
         </table>
     </div>
     <div  >
	     <div class="pagination-container">
	        <div class="pagination">
	            ${pageBar}
	        </div>
	    </div>
	     <div class="search-bar">
	         <form action="${path}/board/boardlist" method="get">
	             <select name="filterType">
	                 <option value="title">제목</option>
	                 <option value="content">내용</option>
	                 <option value="writer">작성자</option>
	             </select>
	             <input type="text" name="filterValue" placeholder="검색">
	             <button class="btn btn-secondary" type="submit">검색</button>
	         </form>
	      </div>
     </div>
      <script>
      function loadBoardView(boardNo) {
          $.ajax({
              url: '${path}/board/boardview',
              method: 'GET',
              data: { boardNo: boardNo },
              success: function(response) {
                  $('.content').html(response);
              },
              error: function(error) {
                  alert('문서를 불러오는 중 오류가 발생했습니다.');
              }
          });
      }
      
      </script>
</body>
</html>