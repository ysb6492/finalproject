package com.ah.spring.board.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Board {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private String boardContent;
	private String boardPass;
	private Date createdAt;
	private Date updatedAt;
	private int boardHits;
//	private int fileAttached;
	private List<Attachment> files = new ArrayList<>();
	 private List<BoardComment> comments = new ArrayList<>(); 
}
