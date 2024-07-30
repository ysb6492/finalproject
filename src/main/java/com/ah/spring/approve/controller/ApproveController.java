package com.ah.spring.approve.controller;

import java.io.File; 
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ah.spring.approve.model.dto.AppAttachment;
import com.ah.spring.approve.model.dto.AppComment;
import com.ah.spring.approve.model.dto.AppDocument;
import com.ah.spring.approve.model.dto.ApprovalLine;
import com.ah.spring.approve.model.dto.ExpenseReq;
import com.ah.spring.approve.model.dto.LeaveReq;
import com.ah.spring.approve.model.dto.OvertimeReq;
import com.ah.spring.approve.model.service.ApproveService;
import com.ah.spring.common.PageFactory;
import com.ah.spring.employee.model.dto.Employee;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/approve")
@RequiredArgsConstructor
public class ApproveController {

    private final ApproveService apprService;
    private final ServletContext servletContext;
	private final PageFactory pageFactory;


    //결제 메인페이지
    @RequestMapping("/mainapprove")
    public String mainApprove() {
        return "approve/mainapprove";
    }

  //문서종류에 따른 문서페이지로 이동
    @RequestMapping("/selectDoc")
    public String selectDoc(@RequestParam("docType") String docType, HttpSession session, Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
        	return "redirect:/login";
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
    
    //기안 문서함 리스트 조회
    @RequestMapping("/draftList")
    public String draftList(
    		@RequestParam(defaultValue="1") int cPage,
			@RequestParam(defaultValue="10") int numPerpage,
	        @RequestParam(defaultValue = "-1") int status, // 기본값을 -1로 설정하여 전체 문서 조회
    		HttpSession session, Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
        	return "redirect:/login";
        }
        int empNo = loginEmployee.getEmpNo();
        
        
        List<AppDocument> draftList;
        int totalData;

        if (status == -1) { // 전체 조회
            draftList = apprService.selectDraftList(empNo, cPage, numPerpage);
            totalData = apprService.selectDraftCount(empNo);
        } else {
            draftList = apprService.selectDocumentsByStatus(empNo, status, cPage, numPerpage);
            totalData = apprService.selectDocumentsByStatusCount(empNo, status);
        }
        String pageBar = pageFactory.getPage(cPage, numPerpage, totalData, "/approve/draftList", "status=" + status, null);

        model.addAttribute("pageBar", pageBar);
        model.addAttribute("empNo", empNo);
        model.addAttribute("draftList", draftList);
        model.addAttribute("status", status); // 상태값 

        return "approve/draftList";
    }
    
