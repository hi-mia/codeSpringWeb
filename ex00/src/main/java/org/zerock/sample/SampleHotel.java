package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Component
@ToString
@Getter
//@AllArgsConstructor
@RequiredArgsConstructor
public class SampleHotel {
	
	@NonNull
	private Chef chef;
	
//	public SampleHotel(Chef chef) { //@AllArgsConstructor로 대체
//		this.chef = chef;
//	}
}


//@AllArgsConstructor 인스턴스 변수로 선언된 모든 것을 파라미터로 받는 생성자 작성