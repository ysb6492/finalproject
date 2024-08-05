package com.ah.spring.commute.controller;

import java.sql.Date;
import java.sql.Timestamp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ah.spring.commute.model.service.CommuteService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/commute")
@RequiredArgsConstructor
public class CommuteController {
	
    private final CommuteService comService;
    
    @GetMapping("/myinformation")
	public String MyInformation() {
		return "commute/myinformation";
	}
    @GetMapping("/mycommute")
	public String MyCommute() {
		return "commute/mycommute";
	}
    @GetMapping("/myworktime")
	public String MyWorktime() {
		return "commute/myworktime";
	}
    
    
    @GetMapping("/status")
    public String getCommuteStatus(
    		@RequestParam("empNo") int empNo,
    		Model model) {
        Date today = new java.sql.Date(System.currentTimeMillis());

        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", today);
        System.out.println("Commute 데이터 조회 params: " + params);

        Map<String, Object> commuteData = comService.getCommuteStatus(params);
        System.out.println("Controller Commute Data 조회 결과: " + commuteData);
        
        if (commuteData == null || commuteData.isEmpty()) {
            // 필요에 따라 초기값 설정 또는 에러 처리
            System.out.println("commuteData가 null이거 비어있음.");

            commuteData = new HashMap<>();
            commuteData.put("attendanceTime", "미등록");
            commuteData.put("leaveTime", "미등록");
            commuteData.put("status", "미등록");
        }
        
        model.addAttribute("commuteData", commuteData);
        System.out.println("Model에 commuteData 추가: " + commuteData);
   
        return "main"; // JSP 파일 경로에 맞게 수정
    }
    

    @PostMapping("/arrival")
    @ResponseBody
    public String saveArrivalTime(
    		@RequestParam("empNo") int empNo,
    		HttpSession session) {
        java.sql.Date commuteDate = new java.sql.Date(System.currentTimeMillis());
        System.out.println("arrivalTime에서 commuteData 제대로 나오는지 : " + commuteDate);

    	Timestamp attendanceTime = new Timestamp(System.currentTimeMillis());
    	System.out.println("attendanceTime : "+attendanceTime);
    	
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", commuteDate);
        params.put("attendanceTime", attendanceTime);
        System.out.println("Controller 출근시간 등록 : " + params);

        comService.saveArrivalTime(params);
        System.out.println("출근시간 저장 완료.");

        session.setAttribute("attendanceTime", attendanceTime);
        session.setAttribute("leaveTime", null);
        return "redirect:/commute/status?empNo=" + empNo;
    }
    
    @PostMapping("/leave")
    @ResponseBody
    public String updateLeaveTime(
    		@RequestParam("empNo") int empNo,
    		HttpSession session) {
        java.sql.Date commuteDate = new java.sql.Date(System.currentTimeMillis());
        System.out.println("leaveTime에서 commuteData 제대로 나오는지 : " + commuteDate);

        Timestamp leaveTime = new Timestamp(System.currentTimeMillis());
        System.out.println("leaveTime : " + leaveTime);

        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", commuteDate);
        params.put("leaveTime", leaveTime);

        System.out.println("퇴근 시간 조회 params: " + params);

        // 출근 시간 조회
        Map<String, Object> commuteData = comService.getCommuteStatus(params);
        System.out.println("Controller Commute Data 조회 결과: " + commuteData);
        
        Timestamp attendanceTime = (Timestamp) commuteData.get("attendanceTime");
        if (attendanceTime == null) {
            System.out.println("출근 기록이 없어 결근으로 처리합니다.");
            // 결근 처리
            params.put("status", "결근");
            comService.updateLeaveTime(params);
            session.setAttribute("status", "결근");
            return "redirect:/commute/status?empNo=" + empNo;
        }
        // 근무 시간 계산
        long workTimeMillis = leaveTime.getTime() - attendanceTime.getTime();
        long workTimeSeconds = workTimeMillis / 1000;
        // 시간을 형식화하여 저장
        String totalhours = formatTotalHours(workTimeSeconds);

        // 상태 결정 로직 추가
        String status;
        int attendanceHour = attendanceTime.toLocalDateTime().getHour();
        int leaveHour = leaveTime.toLocalDateTime().getHour();
        if (attendanceHour >= 18) {
            status = "야간";
        } else if (attendanceHour < 9 && leaveHour >= 18) {
            status = "정상출근";
        } else if (attendanceHour >= 9 && leaveHour >= 18) {
            status = "지각";
        } else if ((attendanceHour < 9 && leaveHour < 18) || (attendanceHour >=9 && leaveHour <18)) {
            status = "조퇴";
        } else {
            status = "퇴근";
        }
        System.out.println("status 결정: " + status);

        // 업데이트 쿼리 실행
        params.put("leaveTime", leaveTime);
        params.put("totalhours", totalhours);
        params.put("status", status);

        comService.updateLeaveTime(params);
        session.setAttribute("leaveTime", leaveTime);
        session.setAttribute("status", status);

        
        System.out.println("Controller 퇴근시간 등록 : " + params);
        return "redirect:/commute/status?empNo=" + empNo;
    }
    
    
    
    @GetMapping("/weekCommuteStatus")
    @ResponseBody
    public List<Map<String, Object>> getWeekCommuteStatus(
        @RequestParam("empNo") int empNo,
        @RequestParam("startDate") Date startDate,
        @RequestParam("endDate") Date endDate,
        Model model) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("startDate", startDate);
        params.put("endDate", endDate);
        System.out.println("params : "+params);

        List<Map<String, Object>> weekCommuteData = comService.getWeekCommuteStatus(params);
        System.out.println("weekCommuteData : "+weekCommuteData);
        return weekCommuteData; // JSON 형식으로 반환
    }
    //날짜 형식 메소드 개별적으로 사용하게
    private String formatTotalHours(long totalSeconds) {
        long hours = totalSeconds / 3600;
        long minutes = (totalSeconds % 3600) / 60;
        long seconds = totalSeconds % 60;
        return hours + "시간 " + minutes + "분 " + seconds + "초";
    }
}
