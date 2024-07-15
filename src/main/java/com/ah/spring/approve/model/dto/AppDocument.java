package com.ah.spring.approve.model.dto;

import java.sql.Date;
import java.util.List;

import com.ah.spring.employee.model.dto.Employee;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AppDocument {
	private int docNo;
	private Employee empNo;
	private String docTitle;
	private String docCategory;
	private String docContent;
	private int docStatus;
	private Date  startDate;
	private Date  endDate;
	private Date  ModifyDate;
	
	private List<ApprovalLine> approvalLines;
	private LeaveReq leaveReq;
}
