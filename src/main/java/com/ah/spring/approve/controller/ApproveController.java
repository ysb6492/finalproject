package com.ah.spring.approve.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.LeaveReq;
import com.ah.spring.approve.model.service.ApproveService;
import com.ah.spring.common.PageFactory;
import com.ah.spring.employee.model.dto.Employee;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/approve")
@RequiredArgsConstructor
public class ApproveController {

    private final ApproveService apprService;
    private final ServletContext servletContext;

    @RequestMapping("/mainapprove")
    public String mainApprove() {
        return "approve/mainapprove";
    }

    
    
    @RequestMapping("/draftList")
    public String draftList(HttpSession session, Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "employee/login";
        }

        int empNo = loginEmployee.getEmpNo();
        List<AppDocument> draftList = apprService.selectDraftList(empNo);
        model.addAttribute("empNo", empNo);
        model.addAttribute("draftList", draftList);

        return "approve/draftList";
    }

    @RequestMapping("/selectDoc")
    public String selectDoc(@RequestParam("docType") String docType, HttpSession session, Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "employee/login";
        }

        int empNo = loginEmployee.getEmpNo();
        model.addAttribute("empNo", empNo);
        
        int nextDocNo = apprService.getNextDocNo(); 
        model.addAttribute("nextDocNo", nextDocNo);

        switch (docType) {
            case "vacation":
                return "approve/vacationDoc";
            case "overtime":
                return "approve/overtimeDoc";
            case "expense":
                return "approve/expenseDoc";
            default:
                return "redirect:/approve/mainapprove";
        }
    }

    @PostMapping("/ajaxWriteVacation")
    public String ajaxVctWrite(
            @RequestParam HashMap<String, String> params,
            @RequestParam MultipartFile[] files,
            @RequestParam(name = "observers", required = false, defaultValue = "") String observers,
            HttpSession session, Model model) {

        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) return "employee/login";

        int empNo = loginEmployee.getEmpNo();

        System.out.println("처리전 결재자들 :" + observers);
        String[] ArrayObserver = observers.isEmpty() ? new String[0] : observers.split(",");
        System.out.println("결재자들 : " + Arrays.toString(ArrayObserver));

        // AppDocument 객체 생성
        AppDocument document = AppDocument.builder()
                .docTitle(params.get("docTitle"))
                .docCategory(params.get("docCategory"))
                .docContent(params.get("docContent"))
                .empNo(Employee.builder().empNo(empNo).build())
                .docStatus(0) // IN_PROGRESS
                .build();

        apprService.insertApprovalDocument(document);
        
     // LeaveRequest 객체 생성 및 삽입
        LeaveReq leaveRequest = LeaveReq.builder()
                .docNo(document.getDocNo())
                .leaveType(params.get("docCategory"))
                .leaveStart(Date.valueOf(params.get("leaveStart")))
                .leaveEnd(Date.valueOf(params.get("leaveEnd")))
                .leaveReason(params.get("docContent"))
                .leaveDays(Integer.parseInt(params.get("leaveDays")))
                .build();
        apprService.insertLeaveRequest(leaveRequest);
        
     // ApprovalLine 객체 생성 및 삽입
        int docNo = document.getDocNo();
        for (String observer : ArrayObserver) {
            String[] parts = observer.split(":");
            int observerEmpNo = Integer.parseInt(parts[0].trim());
            int sequence = Integer.parseInt(parts[1].trim());
            ApprovalLine approvalLine = ApprovalLine.builder()
                    .docNo(AppDocument.builder().docNo(docNo).build())
                    .empNo(Employee.builder().empNo(observerEmpNo).build())
                    .appvStatusCode(0) // PENDING
                    .appvSequence(sequence)
                    .build();
            apprService.insertApprovalLine(approvalLine);
        }

        
        
        // AppAttachment 객체 생성 및 삽입
        String uploadDir = servletContext.getRealPath("/resources/upload/approve");
        for (MultipartFile file : files) {
            if (!file.isEmpty()) {
                AppAttachment attachment = createAttachment(docNo, file, uploadDir);
                apprService.insertFile(attachment);
            }
        }

        // 기안 문서 리스트를 다시 로드하여 모델에 추가
        List<AppDocument> draftList = apprService.selectDraftList(empNo);
        model.addAttribute("draftList", draftList);

        return "approve/draftList";
    }

    private AppAttachment createAttachment(int docNo, MultipartFile file,String uploadDir) {
    	String originalFileName = file.getOriginalFilename();
        String renamedFileName = UUID.randomUUID().toString() + "_" + originalFileName;
        String filePath = uploadDir + "/" + renamedFileName;

        // 디렉토리가 존재하지 않으면 생성
        File uploadDirectory = new File(uploadDir);
        if (!uploadDirectory.exists()) {
            uploadDirectory.mkdirs();
        }
        AppAttachment attachment = AppAttachment.builder()
                .docNo(docNo)
                .fileOriginName(originalFileName)
                .fileRenamedName(renamedFileName)
                .filePath(filePath)
                .build();

        File dest = new File(filePath);
        try {
            file.transferTo(dest);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return attachment;
    }

    @RequestMapping("/pendingList")
    public String pendingList(
        @RequestParam(defaultValue = "1") int cPage,
        @RequestParam(defaultValue = "5") int numPerpage,
        HttpSession session, 
        Model model) {
        
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "redirect:/login";
        }

        int empNo = loginEmployee.getEmpNo();
        System.out.println("로그인한 직원 번호: " + empNo);
        model.addAttribute("empNo", empNo);

        //페이징처리
        int start = (cPage - 1) * numPerpage + 1;
        int end = cPage * numPerpage;

        HashMap<String, Integer> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("start", start);
        params.put("end", end);

        List<AppDocument> pendingList = apprService.selectPendingApprovals(params);
        System.out.println("결재 대기 문서 개수: " + pendingList.size());

        model.addAttribute("pendingList", pendingList);

        int totalData = apprService.selectPendingApprovalsCount(empNo);
        String pageBar = PageFactory.getPage(cPage, numPerpage, totalData, "/approve/pendingList", null, null);
        model.addAttribute("pageBar", pageBar);

        return "approve/pendingList";
    }

    @PostMapping("/ajaxApproveDocument")
    @ResponseBody // 추가
    public String ajaxApproveDocument(
            @RequestParam(value = "docNo", required = true) int docNo,
            @RequestParam(value = "empNo", required = true) Integer empNo,
            @RequestParam(value = "appvSequence", required = true) Integer appvSequence,
            @RequestParam(value = "appvStatusCode", required = true) Integer appvStatusCode,
            HttpSession session) {
        
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        HashMap<String, Object> params = new HashMap<>();
        params.put("docNo", docNo);
        params.put("empNo", empNo);
        params.put("appvSequence", appvSequence);
        params.put("appvStatusCode", appvStatusCode); //승인하는거
        apprService.updateApprovalStatus(params);
        
        
        int maxSequence = apprService.getMaxAppvSequence(docNo);

        if (appvSequence < maxSequence && appvStatusCode == 3) {
            params.put("docStatus", 1); // 진행 중
            apprService.updateDocumentStatus(params);
        } else if (appvSequence == maxSequence && appvStatusCode == 3) {
            params.put("docStatus", 2); // 완료됨
            apprService.updateDocumentStatus(params);
        }

        return "success";
    }

    @PostMapping("/ajaxRejectDocument")
    @ResponseBody // 추가
    public String ajaxRejectDocument(
            @RequestParam int docNo,
            @RequestParam int empNo,
            @RequestParam int appvSequence) {
        
        HashMap<String, Object> params = new HashMap<>();
        params.put("docNo", docNo);
        params.put("empNo", empNo);
        params.put("appvSequence", appvSequence);
        params.put("appvStatusCode", 1); // 반려하는거
        apprService.updateApprovalStatus(params);

        params.put("docStatus", 3); // REJECTED
        apprService.updateDocumentStatus(params);
        
        return "success";
    }
    
    
  //상세페이지 이동
    @RequestMapping("/documentDetail")
    public String documentDetail(@RequestParam("docNo") int docNo, Model model) {
    	AppDocument document = apprService.getDocumentById(docNo);
        LeaveReq leaveRequest = apprService.getLeaveRequestByDocNo(docNo);
        List<ApprovalLine> approvalLines = apprService.getApprovalLinesByDocNo(docNo);
        List<AppAttachment> attachedFiles = apprService.selectAttachmentsByDocNo(docNo); // 첨부 파일 목록 추가

        System.out.println("첨부 파일 목록: " + attachedFiles);

        model.addAttribute("document", document);
        model.addAttribute("leaveRequest", leaveRequest);
        model.addAttribute("approvalLines", approvalLines);
        model.addAttribute("attachedFiles", attachedFiles); // 첨부 파일 목록 추가

        return "approve/docDetail";
    }
    
    
    @PostMapping("/deleteDocuments")
    public String deleteDocuments(@RequestBody List<Integer> docNos, HttpSession session, Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "employee/login";
        }

        apprService.deleteDocuments(docNos);

        int empNo = loginEmployee.getEmpNo();
        HashMap<String, Integer> params = new HashMap<>();
        params.put("empNo", empNo);
        params.put("start", 1);
        params.put("end", 10);
        List<AppDocument> pendingList = apprService.selectPendingApprovals(params);
        model.addAttribute("pendingList", pendingList);

        int totalData = apprService.selectPendingApprovalsCount(empNo);
        String pageBar = PageFactory.getPage(1, 10, totalData, "/approve/pendingList", null, null);
        model.addAttribute("pageBar", pageBar);

        return "approve/pendingList";
               
    }
    
    
    
    @RequestMapping("/getAllDocuments")
    @ResponseBody
    public List<AppDocument> getAllDocuments(HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            return null;
        }
        int empNo = loginEmployee.getEmpNo();
        return apprService.selectAllDocuments(empNo);
    }

    @RequestMapping("/getDocumentsByStatus")
    @ResponseBody
    public List<AppDocument> getDocumentsByStatus(
            @RequestParam("status") int status, 
            HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            return null;
        }
        
        int empNo = loginEmployee.getEmpNo();
        if (status == -1) { // 전체 문서 반환
            return apprService.selectAllDocuments(empNo);
        } else { // 상태별 문서 반환
            return apprService.selectDocumentsByStatus(empNo, status);
        }
    }
    
    
    
    @RequestMapping("/getApprovedDocuments")
    @ResponseBody
    public List<AppDocument> getApprovedDocuments(HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            return null;
        }
        int empNo = loginEmployee.getEmpNo();
        return apprService.selectApprovedDocuments(empNo);
    }

    @RequestMapping("/getRejectedDocuments")
    @ResponseBody
    public List<AppDocument> getRejectedDocuments(HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            return null;
        }
        int empNo = loginEmployee.getEmpNo();
        return apprService.selectRejectedDocuments(empNo);
    }
}
