package kr.co.olympic.qna;

import java.util.Map;

import lombok.Data;

@Data
public class QnaSearchDTO {
	private String game_id; // 특정 경기에 대해서만 조회하는 경우
	private String member_no; // 특정 멤버가 작성한 게시글 조회하는 경우
	private String type; // 0 : 경기, 1 : 일반, 2 : 결제, 3 : 티켓, all (1,2,3)
	private int state; // 0: 일반 게시글, 1: 공지 게시글, 2: 삭제 게시글
	private String search_words; // 검색어가 있는 경우
	private String search_type; // title, content 검색
	private int startIdx; // limit으로 제한 걸어줄 시작 인덱스 값
	private int page; // 현재 페이지
	private String orderinfo;
	/*
	 * 페이지네이션 관련 정보 count : totalPage : endPage : 끝 페이지 startPage : 시작 페이지 isPrev :
	 * 이전 페이지 존재 여부 isNext : 다음 페이지 존재 여부
	 */
	private Map<String, Object> pages;

	public QnaSearchDTO() {
		this.page = 1;
		this.game_id = null;
		this.member_no = null;
		this.type = "all";
		this.orderinfo = "q.qna_no";
	}

	public int getStartIdx() {
		return (this.page - 1) * 10;
	}
	public void setStartIdx(int startIdx) {
		this.startIdx = startIdx;
	}
}