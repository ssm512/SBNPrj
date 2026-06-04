package com.sbn.member.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.dto.RankerDto;
import com.sbn.member.service.MemberService;
import com.sbn.paging.Pagination;
import com.sbn.paging.SearchDto;
import com.sbn.result.vo.HitterVo;
import com.sbn.result.vo.PitcherVo;
import com.sbn.team.dto.TeamDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/Member")
public class MemberController {
	
	@Value("${part1.upload-path}")
	private  String         uploadPath;

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
		
	    // nowpage 없으면 1로 기본값
	    Object nowpageObj = map.get("nowpage");
	    int nowpage = (nowpageObj == null || nowpageObj.toString().equals("null"))
	                  ? 1 : Integer.parseInt(String.valueOf(nowpageObj));

	    // 전체 수 조회
	    int totalCount = memberService.count(map);
	    
	    // 페이징 설정
	    SearchDto searchDto = new SearchDto();
	    searchDto.setPageNo(nowpage);
	    searchDto.setNumOfRows(10);
	    searchDto.setPageSize(10);
		
	    Pagination pagination = new Pagination(totalCount, searchDto);
	    searchDto.setPagination(pagination);

	    map.put("offset",    searchDto.getOffset());
	    map.put("numOfRows", searchDto.getNumOfRows());
	    
	    // 선수 목록 전체 조회 (페이징 단위로 짜름)
		List<MemberDto> memberList  = memberService.getMemberList(map);
		
		// 랭킹 관련 - 전체 선수에 대해 집계
		List<MemberDto> allMemberStats = memberService.getMembersVo();
		RankerDto       rankerList     = memberService.getRankerList(allMemberStats);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/list");
		mv.addObject("memberList", memberList);
		mv.addObject("searchDto",  searchDto);
		mv.addObject("rankerList", rankerList);
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
		// 사진 파일 조회
	    HashMap<String, Object> fileInfo = memberService.getMemberFile(member_idx);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/mypage");
		mv.addObject("teamList", teamList);
		mv.addObject("fileInfo", fileInfo);
		return  mv;
	}
	
	@RequestMapping("/UpdateForm")
	public  ModelAndView  updateForm(HttpServletRequest request) {
		HttpSession  session   = request.getSession();
		MemberDto    login     = (MemberDto) session.getAttribute("login");

		int        member_idx  = login.getMember_idx();
		
		// idx 로 가입된 팀 전체 조회
		List<TeamDto> teamList = memberService.getMyTeamList(member_idx);
		// 사진 조회
		HashMap<String, Object> fileInfo = memberService.getMemberFile(member_idx);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("member/update");
		mv.addObject("teamList", teamList);
		mv.addObject("fileInfo", fileInfo);
		return  mv;
	}
	
	@Transactional
	@PostMapping("/Update")
	public  ModelAndView  update(@RequestParam HashMap<String, Object> map,
			 				     @RequestParam(name="file", required = false) MultipartFile file,
								HttpServletRequest request) throws IllegalStateException, IOException {

		// 멤버 개인 정보 수정 + member_team 테이블의 elite 여부도 함께 수정
		memberService.updateMember(map);
		
	    // 파일 있으면 저장
	    if (file != null && !file.isEmpty()) {
	        String originalName = file.getOriginalFilename();
	        String ext          = originalName.substring(originalName.lastIndexOf(".") + 1);
	        String saveName     = UUID.randomUUID().toString() + "." + ext;
	
	        file.transferTo(new java.io.File(uploadPath + saveName));
	
	        HashMap<String, Object> fileMap = new HashMap<>();
	        fileMap.put("member_idx", map.get("member_idx"));
	        fileMap.put("file_name",  originalName);
	        fileMap.put("file_ext",   ext);
	        fileMap.put("sfile_name", saveName);
	
	        // 기존 이미지 있으면 update, 없으면 insert
	        HashMap<String, Object> existing = memberService.getMemberFile(
	            Integer.parseInt(map.get("member_idx").toString()));
	        if (existing != null) {
	            // 기존 파일 디스크에서 삭제
	        	Object sfileObj = existing.get("SFILE_NAME") != null 
	                    ? existing.get("SFILE_NAME") 
	                    : existing.get("sfile_name");
	            File oldFile = new File(uploadPath + sfileObj.toString());
	            if (oldFile.exists()) {
	                oldFile.delete();
	            }
	            memberService.updateMemberFile(fileMap);
	        } else {
	            memberService.insertMemberFile(fileMap);
	        }
	    }
		
		// 수정된 정보 재 조회후 세션 갱신
		MemberDto  updated = memberService.getMemberById(map);
		
		request.getSession().setAttribute("login", updated);
		
		ModelAndView  mv  = new ModelAndView();
		mv.setViewName("redirect:/Member/Mypage?updated=true");
		return  mv;
	}
	
	
	// /Member/Stats?member_idx=1
	@RequestMapping("/Stats")
	public  ModelAndView  stats(@RequestParam HashMap<String, Object> map) {
		
		// 해당 선수 기록에 해당하는 idx 선수의 팀 목록 조회
		int           member_idx = Integer.parseInt(map.get("member_idx").toString());
		List<TeamDto> teamList   = memberService.getMyTeamList(member_idx);
		// 해당 선수 기본정보(최소화) 조회
		MemberDto     member     = memberService.getMemberProfile(member_idx);
		// 사진 파일 조회
	    HashMap<String, Object> fileInfo = memberService.getMemberFile(member_idx);
		// 해당 번호의 선수가 없다면
		if (member == null) {
			return new ModelAndView("redirect:/Member/List?nowpage=1&keyword=");
		}
		
		HashMap<String, Object> statsMap  = new HashMap<>();
		statsMap.put("member_id", member.getMember_id());

		if (map.get("team_idx") != null) {
		    statsMap.put("team_idx", map.get("team_idx"));
		}
		
		// 해당 선수의 record 조회 (member에 있는 id로)
		HitterVo   hitstats    = memberService.getHitStats(statsMap);
		PitcherVo  pitchstats  = memberService.getPitchStats(statsMap);
		
		ModelAndView  mv = new ModelAndView();
		mv.setViewName("member/stats");
		mv.addObject("teamList",    teamList);
		mv.addObject("member",      member);
		mv.addObject("hitstats" ,   hitstats);
		mv.addObject("pitchstats" , pitchstats);
		mv.addObject("fileInfo",    fileInfo);
		mv.addObject("map",      map);
		return  mv;
	}
	
	
}
