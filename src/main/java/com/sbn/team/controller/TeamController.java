package com.sbn.team.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.team.dto.TeamDto;
import com.sbn.team.service.TeamService;

@Controller
@RequestMapping("/Team")
public class TeamController {

    @Autowired
    private TeamService team_service;

    // 팀 목록
    @RequestMapping("/List")
    public ModelAndView list(@RequestParam HashMap<String, Object> map) {

    	String keyword = map.getOrDefault("keyword", "").toString();
    	
        ModelAndView mv        = new ModelAndView("team/list");
        List<TeamDto> team_list = team_service.getTeamList(keyword);

        mv.addObject("team_list", team_list);
        mv.addObject("map", map);

        return mv;
    }

    // 팀 상세 정보
    @RequestMapping("/Info")
    public ModelAndView info(@RequestParam HashMap<String, Object> map) {

        int    team_idx = Integer.parseInt(map.get("team_idx").toString());
        String keyword = map.getOrDefault("keyword", "").toString();

        ModelAndView mv = new ModelAndView("team/info");
        mv.addObject("team", team_service.getTeamInfo(team_idx));
        mv.addObject("map",  map);
        mv.addObject("league_list", team_service.getTeamLeague(team_idx));
        mv.addObject("mt_list", team_service.getMemberTeamList(team_idx, keyword));
        return mv;
    }

    // 팀 만들기
    @RequestMapping("/Maketeam")
    public ModelAndView maketeam() {
        return new ModelAndView("team/maketeam");
    }

    // 팀 관리
    @RequestMapping("/Managing")
    public ModelAndView managing() {
        return new ModelAndView("team/managing");
    }

}