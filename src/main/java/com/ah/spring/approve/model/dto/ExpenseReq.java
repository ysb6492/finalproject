package com.ah.spring.approve.model.dto;

import java.sql.Date;

import jakarta.annotation.Nullable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ExpenseReq {
	private int expenseNo;
    private int docNo;
    //private String expenseTitle; //지출결의서 제목
    private String expenseReason; //지출사유
    private Date expenseDate; //사용일자
    private String expenseType; //물품구입비, 교통비, 식대
    private String useInformation; //사용내역
    private int expenseCost; //개별금액
    private String expenseEtc; //비고
    
    private int totalExpense; //총금액
    
    private Date createdAt;
    private Date updatedAt;
}
