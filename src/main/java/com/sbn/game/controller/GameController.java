package com.sbn.game.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import com.sbn.member.dto.MemberDto;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/Game")
public class GameController {
	
	@Autowired
	private GameService gameService;
	
	@RequestMapping("/AddGameForm")
	public ModelAndView addGameForm ( @RequestParam HashMap<String, Object> map, HttpServletRequest request ) {
		// 검증 : 세션.login.is_admin == "Y" 이면 진행
		// else: 뒤로 보냄 전페이지로 되돌려보냄 errorpage 403.jsp 띄우도록
		MemberDto 				login		=	(MemberDto) request.getSession().getAttribute("login");
		if (login == null || !"Y".equals(login.getIs_admin())) {
			ModelAndView		mv	=	new ModelAndView();
			mv.setViewName("redirect:/League/Info?league_idx=" + map.get("league_idx"));
			return mv;
		}
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
		String					loc						= 	"redirect:/League/Info?league_idx="+league_idx;				
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
	
	// /Game/AddResultForm?league_idx=1&game_idx=2
	@RequestMapping("/AddResultForm")
	public ModelAndView addResultForm ( @RequestParam HashMap<String, Object> map, HttpServletRequest request ) {
		MemberDto 				login		=	(MemberDto) request.getSession().getAttribute("login");
		String					game_idx				=	String.valueOf(map.get("game_idx"));
		String					league_idx				=	String.valueOf(map.get("league_idx"));
		if (login == null || !"Y".equals(login.getIs_admin())) {
			ModelAndView		mv	=	new ModelAndView();
			mv.setViewName("redirect:/Game/GameInfo?league_idx=" + league_idx +"&game_idx=" + game_idx);
			return mv;
		}
		
		GameDto					gameDto					=	gameService.getGameResult(game_idx);
		HashMap<String, Object>	teamNames				=	gameService.getGameTeamNames(game_idx);
		
		ModelAndView 			mv 						=	new ModelAndView();
		mv.setViewName("/game/addresult");
		mv.addObject("teamNames", teamNames);
		mv.addObject("league_idx",league_idx);
		mv.addObject("game_idx",game_idx);
		mv.addObject("gameDto",gameDto);
		return mv;
	}
	
	@PostMapping("/UpdateGameStat")
	@ResponseBody
	public GameDto updateGameStat(@RequestBody HashMap<String, Object> map) {
		System.out.println(map);
		
		GameDto updatedGame = gameService.getGameInfo(map);

		return updatedGame;
	}
	
	// /Game/AddResult?league_idx=${league_idx}&game_idx=${game_idx}
	@Transactional
	@PostMapping("/AddResult")
	public String addResult( GameResultDto gameResultDto ) { 
		
		List<GameResultDto> resultList = gameResultDto.getResultList();
		for (GameResultDto result : resultList) {
			gameService.insertGameResultList(result, gameResultDto.getGame_idx());
		}

	    return "redirect:/Game/GameInfo?league_idx=" + gameResultDto.getLeague_idx() + "&game_idx=" + gameResultDto.getGame_idx();
	}
	
	// /Game/UpdateResultForm?league_idx=1&game_idx=2
	@RequestMapping("/UpdateResultForm")
	public ModelAndView updateResultForm ( GameResultDto gameResultDto, HttpServletRequest request ) {
		MemberDto 				login					=	(MemberDto) request.getSession().getAttribute("login");
		if (login == null || !"Y".equals(login.getIs_admin())) {
			ModelAndView		mv	=	new ModelAndView();
			mv.setViewName("redirect:/Game/GameInfo?league_idx=" + gameResultDto.getLeague_idx() +"&game_idx=" + gameResultDto.getGame_idx());
			return mv;
		}
		int		league_idx			=	gameResultDto.getLeague_idx();
		int		game_idx			=	gameResultDto.getGame_idx();
		
		ArrayList<GameResultDto>	resultList		=	gameService.getGameResultList(gameResultDto);
		//System.out.println(resultList);
		ModelAndView 			mv 						=	new ModelAndView();
		mv.setViewName("/game/updateresult");
		mv.addObject("resultList",resultList);
		mv.addObject("league_idx",league_idx);
		mv.addObject("game_idx",game_idx);
		return mv;		
	}
	
	@ResponseBody
	@PostMapping("/UpdateResultAjax")
	public String updateResultAjax(@RequestBody GameResultDto gameResultDto) {

	    gameService.updateGameResult(gameResultDto);

	    return "OK";
	}
	
	@Transactional
	@ResponseBody
	@PostMapping("/UpdateResultAllAjax")
	public String updateResultAllAjax(@RequestBody List<GameResultDto> resultList) {

	    for(GameResultDto result : resultList) {
	    	System.out.println(result);
	        gameService.updateGameResult(result);
	    }
	    return "OK";
	}
	
	@ResponseBody
	@PostMapping("/DeleteResultAjax")
	public String deleteResultAjax (@RequestBody HashMap<String, Object> param) {
	    int record_num = Integer.parseInt(param.get("record_num").toString());
		gameService.deleteGameResult(record_num);
		return "OK";
	}
}
