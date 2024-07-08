<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="header" value="헤더"/>
</jsp:include>
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            width: 100%;
            
        }
        .board-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }
        .sidebar {
            width: 250px;
            background-color: #f4f4f4;
            padding: 20px;
            border-right: 0.5px solid rgb(202, 202, 202);
            flex-shrink: 0;
        }
        .sidebar h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .new-board-btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        .new-board-btn:hover {
            background-color: #45a049;
        }
        .menu {
            list-style: none;
        }
        .menu li {
            margin-bottom: 10px;
            list-style: none; 
        }
        .menu a {
            text-decoration: none;
            color: #333;
        }
        .menu a:hover {
            text-decoration: underline;
        }
        .content {
            flex: 1;
            padding: 20px;
            width: calc(100% - 250px);
        }
        
        
        
        
        .container-fluid {
            width: 100%;
            padding: 20px;
            background: #fff;
		}
    </style>
</head>
<body>
    <div class="board-container">
        <aside class="sidebar">
            <h2>전사게시판</h2>
            <button class="new-board-btn" onclick="createNewPost()">새 글 쓰기</button>
            <ul class="menu">
                <li>
                    <a href="#">게시판</a>
                    <ul style="text-align: center;">
                        <li><a href="#" onclick="">공지사항</a></li>
                        <li><a href="#" onclick="loadBoardPage()">자유게시판</a></li>
                    </ul>
                </li>
            </ul>
        </aside>
        <div class="content">
            <div class="container-fluid">
				게시판 홈
            </div>
        </div>
    </div>
    <script>
    function loadBoardPage() {
        $.ajax({
            url: '${path}/board/boardlist',
            method: 'GET',
            success: function(response) {
                $('.content').html(response);
            },
            error: function(error) {
                alert('문서를 불러오는 중 오류가 발생했습니다.');
            }
        });
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
        // 게시글 데이터를 가져오는 예시 배열
        const posts = [
            {id: 1, title: '첫 번째 게시글', author: '홍길동', date: '2024-07-01', views: 100, likes: 5},
            {id: 2, title: '두 번째 게시글', author: '이순신', date: '2024-07-02', views: 200, likes: 15},
            // 추가 게시글 데이터
        ];
        
        // 게시글 데이터를 테이블에 추가하는 함수
        function loadPosts() {
            const postTableBody = document.getElementById('postTableBody');
            posts.forEach(post => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td class="checkbox-cell"><input type="checkbox"></td>
                    <td>${post.id}</td>
                    <td><a href="view.html?id=${post.id}">${post.title}</a></td>
                    <td>${post.author}</td>
                    <td>${post.date}</td>
                    <td>${post.views}</td>
                    <td>${post.likes}</td>
                `;
                postTableBody.appendChild(row);
            });
        }
        
        // 새글쓰기 버튼 클릭 시 호출되는 함수
        function createNewPost() {
            alert('새글쓰기 기능을 구현하세요.');
        }
        
        // 페이지가 로드될 때 게시글 데이터를 로드합니다.
        document.addEventListener('DOMContentLoaded', loadPosts);
        
        // 전체 선택 체크박스 기능
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('#postTableBody input[type="checkbox"]');
            checkboxes.forEach(checkbox => checkbox.checked = this.checked);
        });
    </script>
</body>
</html>
