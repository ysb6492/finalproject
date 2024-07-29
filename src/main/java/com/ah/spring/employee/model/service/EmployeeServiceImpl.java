package com.ah.spring.employee.model.service;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.ah.spring.employee.model.dao.EmployeeDao;
import com.ah.spring.employee.model.dto.Employee;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {
	private final EmployeeDao dao;
	private final SqlSession session;

	
	
	@Override
	public Employee selectEmpById(String empId) {
		return dao.selectEmpById(empId);
	}


	@Override
	public List<Employee> selectEmpAll(Map<String, Object> param) {
		return dao.selectEmpAll(session,param);
	}


	@Override
	public int selectEmpCount(Map<String, Object> param) {
		return dao.selectEmpCount(session,param);
	}
	
	
	
	@Override
	public List<Employee> selectEmpList() {
		return dao.selectEmpList(session);
	}


	@Override
	public int enrollEmployee(Employee e) {
		// TODO Auto-generated method stub
		return dao.enrollEmployee(session,e);
	}


	
	
	
	
	
	@Override
    public void deleteEmployees(List<Integer> empNos) {
        dao.deleteEmployees(session, empNos);  
    }


	@Override
	public Employee selectEmpByNo(int empNo) {
		
		return dao.selectEmpByNo(session,empNo);
	}


	@Override
	public void updateEmployee(Employee employee) {
		System.out.println("Updating Employee: " + employee);
		dao.updateEmployee(employee);
		
	}
	@Override
	public boolean isEmpIdAvailable(String empId) {
	    return dao.countByEmpId(empId) == 0;
	}
	 
	
	
	
	
}
