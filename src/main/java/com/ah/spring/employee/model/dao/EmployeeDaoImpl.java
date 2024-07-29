package com.ah.spring.employee.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ah.spring.employee.model.dto.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {
	@Autowired
    private SqlSession session;
	
	@Override
	public Employee selectEmpById(String empId) {
		return session.selectOne("employee.selectEmpById",empId);
	}
	@Override
	public List<Employee> selectEmpAll(SqlSession session,Map<String, Object> param) {
		int cPage = (int)param.get("cPage");
		int numPerpage = (int)param.get("numPerpage");
		RowBounds row = new RowBounds((cPage - 1) * numPerpage, numPerpage);
		return session.selectList("employee.selectEmpAll",param,row);
	}
	
	@Override
	public int selectEmpCount(SqlSession session,Map<String, Object> param) {
		// TODO Auto-generated method stub
		return session.selectOne("employee.selectEmpCount",param);
	}
	
	
	@Override
	public List<Employee> selectEmpList(SqlSession session) {
		
		return session.selectList("employee.selectEmpList");
	}
	
	@Override
	public int enrollEmployee(SqlSession session, Employee e) {
		return session.insert("employee.enrollEmployee",e);
	}
	
	
	
	
	
	
	@Override
    public void deleteEmployees(SqlSession session, List<Integer> empNos) {
        session.delete("employee.deleteEmployees", empNos);  
    }
	@Override
	public Employee selectEmpByNo(SqlSession session, int empNo) {
		// TODO Auto-generated method stub
		return session.selectOne("employee.employeeByNo",empNo);
	}
	@Override
	public void updateEmployee(Employee employee) {
		System.out.println("Executing update query for Employee: " + employee);
		session.update("employee.updateEmployee",employee);
		
	}
	
	@Override
	public int countByEmpId(String empId) {
	    return session.selectOne("employee.countByEmpId", empId);
	}
//	@Override
//	public List<Employee> selectEmpAll(SqlSession session, Map<String, Integer> param) {
//		return session.selectList("selectEmpAll");
//	}
//
//	@Override
//	public int selectEmpCount(SqlSession session) {
//		// TODO Auto-generated method stub
//		return session.selectOne("selectEmpCount");
//	}

	
	
}
