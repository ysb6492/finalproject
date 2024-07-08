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
public class LeaveReq {
	private int leaveNo;
	private int docNo;
	private String leaveType;
	private Date leaveStart;
	private Date leaveEnd;
	private String leaveReason;
	private Date createdAt;
	private Date updatedAt;
}
