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
<pre>
<c:out value="${commuteData}sss"/>
</pre>

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
    border: 2px solid rgb(106, 90, 205); 
    color:rgb(106, 90, 205); 
    background-color: rgb(193, 184, 247); 
    border-radius: 20px; 
    transition: background-color 0.2s, color 0.2s; 
}

.custom-btn:hover {
    background-color: rgb(193, 184, 247); 
    border: 2px solid rgb(193, 184, 247); 
    color: black; 
}
.time-record {
    display: flex;
    justify-content: space-between;
    margin-bottom: 5px;
}
.time-status {
    color: #9e9e9e; 
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

/* 
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
    font-size: 12px; 
    padding: 3px 5px; 
    width: auto; 
    height: auto; 
    min-width: 30px; 
    min-height: 30px; 
} 
*/


/* 출퇴근 시간 */
.current-time {
    font-size: 25px;
    font-weight: bold;
}
.current-date {
    font-size: 15px;
    color: gray;
}


/* 추가 스타일: 인라인 스타일 대체 */
.info {
    text-align: center;
}

.name {
    display: inline-block;
    margin-right: 10px;
    font-weight: bold;
}

.department {
    font-weight: bolder;
}

.position {
    display: inline-block;
    font-weight: bold;
}
</style>
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
                <div class="info">
                    <span class="name"><c:out value="${loginEmployee.empName}"/></span><br>
                    <span class="department"><c:out value="${loginEmployee.deptCode.deptName}"/></span>
                    <span class="position"><c:out value="${loginEmployee.jobCode.jobName}"/></span>
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
        <c:out value="${commuteData.attendanceTime}" default="미등록"/>
					</span>
                
                </div>
                <div class="time-record">
                    <span>퇴근시간</span>
                    <span class="time-status" id="leave-time">
    <c:out value="${commuteData.leaveTime != null ? commuteData.leaveTime : '미등록'}"/>
					</span>
                </div>
                <div>
				    <span>상태: </span>
				    <span class="time-status" id="status">
				        <c:out value="${commuteData.status != null ? commuteData.status : '미등록'}"/>
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
            <!-- <div >
                <div id="calendar" style="width:100%; margin-left:0px">
	            
	            </div>

            </div> -->
            
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
    	
    	
 /*    	    // 캘린더
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
    	            buttonText: { // 버튼 텍스트 설정
    	                month: '월',
    	                week: '주',
    	                day: '일',
    	                list: '리스트'
    	            },
    	            initialView: 'timeGridWeek', // 초기 로드될 때 주간 뷰로 설정
    	            initialDate: new Date().toISOString().slice(0, 10), // 초기 날짜 설정 (현재 날짜)
    	            navLinks: true, // 날짜 클릭 시 Day/Week 뷰로 링크
    	            editable: true, // 이벤트 수정 가능 여부
    	            selectable: true, // 날짜 선택 가능 여부
    	            nowIndicator: true, // 현재 시간 표시
    	            dayMaxEvents: true, // 이벤트가 많을 경우 "+"로 표시
    	            locale: 'ko', // 한국어 설정
    	            eventAdd: function(obj) { // 이벤트 추가 시 발생
    	                console.log(obj);
    	            },
    	            eventChange: function(obj) { // 이벤트 수정 시 발생
    	                console.log(obj);
    	            },
    	            eventRemove: function(obj) { // 이벤트 삭제 시 발생
    	                console.log(obj);
    	            },
    	            select: function(arg) { // 드래그로 이벤트 생성 가능
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
    	            eventDidMount: function(info) { // 이벤트가 화면에 표시될 때
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
    	                return false; // 'more' 링크 클릭 방지
    	            }
    	        });
    	        // 캘린더 랜더링
    	        calendar.render();
    	    }); */   
    </script>
</body>
</html>