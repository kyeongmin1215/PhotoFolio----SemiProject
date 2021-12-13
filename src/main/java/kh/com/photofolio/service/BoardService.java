package kh.com.photofolio.service;

import java.util.ArrayList;
import java.util.HashMap;

import kh.com.photofolio.dao.BoardDAO;
import kh.com.photofolio.dto.BoardDTO;

public class BoardService {
	
	/*
		1. 전체 데이터수
		2. 하나의 페이지에 총 몇 개의 데이터가 보여질것인지
		3. 페이지 네비게이션을 몇 개의 단위로 보여줄지 (1~5)
	

		int recordTotalCnt = 140; // 총 데이터의수
		
		// 하나의 페이지에 보여질 데이터의 수
		recordCntPerPage = 10;




	*/
	BoardDAO dao = new BoardDAO();

	private int recordCntPerPage = 9; // 한페이지에 보여질 갯수
	private int naviCntPerPage = 10; // 페이지 갯수(1~10, 11~20, 21~30) 10개씩 

		
		public HashMap<String, Object> getPageNavi(int currentPage) {
			int recordTotalCnt = dao.countAll(); // 전체 데이터수
		
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
		
			/*
			 	startRange
			 	endRange
			 	-> 현재 페이지(currentPage), 한페이지에 띄울 아이템 개수(RecordCntPerPage)
			 
			 한 페이지에 띄우는 아이템 개수 : 10개
			 현재 페이지 : 1페이지
			 startRange : 1
			 endRange : 10
			 
			 startRange : 현재 페이지 * 아이템 개수 - (아이템개수-1);
			 1 * 10 = 10 (10-1) = 1
			 
			 현재페이지 : 2페이지
			 아이템 개수 : 10개
			 2 * 10 = 20 - (10-1) = 11
			 
			 현재페이지: 4페이지
			 아이템 개수 : 5개
			 4 * 5 = 20 - (5-1) = 16
			 
			 endRange : 
			 1. startRange + 아이템 개수 - 1
			 2. 현재페이지 * 아이템 개수
		
			*/
			
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

		public ArrayList<BoardDTO> getBoardList(int currentPage) {
			int startRange = currentPage * recordCntPerPage - (recordCntPerPage - 1);
			int endRange = currentPage * recordCntPerPage;

			ArrayList<BoardDTO> list = dao.getBoardList(startRange, endRange);
			for (BoardDTO dto : list) {
				System.out.println("post_no : "+ dto.getPost_no());
				System.out.println("post_title : " + dto.getPost_title());
			}
			return list;
		}

}

