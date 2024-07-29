package com.ah.spring.approve.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppComment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.ExpenseReq;
import com.ah.spring.approve.model.dto.LeaveReq;
import com.ah.spring.approve.model.dto.OvertimeReq;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApproveDaoImpl implements ApproveDao {

    private final SqlSession sqlSession;

    @Override
    public List<AppDocument> selectDraftList(int empNo, RowBounds rowBounds) {
    	Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
    	return sqlSession.selectList("approve.selectDraftList",params, rowBounds);
    }

    @Override
    public int selectDraftCount(int empNo) {
        return sqlSession.selectOne("approve.selectDraftCount", empNo); // 총 데이터 수 조회 메소드 추가
    }
    @Override
    public List<AppDocument> selectDocumentsByStatus(HashMap<String, Object> params, RowBounds rowBounds) {
        return sqlSession.selectList("approve.selectDocumentsByStatus", params, rowBounds);
    }

    @Override
    public int selectDocumentsByStatusCount(HashMap<String, Object> params) {
        return sqlSession.selectOne("approve.selectDocumentsByStatusCount", params);
    }
    
    
    
    
    
    
    @Override
    public List<AppDocument> selectTempSaveList(int empNo, RowBounds rowBounds) {
    	Map<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
    	return sqlSession.selectList("approve.selectTempSaveList",params, rowBounds);
    }
    @Override
    public int selectTempSaveCount(int empNo) {
        return sqlSession.selectOne("approve.selectTempSaveCount", empNo);
    }
    
    
    
    
    @Override
    public void insertApprovalDocument(AppDocument document) {
    	
        sqlSession.insert("approve.insertApprovalDocument", document);
    }

    @Override
    public void insertLeaveRequest(LeaveReq leaveReq) {

        sqlSession.insert("approve.insertLeaveRequest", leaveReq);
    }

    @Override
    public void insertApprovalLine(ApprovalLine approvalLine) {
        System.out.println("insertApprovalLine DAO: " + approvalLine);

        sqlSession.insert("approve.insertApprovalLine", approvalLine);
    }

    @Override
    public void insertFile(AppAttachment attachment) {
        sqlSession.insert("approve.insertFile", attachment);
    }

    @Override
    public List<AppDocument> selectPendingApprovals(HashMap<String, Integer> params) {
        return sqlSession.selectList("approve.selectPendingApprovals", params);
    }

    @Override
    public int selectPendingApprovalsCount(int empNo) {
        return sqlSession.selectOne("approve.selectPendingApprovalsCount", empNo);
    }

    @Override
    public void updateApprovalStatus(HashMap<String, Object> params) {
        sqlSession.update("approve.updateApprovalStatus", params);
    }

    @Override
    public void updateDocumentStatus(HashMap<String, Object> params) {
        sqlSession.update("approve.updateDocumentStatus", params);
    }

    @Override
    public AppDocument getDocumentById(int docNo) {
        return sqlSession.selectOne("approve.selectDocumentById", docNo);
    }

    @Override
    public LeaveReq getLeaveRequestByDocNo(int docNo) {
        return sqlSession.selectOne("approve.selectLeaveRequestByDocNo", docNo);
    }

    @Override
    public List<ApprovalLine> getApprovalLinesByDocNo(int docNo) {
        return sqlSession.selectList("approve.getApprovalLinesByDocNo", docNo);
    }

    @Override
    public List<AppAttachment> selectAttachmentsByDocNo(int docNo) {
        return sqlSession.selectList("approve.selectAttachmentsByDocNo", docNo);
    }

    @Override
    public int getNextDocNo() {
        return sqlSession.selectOne("approve.getNextDocumentNumber");
    }
    
    
    @Override
    public void deleteDocuments(List<Integer> docNos) {
        sqlSession.delete("approve.deleteDocuments", docNos);
    }
    
    
    
    
    
    @Override
    public List<AppDocument> selectAllDocuments(int empNo, RowBounds rowBounds) {
        return sqlSession.selectList("approve.selectAllDocuments", empNo, rowBounds);
    }
//    @Override
//    public List<AppDocument> selectDocumentsByStatus(HashMap<String, Integer> params) {
//        return sqlSession.selectList("approve.selectDocumentsByStatus", params);
//    }
    @Override
    public List<AppDocument> selectApprovedDocuments(int empNo) {
        return sqlSession.selectList("approve.selectApprovedDocuments", empNo);
    }

    @Override
    public List<AppDocument> selectRejectedDocuments(int empNo) {
        return sqlSession.selectList("approve.selectRejectedDocuments", empNo);
    }
    @Override
    public int getMaxAppvSequence(int docNo) {
        return sqlSession.selectOne("approve.getMaxAppvSequence", docNo);
    }

	@Override
	public void insertComment(AppComment comment) {
        sqlSession.insert("approve.insertComment", comment);

	}
	@Override
    public List<AppComment> selectCommentByDocNo(int docNo) {
        return sqlSession.selectList("approve.selectCommentByDocNo", docNo);
    }

	 @Override
	    public void insertExpenseRequest(ExpenseReq expenseReq) {
	        sqlSession.insert("approve.insertExpenseRequest", expenseReq);
	    }
	 
	 @Override
	 public List<ExpenseReq> getExpenseRequestByDocNo(int docNo) {
	        return sqlSession.selectList("approve.getExpenseRequestByDocNo", docNo);
	    }
	 @Override
	    public void insertOvertimeRequest(OvertimeReq overtimeReq) {
	        sqlSession.insert("approve.insertOvertimeRequest", overtimeReq);
	    }
	 @Override
	    public OvertimeReq getOvertimeRequestByDocNo(int docNo) {
	        return sqlSession.selectOne("approve.getOvertimeRequestByDocNo", docNo);
	    }
	 
	 @Override
	    public void updateApprovalDocument(AppDocument document) {
	        sqlSession.update("approve.updateApprovalDocument", document);
	    }

	    @Override
	    public void deleteExpenseRequestByDocNo(int docNo) {
	        sqlSession.delete("approve.deleteExpenseRequestByDocNo", docNo);
	    }

		@Override
		public boolean isDuplicateApprovalLine(int docNo, int empNo, int appvSequence) {
			Integer count = sqlSession.selectOne("approve.checkDuplicateApprovalLine", Map.of("docNo", docNo, "empNo", empNo, "sequence", appvSequence));
		    return count != null && count > 0;
		}
	 
}
