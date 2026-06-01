package com.sbn.result.vo;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class HitterVo {

	private  int     gameCount;  // 경기수
	private  int     pa;         // 타석    (plate-appearance)
	private  int     singleHit;  // 1루타
	private  int     doubleHit;  // 2루타
	private  int     tripleHit;  // 3루타
	private  int     homeRun;    // 홈런
	private  int     getScore;   // 타점
	private  int     bbCnt;      // 사사구
	private  int     strikeOut;  // 삼진
	private  int     sac;        // 희생
	
	// 후처리
	private  int     totalBase;  // 총루타  **
	private  int     atBat;      // 타수    **
	private  int     totalHit;   // 총 안타 **
	
	private  String  avg;        // 타율    **
	private  String  obp;        // 출루율 (on-base-percentage)  **
	private  String  slg;        // 장타율 (slugging percentage) **
	private  String  ops;        // ops     **
	
	public HitterVo(int gameCount, int pa, int singleHit, int doubleHit, int tripleHit, int homeRun, int getScore, int bbCnt,
			int strikeOut, int sac) {
		this.gameCount = gameCount;
		this.pa = pa;
		this.singleHit = singleHit;
		this.doubleHit = doubleHit;
		this.tripleHit = tripleHit;
		this.homeRun = homeRun;
		this.getScore = getScore;
		this.bbCnt = bbCnt;
		this.strikeOut = strikeOut;
		this.sac = sac;
		
		calcStats(pa, singleHit, doubleHit, tripleHit, homeRun, getScore, bbCnt,
					strikeOut, sac);
	}

	private void calcStats(int pa, int singleHit, int doubleHit, int tripleHit, int homeRun, int getScore, int bbCnt,
			int strikeOut, int sac) {
		// 총루타
		this.totalBase = singleHit + (doubleHit*2) + (tripleHit*3) + (homeRun*4);
		
		// 타수 = (타수 - 사사구 - 희생)
		this.atBat     = pa - bbCnt - sac;
		
		// 총안타
		this.totalHit  = singleHit + doubleHit + tripleHit + homeRun;
		
		// 타율 = (총안타/타수)
		this.avg       = atBat > 0 ? 
				         String.format("%.3f", (double) totalHit / atBat) 
		                : "0.000";
		
		// 출루율 = ((총안타+사사구)/타석)
		this.obp       = pa > 0 ? 
		         		 String.format("%.3f", (double) (totalHit + bbCnt) / pa) 
		         		: "0.000";
		
		// 장타율 = (총루타/타수)
		this.slg       = atBat > 0 ? 
		         		 String.format("%.3f", (double) totalBase / atBat) 
		         		: "0.000";
		
		// OPS    = (출루율 + 장타율)
		double obpVal = pa > 0 ? (double)(totalHit + bbCnt) / pa : 0.0;
		double slgVal = atBat > 0 ? (double) totalBase / atBat : 0.0;
		this.ops = String.format("%.3f", obpVal + slgVal);
	}
	
	
	
	
}
