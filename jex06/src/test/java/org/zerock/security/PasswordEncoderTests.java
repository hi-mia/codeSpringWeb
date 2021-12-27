package org.zerock.security;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {org.zerock.config.RootConfig.class,
					org.zerock.config.SecurityConfig.class})
@Log4j
public class PasswordEncoderTests {

	@Setter(onMethod_ = {@Autowired} )
	private PasswordEncoder pwEncoder;
	
	@Test
	public void testEncode() {
		String str = "member";
		String enStr = pwEncoder.encode(str);
		
		//�н����� ���ڵ� ����� �Ź� ���ݾ� �޶��� �� �ֽ��ϴ�
		//$2a$10$1tNLbD1tKQ4QZzy5Z2XOnupjgCPjxF81zFJ5/oHDxhWvBJOBGapea
		log.info(enStr);
	}
}
