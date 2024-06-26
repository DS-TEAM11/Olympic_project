package kr.co.olympic.game;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.co.olympic.member.MemberVO;

@Mapper
public interface GameMapper {
	//#경기관련
	//경기 전체 리스트
	List<GameVO> listGame(GameVO game);
	// 경기 검색 리스트
	List<GameVO> searchGame(Map<String, Object> map);
	//경기 날짜별 리스트
	List<GameVO> listByDate(GameVO game);
	//경기 종목별 리스트
	List<GameVO> listByGame(GameVO game);
	//경기 생성
	int createGame(GameVO game);
	//경기 상세조회
	GameVO detailGame(Map<String, Object> map);
	//경기 수정
	int updateGame(GameVO game);
	//경기 삭제
	int deleteGame(GameVO game);
	// 경기 수
	int count(GameVO game);
	//경기 댓글 등록
	int createComment(Map<String, Object> map);
	//경기 댓글 리스트
	List<CommentVO> listComment(GameVO game);
	// 관심 경기 등록
	int createFavorite(Map<String, Object> map);
	// 관심 경기 조회
	List<GameVO> listFavorite(MemberVO member);
	// 관심 경기 삭제
	int deleteFavorite(Map<String, Object> map);
}
