package org.zerock.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)

//Test for Controller
@WebAppConfiguration

@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
//Java Config
//@ContextConfiguration(classes={
//						org.zerock.config.RootConfig.class,
//						org.zerock.config.ServletConfig.class})
@Log4j
public class BoardControllerTests {

	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	//Controller를 테스트할 경우 WAS를 실행하지 않고 테스트하기 위해 약간의 추가적인 코드를 입력한다
	//목록
	@Test
	public void testList() throws Exception {
//		log.info(mockMvc.perform(
//			MockMvcRequestBuilders.get("/board/list"))
//			.andReturn()
//			.getModelAndView()
//			.getModelMap());
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "50"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	//등록
	public void testRegister() throws Exception{
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "테스트 새글 제목")
				.param("content", "테스트 새글 내용")
				.param("writer", "user00")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
				
	}
	
	//조회
	@Test
	public void testGet() throws Exception{
		log.info(mockMvc.perform(MockMvcRequestBuilders
				.get("/board/get")
				.param("bno", "2"))
				.andReturn()
				.getModelAndView().getModelMap());
	}
	
	//수정
	@Test
	public void testModify() throws Exception{
		
		String resultPage = mockMvc
				.perform(MockMvcRequestBuilders.post("/board/modify")
					.param("bno", "1")
					.param("title", "수정된 테스트 새글 제목")
					.param("content", "수정된 테스트 새글 내용")
					.param("writer", "user00"))
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
	
	//삭제
	@Test
	public void testRemove() throws Exception{
		//삭제 전 데이터 베이스에 게시물 번호 확인할 것
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", "25")
				).andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
	}
}

