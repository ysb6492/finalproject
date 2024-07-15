package com.ah.spring.common;

import org.springframework.stereotype.Component;

@Component
public class PageFactory {
	public static String getPage(int cPage, int numPerpage, int totalData, String url, String filterType, String filterValue) {
		int totalPage = (int) Math.ceil((double) totalData / numPerpage); // 총 페이지 수
        int pageBarSize = 5; // 한 번에 표시할 페이지 수
        int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1; // 페이지바의 시작 번호
        int pageEnd = pageNo + pageBarSize - 1; // 페이지바의 끝 번호
     // 페이지바의 끝 번호가 총 페이지 수를 넘지 않도록 조정
        if (pageEnd > totalPage) {
            pageEnd = totalPage;
        }
        StringBuffer pageBar = new StringBuffer();
        pageBar.append("<ul class='pagination justify-content-center pagination-sm'>");

     // 이전 버튼
        if (pageNo == 1) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'>이전</a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link' href='javascript:fn_paging(").append(pageNo - 1).append(")'>이전</a>");
            pageBar.append("</li>");
        }

        // 페이지 번호
        while (pageNo <= pageEnd) {
            if (pageNo == cPage) {
                pageBar.append("<li class='page-item active'>");
                pageBar.append("<a class='page-link' href='#'>").append(pageNo).append("</a>");
                pageBar.append("</li>");
            } else {
                pageBar.append("<li class='page-item'>");
                pageBar.append("<a class='page-link' href='javascript:fn_paging(").append(pageNo).append(")'>").append(pageNo).append("</a>");
                pageBar.append("</li>");
            }
            pageNo++;
        }
      //!(pageNo > pageEnd || pageNo > totalPage
        // 다음 버튼
        if (pageNo > totalPage) {
            pageBar.append("<li class='page-item disabled'>");
            pageBar.append("<a class='page-link' href='#'>다음</a>");
            pageBar.append("</li>");
        } else {
            pageBar.append("<li class='page-item'>");
            pageBar.append("<a class='page-link' href='javascript:fn_paging(").append(pageNo).append(")'>다음</a>");
            pageBar.append("</li>");
        }
        pageBar.append("</ul>");

		
        pageBar.append("<script>");
        pageBar.append("function fn_paging(pageNo) {");
        pageBar.append("$.get('").append(url).append("?cPage=' + pageNo + '&numPerpage=").append(numPerpage)
            .append("&filterType=").append(filterType != null ? filterType : "").append("&filterValue=").append(filterValue != null ? filterValue : "")
            .append("', function(response) { $('.content').html(response); });");
        pageBar.append("}");
        pageBar.append("</script>");
		return pageBar.toString();
		
	}
}
