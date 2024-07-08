package com.ah.spring.approve.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ah.spring.employee.model.dto.Employee;
import com.ah.spring.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/approve")
@RequiredArgsConstructor
public class ApproveController {
	
	@RequestMapping("/mainapprove")
	public String mainApprove() {
		return "approve/mainapprove";
	}
	@RequestMapping("/draftdoc")
	public String DraftDocView() {
		return "approve/draftdoc";
	}
	@RequestMapping("/vacationdoc")
	public String VacationDoc() {
		return "approve/vacationDoc";
	}
	
	
	

}
