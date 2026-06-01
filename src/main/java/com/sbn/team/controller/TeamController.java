package com.sbn.team.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.config.WebMvcConfig;
import com.sbn.member.dto.MemberDto;
import com.sbn.paging.Pagination;
import com.sbn.paging.SearchDto;
import com.sbn.team.dto.TeamDto;
import com.sbn.team.service.TeamService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Team")
public class TeamController {

    private final WebMvcConfig webMvcConfig;

    @Autowired
    private TeamService teamService;

    TeamController(WebMvcConfig webMvcConfig) {
        this.webMvcConfig = webMvcConfig;
    }

    /* 팀 목록 - 페이징 및 키워드 검색 */
    @RequestMapping("/List")
    public ModelAndView list(@RequestParam HashMap<String, Object> map) {

        // SearchDto 초기화 (기본값: 1페이지, 10개씩, 페이지번호 10개)
        SearchDto searchDto = new SearchDto();

        int nowpage = Integer.parseInt(map.getOrDefault("nowpage", "1").toString());
        searchDto.setPageNo(nowpage);

        String keyword = map.getOrDefault("keyword", "").toString();
        searchDto.setKeyword(keyword);
        map.put("keyword", keyword);

        // 전체 건수 조회 (페이지 수 계산에 사용)
        int totalCount = teamService.getTeamCount(map);

        // Pagination 계산 (페이지 범위 초과 시 마지막 페이지로 보정)
        Pagination pagination = new Pagination(totalCount, searchDto);
        searchDto.setPagination(pagination);

        // SQL 페이징용 파라미터 세팅
        map.put("offset",    searchDto.getOffset());
        map.put("numOfRows", searchDto.getNumOfRows());
        map.put("nowpage",   searchDto.getPageNo());

        ModelAndView mv = new ModelAndView("team/list");
        mv.addObject("team_list",  teamService.getTeamList(map));
        mv.addObject("map",        map);
        mv.addObject("searchDto",  searchDto);

        return mv;
    }

    /* 팀 상세 정보 - 팀 정보, 소속 리그, 선수 목록 조회 */
    @RequestMapping("/Info")
    public ModelAndView info(@RequestParam HashMap<String, Object> map) {

        int    teamIdx = Integer.parseInt(map.get("team_idx").toString());
        String keyword = map.getOrDefault("keyword", "").toString();

        ModelAndView mv = new ModelAndView("team/info");
        mv.addObject("team",        teamService.getTeamInfo(teamIdx));
        mv.addObject("map",         map);
        mv.addObject("league_list", teamService.getTeamLeague(teamIdx));
        mv.addObject("mt_list",     teamService.getMemberTeamList(teamIdx, keyword));
        return mv;
    }

    /* 팀 생성 폼 페이지 */
    @RequestMapping("/MakeTeamForm")
    public ModelAndView makeTeamForm() {
        return new ModelAndView("team/maketeam");
    }

    /* 팀 생성 - 팀 INSERT 후 감독을 MEMBER_TEAM에 자동 등록 */
    @Transactional
    @RequestMapping("/MakeTeam")
    public ModelAndView makeTeam(@RequestParam HashMap<String, Object> map,
                                  HttpServletRequest request) {

        HttpSession session   = request.getSession();
        MemberDto   login     = (MemberDto) session.getAttribute("login");
        int         memberIdx = login.getMember_idx();

        map.put("team_manager", memberIdx);

        int teamIdx = teamService.insertTeam(map);

        // 팀 생성자를 JOIN_STATUS = 1 (승인) 으로 MEMBER_TEAM 자동 등록
        HashMap<String, Object> mtMap = new HashMap<>();
        mtMap.put("member_idx", memberIdx);
        mtMap.put("team_idx",   teamIdx);
        teamService.insertMemberTeam(mtMap);

        return new ModelAndView("redirect:/Team/Info?team_idx=" + teamIdx + "&keyword=");
    }

    /* 팀 관리 페이지 - 감독 권한 체크 후 소속 선수 및 가입 신청 목록 조회 */
    @RequestMapping("/Managing")
    public ModelAndView managing(@RequestParam HashMap<String, Object> map,
                                 HttpServletRequest request) {
        int team_idx = Integer.parseInt(map.get("team_idx").toString());

        // 로그인 유저가 해당 팀의 감독인지 확인
        HttpSession session = request.getSession();
        MemberDto   login   = (MemberDto) session.getAttribute("login");
        TeamDto     team    = teamService.getTeamInfo(team_idx);

        if (team.getTeam_manager() != login.getMember_idx()) {
            return new ModelAndView("redirect:/Team/Info?team_idx=" + team_idx + "&keyword=&alert=no_permission");
        }

        ModelAndView mv = new ModelAndView("team/managing");
        mv.addObject("team",      team);
        mv.addObject("map",       map);
        mv.addObject("mt_list",   teamService.getMemberTeamList(team_idx, ""));
        mv.addObject("join_list", teamService.getMemberJoinRequestList(team_idx));
        return mv;
    }

