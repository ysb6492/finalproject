package com.ah.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;

public interface BoardDao {
	List<Board> selectBoardList(String filterType, String filterValue);

    int selectBoardCount();
    Board selectBoardById(int boardNo);
    int insertBoard(Board board);
    int updateBoard(Board board);
    int deleteBoard(int boardNo);
    
    // 댓글 관련 메소드
    int insertComment(BoardComment comment);
    int deleteComment(int commentNo);
    //사진 첨부
    int insertAttachment(Attachment attachment);



}
