package com.sbn.league.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.game.dto.GameDto;
import com.sbn.league.dto.LeagueDto;
import com.sbn.league.mapper.LeagueMapper;
import com.sbn.league.service.LeagueService;
import com.sbn.paging.Pagination;
import com.sbn.paging.SearchDto;


@Controller
@RequestMapping("/League")
public class LeagueController {
	
	@Autowired
	private LeagueService leagueService;
	
	@RequestMapping("/List")
	public ModelAndView list( @RequestParam HashMap<String, Object> map ) {
		
		//  searchType 화이트리스트 검증
		String searchType = String.valueOf(map.get("searchType"));
		List<String> allowedTypes = List.of("league_name", "league_location");
		if(!allowedTypes.contains(searchType)) {
			map.put("searchType", null);
			// 허용되지 않은 값이면 null 처리
		}
		
		// System.out.println("map:" + map);
		
		
		//자료실 목록 조회 (10개씩) - 페이징 처리 준비작업 시작
		// 전체 자료 수
		int             totalCount  = leagueService.count( map );
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
		
		// 리그 목록 조회
		List<LeagueDto> leagueList  = leagueService.getLeagueList( map );
		
		System.out.println("map2:" + map);
		
		// List<LeagueDto> leagueList2 = leagueService.getLeagueList();
		
		ModelAndView    mv          = new ModelAndView();
		mv.setViewName("league/list");
		
		mv.addObject("leagueList", leagueList);
		mv.addObject("searchDto",  searchDto);
		
		mv.addObject("map", map);
		
		return           mv;
		
	}
	
	@RequestMapping("/Info")
	public ModelAndView info( @RequestParam HashMap<String, Object> map ) {
		
		// 리그 목록 조회
		List<LeagueDto>           leagueList   = leagueService.getLeagueList( map );
		
		// 왼쪽에 리그 정보 띄우는거 조회
		LeagueDto                 league       = leagueService.getLeague( map );
		
		// 오른쪽에 리그 경기 조회
		List<Map<String, Object>> gameList     = leagueService.getGameList( map );
		// System.out.println("gameList=" + gameList);
		// System.out.println("infoMap="  + map     );
		
		// 중간에 리그에 해당하는 팀 목록 조회
		List<Map<String, Object>> teamList     = leagueService.getTeamList( map );
		
		ModelAndView              mv           = new ModelAndView();
		mv.setViewName("league/info"           );
		
		mv.addObject(  "leagueList", leagueList);
		mv.addObject(  "league",     league    );
		mv.addObject(  "gameList",   gameList  );
		mv.addObject(  "teamList",   teamList  );
		mv.addObject(  "map",        map       );
		
		return mv;
	}
	
	@RequestMapping("/Managing")
	public ModelAndView managing( @RequestParam HashMap<String, Object> map ) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("league/managing");
		
		return mv;
		
	}
	
}
















