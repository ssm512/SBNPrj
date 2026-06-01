package com.sbn.member.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.mapper.MemberMapper;
import com.sbn.member.service.MemberService;
import com.sbn.result.vo.HitterVo;
import com.sbn.result.vo.PitcherVo;
import com.sbn.team.dto.TeamDto;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private  MemberMapper  memberMapper;
	
    @Autowired
    private BCryptPasswordEncoder encoder;
	
	@Override
	public List<MemberDto> getMemberList(HashMap<String, Object> map) {
		List<MemberDto> memberList  = memberMapper.getMemberList(map); 
		return memberList;
	}

	@Override
	public MemberDto login(HashMap<String, Object> map) {
        String rawPw = map.get("password").toString();

        MemberDto member = memberMapper.getMemberById(map);

        if (member == null) return null;                                // 아이디 없음
        if (!encoder.matches(rawPw, member.getPassword())) return null; // 비번 틀림

        member.setPassword(null); // 세션에 담기 전 password 제거
        return member;
	}

	@Override
	public MemberDto getMemberById(HashMap<String, Object> map) {
		MemberDto  member  = memberMapper.getMemberById(map);
		member.setPassword(null); // 세션에 담기 전 password 제거
		return  member;
	}
	
	@Override
	public void signin(HashMap<String, Object> map) {
        String rawPw = map.get("password").toString();
        map.put("password", encoder.encode(rawPw)); // 암호화 후 덮어씌우기
        memberMapper.insertMember(map);
	}

	@Override
	public List<TeamDto> getMyTeamList(int member_idx) {
		List<TeamDto> teamList = memberMapper.getMyTeamList(member_idx);
		return teamList;
	}
	
	@Override
	public MemberDto getIdDupCheck(String member_id) {
		MemberDto	member		=	memberMapper.getIdDupCheck(member_id);
		return member;
	}

	@Transactional
	@Override
	public void updateMember(HashMap<String, Object> map) {
		memberMapper.updateMember(map);
		memberMapper.updateElite(map);
	}

	@Override
	public MemberDto getPhoneDupCheck(String phone_num) {
		MemberDto	member		=	memberMapper.getPhoneDupCheck(phone_num);
		return member;
	}

	@Override
	public MemberDto getEmailDupCheck(String email) {
		MemberDto	member		=	memberMapper.getEmailDupCheck(email);
		return member;
	}

	@Override
	public MemberDto getMemberProfile(int member_idx) {
		MemberDto  member  = memberMapper.getMemberProfile(member_idx);
		return member;
	}

	@Override
	public int count(HashMap<String, Object> map) {
		int count = memberMapper.count(map);
		return count;
	}

	@Override
	public HitterVo getHitStats(HashMap<String, Object> statsMap) {
	    HashMap<String, Object> raw = memberMapper.getHitStats(statsMap);
	    if (raw == null || raw.get("pa") == null) return null;

	    return new HitterVo(
	        toInt(raw.get("game_count")),
	        toInt(raw.get("pa")),
	        toInt(raw.get("single_hit")),
	        toInt(raw.get("double_hit")),
	        toInt(raw.get("triple_hit")),
	        toInt(raw.get("home_run")),
	        toInt(raw.get("get_score")),
	        toInt(raw.get("bb_cnt")),
	        toInt(raw.get("strike_out")),
	        toInt(raw.get("sac"))
	    );
	}


	@Override
	public PitcherVo getPitchStats(HashMap<String, Object> statsMap) {
		// GAME_RECORD 집계
	    HashMap<String, Object> raw = memberMapper.getPitchStats(statsMap);
	    if (raw.get("hitter") == null) raw.put("hitter", 0);
	    if (raw == null) return null;
	    // 승패홀세 집계
	    HashMap<String, Object> record = memberMapper.getPitchRecord(statsMap);
	    
	    return new PitcherVo(
	        toInt(raw.get("game_count")),
	        toInt(raw.get("hitter")),
	        toInt(raw.get("hit_allowed")),
	        toInt(raw.get("home_run_allowed")),
	        toInt(raw.get("total_score")),
	        toInt(raw.get("earned_run")),
	        toInt(raw.get("sac")),
	        toInt(raw.get("bb_cnt")),
	        toInt(raw.get("strike_out")),
	        toInt(raw.get("out_count")),
	        toInt(record.get("win")),
	        toInt(record.get("lose")),
	        toInt(record.get("save")),
	        toInt(record.get("hold"))
	    );
	}

	
	private int toInt(Object obj) {
		return obj == null ? 0 : Integer.parseInt(obj.toString());
	}


}
