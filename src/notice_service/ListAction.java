package notice_service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_noticeboard.J_NoticeBoard;
import j_noticeboard.J_NoticeBoardDao;
import service.CommandProcess;

public class ListAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();
		String pageNum = request.getParameter("pageNum");// 패이지를 읽어오지않으면!
		if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
			pageNum = "1";

		int rowPerPage = 15;// 한페이지에 보여줄 게시글의 수
		int pagePerBlock = 10;// 한페이지에 보여줄 블락의 수 (블락은 10페이지)
		int nowPage = Integer.parseInt(pageNum);
		int total = bd.selectTotal();
		int totalPage = (int) Math.ceil((double) total / rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlk = (int) Math.ceil((double) totalPage / pagePerBlock);// 총블록
																			// 구하기
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		total = total - startRow + 1;
		List<J_NoticeBoard> list = bd.selectList(startRow, endRow);
		request.setAttribute("rowPerPage", rowPerPage);
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalBlk", totalBlk);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("total", total);
		request.setAttribute("list", list);
		return "/noticeBoard/list.jsp";
	}

}
