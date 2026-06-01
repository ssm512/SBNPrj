package com.sbn.result.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PitcherVo {
	
	private   int     gameCount;        // 경기수
	private   int     hitter;           // 타자
	private   int     hitAllowed;       // 피안타
	private   int     homeRunAllowed;   // 피홈런
	private   int     totalScore;       // 실점
	private   int     earnedRun;        // 자책점
	private   int     sac;              // 희타/희비
	private   int     bbCnt;            // 사사구
	private   int     strikeOut;        // 탈삼진
	private   int     win;              // 승
	private   int     lose;             // 패
	private   int     save;             // 세이브
	private   int     hold;             // 홀드
	private   int     outCount;         // 아웃
	
	private   String  inning;           // 이닝     **
	private   int     hitterAtBat;      // 타수     **
	private   String  era;              // 방어율   **
	private   String  whip;             // WHIP     **
	
	public PitcherVo(int gameCount, int hitter, int hitAllowed, int homeRunAllowed, int totalScore, int earnedRun,
			int sac, int bbCnt, int strikeOut, int outCount, int win, int lose, int save, int hold) {
		this.gameCount = gameCount;
		this.hitter = hitter;
		this.hitAllowed = hitAllowed;
		this.homeRunAllowed = homeRunAllowed;
		this.totalScore = totalScore;
		this.earnedRun = earnedRun;
		this.sac = sac;
		this.bbCnt = bbCnt;
		this.outCount = outCount;
		this.strikeOut = strikeOut;
		this.win = win;
		this.lose = lose;
		this.save = save;
		this.hold = hold;
		
		calcStats(gameCount, hitter, hitAllowed, homeRunAllowed, totalScore, earnedRun,
				sac, bbCnt, strikeOut, outCount);
	}

	private void calcStats(int gameCount, int hitter, int hitAllowed, int homeRunAllowed, int totalScore,
			int earnedRun, int sac, int bbCnt, int strikeOut, int outCount) {
		// 이닝   (아웃+삼진+희생)
		int totalOut     = (outCount + strikeOut + sac);
		int fullInning   = totalOut / 3;
		int remainder    = totalOut % 3;
		this.inning      = fullInning + "." + (remainder*3);
		double inningVal = fullInning + (remainder / 3.0);
		
		// 타수   (타자-사사구-희생)
		this.hitterAtBat = hitter - bbCnt - sac;
		
		// 방어율 (자책점 * 7 / 이닝)
		this.era         = inningVal > 0 ?
						    String.format("%.2f", (double) earnedRun * 7 / inningVal)
						    : "0.00";
		
		// WHIP   ((피안타 + 사사구) / 이닝)
		this.whip        = inningVal > 0 ?
							String.format("%.2f", (double)(hitAllowed + bbCnt) / inningVal)
							: "0.00";
	}
	
	
	
}
