<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="java.util.Date" %>
<%
    Date now = new Date();
    request.setAttribute("currentTime", now);
%>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:set var="commuteData" value="${commuteData}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="header" value="헤더"/>
</jsp:include>


<style>
.main-container {
    display: flex;
    background-color: #e9ecf2;
    min-height: 100vh;
    padding: 0px 0 20px 0;
}

aside.sidebar {
    width: 275px;
    background-color: rgb(106, 90, 205);
    color: white;
    padding: 20px;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 0px;
    margin-right: 0
}

.profile-card {
    background-color: white;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
    color: #2c3e50;
    margin-bottom: 20px;
    width: 100%;
    height: 400px;
}

.profile-card img {
    border-radius: 50%;
    margin-bottom: 15px;
    border: 1px solid rgba(0, 0, 0, 0.1);
    
    height: 120px;
    width: 110px;
}

.profile-card h2 {
    margin: 10px 0;
    font-size: 1.75em;
}

.profile-card p {
    margin: 5px 0;
    color: #7f8c8d;
    font-size: 1em;
}

.profile-card ul {
    list-style: none;
    padding: 0;
}

.profile-card ul li {
    margin: 5px 0;
    color: #00A6DE;
    font-weight: bold;
}
.custom-btn {
    padding: 3px 6px; 
    font-size: 15px; 
    margin-right: 10px;
    border: 2px solid rgb(106, 90, 205); /* 테두리 색상 */
    color:rgb(106, 90, 205); /* 글자 색상 */
    background-color: rgb(193, 184, 247); /* 배경색을 투명하게 */
    border-radius: 20px; /* 둥근 모서리 */
    transition: background-color 0.2s, color 0.2s; /* 호버 효과를 위한 트랜지션 */
}

.custom-btn:hover {
    background-color: rgb(193, 184, 247); /* 호버 시 배경색 */
    border: 2px solid rgb(193, 184, 247); /* 테두리 색상 */
    color: black; /* 호버 시 글자 색상 */
}
.time-record {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
}


.time-status {
    color: #9e9e9e; /* 텍스트 색상 */
}







main.main-content {
    flex: 1;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

section#right {
    border: 1px solid rgb(193, 184, 247);
    border-radius: 10px;
    padding: 20px;
    background-color: #ffffff;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    width: 100%;
    height: 1500px;
}

section#right > div {
    margin-bottom: 20px;
    display: flex;
}

section#right > div:first-child > div:first-child {
    border: 1px solid rgb(193, 184, 247);
    width: 50%;
    height: 300px;
    padding: 10px;
    margin: 20px 20px 0 20px;
}

section#right > div:first-child > div:last-child {
    border: 1px solid rgb(193, 184, 247);
    width: 50%;
    height: 300px;
    padding: 10px;
    margin: 20px 0 0 0;
}

section#right > div:nth-child(2) {
    margin-left: 20px;
    margin-top: 20px;
    height: 300px;
}

section#right > div:nth-child(2) > div:first-child {
    border: 1px solid rgb(193, 184, 247);
    width: 50%;
}

section#right > div:nth-child(2) > div:last-child {
    border: 1px solid rgb(193, 184, 247);
    width: 50%;
    margin-left: 30px;
}



#calendar {
    padding: 20px;
    background-color: #ffffff;
    border-radius: 10px;
    margin:0px;
}

.fc-event,
.fc-event a {
    color: #2c3e50 !important;
    text-decoration: none !important;
}

.fc-daygrid-day-top {
    color: #2c3e50 !important;
    text-decoration: none !important;
}

.fc-col-header-cell-cushion {
    color: #2c3e50 !important;
    text-decoration: none !important;
    font-size: 20px;
}

.fc-daygrid-day-number {
    color: #2c3e50 !important;
    text-decoration: none !important;
}
.fc-prev-button, .fc-next-button {
    font-size: 12px; /* 글씨 크기 줄이기 */
    padding: 3px 5px; /* 버튼의 내부 여백 줄이기 */
    width: auto; /* 버튼의 너비 자동 조정 */
    height: auto; /* 버튼의 높이 자동 조정 */
    min-width: 30px; /* 최소 너비 설정 */
    min-height: 30px; /* 최소 높이 설정 */
}


/* 출퇴근 시간 */
.current-time {
    font-size: 25px;
    font-weight: bold;
}
.current-date {
    font-size: 15px;
    color: gray;
}
</style>
<%-- <div>
    <h3>Commute Data 데이터오는지</h3>
    <p>Commute Data: <c:out value="${sessionScope.commuteData}" /></p>
    <p>Attendance Time: <c:out value="${sessionScope.attendanceTime}" /></p>
    <p>Leave Time: <c:out value="${sessionScope.leaveTime}" /></p>
