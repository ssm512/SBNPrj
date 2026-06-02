package com.sbn.member.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.sbn.member.dto.MemberDto;

public class RankerProcess {

	// 타율 TOP 5 계산
	public static List<MemberDto> calcAvgRanker(List<MemberDto> validHitStats) {
		
		List<MemberDto> sorted  = new ArrayList<>(validHitStats);
		sorted.sort((a, b) -> {
		    double avgA = Double.parseDouble(a.getHitstats().getAvg());
		    double avgB = Double.parseDouble(b.getHitstats().getAvg());

		    int cmp = Double.compare(avgB, avgA); // 타율 내림차순
		    if (cmp != 0) return cmp;

		    int atBatA = a.getHitstats().getAtBat();
		    int atBatB = b.getHitstats().getAtBat();

		    cmp = Integer.compare(atBatB, atBatA); // 타수 내림차순
		    if (cmp != 0) return cmp;

		    int gameA = a.getHitstats().getGameCount();
		    int gameB = b.getHitstats().getGameCount();

		    return Integer.compare(gameB, gameA); // 경기수 내림차순
		});
	    return sorted.stream()
                .limit(5)
                .collect(Collectors.toList());
	}
	
	// 홈런 TOP 5 계산
	public static List<MemberDto> calcHomeRunRanker(List<MemberDto> validHitStats) {
		
		List<MemberDto> sorted  = new ArrayList<>(validHitStats);
		sorted.sort((a, b) -> {
		    int homeRunA = a.getHitstats().getHomeRun();
		    int homeRunB = b.getHitstats().getHomeRun();

		    int cmp = Integer.compare(homeRunB, homeRunA); // 홈런 내림차순
		    if (cmp != 0) return cmp;

		    int getScoreA = a.getHitstats().getGetScore();
		    int getScoreB = b.getHitstats().getGetScore();

		    cmp = Integer.compare(getScoreB, getScoreA); // 타점 내림차순
		    if (cmp != 0) return cmp;

		    double slgA = Double.parseDouble(a.getHitstats().getSlg());
		    double slgB = Double.parseDouble(b.getHitstats().getSlg());

		    return Double.compare(slgB, slgA); // 장타율 내림차순
		});
	    return sorted.stream()
                .limit(5)
                .collect(Collectors.toList());
	}

	// 타점 TOP 5 계산
	public static List<MemberDto> calcGetScoreRanker(List<MemberDto> validHitStats) {
		
		List<MemberDto> sorted  = new ArrayList<>(validHitStats);
		sorted.sort((a, b) -> {
			int getScoreA = a.getHitstats().getGetScore();
			int getScoreB = b.getHitstats().getGetScore();
			
			int cmp = Integer.compare(getScoreB, getScoreA); // 타점 내림차순
			if (cmp != 0) return cmp;
			
		    int homeRunA = a.getHitstats().getHomeRun();
		    int homeRunB = b.getHitstats().getHomeRun();

		    cmp = Integer.compare(homeRunB, homeRunA); // 홈런 내림차순
		    if (cmp != 0) return cmp;

		    double slgA = Double.parseDouble(a.getHitstats().getSlg());
		    double slgB = Double.parseDouble(b.getHitstats().getSlg());

		    return Double.compare(slgB, slgA); // 장타율 내림차순
		});
	    return sorted.stream()
                .limit(5)
                .collect(Collectors.toList());
	}

	// 안타 TOP 5 계산
	public static List<MemberDto> calcHitRanker(List<MemberDto> validHitStats) {

		List<MemberDto> sorted  = new ArrayList<>(validHitStats);
		sorted.sort((a, b) -> {
			int hitA = a.getHitstats().getTotalHit();
			int hitB = b.getHitstats().getTotalHit();
			
			int cmp = Integer.compare(hitB, hitA); // 안타 내림차순
			if (cmp != 0) return cmp;
			
		    double avgA = Double.parseDouble(a.getHitstats().getAvg());
		    double avgB = Double.parseDouble(b.getHitstats().getAvg());

		    cmp = Double.compare(avgB, avgA); // 타율 내림차순
		    if (cmp != 0) return cmp;

		    int gameA = a.getHitstats().getGameCount();
		    int gameB = b.getHitstats().getGameCount();

		    return Integer.compare(gameB, gameA); // 경기수 내림차순
		});
	    return sorted.stream()
                .limit(5)
                .collect(Collectors.toList());
	}

