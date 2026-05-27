package com.sbn.paging;

public class Pagination {
	private   int       totalCount;      // 해당메뉴의 조회된 자료수
	private   int       totalPageCount;  // 전체 페이지수 : totalCount / numOfRows
	
	private   int       startPage;
	private   int       endPage;
	
	private   int       limitStart; 
	
	private   boolean   existPrevPage;
	private   boolean   existNextPage;
	// 생성자
	public   Pagination( int totalCount, SearchDto  searchDto  ) {
		if( totalCount > 0  ) {
			this.totalCount = totalCount;
			calculation( searchDto  );
		}
	}
	private void calculation(SearchDto searchDto) {
		// 전체 페이지수 계산
				int  numOfRows       =  searchDto.getNumOfRows();   
				this.totalPageCount  =  (int) Math.ceil( (double) this.totalCount / (double) numOfRows );
				
				// 현재 페이지 : pageNo <- nowpage
				int  pageNo          =  searchDto.getPageNo();
				if( pageNo > this.totalPageCount  ) {
					pageNo   = this.totalPageCount;
					searchDto.setPageNo( pageNo );
				}
				
				// 페이지번호의 시작 계산
				int  pageSize =  searchDto.getPageSize(); // 한줄에 출력할 페이지 번호 수 
				startPage     =  ((pageNo - 1) / pageSize ) * pageSize + 1;
				endPage       =  startPage 	+ pageSize - 1; 
						
				// limitStart : 데이터베이스 가져올 시작위치 
				limitStart    =  searchDto.getOffset(); 
				// ==  limitStart    =  (pageNo - 1) * numOfRows;
				
				// 이전페이지로 이동 버튼 필요
				existPrevPage  =  startPage > 1;
				
				// 다음페이지로 이동 버튼 필요
				existNextPage  =  endPage  < totalPageCount; 
	}
}
