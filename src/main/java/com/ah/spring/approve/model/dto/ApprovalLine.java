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
public class ApprovalLine {
	private int appvNo;
    private AppDocument docNo; 
    private Employee empNo; 
    private int appvStatusCode;
    private String appvComment;
    private Date  appvDate;
    private int appvSequence; //1대기,2승인,3반
}
