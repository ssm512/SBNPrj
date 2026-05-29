package com.sbn.member.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.sbn.config.WebMvcConfig;
import com.sbn.member.dto.MemberDto;
import com.sbn.member.mapper.MemberMapper;
import com.sbn.member.service.MemberService;
import com.sbn.team.dto.TeamDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/Member")
public class MemberController {

	@Autowired
	private  MemberService  memberService;
	
	
	@RequestMapping("/LoginForm")
	public  ModelAndView  loginForm() {
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/login");
		return  mv;
	}
	
	@RequestMapping("/Login")
	public  String  login( @RequestParam HashMap<String, Object> map, 
			HttpServletRequest request, Model model) {
		
		MemberDto     member  = memberService.login(map);
		HttpSession   session =  request.getSession();

	    if (member == null) {
	        model.addAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다.");
	        return "member/login"; // 로그인 폼으로 다시
	    }
	    
		session.setAttribute("login", member);
		
		String  loc  = "";
		Object savedLoc = session.getAttribute("loc");
		if (savedLoc == null || savedLoc.toString().contains("null")
		                     || savedLoc.toString().contains("Mypage")) {
		    loc = "redirect:/";
		} else {
		    loc = "redirect:" + savedLoc.toString();
		}
		session.removeAttribute("loc");
		

		return  loc;
	}
	
	@RequestMapping("/Logout")
	public  String  logout( HttpServletRequest request ) {
		HttpSession  session  = request.getSession();
		session.invalidate();
		return  "redirect:/";
	}
	
	
	@RequestMapping("/SigninForm")
	public  ModelAndView  signinForm() {
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/signin");
		return  mv;
	}
	
	@RequestMapping("/Signin")
	public String signin(@RequestParam HashMap<String, Object> map) {
	    memberService.signin(map);
	    return "redirect:/Member/LoginForm";
	}
	
	@RequestMapping("/IdDupCheck/{member_id}") // /Member/IdDupCheck/test123
	@ResponseBody		
	public HashMap<String, Object> idDupCheck (@PathVariable(value="member_id") String member_id) {
		MemberDto	member		=	memberService.getIdDupCheck(member_id); 

		if (member == null)  
			member = new MemberDto();
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("member", member);
		
			
		return map;
	}
	
	@RequestMapping("/PhoneDupCheck/{phone_num}") // /Member/PhoneDupCheck/01012345678
	@ResponseBody		
	public HashMap<String, Object> phoneDupCheck (@PathVariable(value="phone_num") String phone_num) {
		MemberDto	member		=	memberService.getPhoneDupCheck(phone_num);
		
		if (member == null)  
			member = new MemberDto();
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("member", member);
		
		return map;
	}
	
	@RequestMapping("/EmailDupCheck/{email}") // /Member/EmailDupCheck/test@naver.com
	@ResponseBody		
	public HashMap<String, Object> emailDupCheck (@PathVariable(value="email") String email) {
		MemberDto	member		=	memberService.getEmailDupCheck(email);
		
		if (member == null)  
			member = new MemberDto();
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("member", member);
		
		return map;
	}
	
	
	@RequestMapping("/List")
	public  ModelAndView  list(@RequestParam HashMap<String, Object> map) {
		
		List<MemberDto> memberList  = memberService.getMemberList(map);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/list");
		mv.addObject("memberList", memberList);
		mv.addObject("map", map);
		return  mv;
	}
	

	// /Member/Mypage
	@RequestMapping("/Mypage")
	public  ModelAndView  mypage(HttpServletRequest request) {
		HttpSession  session   = request.getSession();
		MemberDto    login     = (MemberDto) session.getAttribute("login");

		int        member_idx  = login.getMember_idx();
		
		// idx 로 가입된 팀 전체 조회
		List<TeamDto> teamList = memberService.getMyTeamList(member_idx);
		// System.out.println(teamList);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/mypage");
		mv.addObject("teamList", teamList);
		return  mv;
	}
	
	@RequestMapping("/UpdateForm")
	public  ModelAndView  updateForm(HttpServletRequest request) {
		HttpSession  session   = request.getSession();
		MemberDto    login     = (MemberDto) session.getAttribute("login");

		int        member_idx  = login.getMember_idx();
		
		// idx 로 가입된 팀 전체 조회
		List<TeamDto> teamList = memberService.getMyTeamList(member_idx);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/update");
		mv.addObject("teamList", teamList);
		return  mv;
	}
	
	@Transactional
	@PostMapping("/Update")
	public  ModelAndView  update(@RequestParam HashMap<String, Object> map,
								HttpServletRequest request) {

		// 멤버 개인 정보 수정 + member_team 테이블의 elite 여부도 함께 수정
		memberService.updateMember(map);
		
		// 수정된 정보 재 조회후 세션 갱신
		MemberDto  updated = memberService.getMemberById(map);
		
		request.getSession().setAttribute("login", updated);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("redirect:/Member/Mypage?updated=true");
		return  mv;
	}
	
	
	// /Member/HitStats?member_idx=1
	@RequestMapping("/HitStats")
	public  ModelAndView  hitStats(@RequestParam HashMap<String, Object> map) {
		
		// 해당 선수 기록에 해당하는 idx 선수의 팀 목록 조회
		int           member_idx = Integer.parseInt(map.get("member_idx").toString());
		List<TeamDto> teamList   = memberService.getMyTeamList(member_idx);
		// 해당 선수 기본정보(최소화) 조회
		MemberDto     member     = memberService.getMemberProfile(member_idx);
		// 해당 번호의 선수가 없다면
		if (member == null) {
			return new ModelAndView("redirect:/Member/List?nowpage=1&keyword=");
		}
		
		ModelAndView  mv = new ModelAndView();
		mv.setViewName("member/hitstats");
		mv.addObject("teamList", teamList);
		mv.addObject("member",   member);
		mv.addObject("map",      map);
		return  mv;
	}
	
	
}
