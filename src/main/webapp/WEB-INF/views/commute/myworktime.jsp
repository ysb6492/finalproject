<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="loginEmployee" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<c:set var="commuteData" value="${commuteData}" />

<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css' rel='stylesheet' />
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>



<style>
.calendar-container {
    background-color: #ffffff;
    border-radius: 10px;
    margin: 0px;
}

.accordion-button::after {
    margin-left: auto;
}

.table {
    width: 100%;
    margin-bottom: 0;
}
.fc-header-toolbar{
	margin-bottom: 15px !important;
	
}
.fc-header-toolbar .fc-toolbar-chunk:first-child {
    margin-left: 35%; 
}
.fc-header-toolbar .fc-toolbar-chunk:nth-child(2) {
    margin: auto; 
}
.fc-header-toolbar .fc-toolbar-chunk:nth-child(3) {
    margin-right: 35%; 
}
.fc-button-primary, .fc-button-primary:hover, .fc-button-primary:active {
    color: black !important;
    background-color: white !important;
    border-color: white !important;
    box-shadow: none !important;
    outline: none !important; 
}

.fc-button-primary.fc-prev-button,
.fc-button-primary.fc-next-button {
    border-radius: 0px !important;
    padding: 0px 10px !important; 
}
.fc-scrollgrid{
	display:none;
}
.accordion-button:focus {
    background-color: #d3d3d3; /* 변경할 색상 코드 입력 */
    color: #333333; /* 텍스트 색상도 필요시 변경 */
    box-shadow: none; /* 포커스 시 외곽선 제거 */
}
.accordion-button:not(.collapsed) {
    background-color: #d3d3d3; /* 변경하고자 하는 색상 */
    color: #333333; /* 텍스트 색상도 변경 가능 */
}
.table tbody tr:hover {
    background-color: #f0f0f0 !important; /* 원하는 색상으로 변경 */
}



