package com.ah.spring.board.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BoardComment {
	private int commentNo;
	private String commentContent;
	private String commentWriter;
	private int boardNo;
	private Date createdAt;
}
