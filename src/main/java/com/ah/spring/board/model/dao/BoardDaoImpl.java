package com.ah.spring.board.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDaoImpl implements BoardDao {
    private final SqlSession sqlSession;
    @Override
    public List<Board> selectBoardList(String filterType, String filterValue) {
        return sqlSession.selectList("board.selectBoardList", Map.of("filterType", filterType, "filterValue", filterValue));
    }
	@Override
    public int selectBoardCount() {
        return sqlSession.selectOne("board.selectBoardCount");
    }

    @Override
    public Board selectBoardById(int boardNo) {
        return sqlSession.selectOne("board.selectBoardById", boardNo);
    }

    @Override
    public int insertBoard(Board board) {
        return sqlSession.insert("board.insertBoard", board);
    }

    @Override
    public int updateBoard(Board board) {
        return sqlSession.update("board.updateBoard", board);
    }

    @Override
    public int deleteBoard(int boardNo) {
        return sqlSession.delete("board.deleteBoard", boardNo);
    }

    @Override
    public int insertComment(BoardComment comment) {
        return sqlSession.insert("board.insertComment", comment);
    }

    @Override
    public int deleteComment(int commentNo) {
        return sqlSession.delete("board.deleteComment", commentNo);
    }
    
    @Override
    public int insertAttachment(Attachment attachment) {
    	System.out.println("첨부 파일 삽입 시도: " + attachment);
        int result = sqlSession.insert("board.insertAttachment", attachment);
        System.out.println("첨부 파일 삽입 결과: " + result + ", 파일: " + attachment);
        return result;
    }
}
