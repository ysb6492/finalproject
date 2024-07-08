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
public class AppReviewer {
	private int empNo;
	private int docNo;
	private int reviewStatus;
	private Date reviewDate;
	private Date updateDate;
}
