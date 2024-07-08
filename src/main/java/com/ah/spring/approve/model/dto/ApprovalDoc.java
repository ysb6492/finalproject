package com.ah.spring.approve.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApprovalDoc {
	private int docNo;
	private int empNo;
	private String docTitle;
	private String docCategory;
	private String docContent;
	private int docStatus;
	private Date startDate;
	private Date endDate;
	private Date ModifyDate;
	
}