</style>
<body>
	<h2>나의 근태현황</h2>
	<div class="calendar-container">
		
        <div id="calendar">
        
        </div>
 <!--        <div style="display:flex; width:100%; margin:50px; height: 100px;">
  			<div style="width:500px;">총 근무시간 : 00시간 00분</div>
  			<div style="width:500px;">초과 근무시간 : 00시간 00분</div>
		</div> -->
    </div>

    <div class="accordion" id="weekAccordion">
        
    </div>
    
    <script>
        $(document).ready(function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                height: '100%',
                expandRows: true,
                headerToolbar: {
                    left: 'prev',
                    center: 'title',
                    right: 'next today'
                },
                initialView: 'dayGridMonth',
                initialDate: new Date().toISOString().slice(0, 10),
                navLinks: true,
                editable: true,
                selectable: true,
                nowIndicator: true,
                dayMaxEvents: true,
                locale: 'ko',
                datesSet: function(info) {
                    console.log('시작날짜:', info.start);
                    console.log('끝날짜 :', info.end);
                    createWeekAccordion(info.start, info.end);
                }
            });

            calendar.render();

            function createWeekAccordion(startDate, endDate) {
                var weekAccordion = $('#weekAccordion');
                weekAccordion.empty();

                var currentDate = new Date(startDate);
                var weekNumber = 1;
                var currentMonth = new Date(calendar.getDate()).getMonth();

                while (currentDate <= endDate) {
                    var weekStart = new Date(currentDate);
                    var weekEnd = new Date(currentDate);
                    weekEnd.setDate(weekStart.getDate() + 6);

                    var containsCurrentMonthDate = false;
                    for (var d = new Date(weekStart); d <= weekEnd; d.setDate(d.getDate() + 1)) {
                        if (d.getMonth() === currentMonth) {
                            containsCurrentMonthDate = true;
                            break;
                        }
                    }

                    if (!containsCurrentMonthDate) {
                        currentDate.setDate(currentDate.getDate() + 7);
                        weekNumber++;
                        continue;
                    }

                    // 주차별 기본 데이터 생성
                    var weekData = createWeekData(weekNumber, weekStart);

                    var tableRows = '';
                    weekData.forEach(function(data) {
                        var rowStyle = data.isSunday ? ' style="color:red !important;"' : '';
                        tableRows += '<tr>' +
                            '<td' + rowStyle + '>' + data.date + ' ' + data.day + '</td>' +
                            '<td style="text-align:center;">' + (data.start ||"") + '</td>' +
                            '<td style="text-align:center;">' + (data.end ||"") + '</td>' +
                            '<td style="text-align:center;">' + (data.totalhours||"") + '</td>' +
                            '<td style="text-align:center;">' + (data.status||"") + '</td>' +
                            '</tr>';
                    });

                    var accordionItem = 
                        '<div class="accordion-item">' +
                            '<h2 class="accordion-header" id="heading' + weekNumber + '">' +
                                '<button class="accordion-button collapsed" type="button" style="font-weight:bold;" data-bs-toggle="collapse" data-bs-target="#collapse' + 
                                    weekNumber + '" aria-expanded="false" aria-controls="collapse' + weekNumber + '">' +
                                    weekNumber + '주차 (' + formatDate(weekStart) + ' - ' + formatDate(weekEnd) + ')' +
                                '</button>' +
                            '</h2>' +
                            '<div id="collapse' + weekNumber + '" class="accordion-collapse collapse" aria-labelledby="heading' + weekNumber + '">' +
                                '<div class="accordion-body">' +
                                    '<table class="table" >' +
                                        '<thead >' +
                                            '<tr>' +
                                                '<th>일자</th>' +
                                                '<th style="text-align:center;">업무 시작</th>' +
                                                '<th style="text-align:center;">업무 종료</th>' +
                                                '<th style="text-align:center;">일일 총 근무시간</th>' +
                                                '<th style="text-align:center;">근무 상태</th>' +
                                            '</tr>' +
                                        '</thead>' +
                                        '<tbody>' + tableRows + '</tbody>' +
                                    '</table>' +
                                '</div>' +
                            '</div>' +
                        '</div>';

                    weekAccordion.append(accordionItem);

                    // AJAX를 통해 실제 데이터를 가져와서 업데이트
                    fetchWeekData(weekNumber, weekStart, weekEnd);

                    currentDate.setDate(currentDate.getDate() + 7);
                    weekNumber++;
                }
            }

            function fetchWeekData(weekNumber, weekStart, weekEnd) {
                $.ajax({
                    url: '${path}/commute/weekCommuteStatus',
                    type: 'GET',
                    data: {
                        empNo: '${loginEmployee.empNo}',
                        startDate: formatDate(weekStart),
                        endDate: formatDate(weekEnd)
                    },
                    dataType: 'json',
                    success: function(response) {
                        //console.log("서버오나:", response);

                        var dayData = {};
                        response.forEach(function(data) {
                            var commuteDate = data.commuteDate; 
                            //console.log("CommuteDate: ", data.commuteDate);

                            var date = new Date(commuteDate);
                             var dateKey = formatDate(date); // 올바른 날짜 형식으로 변환
                             //console.log("Date Key: ", dateKey);
                            
                             
                             if (!dayData[dateKey]) {
                                dayData[dateKey] = {
                                    attendanceTime: null,
                                    leaveTime: null,
                                    totalhours: null,
                                    status: null
                                };
                            }
                            if (data.attendanceTime) {
                                dayData[dateKey].attendanceTime = data.attendanceTime;
                            }
                            if (data.leaveTime) {
                                dayData[dateKey].leaveTime = data.leaveTime;
                            }
                            if (data.totalhours) {
                                dayData[dateKey].totalhours = data.totalhours;
                            }
                            if (data.status) {
                                dayData[dateKey].status = data.status; 
                            }
                        });

                        //console.log("Day Data:", dayData); // 확인용

                        // 테이블 데이터 업데이트
                        $('#weekAccordion tbody tr').each(function() {
                            var fullDateText = $(this).find('td:first-child').text();
                            //console.log("fullDateText: "+fullDateText)
                            var datePart = fullDateText.split(' ')[0];
                            //console.log("datePart: "+datePart)

                            var dayInfo = dayData[datePart];
                            if (dayInfo) {
                                var attendanceTime = dayInfo.attendanceTime ? formatTime(dayInfo.attendanceTime)+' 출근' : '-';
                                var leaveTime = dayInfo.leaveTime ? formatTime(dayInfo.leaveTime)+ ' 퇴근' : '-';
                                var totalhours = dayInfo.totalhours ? dayInfo.totalhours : '-';
                                var status = dayInfo.status ? dayInfo.status : '-'; 
                                
                            	 // "결근" 상태를 빨간 글씨로, "정상출근" 상태를 파란 글씨로 표시
                                var statusResult;
                                if (status === '결근') {
                                	statusResult = '<span style="color:red;">' + status + '</span>';
                                } else if (status === '정상출근') {
                                	statusResult = '<span style="color:blue;">' + status + '</span>';
                                } else {
                                	statusResult = status;
                                }

                                $(this).find('td:eq(1)').text(attendanceTime);
                                $(this).find('td:eq(2)').text(leaveTime);
                                $(this).find('td:eq(3)').text(totalhours);
                                $(this).find('td:eq(4)').html(statusResult);


                            }
                        });
                    },
                    error: function(xhr, status, error) {
                        console.error('에러:', xhr.responseText);
                    }
                });
            }

            function createWeekData(weekNumber, startDate) {
                //console.log("weekNumber : " + weekNumber);
                //console.log("startDate : " + startDate);

                var daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
                var weekData = [];
                
                for (var i = 0; i < daysOfWeek.length; i++) {
                    var date = new Date(startDate);
                    date.setDate(startDate.getDate() + i);
                    //console.log("date : " + date);
                    var dayOfWeekIndex = (date.getDay() + 6) % 7; // 일요일이 마지막에 오도록 인덱스 조정
                    var dayOfWeek = daysOfWeek[dayOfWeekIndex];
                    weekData.push({
                        day: dayOfWeek,
                        date: formatDate(date),
                        start: '',
                        end: '',
                        totalHours: '',
                        isSunday: (dayOfWeek === '일')
                    });
                }
                console.log(weekNumber + "주차 data:", weekData);
                return weekData;
            }

            function formatDate(date) {
                var d = new Date(date),
                    month = '' + (d.getMonth() + 1),
                    day = '' + d.getDate(),
                    year = d.getFullYear();

                if (month.length < 2) month = '0' + month;
                if (day.length < 2) day = '0' + day;

                return [ year,month, day].join('-');
            }
            function formatTime(dateString) {
                var date = new Date(dateString);

                var hours = date.getHours().toString().padStart(2, '0');
                var minutes = date.getMinutes().toString().padStart(2, '0');
                var seconds = date.getSeconds().toString().padStart(2, '0');
                return hours + ':' + minutes + ':' + seconds;
            }
        });
    </script>
</body>
</html>
