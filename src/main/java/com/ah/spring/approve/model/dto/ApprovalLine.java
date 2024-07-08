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
public class ApprovalLine {
	private int lineNo;
	private int docNo;
	private int empNo;
	private int appStatusCode;
	private String appComment;
	private Date appDate;
	private int appSequence;
}
