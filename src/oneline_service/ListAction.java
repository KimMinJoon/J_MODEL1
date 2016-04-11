package oneline_service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import j_onelineboard.J_OneLineBoard;
import j_onelineboard.J_OneLineBoardDAO;
import service.CommandProcess;

public class ListAction implements CommandProcess {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {		
		
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		
		if(searchType == null || searchType.equals("null") || searchType.equals("")){
			searchType = "brd_content";
		}
		
		if(searchTxt == null || searchTxt.equals("null")){
			searchTxt = "";
		}
		
		int rowPerPage = 10;
		int pagePerBlock = 10;
		int nowPage = 0;
		String pageNum = request.getParameter("pageNum");

		if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
			pageNum = "1";
		}
		nowPage = Integer.parseInt(pageNum);

		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int total = jobd.selectTotal(searchType, searchTxt);

		int totalPage = (int) Math.ceil((double) total / rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		total = total - startRow + 1;

		List<J_OneLineBoard> list = jobd.selectOneLine(startRow, endRow, searchType, searchTxt);
		
		request.setAttribute("rowPerPage", rowPerPage);
		request.setAttribute("pagePerBlock", pagePerBlock);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("totalBlock", totalBlock);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("total", total);
		request.setAttribute("list", list);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchTxt", searchTxt);
		
		return "/oneLineBoard/oneLineBoard.jsp";
	}

}
