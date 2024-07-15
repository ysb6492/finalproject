package com.ah.spring.approve.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.ah.spring.approve.model.dao.ApproveDao;
import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.LeaveReq;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApproveServiceImpl implements ApproveService {

    private final ApproveDao apprDao;

    @Override
    public List<AppDocument> selectDraftList(int empNo) {
        return apprDao.selectDraftList(empNo);
    }

    @Override
    public void insertApprovalDocument(AppDocument document) {
        apprDao.insertApprovalDocument(document);
    }

    @Override
    public void insertLeaveRequest(LeaveReq leaveReq) {
        apprDao.insertLeaveRequest(leaveReq);
    }

    @Override
    public void insertApprovalLine(ApprovalLine approvalLine) {
        apprDao.insertApprovalLine(approvalLine);
    }

    @Override
    public void insertFile(AppAttachment attachment) {
        apprDao.insertFile(attachment);
    }

    @Override
    public List<AppDocument> selectPendingApprovals(HashMap<String, Integer> params) {
        return apprDao.selectPendingApprovals(params);
    }
    
    
    @Override
    public int getMaxAppvSequence(int docNo) {
        return apprDao.getMaxAppvSequence(docNo);
    }

    @Override
    public int selectPendingApprovalsCount(int empNo) {
        return apprDao.selectPendingApprovalsCount(empNo);
    }

    @Override
    public void updateApprovalStatus(HashMap<String, Object> params) {
        apprDao.updateApprovalStatus(params);
    }

    @Override
    public void updateDocumentStatus(HashMap<String, Object> params) {
        apprDao.updateDocumentStatus(params);
    }

    @Override
    public AppDocument getDocumentById(int docNo) {
        return apprDao.getDocumentById(docNo);
    }

    @Override
    public LeaveReq getLeaveRequestByDocNo(int docNo) {
        return apprDao.getLeaveRequestByDocNo(docNo);
    }

    @Override
    public List<ApprovalLine> getApprovalLinesByDocNo(int docNo) {
        return apprDao.getApprovalLinesByDocNo(docNo);
    }

    @Override
    public List<AppAttachment> selectAttachmentsByDocNo(int docNo) {
        return apprDao.selectAttachmentsByDocNo(docNo);
    }

    @Override
    public int getNextDocNo() {
        return apprDao.getNextDocNo();     
    }
    
    
    @Override
    public void deleteDocuments(List<Integer> docNos) {
        apprDao.deleteDocuments(docNos);
    }
    
    
    
    
    
    
    
    @Override
    public List<AppDocument> selectAllDocuments(int empNo) {
        return apprDao.selectAllDocuments(empNo);
    }
    @Override
    public List<AppDocument> selectDocumentsByStatus(int empNo, int status) {
        HashMap<String, Integer> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("status", status);
        return apprDao.selectDocumentsByStatus(params);
//        return apprDao.selectDocumentsByStatus(empNo, status);

    }
    @Override
    public List<AppDocument> selectApprovedDocuments(int empNo) {
        return apprDao.selectApprovedDocuments(empNo);
    }

    @Override
    public List<AppDocument> selectRejectedDocuments(int empNo) {
        return apprDao.selectRejectedDocuments(empNo);
    }
}
