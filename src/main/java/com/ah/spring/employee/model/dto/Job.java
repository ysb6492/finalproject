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
public class Job {
	private String jobCode;
	private String jobName;
	private List<Employee> employees;
}
