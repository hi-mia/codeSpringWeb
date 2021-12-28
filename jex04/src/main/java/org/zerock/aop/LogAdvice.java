package org.zerock.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	@Before( "execution(* org.zerock.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("===================================");
	}
	
	@Before("execution(* org.zerock.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* org.zerock.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		log.info("Exception....!!!!");
		log.info("exception: " + exception);
	}
	
	@Around("execution(* org.zerock.service.SampleService*.*(..))") //리턴타입 void(X), 메서드 실행결과 직접 반환 형태
	public Object logTime(ProceedingJoinPoint pjp) { //ProceedingJoinPoint: AOP대상이 되는 Target이나 파라미터 확인 + 직접 실행을 결정
		long start = System.currentTimeMillis();
		
		log.info("Target: " + pjp.getTarget());
		log.info("Param: " + Arrays.toString(pjp.getArgs()));
		
		//invoke method
		Object result = null;
		
		try {
		result = pjp.proceed();
		} catch(Throwable e) {
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		log.info("TIME: " + (end - start));
		
		return result;
	}
}
