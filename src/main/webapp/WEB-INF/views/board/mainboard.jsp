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
    flex-shrink: 0; /* 사이드바 안줄어들게하는거 */
}
.sidebar h2 {
    font-size: 24px;
    margin-bottom: 20px;
    margin-top:0px;
    font-weight: bold;
    
}
/* 사이드바 */
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
.sidebar ul.menu {
    padding: 0;
}

.sidebar ul.menu li {
    list-style: none;
    margin-bottom: 10px;
}

.sidebar ul.menu li a {
    display: block;
    padding: 10px;
    color: #333;
    background-color: #e9ecef;
    border-radius: 5px;
    text-decoration: none;
    transition: background-color 0.3s ease;
}

.sidebar ul.menu li a:hover {
    background-color: rgb(106, 90, 205);
    color: white;
}

.sidebar ul.menu ul {
    padding: 0;
    display: none;
    margin-top: 10px;
}

.sidebar ul.menu ul li {
    margin-bottom: 0;
}

.sidebar ul.menu ul li a {
    background-color: #f4f4f4;
    color: #333;
    padding: 10px 20px;
    display: block;
}

.sidebar ul.menu ul li a:hover {
    background-color: rgb(193, 184, 247);
    color: rgb(37, 22, 121);
}

.sidebar ul.menu .submenu-toggle::after {
    content: " ▼";
    float: right;
}

.sidebar ul.menu .submenu-toggle.active::after {
    content: " ▲";
}

.sidebar ul.menu .submenu-toggle.active + ul {
    display: block;
}



.new-board-btn {
    display: block;
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    background-color: rgb(106, 90, 205);
    color: white;
    border: none;
    cursor: pointer;
}
.new-board-btn:hover {
    background-color: rgb(193, 184, 247);
}

.content {
    flex: 1;
    padding: 20px;
    width: 100%;
    background: #fff;
    
}
   
.container-fluid {
    width: 100%;
    padding: 20px;
    background: #fff;
}
  </style>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-bs4.min.css" rel="stylesheet">
</head>
<body>
    <div class="board-container">
        <aside class="sidebar">
            <h2>전사게시판</h2>
            <button class="new-board-btn" onclick="loadBoardWritePage()">새 글 쓰기</button>
            <ul class="menu">
                <li>
                	<a href="#" class="submenu-toggle">게시판</a>
                    <ul style="text-align: center;">
                        <li><a href="#" onclick="loadNoticeListPage">공지사항</a></li>
                        <li><a href="#" onclick="loadBoardListPage()">자유게시판</a></li>
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
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script>
    
    
    $(document).ready(function() {
		// 서브메뉴 토글
	    $('.submenu-toggle').click(function(e) {
	        e.preventDefault();
	        var $submenu = $(this).next('ul');
	
	        $submenu.slideToggle();
	        $(this).toggleClass('active');
	    });
	});
    function loadBoardListPage() {
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
    
    function loadBoardWritePage() {
        $.ajax({
            url: '${path}/board/boardwrite',
            method: 'GET',
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
