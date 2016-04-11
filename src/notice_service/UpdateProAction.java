package notice_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_noticeboard.J_NoticeBoard;
import j_noticeboard.J_NoticeBoardDao;
import service.CommandProcess;

public class UpdateProAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		J_NoticeBoard jnb = new J_NoticeBoard();
		jnb.setBrd_no(Integer.parseInt(request.getParameter("brd_no")));
		jnb.setBrd_subject(request.getParameter("brd_subject"));
		jnb.setBrd_content(request.getParameter("brd_content"));
		jnb.setAdmin(request.getParameter("admin"));
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao jnbd = J_NoticeBoardDao.getInstance();
		int result = jnbd.update(jnb);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("result", result);
		return "/noticeBoard/updatePro.jsp";
	}

}