    //결재문서함 리스트 조회
    @RequestMapping("/pendingList")
    public String pendingList(
        @RequestParam(defaultValue = "1") int cPage,
        @RequestParam(defaultValue = "10") int numPerpage,
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
    
    //임시저장문서함 리스트 조회
    @RequestMapping("/tempsaveList")
    public String tempSaveList(
    		@RequestParam(defaultValue="1") int cPage,
    		@RequestParam(defaultValue="10") int numPerpage,
    		HttpSession session, Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "redirect:/login";
        }
        int empNo = loginEmployee.getEmpNo();
    
        List<AppDocument> tempsaveList = apprService.selectTempSaveList(empNo, cPage, numPerpage);
        System.out.println("controller: "+tempsaveList);
        int totalData = apprService.selectTempSaveCount(empNo);
        String pageBar = pageFactory.getPage(cPage, numPerpage, totalData, "/approve/tempsaveList", null, null);

        model.addAttribute("pageBar", pageBar);
        model.addAttribute("empNo", empNo);
        model.addAttribute("tempsaveList", tempsaveList);
        
        return "approve/tempsaveList";
    }

    
    //휴가 신청서 작성,제출
    @PostMapping("/ajaxWriteVacation")
    public String ajaxVctWrite(
            @RequestParam HashMap<String, String> params,
            @RequestParam MultipartFile[] files,
            @RequestParam(name = "observers", required = false, defaultValue = "") String observers,
            @RequestParam(name = "docStatus") int docStatus,

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
                .docCategory("연차신청서")
                .docContent(params.get("docContent"))
                .empNo(Employee.builder().empNo(empNo).build())
                .docStatus(docStatus) //대기중
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
        
        
        int cPage = 1;
        int numPerpage = 5;

        // 기안 문서 리스트를 다시 로드하여 모델에 추가
        List<AppDocument> draftList = apprService.selectDraftList(empNo, cPage, numPerpage);
        List<AppDocument> tempsaveList = apprService.selectTempSaveList(empNo, cPage, numPerpage);
        model.addAttribute("draftList", draftList);
        model.addAttribute("tempsaveList", tempsaveList);

        
     // 임시저장 시에는 임시저장 문서함으로 리다이렉트, 그렇지 않으면 기안문서함으로 리다이렉트
        return docStatus == 4 ? "approve/tempsaveList" : "approve/draftList";
    }
    
    
    
    
    // AppAttachment 객체 생성
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

    
    // 결재 승인 처리
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
    // 결재 반려 처리
    @PostMapping("/ajaxRejectDocument")
    @ResponseBody // 추가
    public String ajaxRejectDocument(
            @RequestParam int docNo,
            @RequestParam int empNo,
            @RequestParam int appvSequence,
            @RequestParam String rejectMessage,
            HttpSession session){
    	
    	try {
    		Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

            HashMap<String, Object> params = new HashMap<>();
            params.put("docNo", docNo);
            params.put("empNo", empNo);
            params.put("appvSequence", appvSequence);
            params.put("appvStatusCode", 1); // 반려하는거
            apprService.updateApprovalStatus(params);

            params.put("docStatus", 3); // REJECTED
            apprService.updateDocumentStatus(params);
            
            AppComment comment = AppComment.builder()
            		.docNo(AppDocument.builder().docNo(docNo).build())
            		.empNo(Employee.builder().empNo(empNo).build())
                    .commentContent(rejectMessage)
                    .createdDate(new Date(System.currentTimeMillis()))
            		.build();
            
            System.out.println("반려메세지 내용은 : " + comment);

            apprService.insertComment(comment);
            
            return "success";
    	}catch (Exception e) {
            e.printStackTrace();
            return "error: " + e.getMessage();
        }
        
    }
    
    
    //상세페이지 이동
    @RequestMapping("/documentDetail")
    public String documentDetail(@RequestParam("docNo") int docNo, Model model) {
    	AppDocument document = apprService.getDocumentById(docNo);
        List<ApprovalLine> approvalLines = apprService.getApprovalLinesByDocNo(docNo);
        List<AppAttachment> attachedFiles = apprService.selectAttachmentsByDocNo(docNo); // 첨부 파일 목록 추가
        List<AppComment> comments = apprService.selectCommentByDocNo(docNo);
        System.out.println("첨부 파일 목록: " + attachedFiles);
   
        model.addAttribute("document", document);
        model.addAttribute("approvalLines", approvalLines);
        model.addAttribute("attachedFiles", attachedFiles); // 첨부 파일 목록 추가
        model.addAttribute("comments",comments);
        
        if ("지출결의서".equals(document.getDocCategory())) {
        	List<ExpenseReq> expenseRequest = apprService.getExpenseRequestByDocNo(docNo);
            model.addAttribute("expenseRequest", expenseRequest);

            return "approve/expenseDetail";
            
        } else if ("연차신청서".equals(document.getDocCategory())) {
            LeaveReq leaveRequest = apprService.getLeaveRequestByDocNo(docNo);
            model.addAttribute("leaveRequest", leaveRequest);
            return "approve/vacationDetail";
            
        } else if("연장근무신청서".equals(document.getDocCategory())){
        	OvertimeReq overtimeRequest = apprService.getOvertimeRequestByDocNo(docNo);
        	model.addAttribute("overtimeRequest",overtimeRequest);
        	return "approve/overtimeDetail";
        }else {
            return "approve/mainapprove";
        }
    }
    
