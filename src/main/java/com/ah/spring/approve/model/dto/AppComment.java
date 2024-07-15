package com.ah.spring.approve.model.dto;

import java.sql.Date;

import com.ah.spring.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AppComment {
	private int commentNo;
	private AppDocument docNo;
	private Employee empNo;
	private String commentContent;
	private Date createdDate;
	private Date  updatedDate;
	
}
