package com.ah.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;

public interface BoardService {

	List<Board> selectBoardList(Map<String, Object> param);
    int selectBoardCount();
    Board selectBoardById(int boardNo);
    int insertBoard(Board board);
    int updateBoard(Board board);
    int deleteBoard(int boardNo);
    
    // 댓글 관련 메소드
    boolean addComment(BoardComment comment);
    boolean deleteComment(int commentNo);

    //사진 첨부
    int insertAttachment(Attachment attachment);

	

	

}
