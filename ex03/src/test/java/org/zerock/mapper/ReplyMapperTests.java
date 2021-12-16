package org.zerock.mapper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//Java Config
//@ContextConfiguration(classes = {org.zerock.config.RootConfig.class
//})
@Log4j
public class ReplyMapperTests {

	// �׽�Ʈ ���� �ش� ��ȣ�� �Խù��� �����ϴ��� �ݵ�� Ȯ���� ��
	private Long[] bnoArr = { 3145745L, 3145744L, 3145743L, 3145742L, 3145741L };

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1,  10).forEach(i -> {
			
			ReplyVO vo = new ReplyVO();
			
			//�Խù��� ��ȣ
			vo.setBno(bnoArr[i%5]);
			vo.setReply("��� �׽�Ʈ " + i);
			vo.setReplyer("replyer" + i);
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testMapper() {
		log.info(mapper);
	}

}
