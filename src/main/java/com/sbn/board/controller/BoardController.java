package com.sbn.board.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.board.dto.BoardDto;
import com.sbn.board.service.BoardService;
import com.sbn.paging.Pagination;
import com.sbn.paging.SearchDto;

@Controller
@RequestMapping("/Board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("/List")
	public ModelAndView list( @RequestParam HashMap<String, Object> map ) {
		
		String searchType = String.valueOf(map.get("searchType"));
		List<String> allowedTypes = List.of("title", "writer");
		if(!allowedTypes.contains(searchType)) {
			map.put("searchType", null);
			// 허용되지 않은 값이면 null 처리한다.
		}
		
		// 자료실 목록 조회(10개씩) - 페이징 처리 준비작업 시작
		// 전체 자료 수
		int totalCount = boardService.count( map );
		System.out.println("totalCount=" + totalCount);
		
		// 현재 페이지 정보 : map{nowpage=1} Object -> String -> int
		int nowpage = Integer.parseInt(String.valueOf(map.get("nowpage")));
		
		// 페이징 설정
		SearchDto searchDto = new SearchDto();
		searchDto.setPageNo( nowpage ); // 현재 페이지 설정
		searchDto.setNumOfRows( 10 );   // 한 페이지에 10줄의 자료를 출력
		searchDto.setPageSize( 10 );    // 페이지 번호 목록
		
		// Pagination 설정
		Pagination pagination = new Pagination( totalCount, searchDto );
		searchDto.setPagination(pagination);
		
		int offset = searchDto.getOffset();
		int numOfRows = searchDto.getNumOfRows();
		
		map.put("offset", offset);
		map.put("numOfRows", numOfRows);
		// 페이징 처리 준비작업 종료
		
		// Board 목록 조회
		List<BoardDto> boardList = boardService.getBoardList( map );
		System.out.println("map=" + map);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/list");
		
		mv.addObject("boardList", boardList);
		mv.addObject("searchDto", searchDto);
		
		mv.addObject("map", map);
		
		return mv;
	}
	
	@RequestMapping("/View")
	public ModelAndView view( @RequestParam HashMap<String, Object> map ) {
		
		// Board 목록 조회
		List<BoardDto> boardList = boardService.getBoardList( map );
		
		// 게시물 내용 조회
		BoardDto       board     = boardService.getBoard(map);
		
		// 조회수 증가
		boardService.setCountUpdate(map);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/view");
		
		mv.addObject("boardList", boardList);
		mv.addObject("board", board);
		mv.addObject("map", map);
		
		return mv;
	}
	
	@RequestMapping("/WriteForm")
	public ModelAndView write( @RequestParam HashMap<String, Object> map ) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("board/write");
		
		return mv;
	}

}

























