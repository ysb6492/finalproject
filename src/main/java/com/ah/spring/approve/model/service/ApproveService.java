package com.ah.spring.approve.model.service;

import java.util.HashMap;
import java.util.List;


import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppComment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.ExpenseReq;
import com.ah.spring.approve.model.dto.LeaveReq;
import com.ah.spring.approve.model.dto.OvertimeReq;

public interface ApproveService {
	List<AppDocument> selectDraftList(int empNo, int cPage, int numPerpage);
	int selectDraftCount(int empNo);

    List<AppDocument> selectDocumentsByStatus(int empNo, int status, int cPage, int numPerPage);
	int selectDocumentsByStatusCount(int empNo, int status);
	
	List<AppDocument> selectAllDocuments(int empNo, int cPage, int numPerpage);
	
	
	
	
	List<AppDocument> selectTempSaveList(int empNo, int cPage, int numPerpage);
	int selectTempSaveCount(int empNo);

	
	
    void insertApprovalDocument(AppDocument document);
    void insertApprovalLine(ApprovalLine approvalLine);
    
    void insertLeaveRequest(LeaveReq leaveReq);
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

    // 추가: 승인 및 반려 처리 메소드
//    void approveDocument(int docNo, int empNo, int appvSequence, int appvStatusCode);
//    void rejectDocument(int docNo, int empNo, int appvSequence);
    
    
    
	List<AppDocument> selectApprovedDocuments(int empNo);
    List<AppDocument> selectRejectedDocuments(int empNo);
    
    
	int getMaxAppvSequence(int docNo);
	//반려메세지 등록
	void insertComment(AppComment comment);
	//문서마다 반려자랑 반려메세지 출력
	List<AppComment> selectCommentByDocNo(int docNo);
    
    //지출결의서 작성
	void insertExpenseRequest(ExpenseReq expenseReq);

	List<ExpenseReq> getExpenseRequestByDocNo(int docNo);

	void insertOvertimeRequest(OvertimeReq overtimeReq);

	OvertimeReq getOvertimeRequestByDocNo(int docNo);

	
	
	
	//임시저장
	void updateApprovalDocument(AppDocument document);

	void deleteExpenseRequestByDocNo(int docNo);

    
    
	

}
