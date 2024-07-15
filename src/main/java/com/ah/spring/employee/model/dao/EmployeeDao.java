package com.ah.spring.employee.model.dao;

import java.util.List; 
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ah.spring.employee.model.dto.Employee;

public interface EmployeeDao {
	Employee selectEmpById(String empId);
	List<Employee> selectEmpAll(SqlSession session,Map<String,Object> param);
	int selectEmpCount(SqlSession session,Map<String, Object> param);
	
	
	List<Employee> selectEmpList(SqlSession session);
	
	int enrollEmployee(SqlSession session, Employee e);
	
    void deleteEmployees(SqlSession session, List<Integer> empNos);
	Employee selectEmpByNo(SqlSession session, int empNo);
	void updateEmployee(Employee employee);
	int countByEmpId(String empId);


	

	
}
