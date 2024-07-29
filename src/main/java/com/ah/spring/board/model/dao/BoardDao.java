package com.ah.spring.board.model.dao;

import java.util.List; 
import java.util.Map;

import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;

public interface BoardDao {
	List<Board> selectBoardList(String filterType, String filterValue);

    int selectBoardCount();
    int insertBoard(Board board);
	Board selectBoardByNo(int boardNo);
	List<Attachment> selectAttachmentsByBoardNo(int boardNo);
	List<BoardComment> selectCommentsByBoardNo(int boardNo);
	String getWriterProfileReName(String writerId);
	int deleteBoard(int boardNo);
	int insertComment(BoardComment comment);
	int deleteComment(int commentNo);
    
    
    
    
    
    int updateBoard(Board board);
    
    // 댓글 관련 메소드
    
    //사진 첨부
    int insertAttachment(Attachment attachment);







}
