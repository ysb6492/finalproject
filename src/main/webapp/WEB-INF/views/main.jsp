<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="header" value="헤더"/>
</jsp:include>
<style>

.main-container{
	display: flex;
}

aside.sidebar {
    width: 275px;
    background-color: #f4f4f4;
    padding: 15px;
}





main.main-content {
    flex: 1;
    padding: 20px;
}
.photo {
display: flex;
justify-content: center;
align-items: center;
height: 200px; 
}
.photo img {
display: block;
border-radius: 50%;
}
.info span {
display: block;
}
.alram li{
display: flex;
justify-content: space-between;
padding: 0px 30px 0px 30px;
}
.alram a {
display: flex;
justify-content: space-between;
width: 100%;
text-decoration: none;
}
.alram span {
}


.profile-card{
    background-color: white;
    border-radius: 10px;
    
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
    margin-bottom: 20px;
   
}
.profile-card img {
    display: block;
    border-radius: 50%;
    margin: 0 auto 20px auto;
    width: 100px;
    height: 100px;
}
.profile-card h2 {
    text-align: center;
    margin: 0;
}
.profile-card p {
    text-align: center;
    color: #888;
    margin: 5px 0 20px 0;
}
.profile-card ul {
    list-style: none;
    padding: 0;
    margin: 0;
    text-align: center;
}
.profile-card ul li {
    margin: 5px 0;
    color: #00A6DE;
}

.fc-event,
.fc-event a {
    color: black !important; /* 글자 색상을 검은색으로 설정 */
    text-decoration: none !important; /* 밑줄 제거 */
}

/* Remove underline and change color for calendar dates and weekdays */
.fc-daygrid-day-top {
    color: black !important;
    text-decoration: none !important;
}
.fc-col-header-cell-cushion {
    color: black !important;
    text-decoration: none !important;
    font-size: 20px;
}

.fc-daygrid-day-number {
    color: black !important;
    text-decoration: none !important;
}
</style>
	<section class="main-container">
	
	    <aside class="sidebar">
	        <div class="profile-card" style="width:100%; height:330px; ">
                <div class="profile-info">
                    <div class="photo">
                        <img src="" alt="" height="100" width="100">
                    </div>
                    <div class="info" style="text-align:center;">
                    	<span class="name" style="display: inline-block; margin-right:10px "><c:out value="${loginEmployee.empName}"/></span>
                        <span class="position" style="display: inline-block;"><c:out value="${loginEmployee.jobCode.jobName}"/></span>
                        <span class="department" ><c:out value="${loginEmployee.deptCode.deptName}"/></span>
                    </div> 
                </div>
	             <div>
		             <ul class="alram" style="font-size: 12px;">
	                    <li><a href=""><span>결재할 문서</span><span>1</span></a></li> 
	                    <li><a href=""><span>받은 이메일</span><span>2</span></a></li> 
	                </ul>
	             </div>  
            </div>
	    </aside>
	    <main class="main-content">
	        <section id="right" style="border: 1px solid black; width: 100%; height: 1500px;">
	            <div style="display: flex;">
	                
	                <div style="width: 100%; display: flex;">
	                    <div style="border: 1px solid black; width: 70%; height: 350px; padding: 10px 0 0 10px;  margin: 20px 0 0 20px;">
	                        aaa
	                        
	                    </div>
	                    <div style="border: 1px solid black; width: 22%; height: 350px; padding: 10px 0 0 10px;  margin: 20px 0 0 20px;">
	                        ddd
	                    </div>
	                    
	                </div>
	            </div>
	            <div style="display: flex; margin-left: 20px; margin-top: 20px;height: 300px;">
	                <div style="border: 1px solid black; width: 50%;  ">
	                    메일/결재
	                </div>
	                <div style="border: 1px solid black; width: 45.5%; margin-left: 30px;">
	                    공지사항/QnA
	                </div>
	            </div>
	            <div id="calendar-container" style="margin-left: 20px; margin-right: 35px; margin-top: 20px; ">
	                <div id="calendar" style="border: 1px solid black; width: 100%; height: 700px; ">
	                    
	                </div>
	            </div>
	        </section>
	    </main>
    </section>
    <script>
        // 캘린더
        $(document).ready(function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                height: '700px', // calendar 높이 설정
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