	// 방어율 TOP 5 계산
	public static List<MemberDto> calcEraRanker(List<MemberDto> validPitchStats) {
		List<MemberDto> sorted  = new ArrayList<>(validPitchStats);
		
		sorted.sort((a, b) -> {
			double eraA = Double.parseDouble(a.getPitchstats().getEra());
			double eraB = Double.parseDouble(b.getPitchstats().getEra());
			
			int cmp = Double.compare(eraA, eraB); // 방어율 오름차순
			if (cmp != 0) return cmp;
			
		    double inningA = Double.parseDouble(a.getPitchstats().getInning());
		    double inningB = Double.parseDouble(b.getPitchstats().getInning());

		    cmp = Double.compare(inningB, inningA); // 이닝 내림차순
		    if (cmp != 0) return cmp;

		    double whipA = Double.parseDouble(a.getPitchstats().getWhip());
		    double whipB = Double.parseDouble(b.getPitchstats().getWhip());

		    return Double.compare(whipA, whipB); // whip 오름차순
		});
	    return sorted.stream()
                .limit(5)
                .collect(Collectors.toList());
	}
	
	// 승리 TOP 5 계산
	public static List<MemberDto> calcWinRanker(List<MemberDto> validPitchStats) {
	    List<MemberDto> sorted = new ArrayList<>(validPitchStats);
	    
	    sorted.sort((a, b) -> {
	        int winA = a.getPitchstats().getWin();
	        int winB = b.getPitchstats().getWin();

	        int cmp = Integer.compare(winB, winA); // 승 내림차순
	        if (cmp != 0) return cmp;

	        double inningA = Double.parseDouble(a.getPitchstats().getInning());
	        double inningB = Double.parseDouble(b.getPitchstats().getInning());

	        cmp = Double.compare(inningB, inningA); // 이닝 내림차순
	        if (cmp != 0) return cmp;

	        double eraA = Double.parseDouble(a.getPitchstats().getEra());
	        double eraB = Double.parseDouble(b.getPitchstats().getEra());

	        return Double.compare(eraA, eraB); // ERA 오름차순
	    });
	    return sorted.stream()
	            .limit(5)
	            .collect(Collectors.toList());
	}
	
	// 탈삼진 TOP 5 계산
	// 탈삼진 TOP 5 계산
	public static List<MemberDto> calcStrikeOutRanker(List<MemberDto> validPitchStats) {
	    List<MemberDto> sorted = new ArrayList<>(validPitchStats);
	    
	    sorted.sort((a, b) -> {
	        int soA = a.getPitchstats().getStrikeOut();
	        int soB = b.getPitchstats().getStrikeOut();

	        int cmp = Integer.compare(soB, soA); // 탈삼진 내림차순
	        if (cmp != 0) return cmp;

	        double inningA = Double.parseDouble(a.getPitchstats().getInning());
	        double inningB = Double.parseDouble(b.getPitchstats().getInning());

	        cmp = Double.compare(inningB, inningA); // 이닝 내림차순
	        if (cmp != 0) return cmp;

	        double eraA = Double.parseDouble(a.getPitchstats().getEra());
	        double eraB = Double.parseDouble(b.getPitchstats().getEra());

	        return Double.compare(eraA, eraB); // ERA 오름차순
	    });
	    return sorted.stream()
	            .limit(5)
	            .collect(Collectors.toList());
	}
	
	// 최다이닝 TOP 5 계산
	public static List<MemberDto> calcInningRanker(List<MemberDto> validPitchStats) {
	    List<MemberDto> sorted = new ArrayList<>(validPitchStats);
	    sorted.sort((a, b) -> {
	        double inningA = Double.parseDouble(a.getPitchstats().getInning());
	        double inningB = Double.parseDouble(b.getPitchstats().getInning());

	        int cmp = Double.compare(inningB, inningA); // 이닝 내림차순
	        if (cmp != 0) return cmp;

	        double eraA = Double.parseDouble(a.getPitchstats().getEra());
	        double eraB = Double.parseDouble(b.getPitchstats().getEra());

	        cmp = Double.compare(eraA, eraB); // ERA 오름차순
	        if (cmp != 0) return cmp;

	        double whipA = Double.parseDouble(a.getPitchstats().getWhip());
	        double whipB = Double.parseDouble(b.getPitchstats().getWhip());

	        return Double.compare(whipA, whipB); // WHIP 오름차순
	    });
	    return sorted.stream()
	            .limit(5)
	            .collect(Collectors.toList());
	}

}
