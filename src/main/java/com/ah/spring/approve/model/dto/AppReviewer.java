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
public class AppReviewer {
	private Employee empNo;
	private AppDocument docNo;
	private int reviewStatus;
	private Date  reviewDate;
	private Date  updateDate;
}
