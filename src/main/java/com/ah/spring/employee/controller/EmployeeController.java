package com.ah.spring.employee.controller;

import java.util.List; 
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ah.spring.common.PageFactory;
import com.ah.spring.employee.model.dto.Employee;
import com.ah.spring.employee.model.service.EmployeeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/employee")
public class EmployeeController {
	private final EmployeeService service;
	private final BCryptPasswordEncoder pwencoder;

	private final PageFactory page;


    @RequestMapping("/mainemployee")
	public String mainEmployee() {
		return "employee/mainemployee";
	}
    @GetMapping("/emplist")
	public void empList(
			@RequestParam(defaultValue="1") int cPage,
			@RequestParam(defaultValue="5") int numPerpage,
			@RequestParam(required = false) String filterType,
	        @RequestParam(required = false) String filterValue,
			Model m
			
			) {
    	Map<String, Object> param = Map.of(
                "cPage", cPage,
                "numPerpage", numPerpage,
                "filterType", filterType != null ? filterType : "",
                "filterValue", filterValue != null ? filterValue : ""
        );
    	
    	System.out.println("Parameters: " + param);
    	List<Employee> employees =service.selectEmpAll(param);
		int totalData = service.selectEmpCount(param);
		 System.out.println("Employees: " + employees + ", Total Data: " + totalData);
		m.addAttribute("pageBar",page.getPage(cPage, numPerpage, totalData, "emplist", filterType, filterValue));
		m.addAttribute("employees",employees);

	}
    
    

    //결재선에서 직원목록
    @GetMapping("/employeelist")
    @ResponseBody
    public List<Employee> getEmployeesByDept(
    		@RequestParam String deptCode) {
        List<Employee> employees = service.selectEmpList();
        return employees.stream()
                .filter(e -> e.getDeptCode().getDeptCode().equals(deptCode))
                .collect(Collectors.toList());
    }
    
    
    @GetMapping("/empenroll")
	public String EmpEnroll() {
		return "employee/empenroll";
	}
    @PostMapping("/empenrollend")
	public String insertMember(
			@Validated @RequestBody Employee e,
			BindingResult isResult,
			Model model ) {
    	if (isResult.hasErrors()) {
            // 설정한 유효성 검사를 통과하지 못한 것
            System.out.println("유효성 검사 실패: " + isResult.getAllErrors());
            return "employee/empenroll";
        }
    	
    	System.out.println("Employee 데이터: " + e);
		//패스워드 암호화
		String encodePw = pwencoder.encode(e.getPassword()); //암호화된 값을 반환해준다
//		System.out.println(encodePw);
		e.setEmpPw(encodePw);
		System.out.println("암호화 패스워드 등록");
		
		int result = service.enrollEmployee(e);
		if(result>0) {
			System.out.println("직원등록 성공");
			return "employee/mainemployee";
//			return login(m.getUserId(),m.getPassword(),model); 가입시 자동로그인
		}else {
			System.out.println("직원등록 실패");
			model.addAttribute("msg","회원가입실패");
			model.addAttribute("loc","/empenroll");
			return "common/msg";
		}
		
	}
    
    
    @PostMapping("/deleteEmployee")
    @ResponseBody
    public String deleteEmployees(
    		@RequestBody List<Integer> empNos) {
        try {
            service.deleteEmployees(empNos);
            return "삭제 성공";
        } catch (Exception e) {
            System.out.println("삭제 실패::"+ e);
            return "삭제 실패";
        }
    }

    @GetMapping("/empdetail")
	public String boardView(int empNo, Model model) {
		Employee e=service.selectEmpByNo(empNo);
		model.addAttribute("employee",e);
		
		return "employee/empdetail";
	}
    
    
    @PostMapping("/updateEmployee")
    @ResponseBody
    public String updateEmployee(@RequestBody Employee employee) { //@RequestBody : JSON, XML 등의 요청 데이터를 자동으로 Java 객체로 매핑
        try {
        	System.out.println("Received Employee Data: " + employee);
            service.updateEmployee(employee);
            return "직원정보가 업데이트되었습니다";
        } catch (Exception e) {
            return "직원 정보 업데이트 중 오류가 발생했습니다: " + e.getMessage();
        }
    } 
}