    /* 선수 포지션 / 배번 일괄 수정 */
    @Transactional
    @RequestMapping("/UpdateMemberTeam")
    public ModelAndView updateMemberTeam(HttpServletRequest request) {
        String   teamIdx      = request.getParameter("team_idx");
        String[] memberIdxArr = request.getParameterValues("member_idx");
        String[] positionArr  = request.getParameterValues("position");
        String[] backNumArr   = request.getParameterValues("back_num");

        // 선수 수만큼 반복하여 각각 UPDATE
        if (memberIdxArr != null) {
            for (int i = 0; i < memberIdxArr.length; i++) {
                HashMap<String, Object> updateMap = new HashMap<>();
                updateMap.put("team_idx",   teamIdx);
                updateMap.put("member_idx", memberIdxArr[i]);
                updateMap.put("position",   positionArr[i]);
                String backNumStr = backNumArr[i];
                // 배번 미입력 시 null 처리
                updateMap.put("back_num",
                    (backNumStr != null && !backNumStr.isEmpty()) ? Integer.parseInt(backNumStr) : null);
                teamService.updateMemberTeam(updateMap);
            }
        }

        return new ModelAndView("redirect:/Team/Managing?team_idx=" + teamIdx + "&keyword=&alert=update_ok");
    }

    /* 선수 방출 MEMBER_TEAM 레코드 삭제 */
    @RequestMapping("/RemoveMember")
    public ModelAndView removeMember(@RequestParam HashMap<String, Object> map) {
        teamService.deleteMemberTeam(map);
        return new ModelAndView("redirect:/Team/Managing?team_idx=" + map.get("team_idx") + "&keyword=");
    }

    /* 가입 승인 - JOIN_STATUS = 1 (승인) 으로 변경 */
    @RequestMapping("/ApproveJoin")
    public ModelAndView approveJoin(@RequestParam HashMap<String, Object> map) {
        map.put("join_status", 1);
        teamService.updateJoinStatus(map);
        return new ModelAndView("redirect:/Team/Managing?team_idx=" + map.get("team_idx") + "&keyword=");
    }

    /* 가입 거절 - MEMBER_TEAM 레코드 삭제 */
    @RequestMapping("/RejectJoin")
    public ModelAndView rejectJoin(@RequestParam HashMap<String, Object> map) {
        teamService.deleteMemberTeam(map);
        return new ModelAndView("redirect:/Team/Managing?team_idx=" + map.get("team_idx") + "&keyword=");
    }
    
	/* 팀 가입 신청 */
    @RequestMapping("/Join")
    public ModelAndView join(@RequestParam HashMap<String, Object> map,
    						 HttpServletRequest request) {
    	
        HttpSession session   = request.getSession();
        MemberDto   login     = (MemberDto) session.getAttribute("login");
        int         memberIdx = login.getMember_idx();
        int         teamIdx   = Integer.parseInt(map.get("team_idx").toString());
        
        HashMap <String, Object> joinMap = new HashMap<>();
        joinMap.put("member_idx", memberIdx);
        joinMap.put("team_idx",   teamIdx);
        
        Integer joinStatus = teamService.getJoinStatus(joinMap);
        
        String alert;
        if (joinStatus == null) {
        	// 신규 신청
        	joinMap.put("position", login.getHope_position());
        	joinMap.put("elite",    login.getElite());
        	teamService.joinTeam(joinMap);
        	alert = "join_ok";
        } else if (joinStatus == 0) {
            // 이미 신청 중
            alert = "already_applied";
        } else if (joinStatus == 1) {
            // 이미 소속된 팀
            alert = "already_member";
        } else {
            // 이전에 거절/제거된 경우 → 재신청
            joinMap.put("join_status", 0);
            teamService.updateJoinStatus(joinMap);
            alert = "join_ok";
        }

        return new ModelAndView("redirect:/Team/Info?team_idx=" + teamIdx + "&keyword=&alert=" + alert);
    }
}