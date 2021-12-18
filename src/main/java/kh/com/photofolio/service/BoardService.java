package kh.com.photofolio.service;

import java.util.ArrayList;
import java.util.HashMap;

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dto.BoardDTO;

public class BoardService {

	BoardDAO dao = new BoardDAO();

	private int recordCntPerPage = 9; // 한페이지에 보여질 갯수
	private int naviCntPerPage = 10; // 페이지 갯수(1~10, 11~20, 21~30) 10개씩 
	
	public ArrayList<BoardDTO> getBoardList(int currentPage, String id) {
		int startRange = currentPage * recordCntPerPage - (recordCntPerPage - 1);
		int endRange = currentPage * recordCntPerPage;
		ArrayList<BoardDTO> list = new ArrayList<>();
		try {
		list = dao.getBoardList(startRange, endRange, id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		for (BoardDTO dto : list) {
			System.out.println("post_no : "+ dto.getPost_no());
			System.out.println("post_title : " + dto.getPost_title());
		}
		return list;
	}

		
		public HashMap<String, Object> getPageNavi(int currentPage, int totalCnt) {
			int recordTotalCnt = totalCnt; // 전체 데이터수
		
			int pageTotalCnt = 0; // 총 몇페이지가 나올지
			if (recordTotalCnt % recordCntPerPage > 0) { // 총 데이터수 와 10개의 페이지를 나눈 나머지
				pageTotalCnt = (recordTotalCnt / recordCntPerPage) + 1;
			} else {
				pageTotalCnt = recordTotalCnt / recordCntPerPage;
			}
			
			if (currentPage < 1) { // currentPage 안전 장치
				currentPage = 1;

			} else if (currentPage > pageTotalCnt) {
				currentPage = pageTotalCnt;
			}

					
			// 시작 네비 페이지, 끝 네비 페이지 잡아주기
			int startNavi = ((currentPage -1) / naviCntPerPage) * naviCntPerPage + 1;
			int endNavi = startNavi + naviCntPerPage - 1;

			if (endNavi > pageTotalCnt) { // endNavi 총 페이지 수를 초과되지 않게 맞춰주기.
				endNavi = pageTotalCnt;

			}
		
			// 이전, 다음 버튼 필요 여부 세팅
			boolean needPrev = true;
			boolean needNext = true;
			if (startNavi == 1)
				needPrev = false;
			if (endNavi == pageTotalCnt)
				needNext = false;
		
			
			System.out.println("startNavi : " + startNavi);
			System.out.println("endNavi : " + endNavi);
			System.out.println("needPrev : " + needPrev);
			System.out.println("needNext : " + needNext);

			HashMap<String, Object> map = new HashMap<>();
			map.put("startNavi", startNavi);
			map.put("endNavi", endNavi);
			map.put("needPrev", needPrev);
			map.put("needNext", needNext);
			map.put("currentPage", currentPage);

			return map;
		}

	

}
