package com.ah.spring.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ah.spring.board.model.dto.Attachment;
import com.ah.spring.board.model.dto.Board;
import com.ah.spring.board.model.dto.BoardComment;
import com.ah.spring.board.model.service.BoardService;
import com.ah.spring.common.BadAuthenticationException;
import com.ah.spring.common.PageFactory;
import com.ah.spring.employee.model.dto.Employee;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
@Controller
@RequiredArgsConstructor

@RequestMapping("/board")
public class BoardController {
    private final BoardService service;
    private final PageFactory page;

    @RequestMapping("/mainboard")
    public String ApproveList() {
        return "board/mainboard";
    }

    @GetMapping("/boardwrite")
    public String writeForm(Model model) {
        model.addAttribute("board", new Board());
        return "board/boardwrite";
    }

    @GetMapping("/boardlist")
    public String boardlist(
            @RequestParam(defaultValue = "1") int cPage,
            @RequestParam(defaultValue = "5") int numPerpage,
            @RequestParam(required = false) String filterType,
            @RequestParam(required = false) String filterValue,
            Model model) {
        Map<String, Object> param = Map.of(
                "cPage", cPage,
                "numPerpage", numPerpage,
                "filterType", filterType != null ? filterType : "",
                "filterValue", filterValue != null ? filterValue : ""
        );

        List<Board> boards = service.selectBoardList(param);
        model.addAttribute("boards", boards);
        int totalData = service.selectBoardCount();
        String pageBar = page.getPage(cPage, numPerpage, totalData, "boardlist.do", filterType, filterValue);
        model.addAttribute("pageBar", pageBar);
        model.addAttribute("totalContents", totalData);
        
        return "board/boardlist";
    }

    @PostMapping("/insertboard")
    public String insertBoard(
            HttpSession session,
            MultipartFile[] upFile,
            Board b,
            Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            model.addAttribute("msg", "로그인이 필요합니다.");
            model.addAttribute("loc", "/login");
            return "common/msg";
        }

        b.setBoardWriter(loginEmployee.getEmpId());

        List<Attachment> files = new ArrayList<>();
        String path = session.getServletContext().getRealPath("/resources/upload/board");

        if (upFile != null) {
            for (MultipartFile file : upFile) {
                if (!file.isEmpty()) {
                    String oriName = file.getOriginalFilename();
                    String ext = oriName.substring(oriName.lastIndexOf("."));
                    Date today = new Date(System.currentTimeMillis());
                    int randomVal = (int) (Math.random() * 10000) + 1;
                    String rename = "BOARDFILES_" + new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(today)
                            + "_" + randomVal + ext;

                    File dir = new File(path);
                    if (!dir.exists()) dir.mkdirs();
                    try {
                        file.transferTo(new File(path, rename));

                        files.add(Attachment.builder()
                                .bfileOriName(oriName)
                                .bfileReName(rename)
                                .build());
                        System.out.println("첨부 파일 추가: " + oriName + ", " + rename);
                    } catch (IOException e) {
                        e.printStackTrace();
                        model.addAttribute("msg", "파일 업로드 중 오류가 발생했습니다.");
                        model.addAttribute("loc", "/board/write");
                        return "common/msg";
                    }
                }
            }
            b.setFiles(files);
            System.out.println("첨부 파일 목록: " + files);
        }

        int result = 0;
        String msg, loc;
        try {
            result = service.insertBoard(b);
            System.out.println("게시글 등록 결과: " + result);
            System.out.println("게시글 번호: " + b.getBoardNo());

            msg = "게시글 등록 성공!";
            loc = "/board/mainboard";
        } catch (BadAuthenticationException e) {
            msg = "게시글 등록 실패, 다시 시도하세요!";
            loc = "board/boardwrite";
            files.forEach(f -> {
                File delFile = new File(path + "/" + f.getBfileReName());
                if (delFile.exists()) delFile.delete();
            });
        }

