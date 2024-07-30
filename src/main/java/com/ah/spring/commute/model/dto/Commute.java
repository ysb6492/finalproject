package com.ah.spring.commute.model.dto;

import java.sql.Date; 
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Commute {
	private int commuteNo;
	private int empNo;
	private Date commuteDate;
	private Timestamp attendanceTime;
	private Timestamp leaveTime;
	private String status;
}
