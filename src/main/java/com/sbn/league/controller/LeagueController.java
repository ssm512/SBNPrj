package com.sbn.league.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.game.dto.GameDto;
import com.sbn.interceptor.AuthInterceptor;
import com.sbn.league.dto.LeagueDto;
import com.sbn.league.mapper.LeagueMapper;
import com.sbn.league.service.LeagueService;
import com.sbn.paging.Pagination;
import com.sbn.paging.SearchDto;

import jakarta.servlet.http.HttpSession;


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
		// System.out.println("totalCount= " + totalCount);
		
		// 현재 페이지 정보 : map{ nowpage=1 } Object -> String -> int 
		int             nowpage     = Integer.parseInt( String.valueOf( map.get("nowpage") ) );
		
		// 페이징 설정
		SearchDto       searchDto   = new SearchDto();
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
		
		// System.out.println("map2:" + map);
		
		ModelAndView    mv          = new ModelAndView();
		mv.setViewName("league/list");
		
		mv.addObject("leagueList", leagueList);
		mv.addObject("searchDto",  searchDto);
		
		mv.addObject("map",        map);
		
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
	
	@RequestMapping("/ManagingForm")
	public ModelAndView managing( 
		@RequestParam HashMap<String, Object> map,
		HttpSession session
			) {
		
		// 권한이 없는 사람이 주소창에 ManagingForm 에 해당하는 주소를 직접 입력했을때 info.jsp로 돌려보내기 (시작)
		// 세션에서 로그인 정보를 꺼냄
		Object                    loginObj     = session.getAttribute("login");
		String                    leagueIdx    = String.valueOf(map.get("league_idx"));
		
		// 관리자 여부를 체크
		boolean isAdmin = false;
		
		// loginObj 가 Map 타입일때
		if(loginObj instanceof Map) {
			// 세션이 map 형태일때(대소문자 전부 시도한다.)
			Map<String, Object>   loginMember  = (Map<String, Object>) loginObj;
			
			Object                roleObj      = loginMember.get("is_admin") != null
					                           ? loginMember.get("is_admin")
					                           : loginMember.get("IS_ADMIN");
			                      isAdmin      = "Y".equals(String.valueOf(roleObj));
		} else if(loginObj != null) {
			// 세션이 Dto 객체 형태일 때 — 리플렉션으로 getIs_admin 호출함
			try {
				for (java.lang.reflect.Method method : loginObj.getClass().getMethods()) {
					String        name         = method.getName().toLowerCase();
					if (name.equals("getis_admin") || name.equals("getisadmin")) {
						Object    val          = method.invoke(loginObj);
						          isAdmin      = "Y".equals(String.valueOf(val));
						break;
					}
				}
			} catch (Exception e) {
				System.out.println("Dto에서 is_admin 추출 실패:" + e.getMessage());
			}
		}
		
		// 관리자가 아닐경우엔 info 페이지로 돌려보내기
		if(!isAdmin) {
			ModelAndView          mv           = new ModelAndView();
			mv.setViewName("redirect:/League/Info?league_idx=" + leagueIdx + "&checkalert=true");
			return mv;
		}
		
		// 권한이 없는 사람이 주소창에 ManagingForm 에 해당하는 주소를 직접 입력했을때 info.jsp로 돌려보내기 (끝)
		
		// managingForm에 해당하는 리그 정보 가져오기
		LeagueDto                 league       = leagueService.getLeague( map );
		
		// 리그 가입 신청 현황 팀 목록 조회 추가
		List<Map<String, Object>> signTeamList = leagueService.getSignTeamList( map );
		
		ModelAndView              mv           = new ModelAndView();
		mv.setViewName("league/managing"           );
		
		mv.addObject(  "league",       league      );
		mv.addObject(  "signTeamList", signTeamList);
		
		return mv;
	}
	
	// 팀 가입 승인 처리( join_status를 0에서 1로 바꾸기 )
	@PostMapping("/ApproveTeam")
	@ResponseBody
	public String approveTeam( @RequestParam HashMap<String, Object> map ) {
		try {
			leagueService.approveTeam(map);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	// 팀 가입 거절 처리(team-league 테이블에서 해당 행 delete)
	@PostMapping("/RejectTeam")
	@ResponseBody
	public String rejectTeam(@RequestParam HashMap<String, Object> map) {
		try {
			leagueService.rejectTeam(map);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
	@PostMapping("/Update")
	public String update(@RequestParam HashMap<String, Object> map) {
		
		// 서비스를 호출해서 DB의 league 테이블 update를 실행
		leagueService.updateLeague(map);
		
		// 주소창의 league_idx 를 바탕으로 info 페이지 돌아가기
		String leagueIdx = String.valueOf(map.get("league_idx"));
		return "redirect:/League/Info?league_idx=" + leagueIdx;
	}
	
	// 1. 로그인한 회원이 감독인 팀 목록 조회(json 반환)
	@PostMapping("/CheckManagerTeams")
	@ResponseBody
	public List<Map<String, Object>> checkManagerTeams(HttpSession session) {
		
		Object     loginObj    = session.getAttribute("login");
		
		if (loginObj == null) {
			System.out.println("[CheckManagerTeams] 세션에서 로그인 정보를 찾지 못했습니다.");
			return new ArrayList<>();
		}
		
		String     memberIdx   = "";
		
		// 세션 데이터가 Map 형태인 경우
		if (loginObj instanceof Map) {
			Map<String, Object> loginMember = (Map<String, Object>) loginObj;
			// Oracle MyBatis 결과는 대문자 키로 오는 경우가 많으므로 둘 다 시도
			Object idxObj      = loginMember.get("member_idx") != null 
							   ? loginMember.get("member_idx") 
							   : loginMember.get("MEMBER_IDX");
			       memberIdx   = idxObj != null ? String.valueOf(idxObj) : "";
		}
		// 세션 데이터가 DTO 객체 형태인 경우 - 리플렉션으로 getMemberIdx 또는 getMember_idx 호출
		else {
			try {
				for (java.lang.reflect.Method method : loginObj.getClass().getMethods()) {
					String     name      = method.getName().toLowerCase();
					if (name.equals("getmemberidx") || name.equals("getmember_idx")) {
						Object val       = method.invoke(loginObj);
						if (val != null) {
							   memberIdx = String.valueOf(val);
						}
						break;
					}
				}
			} catch (Exception e) {
				System.out.println("[CheckManagerTeams] DTO에서 member_idx 추출 실패: " + e.getMessage());
			}
		}
		
		// System.out.println("[CheckManagerTeams] 추출된 member_idx: " + memberIdx);
		
		if (memberIdx.isEmpty() || memberIdx.equals("null")) {
			System.out.println("[CheckManagerTeams] member_idx가 없어 빈 목록 반환");
			return new ArrayList<>();
		}
		
		HashMap<String, Object>   paramMap    = new HashMap<>();
		paramMap.put("memberIdx", memberIdx);
		
		List<Map<String, Object>> rawTeamList = leagueService.getTeamsByManager(paramMap);
		
		System.out.println("[CheckManagerTeams] 조회된 팀 수: " + (rawTeamList != null ? rawTeamList.size() : 0));
		return rawTeamList != null ? rawTeamList : new ArrayList<>();
	}
	
	// 2. 실제 리그 가입 선청하기(team-league 테이블에 insert 하는거)
	@PostMapping("/ApplyTeam")
	@ResponseBody
	public String applyTeam(@RequestParam HashMap<String, Object> map) {
		try {
			// 중복 신청 방지 체크 (굳이 안해도 되는거지만 안전장치로 ㅎㅎ)
			int check = leagueService.checkDuplicateApply(map);
			if(check > 0) {
				return "already";
			}
			
			// 가입 신청 실행(join_status 0 으로 집어넣기)
			leagueService.applyLeague(map);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
	}
	
}























