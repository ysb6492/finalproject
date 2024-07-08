package com.ah.spring.employee.model.service;



import java.util.List;
import java.util.Map; 

import com.ah.spring.employee.model.dto.Employee;

public interface EmployeeService {
	Employee selectEmpById(String param);

	List<Employee> selectEmpAll(Map<String, Object> param);
	int selectEmpCount(Map<String, Object> param);
	
	
	List<Employee> selectEmpList();


	int enrollEmployee(Employee e);

	void deleteEmployees(List<Integer> empNos);

	Employee selectEmpByNo(int empNo);

	void updateEmployee(Employee employee);
	
}