</div> --%>
<section class="main-container">


    <aside class="sidebar">
        <div class="profile-card">
            <div class="profile-info">
                <div class="photo">
					<c:choose>
	                    <c:when test="${not empty loginEmployee.empProfileReName}">
	                        <img src="${path}/resources/upload/employee/${loginEmployee.empProfileReName}" alt="Profile Picture" width="60" height="60">
	                    </c:when>
	                    <c:otherwise>
	                        <img src="${path}/resources/images/basicprofile.png" alt="Basic Profile Picture"  width="60" height="60">
	                    </c:otherwise>
	                </c:choose>
                </div>
                <div class="info" style="text-align:center;">
                    <span class="name" style="display: inline-block; margin-right:10px; font-weight:bold;"><c:out value="${loginEmployee.empName}"/></span><br>
                    <span class="department" style="font-weight:bolder;"><c:out value="${loginEmployee.deptCode.deptName}"/></span>
                    <span class="position" style="display: inline-block; font-weight:bold;"><c:out value="${loginEmployee.jobCode.jobName}"/></span>
                </div> 
            </div>
            <div class="current-date">
            	<fmt:formatDate value="${currentTime }" pattern="yyyy-MM-dd(EEE)"/>
            </div>
            <div class="current-time" id="time" >
            	
            </div>
            <div id="commute-info"
                data-attendance-time="${commuteData != null && commuteData.attendanceTime != null ? commuteData.attendanceTime : ''}"
                data-leave-time="${commuteData != null && commuteData.leaveTime != null ? commuteData.leaveTime : ''}">
            </div>
            
            <div style="margin-top:20px">
                <button id="arrival-btn" type="button" class="btn btn-outline-success custom-btn"
                    onclick="setTime('arrival-time','출근하시겠습니까?',${loginEmployee.empNo}, '/commute/arrival')">출근하기</button>
                <button id="leave-btn" type="button" class="btn btn-outline-success custom-btn"
                    onclick="setTime('leave-time','퇴근하시겠습니까?',${loginEmployee.empNo}, '/commute/leave')">퇴근하기</button>
            </div>  
            <div style="margin-top:10px; font-size:14px;">
            
                <div class="time-record">
                    <span>출근시간</span>
                    <span class="time-status" id="arrival-time">
                    	<c:out value="${commuteData != null && commuteData.attendanceTime != null ? commuteData.attendanceTime : '미등록'}"/>
                    </span>
                
                </div>
                <div class="time-record">
                    <span>퇴근시간</span>
                    <span class="time-status" id="leave-time">
                    	<c:out value="${commuteData != null && commuteData.leaveTime != null ? commuteData.leaveTime : '미등록'}"/>
                    </span>
                </div>
            </div>
        </div>
    </aside>
    <main class="main-content">
        <section id="right">
            <div>
                <div style="background-color: rgb(188,146,252,0.3); border:none;">
                    <h4 style="font-weight:bold;">전자결재</h4>
                    <div style="margin:20px 0 0 20px;">
	                    <p style="font-weight:600; margin-top:30px;">결재 대기중인 문서 : 4개 </p>
	                    <p style="font-weight:600; margin-top:30px;">결재 진행중인 문서 : 1개</p>
	                    <p style="font-weight:600; margin-top:30px;">결재 반려된 문서 : 2개</p>
	                    <p style="font-weight:600; margin-top:30px;">결재 승인된 문서 : 1개</p>
                    </div>
                </div>
                <div style="background-color:rgb(143,242,246,0.3); border:none;">
                    게시판/공지사항
                </div>
                
            </div>
            <div >
                <div id="calendar" style="width:100%; margin-left:0px">
	            </div>

            </div>
            
        </section>
    </main>