        model.addAttribute("msg", msg);
        model.addAttribute("loc", loc);
        return "common/msg";
    }
    
    @GetMapping("/boardview")
    public String getBoardView(@RequestParam("boardNo") int boardNo, Model model,HttpSession session) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");

        // 서비스나 DAO를 통해 게시글 정보를 가져오는 로직
        Board board = service.selectBoardByNo(boardNo);
        if (board != null) {
        	List<Attachment> attachments = service.selectAttachmentsByBoardNo(boardNo);
            board.setFiles(attachments);
            
            // 댓글 목록을 가져오는 로직 추가
            List<BoardComment> comments = service.selectCommentsByBoardNo(boardNo);
//            for (BoardComment comment : comments) {
//                if (loginEmployee != null && loginEmployee.getEmpId().equals(comment.getCommentWriter())) {
//                    comment.setDeletable(true);  // 본인이 작성한 댓글임을 표시
//                } else {
//                    comment.setDeletable(false);  // 본인이 작성한 댓글이 아님을 표시
//                }
//            }
            board.setComments(comments);
            // 작성자의 프로필 사진 경로를 가져오는 로직
            String writerProfileReName = service.getWriterProfileReName(board.getBoardWriter());
            model.addAttribute("writerProfileReName", writerProfileReName);
        }
        model.addAttribute("board", board);
        
        
        return "board/boardview"; // boardview.jsp로 이동
    }
    
    @PostMapping("/delete")
    @ResponseBody
    public Map<String, Object> deleteBoard(@RequestBody Map<String, Integer> request) {
        int boardNo = request.get("boardNo");
        String msg;
        boolean success;
        try {
            int result = service.deleteBoard(boardNo);
            if (result > 0) {
                msg = "게시글 삭제 성공!";
                success = true;
            } else {
                msg = "게시글 삭제 실패, 다시 시도하세요!";
                success = false;
            }
        } catch (Exception e) {
            msg = "서버 오류로 인해 게시글 삭제에 실패했습니다.";
            success = false;
            e.printStackTrace();  // 서버 로그에 예외를 기록
        }

        return Map.of("success", success, "msg", msg);
    }
    
    
    @PostMapping("/addComment")
    @ResponseBody
    public Map<String, Object> addComment(HttpSession session, @RequestBody BoardComment comment) {
    	Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
    	if (loginEmployee == null) {
            return Map.of("success", false, "msg", "로그인이 필요합니다.");
        }
        comment.setCommentWriter(loginEmployee.getEmpId());

//        if (comment.getParentId() == 0) {
//            comment.setCommentLevel(0); // 최상위 댓글의 commentLevel은 0
//        } else {
//            comment.setCommentLevel(1); // 대댓글의 commentLevel은 1
//        }
        
        
        System.out.println("comment: " + comment);

    	//댓글 저장시키고
    	boolean success = service.addComment(comment);
        // 작성자의 프로필 이미지 경로 가져오기
        String writerProfileReName = service.getWriterProfileReName(comment.getCommentWriter());
        // 프로필 이미지가 없는 경우 기본 이미지로 설정
        if (writerProfileReName == null || writerProfileReName.isEmpty()) {
            writerProfileReName = "basicprofile.png";
        }
        // 현재 시간 생성
        String formattedDate = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());

        
     // Null 체크
        System.out.println("commentWriter: " + comment.getCommentWriter());
        System.out.println("writerProfileReName: " + writerProfileReName);
        System.out.println("commentContent: " + comment.getCommentContent());
        System.out.println("commentNo: " + comment.getCommentNo()); // commentNo 출력 확인

        return Map.of(
            "success", success,
            "commentWriter", comment.getCommentWriter(),
            "writerProfileReName", writerProfileReName,
            "createdAt", formattedDate,
            "commentContent", comment.getCommentContent(),
            "commentNo", comment.getCommentNo(),
            "commentLevel", comment.getCommentLevel()
        );
    }
    @PostMapping("/deleteComment")
    @ResponseBody
    public Map<String, Object> deleteComment(@RequestBody Map<String, Integer> request) {
    	Integer commentNo = request.get("commentNo");
        if (commentNo == null) {
            return Map.of("success", false, "msg", "댓글 번호가 전달되지 않았습니다.");
        }
        System.out.println("Deleting comment with commentNo: " + commentNo); // 디버깅 메시지 추가

//        boolean success = service.deleteComment(commentNo);
//        if (success) {
//            return Map.of("success", true, "msg", "댓글이 삭제되었습니다.");
//        } else {
//            return Map.of("success", false, "msg", "댓글 삭제에 실패했습니다.");
//        }
        
        
        boolean success = service.deleteComment(commentNo);
        return Map.of("success", success);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /////////////////////////////
    

    @PostMapping("/edit")
    public String editBoard(
            HttpSession session,
            MultipartFile[] upFile,
            Board b,
            Model model) {
        Employee loginEmployee = (Employee) session.getAttribute("loginEmployee");
        if (loginEmployee == null) {
            model.addAttribute("msg", "로그인이 필요합니다.");
            model.addAttribute("loc", "/login");
            return "common/msg";
        }

        b.setBoardWriter(loginEmployee.getEmpId());

        List<Attachment> files = new ArrayList<>();
        String path = session.getServletContext().getRealPath("/resources/static/upload/board");

        if (upFile != null) {
            for (MultipartFile file : upFile) {
                if (!file.isEmpty()) {
                    String oriName = file.getOriginalFilename();
                    String ext = oriName.substring(oriName.lastIndexOf("."));
                    Date today = new Date(System.currentTimeMillis());
                    int randomVal = (int) (Math.random() * 10000) + 1;
                    String rename = "BOARDFILES_" + new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(today)
                            + "_" + randomVal + ext;

                    File dir = new File(path);
                    if (!dir.exists()) dir.mkdirs();
                    try {
                        file.transferTo(new File(path, rename));

                        files.add(Attachment.builder()
                                .bfileOriName(oriName)
                                .bfileReName(rename)
                                .build());
                    } catch (IOException e) {
                        e.printStackTrace();
                        model.addAttribute("msg", "파일 업로드 중 오류가 발생했습니다.");
                        model.addAttribute("loc", "/board/edit/" + b.getBoardNo());
                        return "common/msg";
                    }
                }
            }
            b.setFiles(files);
        }

        int result = 0;
        String msg, loc;
        try {
            result = service.updateBoard(b);
            msg = "게시글 수정 성공!";
            loc = "/board/boardlist";
        } catch (BadAuthenticationException e) {
            msg = "게시글 수정 실패, 다시 시도하세요!";
            loc = "board/edit/" + b.getBoardNo();
            files.forEach(f -> {
                File delFile = new File(path + "/" + f.getBfileReName());
                if (delFile.exists()) delFile.delete();
            });
        }

        model.addAttribute("msg", msg);
        model.addAttribute("loc", loc);
        return "common/msg";
    }

    


    
}