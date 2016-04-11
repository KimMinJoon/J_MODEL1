package notice_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_noticeboard.J_NoticeBoard;
import j_noticeboard.J_NoticeBoardDao;
import service.CommandProcess;

public class UpdateFormAction implements CommandProcess {
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao jnbd = J_NoticeBoardDao.getInstance();
		J_NoticeBoard jnb = jnbd.select(brd_no);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("jnb", jnb);
		return "/noticeBoard/updateForm.jsp";
	}

}
