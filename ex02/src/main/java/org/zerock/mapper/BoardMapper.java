package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	
	//@Select("select * from tbl_board where bno>0")
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno); //데이터가 삭제되면 1이상의 값 가짐, 해당 번호의 게시물 없다면 0을 가짐
	
	public int update(BoardVO board); //몇 개의 데이터가 수정되었는가
	
	public int getTotalCount(Criteria cri); 
}
