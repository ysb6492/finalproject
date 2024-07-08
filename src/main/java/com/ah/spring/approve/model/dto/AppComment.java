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
public class AppComment {
	private int commentNo;
	private int docNo;
	private int empNo;
	private String commentContent;
	private Date createdDate;
	private Date updatedDate;
	
}
