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
public class AppAttachment {
	private int attachmentNo;
    private int docNo; 
    private String fileOriginName;
    private String fileRenamedName;
    private String filePath;
    private Date  uploadDate;
    private Date  updateDate;
}