    // 문서 삭제
    @PostMapping("/deleteDocuments")
    public String deleteDocuments(
    		@RequestBody List<Integer> docNos, 
    		HttpSession session, Model model,
    		HttpServletRequest request) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "employee/login";
        }

        apprService.deleteDocuments(docNos);

        // 이전 페이지 URL 가져오기
        String referer = request.getHeader("Referer");

        // referer가 null이 아닌 경우 해당 페이지로 리다이렉트, 그렇지 않은 경우 결재 메인 페이지로 리다이렉트
        if (referer != null) {
            return "redirect:" + referer;
        } else {
            return "redirect:/approve/mainapprove"; // 기본 리다이렉트 URL 설정
        }
               
    }
    
    
    // 모든 문서 조회
    @RequestMapping("/getAllDocuments")
    @ResponseBody
    public Map<String, Object> getAllDocuments(
            @RequestParam(value = "cPage", defaultValue = "1") int cPage,
            @RequestParam(value = "numPerpage", defaultValue = "10") int numPerpage,
            HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            return null;
        }
        int empNo = loginEmployee.getEmpNo();
        List<AppDocument> documentList = apprService.selectAllDocuments(empNo, cPage, numPerpage);
        int totalData = apprService.selectDraftCount(empNo);

        Map<String, Object> result = new HashMap<>();
        result.put("documentList", documentList);
        result.put("pageBar", pageFactory.getPage(cPage, numPerpage, totalData, "/approve/draftList", "status=-1", null));

        return result;
    }
    
    // 상태별 문서 조회
    @RequestMapping("/getDocumentsByStatus")
    @ResponseBody
    public Map<String, Object> getDocumentsByStatus(
            @RequestParam("status") int status, 
            @RequestParam(value = "cPage", defaultValue = "1") int cPage,
            @RequestParam(value = "numPerpage", defaultValue = "10") int numPerpage,
            HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            return null;
        }
        
        int empNo = loginEmployee.getEmpNo();
        List<AppDocument> documentList;
        int totalData;

        if (status == -1) { // 전체 문서 반환
            documentList = apprService.selectAllDocuments(empNo, cPage, numPerpage);
            totalData = apprService.selectDraftCount(empNo);
        } else { // 상태별 문서 반환
            documentList = apprService.selectDocumentsByStatus(empNo, status, cPage, numPerpage);
            totalData = apprService.selectDocumentsByStatusCount(empNo, status);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("documentList", documentList);
        result.put("pageBar", pageFactory.getPage(cPage, numPerpage, totalData, "/approve/draftList", "status=" + status, null));

        return result;
    }
 
    
    
    
    
    
    
    
    
    // 승인된 문서 조회
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
    // 반려된 문서 조회
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
    
    
 
    
 // 지출 결의서 작성 및 제출
    @PostMapping("/ajaxWriteExpense")
    public String ajaxWriteExpense(
    		 @RequestBody Map<String, Object> requestData,
    	        HttpSession session, Model model) {

    	    Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
    	    if (loginEmployee == null) return "employee/login";
    	    int empNo = loginEmployee.getEmpNo();

    	    String observers = (String) requestData.get("observers");
    	    int docStatus = (Integer) requestData.get("docStatus");
    	    Map<String, String> params = (Map<String, String>) requestData.get("params");
    	    List<Map<String, String>> details = (List<Map<String, String>>) requestData.get("details");

    	    System.out.println("처리 전 결재자들: " + observers);
    	    String[] arrayObserver = observers.isEmpty() ? new String[0] : observers.split(",");
    	    System.out.println("결재자들: " + Arrays.toString(arrayObserver));

    	    // AppDocument 객체 생성 및 삽입
    	    AppDocument document = AppDocument.builder()
    	            .docTitle(params.get("docTitle"))
    	            .docCategory("지출결의서")
    	            .docContent(params.get("docContent"))
    	            .empNo(Employee.builder().empNo(empNo).build())
    	            .docStatus(docStatus)
    	            .build();
    	    //apprService.insertApprovalDocument(document);
    	    // 기존 문서 업데이트
            if (params.get("docNo") != null && !params.get("docNo").isEmpty()) {
                document.setDocNo(Integer.parseInt(params.get("docNo")));
                apprService.updateApprovalDocument(document);
            } else {
                apprService.insertApprovalDocument(document);
            }
            
    	    // 각 행의 데이터를 처리
    	    for (Map<String, String> detail : details) {
    	        String expenseCostStr = detail.get("expenseCost").replaceAll(",", "");
    	        String totalExpenseStr = params.getOrDefault("totalExpense", "0").replaceAll(",", "");
    	        // expenseDate가 null 또는 비어 있는 경우에 대한 처리
    	        Date expenseDate = null;
    	        if (detail.get("expenseDate") != null && !detail.get("expenseDate").isEmpty()) {
    	            expenseDate = Date.valueOf(detail.get("expenseDate"));
    	        }
    	     // 빈 문자열 또는 null을 0으로 처리
    	        int expenseCost = expenseCostStr.isEmpty() ? 0 : Integer.parseInt(expenseCostStr);
    	        int totalExpense = totalExpenseStr.isEmpty() ? 0 : Integer.parseInt(totalExpenseStr);
    	        ExpenseReq expenseReq = ExpenseReq.builder()
    	                .docNo(document.getDocNo())
    	                .expenseReason(params.get("docContent"))
    	                .expenseDate(expenseDate)
    	                .expenseType(detail.get("expenseType"))
    	                .useInformation(detail.get("useInformation"))
    	                .expenseCost(expenseCost)
    	                .expenseEtc(detail.get("expenseEtc"))
    	                .totalExpense(totalExpense)
    	                .build();
    	        apprService.insertExpenseRequest(expenseReq);
    	    }

    	    // ApprovalLine 객체 생성 및 삽입
    	    int docNo = document.getDocNo();
    	    for (String observer : arrayObserver) {
    	        String[] parts = observer.split(":");
    	        int observerEmpNo = Integer.parseInt(parts[0].trim());
    	        int sequence = Integer.parseInt(parts[1].trim());
    	        ApprovalLine approvalLine = ApprovalLine.builder()
    	                .docNo(AppDocument.builder().docNo(docNo).build())
    	                .empNo(Employee.builder().empNo(observerEmpNo).build())
    	                .appvStatusCode(0) // PENDING
    	                .appvSequence(sequence)
    	                .build();
    	        try {
    	            apprService.insertApprovalLine(approvalLine);
    	        } catch (DuplicateKeyException e) {
    	            System.out.println("Error inserting approval line: " + e.getMessage());
    	        }
    	    }
            int cPage = 1;
            int numPerpage = 10;

            // 기안 문서 리스트를 다시 로드하여 모델에 추가
            List<AppDocument> draftList = apprService.selectDraftList(empNo, cPage, numPerpage);
            List<AppDocument> tempsaveList = apprService.selectTempSaveList(empNo, cPage, numPerpage);
            model.addAttribute("draftList", draftList);
            model.addAttribute("tempsaveList", tempsaveList);

        // 임시저장 시에는 임시저장 문서함으로 리다이렉트, 그렇지 않으면 기안문서함으로 리다이렉트
        return docStatus == 4 ? "approve/tempsaveList" : "approve/draftList";
    }
