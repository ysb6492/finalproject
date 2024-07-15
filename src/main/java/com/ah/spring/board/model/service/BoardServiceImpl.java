package com.ah.spring.board.model.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ah.spring.board.model.dao.BoardDao;
import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	private final BoardDao boardDao;
	@Override
    public List<Board> selectBoardList(Map<String, Object> param) {
        String filterType = (String) param.get("filterType");
        String filterValue = (String) param.get("filterValue");
        int cPage = (int) param.get("cPage");
        int numPerpage = (int) param.get("numPerpage");

        List<Board> allBoards = boardDao.selectBoardList(filterType, filterValue);

        return allBoards.stream()
                .skip((cPage - 1) * numPerpage)
                .limit(numPerpage)
                .collect(Collectors.toList());
    }

    @Override
    public int selectBoardCount() {
        return boardDao.selectBoardCount();
    }

    @Override
    public Board selectBoardById(int boardNo) {
        return boardDao.selectBoardById(boardNo);
    }
    
    @Transactional
    @Override
    public int insertBoard(Board board) {
        int result = boardDao.insertBoard(board);
        System.out.println("삽입된 게시글 번호: " + board.getBoardNo());

        if (result > 0 && board.getFiles() != null) {
            for (Attachment attachment : board.getFiles()) {
                attachment.setBoardNo(board.getBoardNo());
               // boardDao.insertAttachment(attachment);
            	int attachResult = boardDao.insertAttachment(attachment);
                System.out.println("첨부 파일 삽입 결과: " + attachResult + ", 첨부 파일: " + attachment);
            }
        }
        return result;
    }

    @Override
    public int updateBoard(Board board) {
        return boardDao.updateBoard(board);
    }

    @Override
    public int deleteBoard(int boardNo) {
        return boardDao.deleteBoard(boardNo);
    }

    @Override
    public boolean addComment(BoardComment comment) {
        return boardDao.insertComment(comment) > 0;
    }

    @Override
    public boolean deleteComment(int commentNo) {
        return boardDao.deleteComment(commentNo) > 0;
    }
    
    @Override
    public int insertAttachment(Attachment attachment) {
        return boardDao.insertAttachment(attachment);
    }
}
