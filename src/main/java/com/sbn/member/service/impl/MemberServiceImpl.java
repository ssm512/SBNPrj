package com.sbn.member.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.dto.RankerDto;
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
	    return toHitterVo(raw);

	}


	private HitterVo toHitterVo(HashMap<String, Object> raw) {
	    if (raw == null) return null;

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
	    if (raw == null || raw.get("hitter") == null ) raw.put("hitter", 0);
	    // 승패홀세 집계
	    HashMap<String, Object> record = memberMapper.getPitchRecord(statsMap);
	    if (record == null) {
	    	record = new HashMap<>();
	    	record.put("win", 0);
	    	record.put("lose", 0);
	    	record.put("save", 0);
	    	record.put("hold", 0);
	    }
	    
	    return toPitcherVo(raw, record);
	}
	
	private PitcherVo toPitcherVo(HashMap<String, Object> pitchRaw,
            HashMap<String, Object> recordRaw) {
		if (pitchRaw == null || pitchRaw.get("hitter") == null) return null;
		if (recordRaw == null) recordRaw = new HashMap<>();
			return new PitcherVo(
			toInt(pitchRaw.get("game_count")),
			toInt(pitchRaw.get("hitter")),
			toInt(pitchRaw.get("hit_allowed")),
			toInt(pitchRaw.get("home_run_allowed")),
			toInt(pitchRaw.get("total_score")),
			toInt(pitchRaw.get("earned_run")),
			toInt(pitchRaw.get("sac")),
			toInt(pitchRaw.get("bb_cnt")),
			toInt(pitchRaw.get("strike_out")),
			toInt(pitchRaw.get("out_count")),
			toInt(recordRaw.get("win")),
			toInt(recordRaw.get("lose")),
			toInt(recordRaw.get("save")),
			toInt(recordRaw.get("hold"))
		);
	}	

	@Override
	public List<MemberDto> getMembersVo() {
		// 회원 목록 (전체)
		List<MemberDto> allMembers = memberMapper.getAllMember();
		
	    // 전체 집계 쿼리 3번
	    List<HashMap<String, Object>> allHitStats    = memberMapper.getAllHitStats();
	    List<HashMap<String, Object>> allPitchStats  = memberMapper.getAllPitchStats();
	    List<HashMap<String, Object>> allPitchRecord = memberMapper.getAllPitchRecord();
	    
	    // member_id 기준 Map 변환
	    Map<String, HashMap<String, Object>> hitMap = allHitStats.stream()
	        .collect(Collectors.toMap(
	            m -> m.get("member_id").toString(), m -> m));

	    Map<String, HashMap<String, Object>> pitchMap = allPitchStats.stream()
	        .collect(Collectors.toMap(
	            m -> m.get("member_id").toString(), m -> m));

	    Map<String, HashMap<String, Object>> recordMap = allPitchRecord.stream()
	        .collect(Collectors.toMap(
	            m -> m.get("member_id").toString(), m -> m));
	    
		for (MemberDto member : allMembers) {
		    String id = member.getMember_id();
		    member.setHitstats(toHitterVo(hitMap.get(id)));
		    member.setPitchstats(toPitcherVo(
		        pitchMap.get(id),
		        recordMap.get(id)
		    ));
		}
		return  allMembers;
	}
	
	@Override
	public RankerDto getRankerList(List<MemberDto> allMemberStats) {
		List<MemberDto> validHitStats = allMemberStats.stream()
			    .filter(m -> m.getHitstats() != null && m.getHitstats().getGameCount() > 0)
			    .collect(Collectors.toList());
		
		List<MemberDto> validPitchStats = allMemberStats.stream()
			    .filter(m -> m.getPitchstats() != null && m.getPitchstats().getGameCount() > 0)
			    .collect(Collectors.toList());
		
		// 각 부문 별 Ranker 목록
		List<MemberDto> avg       = RankerProcess.calcAvgRanker(validHitStats);
		List<MemberDto> homeRun   = RankerProcess.calcHomeRunRanker(validHitStats);
		List<MemberDto> getScore  = RankerProcess.calcGetScoreRanker(validHitStats);
		List<MemberDto> hit       = RankerProcess.calcHitRanker(validHitStats);
		
		List<MemberDto> era       = RankerProcess.calcEraRanker(validPitchStats);
		List<MemberDto> win       = RankerProcess.calcWinRanker(validPitchStats);
		List<MemberDto> strikeOut = RankerProcess.calcStrikeOutRanker(validPitchStats);
		List<MemberDto> inning    = RankerProcess.calcInningRanker(validPitchStats);

		// rankerDto 생성 후 랭커 목록 세팅
		RankerDto  rankerDto  = new RankerDto(avg, homeRun, getScore, hit, era, win, strikeOut, inning);
		
		return  rankerDto;
	}

	
	private int toInt(Object obj) {
		return obj == null ? 0 : Integer.parseInt(obj.toString());
	}

	@Override
	public HashMap<String, Object> getMemberFile(int member_idx) {
		HashMap<String, Object> fileInfo = memberMapper.getMemberFile(member_idx);
		return fileInfo;
	}

	@Override
	public void updateMemberFile(HashMap<String, Object> fileMap) {
		memberMapper.updateMemberFile(fileMap);
	}

	@Override
	public void insertMemberFile(HashMap<String, Object> fileMap) {
		memberMapper.insertMemberFile(fileMap);
	}


	@Override
	public boolean changePassword(HashMap<String, Object> map) {
	    // 현재 비번 검증
	    MemberDto member = memberMapper.getMemberById(map);
	    String currentPw = map.get("current_pw").toString();

	    if (!encoder.matches(currentPw, member.getPassword())) {
	        return false; // 현재 비번 틀림
	    }

	    // 새 비번 암호화 후 update
	    String newPw = map.get("new_pw").toString();
	    map.put("password", encoder.encode(newPw));
	    memberMapper.changePassword(map);
	    return true;
	}

	@Override
	public void deleteMember(int member_idx) {
		memberMapper.deleteMember(member_idx);
	}






}
