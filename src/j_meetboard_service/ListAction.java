package j_meetboard_service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import j_meetboard.J_MeetBoard;
import j_meetboard.J_MeetBoardDao;
import service.CommandProcess;

public class ListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response){
		
		HttpSession session = request.getSession();
		String m_no = (String) session.getAttribute("m_no");
		//System.out.println(m_no);//이거0
		String pageNum = request.getParameter("pageNum");//패이지를 읽어오지않으면!
		J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		
		if(searchType == null || searchType.equals("null") || searchType.equals("")){
			searchType = "all";
		}
		
		if(searchTxt == null || searchTxt.equals("null")){
			searchTxt = "";
		}
		
		
		int rowPerPage = 15;//한페이지에 보여줄 게시글의 수
		int pagePerBlock = 10;//한페이지에 보여줄 블락의 수 (블락은 10페이지)
		if (pageNum == null || pageNum.equals("null")||pageNum.equals("")) pageNum = "1";//페이지는 1이다.
		int nowPage = Integer.parseInt(pageNum);
		int total = bd.selectTotal(searchType, searchTxt);
		int totalPage = (int)Math.ceil((double)total/rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlk = (int)Math.ceil((double)totalPage/pagePerBlock);//총블록 구하기 
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		total = total - startRow +1;
		
		List<J_MeetBoard> list = bd.selectList(startRow, endRow, searchType, searchTxt);
		
		request.setAttribute("rowPerPage", rowPerPage);
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("totalBlk", totalBlk);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("total", total);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("list", list);
		
		return "list.jsp";
	}

}