</section>

    <script>
    	function updateTime(){
    		const now = new Date();
    		const hours = String(now.getHours()).padStart(2,"0");
    		const minutes = String(now.getMinutes()).padStart(2,"0");
    		const seconds = String(now.getSeconds()).padStart(2,"0");
    		const currentTime = hours + ":" + minutes + ":" + seconds;
    		document.getElementById("time").innerText = currentTime;
    	}
    	function setTime(settimeId, message, empNo, url) {
	    		if (confirm(message)) {
	            const now = new Date();
	            const hours = String(now.getHours()).padStart(2, '0');
	            const minutes = String(now.getMinutes()).padStart(2, '0');
	            const seconds = String(now.getSeconds()).padStart(2, '0');
	            const currentTime = hours + ":" + minutes + ":" + seconds;
	            document.getElementById(settimeId).innerText = currentTime;
	            
	            
	            $.ajax({
	            	type:"POST",
	            	url:url,
	            	data:{
	            		empNo:empNo
	            	},
	            	success: function(res){
/* 	            		alert(res)
 */	                    if (settimeId === 'arrival-time') {
	                        document.getElementById('arrival-btn').disabled = true;
	                        document.getElementById('leave-btn').disabled = false;
	                        document.getElementById('arrival-btn').classList.add('custom-btn-completed');

	                    } else if (settimeId === 'leave-time') {
	                        document.getElementById('arrival-btn').disabled = true;
	                        document.getElementById('leave-btn').disabled = true;
	                        document.getElementById('leave-btn').classList.add('custom-btn-completed');

	                    }
	                },
	                error: function(xhr, status, error) {
	                    alert("오류 발생: " + error);
	                }
	            });
	        }
	    }
    	
        /* function initializeButtonStates() {
        	const commuteInfo = document.getElementById('commute-info');
    		const attendanceTime = commuteInfo.getAttribute('data-attendance-time');
    		const leaveTime = commuteInfo.getAttribute('data-leave-time');

    		if (!attendanceTime || attendanceTime === '') {
    			document.getElementById('arrival-btn').disabled = false;
    			document.getElementById('leave-btn').disabled = true;
    		} else if (!leaveTime || leaveTime === '') {
    			document.getElementById('arrival-btn').disabled = true;
    			document.getElementById('leave-btn').disabled = false;
    		} else {
    			document.getElementById('arrival-btn').disabled = true;
    			document.getElementById('leave-btn').disabled = true;
    		}
    	} */
    	

    
    	function disableButtonsBeforeSix() {
    	    const now = new Date();
    	    const currentHour = now.getHours();
    	    const commuteInfo = document.getElementById('commute-info');
    	    const attendanceTime = commuteInfo.getAttribute('data-attendance-time');
    	    const leaveTime = commuteInfo.getAttribute('data-leave-time');
    	    
    	    if (currentHour < 6) {
    	        document.getElementById('arrival-btn').disabled = true;
    	        document.getElementById('leave-btn').disabled = true;
    	    } else {
    	        if (!attendanceTime || attendanceTime === '') {
    	            document.getElementById('arrival-btn').disabled = false;
    	            document.getElementById('leave-btn').disabled = true;
    	        } else if (!leaveTime || leaveTime === '') {
    	            document.getElementById('arrival-btn').disabled = true;
    	            document.getElementById('leave-btn').disabled = false;
    	        } else {
    	            document.getElementById('arrival-btn').disabled = true;
    	            document.getElementById('leave-btn').disabled = true;
    	        }
    	    }
    	} 
    	window.onload = function(){
    		updateTime();
    		setInterval(updateTime,1000);
            //initializeButtonStates();

            //disableButtonsBeforeSix();

    	}
    	
    	
        // 캘린더
        $(document).ready(function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                height: '600px', // calendar 높이 설정
                expandRows: true, // 화면에 맞게 높이 재설정
                slotMinTime: '08:00', // Day 캘린더에서 시작 시간
                slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek',
                },
                buttonText: { // 이 부분을 최상위 설정 객체에 추가
                    month: '월',
                    week: '주',
                    day: '일',
                    list: '리스트'
                },
                initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
                initialDate: new Date().toISOString().slice(0, 10), // 초기 날짜 설정 (현재 날짜)
                navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                editable: true, // 수정 가능?
                selectable: true, // 달력 일자 드래그 설정가능
                nowIndicator: true, // 현재 시간 마크
                dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
                locale: 'ko', // 한국어 설정
                eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
                    console.log(obj);
                },
                eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
                    console.log(obj);
                },
                eventRemove: function(obj) { // 이벤트가 삭제되면 발생하는 이벤트
                    console.log(obj);
                },
                select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
                    var title = prompt('Event Title:');
                    if (title) {
                        calendar.addEvent({
                            title: title,
                            start: arg.start,
                            end: arg.end,
                            allDay: arg.allDay
                        })
                    }
                    calendar.unselect()
                },
                eventClick: function(info) { // 이벤트 클릭 시
                    if (confirm("일정을 취소하시겠습니까?")) {
                        info.event.remove(); // 이벤트 삭제
                    }
                },
                
                eventDidMount: function(info) { // 이벤트가 화면에 표시될 때 발생하는 이벤트
                    if (info.el.querySelector('.fc-more')) {
                        const moreLink = info.el.querySelector('.fc-more');
                        moreLink.addEventListener('click', function(e) {
                            e.preventDefault();
                            $('#eventList').empty();
                            info.event.extendedProps.moreEvents.forEach(function(event) {
                                $('#eventList').append('<li>' + event.title + '</li>');
                            });
                            $('#eventModal').modal('show');
                        });
                    }
                },
                moreLinkClick: function(arg) { // more 링크 클릭 시
                    $('#eventList').empty();
                    arg.allSegs.forEach(function(seg) {
                        $('#eventList').append('<li>' + seg.event.title + '</li>');
                    });
                    $('#eventModal').modal('show');
                    return false; // 'more' 링크 클릭을 막음
                }
            });
            // 캘린더 랜더링
            calendar.render();
        });
        
        
        
    </script>
	



</body>
</html>