package com.ah.spring.employee.model.dto;



import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Department {
	private String deptCode;
	private String deptName;
	private List<Employee> employees;
}
