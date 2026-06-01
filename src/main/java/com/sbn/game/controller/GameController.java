package com.sbn.game.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.game.dto.GameDto;
import com.sbn.game.dto.GameResultDto;
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
		ModelAndView 			mv 						= 	new ModelAndView();
		mv.setViewName("/game/addgame");
		mv.addObject("map", map);
		return mv;
	}
	
	// /Game/AddGame
	@RequestMapping("/AddGame")
	public ModelAndView addGame ( @RequestParam HashMap<String, Object> map ) {
		String					league_idx				=	String.valueOf(map.get("league_idx"));
		gameService.insertGame(map);
		ModelAndView 			mv 						= 	new ModelAndView();
		String					loc						= 	"redirect:/League/List?league_idx="+league_idx;				
		System.out.println(loc);
		mv.setViewName(loc);
		return mv;
	}
	
	// /Game/GameInfo?game_idx=2&league_idx=1
	@Transactional
	@RequestMapping("/GameInfo")
	public ModelAndView gameInfo ( @RequestParam HashMap<String, Object> map ) {
		String					game_idx				=	String.valueOf(map.get("game_idx"));
		String					league_idx				=	String.valueOf(map.get("league_idx"));
		GameDto					gameinfo				=	gameService.getGameResult(game_idx);
		String					league_name				=	gameService.getLeagueName(league_idx);
		
		HashMap<String, Object> topScoreBoard			=	gameService.getTopScoreBoard(game_idx);
		HashMap<String, Object> bottomScoreBoard		=	gameService.getBottomScoreBoard(game_idx);
		HashMap<String, Object>	teamNames				=	gameService.getGameTeamNames(game_idx);
		ArrayList<HashMap<String, Object>> awayHRecord	=	gameService.getAwayRecord(game_idx);
		ArrayList<HashMap<String, Object>> homeHRecord	=	gameService.getHomeRecord(game_idx);
		ArrayList<HashMap<String, Object>> awayPRecord	=	gameService.getAwayPRecord(game_idx);
		ArrayList<HashMap<String, Object>> homePRecord	=	gameService.getHomePRecord(game_idx);
		System.out.println(homePRecord);
		ModelAndView 			mv 						= 	new ModelAndView();
		mv.setViewName("/game/gameinfo");
		mv.addObject("gameinfo", gameinfo);
		mv.addObject("league_name", league_name);
		mv.addObject("topScoreBoard", topScoreBoard);		
		mv.addObject("bottomScoreBoard", bottomScoreBoard);		
		mv.addObject("teamNames", teamNames);		
		mv.addObject("awayHRecord", awayHRecord);		
		mv.addObject("homeHRecord", homeHRecord);		
		mv.addObject("awayPRecord", awayPRecord);		
		mv.addObject("homePRecord", homePRecord);		
		mv.addObject("league_idx",league_idx);
		mv.addObject("game_idx",game_idx);
		return mv;
	}
	
	// /Game/AddResultForm?league_idx=1&game_dix=2
	@RequestMapping("/AddResultForm")
	public ModelAndView addResultForm ( @RequestParam HashMap<String, Object> map ) {
		String					game_idx				=	String.valueOf(map.get("game_idx"));
		String					league_idx				=	String.valueOf(map.get("game_idx"));
		GameDto					gameDto					=	gameService.getGameResult(game_idx);
		HashMap<String, Object>	teamNames				=	gameService.getGameTeamNames(game_idx);
		
		ModelAndView 			mv 						=	new ModelAndView();
		mv.setViewName("/game/addresult2");
		mv.addObject("teamNames", teamNames);
		mv.addObject("league_idx",league_idx);
		mv.addObject("game_idx",game_idx);
		mv.addObject("gameDto",gameDto);
		mv.addObject("map", map);
		return mv;
	}
	
	@PostMapping("/UpdateGameStat")
	@ResponseBody
	public GameDto updateGameStat(@RequestBody GameDto gameDto) {

		gameService.updateGameStat(gameDto);

		GameDto updatedGame = gameService.getGameInfo(gameDto.getGame_idx());

		return updatedGame;
	}
	
	// /Game/AddResult?league_idx=${league_idx}&game_idx=${game_idx}
	@PostMapping("/AddResult")
	public String addResult( GameResultDto gameResultDto, @RequestParam("league_idx") int league_idx ) {
		
		gameService.insertGameResult(gameResultDto);

	    return "redirect:/Game/Info?league_idx=" + league_idx + "&game_idx=" + gameResultDto.getGame_idx();
	}
}