//    @PostMapping("/ajaxWriteExpense")
//    public String ajaxWriteExpense(
//            @RequestBody Map<String, Object> requestData,
//            HttpSession session, Model model) {
//
//        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
//        if (loginEmployee == null) return "employee/login";
//        int empNo = loginEmployee.getEmpNo();
//
//        String observers = (String) requestData.get("observers");
//        int docStatus = (Integer) requestData.get("docStatus");
//        Map<String, String> params = (Map<String, String>) requestData.get("params");
//        List<Map<String, String>> details = (List<Map<String, String>>) requestData.get("details");
//
//        System.out.println("처리 전 결재자들: " + observers);
//        String[] arrayObserver = observers.isEmpty() ? new String[0] : observers.split(",");
//        System.out.println("결재자들: " + Arrays.toString(arrayObserver));
//
//        int docNo;
//        if (params.containsKey("docNo")) {
//            // 기존 문서 수정
//            docNo = Integer.parseInt(params.get("docNo"));
//            AppDocument document = apprService.getDocumentById(docNo);
//            document.setDocTitle(params.get("docTitle"));
//            document.setDocCategory("지출결의서");
//            document.setDocContent(params.get("docContent"));
//            document.setDocStatus(docStatus);
//            apprService.updateApprovalDocument(document);
//
//            apprService.deleteExpenseRequestByDocNo(docNo); // 기존 지출내역 삭제
//        } else {
//            // 새 문서 생성
//            AppDocument document = AppDocument.builder()
//                    .docTitle(params.get("docTitle"))
//                    .docCategory("지출결의서")
//                    .docContent(params.get("docContent"))
//                    .empNo(Employee.builder().empNo(empNo).build())
//                    .docStatus(docStatus)
//                    .build();
//            apprService.insertApprovalDocument(document);
//            docNo = document.getDocNo();
//        }
//
//        // 각 행의 데이터를 처리
//        for (Map<String, String> detail : details) {
//            String expenseCostStr = detail.get("expenseCost").replaceAll(",", "");
//            String totalExpenseStr = params.getOrDefault("totalExpense", "0").replaceAll(",", "");
//
//            ExpenseReq expenseReq = ExpenseReq.builder()
//                    .docNo(docNo)
//                    .expenseReason(params.get("docContent"))
//                    .expenseDate(Date.valueOf(detail.get("expenseDate")))
//                    .expenseType(detail.get("expenseType"))
//                    .useInformation(detail.get("useInformation"))
//                    .expenseCost(Integer.parseInt(expenseCostStr))
//                    .expenseEtc(detail.get("expenseEtc"))
//                    .totalExpense(Integer.parseInt(totalExpenseStr))
//                    .build();
//            apprService.insertExpenseRequest(expenseReq);
//        }
//
//        // ApprovalLine 객체 생성 및 삽입
//        for (String observer : arrayObserver) {
//            String[] parts = observer.split(":");
//            int observerEmpNo = Integer.parseInt(parts[0].trim());
//            int sequence = Integer.parseInt(parts[1].trim());
//            ApprovalLine approvalLine = ApprovalLine.builder()
//                    .docNo(AppDocument.builder().docNo(docNo).build())
//                    .empNo(Employee.builder().empNo(observerEmpNo).build())
//                    .appvStatusCode(0) // PENDING
//                    .appvSequence(sequence)
//                    .build();
//            apprService.insertApprovalLine(approvalLine);
//        }
//
//        // 기안 문서 리스트를 다시 로드하여 모델에 추가
//        List<AppDocument> draftList = apprService.selectDraftList(empNo);
//        model.addAttribute("draftList", draftList);
//
//        // 임시저장 시에는 임시저장 문서함으로 리다이렉트, 그렇지 않으면 기안문서함으로 리다이렉트
//        return docStatus == 4 ? "approve/tempsaveList" : "approve/draftList";
//    }
    // 연장근무 신청서 작성 및 제출
    @PostMapping("/ajaxWriteOvertime")
    public String ajaxWriteOvertime(
            @RequestBody Map<String, Object> requestData,
            HttpSession session, Model model) {

        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) return "employee/login";
        int empNo = loginEmployee.getEmpNo();

        String observers = (String) requestData.get("observers");
        int docStatus = (Integer) requestData.get("docStatus");
        Map<String, String> params = (Map<String, String>) requestData.get("params");

        System.out.println("처리 전 결재자들: " + observers);
        String[] arrayObserver = observers.isEmpty() ? new String[0] : observers.split(",");
        System.out.println("결재자들: " + Arrays.toString(arrayObserver));

        // AppDocument 객체 생성 및 삽입
        AppDocument document = AppDocument.builder()
                .docTitle(params.get("docTitle"))
                .docCategory("연장근무신청서")
                .docContent(params.get("overtimeReason"))
                .empNo(Employee.builder().empNo(empNo).build())
                .docStatus(docStatus)
                .build();
        apprService.insertApprovalDocument(document);

        // OvertimeReq 객체 생성 및 삽입
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        OvertimeReq overtimeReq = OvertimeReq.builder()
                .docNo(document.getDocNo())
                .overtimeType(params.get("overtimeType"))
                .overtimeDate(Date.valueOf(params.get("overtimeDate")))
                .overtimeStartTime(LocalDateTime.parse(params.get("overtimeDate") + " " + params.get("startTimeHour") + ":" + params.get("startTimeMinute"), formatter))
                .overtimeEndTime(LocalDateTime.parse(params.get("overtimeDate") + " " + params.get("endTimeHour") + ":" + params.get("endTimeMinute"), formatter))
                .overtimeReason(params.get("overtimeReason"))
                .overtime(params.get("calculatedOvertime")) // 여기에 calculatedOvertime 값 설정
                .build();
        apprService.insertOvertimeRequest(overtimeReq);

        // ApprovalLine 객체 생성 및 삽입
        int docNo = document.getDocNo();
        for (String observer : arrayObserver) {
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
        int cPage = 1;
        int numPerpage = 10;

        // 기안 문서 리스트를 다시 로드하여 모델에 추가
        List<AppDocument> draftList = apprService.selectDraftList(empNo, cPage, numPerpage);
        List<AppDocument> tempsaveList = apprService.selectTempSaveList(empNo, cPage, numPerpage);
        model.addAttribute("draftList", draftList);
        model.addAttribute("tempsaveList", tempsaveList);

        // 임시저장 시에는 임시저장 문서함으로 리다이렉트, 그렇지 않으면 기안문서함으로 리다이렉트
        return docStatus == 4 ? "approve/tempsaveList" : "approve/draftList";
    }
    
    
    
 // 임시 저장된 문서 수정 페이지 이동
    @RequestMapping("/editTempSaveDoc")
    public String editTempSaveDoc(
    		@RequestParam("docNo") int docNo, 
    		Model model, 
    		HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        if (loginEmployee == null) {
            return "redirect:/login";
        }

        AppDocument document = apprService.getDocumentById(docNo);
        LeaveReq leaveRequest = apprService.getLeaveRequestByDocNo(docNo);
        List<ApprovalLine> approvalLines = apprService.getApprovalLinesByDocNo(docNo);
        List<AppAttachment> attachedFiles = apprService.selectAttachmentsByDocNo(docNo);
        List<AppComment> comments = apprService.selectCommentByDocNo(docNo);

        model.addAttribute("document", document);
        model.addAttribute("leaveRequest", leaveRequest);
        model.addAttribute("approvalLines", approvalLines);
        model.addAttribute("attachedFiles", attachedFiles);
        model.addAttribute("comments", comments);

        // 문서 카테고리에 따라 수정 페이지를 리턴
        if ("지출결의서".equals(document.getDocCategory())) {
            List<ExpenseReq> expenseRequest = apprService.getExpenseRequestByDocNo(docNo);
            model.addAttribute("expenseRequest", expenseRequest);
            return "approve/expenseEditDoc";  // 지출결의서 수정 페이지로 리턴
        } else if ("연차신청서".equals(document.getDocCategory())) {
            return "approve/vacationEditDoc";  // 연차신청서 수정 페이지로 리턴
        } else if ("연장근무신청서".equals(document.getDocCategory())) {
            OvertimeReq overtimeRequest = apprService.getOvertimeRequestByDocNo(docNo);
            model.addAttribute("overtimeRequest", overtimeRequest);
            return "approve/overtimeEditDoc";  // 연장근무신청서 수정 페이지로 리턴
        } else {
            return "approve/mainapprove";  // 기타의 경우 메인 페이지로 리턴
        }
    }
}
