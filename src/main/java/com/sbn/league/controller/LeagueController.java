package com.sbn.league.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.league.dto.LeagueDto;
import com.sbn.league.dto.Pagination;
import com.sbn.league.dto.SearchDto;
import com.sbn.league.mapper.LeagueMapper;

@Controller
@RequestMapping("/League")
public class LeagueController {
	
	@Autowired
	private LeagueMapper leagueMapper;
	
	@RequestMapping("/List")
	public ModelAndView list( @RequestParam HashMap<String, Object> map ) {
		
		// System.out.println("map:" + map);
		
		// 리그 목록 조회
		List<LeagueDto> leagueList  = leagueMapper.getLeagueList();
		
		//자료실 목록 조회 (10개씩) - 페이징 처리 준비작업 시작
		// 전체 자료 수
		int             totalCount  = leagueMapper.count( map );
		System.out.println("totalCount= " + totalCount);
		
		// 현재 페이지 정보 : map{ nowpage=1 } Object -> String -> int 
		int             nowpage     = Integer.parseInt( String.valueOf( map.get("nowpage") ) );
		
		// 페이징 설정
		SearchDto searchDto = new SearchDto();
		searchDto.setPageNo( nowpage ); // 현재 페이지 설정
		searchDto.setNumOfRows( 10 );   // 한페이지에 10줄의 자료
		searchDto.setPageSize( 10 );    // 페이지 번호 목록
		
		// Pagination 설정
		Pagination      pagination  = new Pagination( totalCount, searchDto );
		searchDto.setPagination( pagination );
		
		int             offset      = searchDto.getOffset();
		int             numOfRows   = searchDto.getNumOfRows();
		
		map.put("offset",    offset);
		map.put("numOfRows", numOfRows);
		// 페이징 처리 준비작업 종료
		
		System.out.println("map2:" + map);
		
		ModelAndView     mv        = new ModelAndView();
		mv.setViewName("league/list");
		
		mv.addObject("leagueList", leagueList);
		
		return           mv;
		
	}
	
}
