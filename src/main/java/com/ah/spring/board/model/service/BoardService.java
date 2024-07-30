package com.ah.spring.board.model.service;

import java.util.List;
import java.util.Map;

import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;

public interface BoardService {

	List<Board> selectBoardList(Map<String, Object> param);
    int selectBoardCount();
    int insertBoard(Board board);
    
    //게시글 상세보기
    Board selectBoardByNo(int boardNo);
	List<Attachment> selectAttachmentsByBoardNo(int boardNo);
	void incrementBoardHits(int boardNo);

	//댓글 불러올때
	List<BoardComment> selectCommentsByBoardNo(int boardNo);
	// 댓글 관련 메소드
    boolean addComment(BoardComment comment);
	String getWriterProfileReName(String boardWriter);
	int deleteBoard(int boardNo);
	boolean deleteComment(int commentNo);
//    int insertAttachment(Attachment attachment);

    //댓글 불러올때

    
    
    
    int updateBoard(Board board);
    
    
    
    
    
    
    
    
    
    
    
    
    
   

    //사진 첨부
	

	

	

}
