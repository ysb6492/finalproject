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
	private Date overtimeDate;
	private LocalDateTime overtimeStart;
	private LocalDateTime overtimeEnd;
	private String overtimeReason;
	private Date createdAt;
	private Date updatedAt;
}
