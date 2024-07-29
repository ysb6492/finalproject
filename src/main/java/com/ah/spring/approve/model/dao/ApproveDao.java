package com.ah.spring.approve.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppComment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.ExpenseReq;
import com.ah.spring.approve.model.dto.LeaveReq;
import com.ah.spring.approve.model.dto.OvertimeReq;

public interface ApproveDao {
	List<AppDocument> selectDraftList(int empNo, RowBounds rowBounds);
	int selectDraftCount(int empNo);

	List<AppDocument> selectDocumentsByStatus(HashMap<String, Object> params, RowBounds rowBounds);
    int selectDocumentsByStatusCount(HashMap<String, Object> params);
	
    List<AppDocument> selectAllDocuments(int empNo, RowBounds rowBounds);
	
	
	public List<AppDocument> selectTempSaveList(int empNo, RowBounds rowBounds);
	int selectTempSaveCount(int empNo);

	void insertApprovalDocument(AppDocument document);
    void insertLeaveRequest(LeaveReq leaveReq);
    void insertApprovalLine(ApprovalLine approvalLine);
    void insertFile(AppAttachment attachment);
    List<AppDocument> selectPendingApprovals(HashMap<String, Integer> params);
    int selectPendingApprovalsCount(int empNo);
    void updateApprovalStatus(HashMap<String, Object> params);
    void updateDocumentStatus(HashMap<String, Object> params);
    AppDocument getDocumentById(int docNo);
    LeaveReq getLeaveRequestByDocNo(int docNo);
    List<ApprovalLine> getApprovalLinesByDocNo(int docNo);
    List<AppAttachment> selectAttachmentsByDocNo(int docNo);
    int getNextDocNo();
    
    
    
    
	void deleteDocuments(List<Integer> docNos);
	
	
	
	List<AppDocument> selectApprovedDocuments(int empNo);
    List<AppDocument> selectRejectedDocuments(int empNo);
	int getMaxAppvSequence(int docNo);
	
	//반려메세지
	void insertComment(AppComment comment);
	List<AppComment> selectCommentByDocNo(int docNo);
	 
	 
	 
	 
	void insertExpenseRequest(ExpenseReq expenseReq);
	 List<ExpenseReq> getExpenseRequestByDocNo(int docNo);
	void insertOvertimeRequest(OvertimeReq overtimeReq);
	OvertimeReq getOvertimeRequestByDocNo(int docNo);
	
	
	//임시저장
	void updateApprovalDocument(AppDocument document);
	void deleteExpenseRequestByDocNo(int docNo);
	boolean isDuplicateApprovalLine(int docNo, int empNo, int appvSequence);
	

	

}
