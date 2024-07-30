package com.ah.spring.commute.controller;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.HashMap;
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
    
    @GetMapping("/status")
    public String getCommuteStatus(
    		@RequestParam("empNo") int empNo,
    		Model model) {
        Date today = new java.sql.Date(System.currentTimeMillis());

        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", today);
        System.out.println("Controller  Commute Data 조회 결과: " + params); 

        Map<String, Object> commuteData = comService.getCommuteStatus(params);
        System.out.println("Controller  Commute Data22 조회 결과: " + commuteData); 

        model.addAttribute("commuteData", commuteData);

        
        return "main"; // JSP 파일 경로에 맞게 수정
    }
    
    public String afterLogin(
    		Model model, 
    		HttpSession session) {
        int empNo = (int) session.getAttribute("empNo"); // 로그인한 사용자의 사번을 세션에서 가져옴
        Date today = new java.sql.Date(System.currentTimeMillis());
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", today);

        Map<String, Object> commuteData = comService.getCommuteStatus(params);
        session.setAttribute("commuteData", commuteData);
        model.addAttribute("commuteData", commuteData);
        return "main";
    }

    @PostMapping("/arrival")
    @ResponseBody
    public String saveArrivalTime(
    		@RequestParam("empNo") int empNo,
    		HttpSession session) {
        java.sql.Date commuteDate = new java.sql.Date(System.currentTimeMillis());
        System.out.println("arrivalTime에서 commuteData 제대로 나오는지 : " + commuteDate);

    	Timestamp attendanceTime = new Timestamp(System.currentTimeMillis());
    	
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", commuteDate);
        params.put("attendanceTime", attendanceTime);

        System.out.println("Controller 출근시간 등록 : " + params);

        comService.saveArrivalTime(params);
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
        Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("commuteDate", commuteDate);
        params.put("leaveTime", leaveTime);
        
        System.out.println("Controller 업데이트 퇴근시간: " + params);

        comService.updateLeaveTime(params);
        session.setAttribute("leaveTime", leaveTime);

        return "redirect:/commute/status?empNo=" + empNo;
    }
}
