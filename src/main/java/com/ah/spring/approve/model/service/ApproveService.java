package com.ah.spring.approve.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.LeaveReq;

public interface ApproveService {

	List<AppDocument> selectDraftList(int empNo);
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

    // 추가: 승인 및 반려 처리 메소드
//    void approveDocument(int docNo, int empNo, int appvSequence, int appvStatusCode);
//    void rejectDocument(int docNo, int empNo, int appvSequence);
    
    
    
	List<AppDocument> selectDocumentsByStatus(int empNo, int status);
	List<AppDocument> selectAllDocuments(int empNo);
	List<AppDocument> selectApprovedDocuments(int empNo);
    List<AppDocument> selectRejectedDocuments(int empNo);
    
    
	int getMaxAppvSequence(int docNo);

    

	
}
