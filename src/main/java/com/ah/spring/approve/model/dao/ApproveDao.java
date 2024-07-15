package com.ah.spring.approve.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.LeaveReq;

public interface ApproveDao {
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
	
	
	
	List<AppDocument> selectDocumentsByStatus(HashMap<String, Integer> params);
	List<AppDocument> selectAllDocuments(int empNo);
	List<AppDocument> selectApprovedDocuments(int empNo);
    List<AppDocument> selectRejectedDocuments(int empNo);
	int getMaxAppvSequence(int docNo);

	

}
