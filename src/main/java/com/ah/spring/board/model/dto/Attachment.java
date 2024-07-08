package com.ah.spring.board.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Attachment {
	private int bfileNo;
	private String bfileOriName;
	private String bfileReName;
	private int boardNo;
}
