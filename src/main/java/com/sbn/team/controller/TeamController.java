package com.sbn.team.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.sbn.config.WebMvcConfig;
import com.sbn.member.dto.MemberDto;
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

    // 팀 목록
    @RequestMapping("/List")
    public ModelAndView list(@RequestParam HashMap<String, Object> map) {

        String keyword = map.getOrDefault("keyword", "").toString();

        ModelAndView mv      = new ModelAndView("team/list");
        List<TeamDto> teamList = teamService.getTeamList(keyword);

        mv.addObject("team_list", teamList);
        mv.addObject("map", map);

        return mv;
    }

    // 팀 상세 정보
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

    // 팀 만들기 페이지
    @RequestMapping("/MakeTeamForm")
    public ModelAndView makeTeamForm() {
        return new ModelAndView("team/maketeam");
    }

    // 팀 생성
    @Transactional
    @RequestMapping("/MakeTeam")
    public ModelAndView makeTeam(@RequestParam HashMap<String, Object> map,
                                  HttpServletRequest request) {

        HttpSession session   = request.getSession();
        MemberDto   login     = (MemberDto) session.getAttribute("login");
        int         memberIdx = login.getMember_idx();

        map.put("team_manager", memberIdx);

        int teamIdx = teamService.insertTeam(map);

        HashMap<String, Object> mtMap = new HashMap<>();
        mtMap.put("member_idx", memberIdx);
        mtMap.put("team_idx",   teamIdx);
        teamService.insertMemberTeam(mtMap);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Team/Info?team_idx=" + teamIdx + "&keyword=");
        return mv;
    }

    
    // 팀 관리 페이지
    @RequestMapping("/Managing")
    public ModelAndView managing(@RequestParam HashMap<String, Object> map,
    							 HttpServletRequest request) {
    	int team_idx = Integer.parseInt(map.get("team_idx").toString());
    	
    	// 감독 권한 체크
    	HttpSession session = request.getSession();
    	MemberDto   login   = (MemberDto) session.getAttribute("login");
    	TeamDto     team    = teamService.getTeamInfo(team_idx);
    	
    	if (team.getTeam_manager() != login.getMember_idx()) {
    	    return new ModelAndView("redirect:/Team/Info?team_idx=" + team_idx + "&keyword=&alert=no_permission");
    	}
    	
    	ModelAndView mv = new ModelAndView("team/managing");
    	mv.addObject("team",     team);
    	mv.addObject("map",      map);
    	mv.addObject("mt_list",   teamService.getMemberTeamList(team_idx, ""));
    	mv.addObject("join_list", teamService.getMemberJoinRequestList(team_idx));
    	return mv;
    }
    
    
    
    
    
    
    
    
    
    
    
    
}