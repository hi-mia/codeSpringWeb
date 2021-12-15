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
	
	public int delete(Long bno); //�����Ͱ� �����Ǹ� 1�̻��� �� ����, �ش� ��ȣ�� �Խù� ���ٸ� 0�� ����
	
	public int update(BoardVO board); //�� ���� �����Ͱ� �����Ǿ��°�
	
	public int getTotalCount(Criteria cri); 
}
