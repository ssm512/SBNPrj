package com.sbn.game.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.game.dto.GameDto;
import com.sbn.game.mapper.GameMapper;
import com.sbn.game.service.GameService;

@Controller
@RequestMapping("/Game")
public class GameController {
	
	@Autowired
	private GameService gameService;
	
	@RequestMapping("/AddGameForm")
	public ModelAndView addGameForm ( @RequestParam HashMap<String, Object> map ) {
		// 검증 : 세션.login.is_admin == "Y" 이면 진행
		// else: 뒤로 보냄 전페이지로 되돌려보냄 errorpage 403.jsp 띄우도록
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/game/addgame");
		mv.addObject("map", map);
		return mv;
	}
	
	// /Game/AddGame
	@RequestMapping("/AddGame")
	public ModelAndView addGame ( @RequestParam HashMap<String, Object> map ) {
		String	league_idx	=	String.valueOf(map.get("league_idx"));
		gameService.insertGame(map);
		ModelAndView mv = new ModelAndView();
		String	loc			= "redirect:/League/List?league_idx="+league_idx;				
		System.out.println(loc);
		mv.setViewName(loc);
		return mv;
	}
	
	// /Game/GameInfo?game_idx=2&league_idx=1
	@RequestMapping("/GameInfo")
	public ModelAndView gameInfo ( @RequestParam HashMap<String, Object> map ) {
		String		game_idx		=	String.valueOf(map.get("game_idx"));
		String		league_idx		=	String.valueOf(map.get("league_idx"));
		map.put("league_idx", league_idx);
		GameDto		gameinfo		=	gameService.getGameResult(game_idx);
		String		league_name		=	gameService.getLeagueName(league_idx);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/game/gameinfo");
		mv.addObject("gameinfo", gameinfo);
		mv.addObject("league_name", league_name);
		return mv;
	}
	
	@RequestMapping("/AddResultForm")
	public ModelAndView addResultForm ( @RequestParam HashMap<String, Object> map ) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/game/addresult");
		mv.addObject("map", map);
		return mv;
	}
}
