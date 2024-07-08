package com.ah.spring.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
@RequestMapping("/board")
public class BoardController {
	@RequestMapping("/mainboard")
	public String ApproveList() {
		return "board/mainboard";
	}
	
	@GetMapping("/boardlist")
	public String boardList() {
		return "board/boardlist";
	}
}
