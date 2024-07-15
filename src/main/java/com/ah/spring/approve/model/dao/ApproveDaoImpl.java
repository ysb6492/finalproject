package com.ah.spring.approve.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.LeaveReq;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApproveDaoImpl implements ApproveDao {

    private final SqlSession sqlSession;

    @Override
    public List<AppDocument> selectDraftList(int empNo) {
        return sqlSession.selectList("approve.selectDraftList", empNo);
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
    public List<AppDocument> selectAllDocuments(int empNo) {
        return sqlSession.selectList("approve.selectAllDocuments", empNo);
    }
    @Override
    public List<AppDocument> selectDocumentsByStatus(HashMap<String, Integer> params) {
        return sqlSession.selectList("approve.selectDocumentsByStatus", params);
    }
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
}
