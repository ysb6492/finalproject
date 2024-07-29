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
	private int boardNo;
	private String commentContent;
	private String commentWriter;
	private Date createdAt;
    private int commentLevel; // 댓글의 깊이를 나타내는 필드
    private int parentId;
    private String writerProfileReName; // 추가된 필드


}
