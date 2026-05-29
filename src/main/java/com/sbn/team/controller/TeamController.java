package com.sbn.team.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.member.dto.MemberDto;
import com.sbn.team.dto.TeamDto;
import com.sbn.team.service.TeamService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/Team")
public class TeamController {

    @Autowired
    private TeamService teamService;

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

    // 팀 관리
    @RequestMapping("/Managing")
    public ModelAndView managing() {
        return new ModelAndView("team/managing");
    }
}