package com.ah.spring.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;

@Controller
public class HomeController {
	
    @RequestMapping("/login")
    public String login() {
    	return "employee/login";
    }
    @GetMapping("/main")
    public String mainPage() {
        return "main"; // main.jsp 파일을 반환하도록 합니다.
    }
    @GetMapping("/logout")
    public String logout(SessionStatus session) {
        if (!session.isComplete()) session.setComplete(); // 세션이 살아있다면 세션 종료
        return "employee/login"; // 로그아웃 후 로그인 페이지로 리다이렉트
    }
}
