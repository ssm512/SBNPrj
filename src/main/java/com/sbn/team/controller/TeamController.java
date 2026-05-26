package com.sbn.team.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.sbn.team.dto.TeamDto;
import com.sbn.team.service.TeamService;

@Controller
@RequestMapping("/Team")
public class TeamController {

    @Autowired
    private TeamService teamService;

    // 팀 목록
    @RequestMapping("/List")
    public String list(@RequestParam(value="keyword", defaultValue="") String keyword,
                       Model model) {

        List<TeamDto> teamList = teamService.getTeamList(keyword);
        model.addAttribute("teamList", teamList);
        model.addAttribute("keyword", keyword);

        return "team/list";
    }

    // 팀 상세 정보
    @RequestMapping("/Info")
    public String info() {
        return "team/info";
    }

    // 팀 만들기
    @RequestMapping("/Maketeam")
    public String maketeam() {
        return "team/maketeam";
    }

    // 팀 관리
    @RequestMapping("/Managing")
    public String managing() {
        return "team/managing";
    }

}