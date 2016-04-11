package notice_service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_noticeboard.J_NoticeBoard;
import j_noticeboard.J_NoticeBoardDao;
import service.CommandProcess;

public class WriteFormAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		return "/noticeBoard/writeForm.jsp";
	}

}
