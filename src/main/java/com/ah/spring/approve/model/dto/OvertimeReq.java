package com.ah.spring.approve.model.dto;

import java.sql.Date; 
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OvertimeReq {
	private int overtimeNo;
	private int docNo;
	private String overtimeType;
	private Date overtimeDate;
	private String overtimeReason;
	private LocalDateTime overtimeStartTime;
	private LocalDateTime overtimeEndTime;
	private String overtime;
	private Date createdAt;
	private Date updatedAt;
}
