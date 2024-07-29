package com.ah.spring.approve.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import com.ah.spring.approve.model.dao.ApproveDao;
import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppComment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.ExpenseReq;
import com.ah.spring.approve.model.dto.LeaveReq;
import com.ah.spring.approve.model.dto.OvertimeReq;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApproveServiceImpl implements ApproveService {

    private final ApproveDao apprDao;

    @Override
    public List<AppDocument> selectDraftList(int empNo, int cPage, int numPerPage) {
        int offset = (cPage - 1) * numPerPage;
        RowBounds rowBounds = new RowBounds(offset, numPerPage);
        return apprDao.selectDraftList(empNo, rowBounds);
    }
    
    @Override
    public int selectDraftCount(int empNo) {
        return apprDao.selectDraftCount(empNo); // 총 데이터 수 조회 메소드 추가
    }
    @Override
    public List<AppDocument> selectDocumentsByStatus(int empNo, int status, int cPage, int numPerPage) {
        int offset = (cPage - 1) * numPerPage;
        RowBounds rowBounds = new RowBounds(offset, numPerPage);
        HashMap<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("status", status);
        return apprDao.selectDocumentsByStatus(params, rowBounds);
    }

    @Override
    public int selectDocumentsByStatusCount(int empNo, int status) {
        HashMap<String, Object> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("status", status);
        return apprDao.selectDocumentsByStatusCount(params);
    }
    
    
    
    
    
    
    
    
    @Override
    public List<AppDocument> selectTempSaveList(int empNo, int cPage, int numPerPage) {
        int offset = (cPage - 1) * numPerPage;
        RowBounds rowBounds = new RowBounds(offset, numPerPage);
        return apprDao.selectTempSaveList(empNo, rowBounds);
    }
    @Override
    public int selectTempSaveCount(int empNo) {
        return apprDao.selectTempSaveCount(empNo);
    }
    
    
    
    @Override
    public void insertApprovalDocument(AppDocument document) {
        apprDao.insertApprovalDocument(document);
    }

    @Override
    public void insertLeaveRequest(LeaveReq leaveReq) {
        System.out.println("insertLeaveRequest: " + leaveReq);

        apprDao.insertLeaveRequest(leaveReq);
    }

    @Override
    public void insertApprovalLine(ApprovalLine approvalLine) {
    	if (!apprDao.isDuplicateApprovalLine(approvalLine.getDocNo().getDocNo(), approvalLine.getEmpNo().getEmpNo(), approvalLine.getAppvSequence())) {
    		apprDao.insertApprovalLine(approvalLine);
        } else {
            throw new DuplicateKeyException("Duplicate approval line found for docNo: " + approvalLine.getDocNo().getDocNo() + ", empNo: " + approvalLine.getEmpNo().getEmpNo() + ", sequence: " + approvalLine.getAppvSequence());
        }
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
    public List<AppDocument> selectAllDocuments(int empNo, int cPage, int numPerpage) {
        int offset = (cPage - 1) * numPerpage;
        RowBounds rowBounds = new RowBounds(offset, numPerpage);
        return apprDao.selectAllDocuments(empNo, rowBounds);
    }
//    @Override
//    public List<AppDocument> selectDocumentsByStatus(int empNo, int status) {
//        HashMap<String, Integer> params = new HashMap<>();
//        params.put("empNo", empNo);
//        params.put("status", status);
//        return apprDao.selectDocumentsByStatus(params);
//
//    }
    @Override
    public List<AppDocument> selectApprovedDocuments(int empNo) {
        return apprDao.selectApprovedDocuments(empNo);
    }

    @Override
    public List<AppDocument> selectRejectedDocuments(int empNo) {
        return apprDao.selectRejectedDocuments(empNo);
    }

	@Override
	public void insertComment(AppComment comment) {
		apprDao.insertComment(comment);
	}

	@Override
	public List<AppComment> selectCommentByDocNo(int docNo) {
		
		return apprDao.selectCommentByDocNo(docNo);
	}

	
	
    
	@Override
    public void insertExpenseRequest(ExpenseReq expenseReq) {
        apprDao.insertExpenseRequest(expenseReq);
    }
	
	@Override
	public List<ExpenseReq> getExpenseRequestByDocNo(int docNo) {
        return apprDao.getExpenseRequestByDocNo(docNo);
    }
	
	@Override
    public void insertOvertimeRequest(OvertimeReq overtimeReq) {
        apprDao.insertOvertimeRequest(overtimeReq);
    }
	@Override
    public OvertimeReq getOvertimeRequestByDocNo(int docNo) {
        return apprDao.getOvertimeRequestByDocNo(docNo);
    }
	
	//임시저장
	@Override
    public void updateApprovalDocument(AppDocument document) {
        apprDao.updateApprovalDocument(document);
    }

    @Override
    public void deleteExpenseRequestByDocNo(int docNo) {
        apprDao.deleteExpenseRequestByDocNo(docNo);
    }

	
	
	

}
