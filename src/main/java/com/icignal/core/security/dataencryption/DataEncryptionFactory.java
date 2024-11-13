package com.icignal.core.security.dataencryption;



import java.util.HashMap;
import java.util.Map;
import java.util.function.Supplier;

import com.icignal.core.Factory;
import com.icignal.core.security.dataencryption.impl.DatabaseDataAwsKmsEncryption;
import com.icignal.core.security.dataencryption.impl.DatabaseDataLocalEncryption;
import com.icignal.core.security.dataencryption.impl.FileDataAwsKmsEncryption;
import com.icignal.core.security.dataencryption.impl.FileDataLocalEncryption;
public class DataEncryptionFactory  extends Factory {
	    /*
			** 함수형 인터페이스 사용법 **	    	
			1. Consumer :	매개값이 있고 리턴 값이 없다.						
				Consumer<T> 
				void accept(T t) // 객체 T를 받아서 소비한다
				
				BiConsumer<T, U>
				void accet(T t, U u) // 객체 T와 U를 받아서 소비한다
								
				IntConsumer
				void accapt(int value) // int 값을 받아서 소비한다
			
			2. Supplier : 매개 변수는 없고 리턴값이 있다. 단순 공급자의 역할을 한다.
			
				Supplier<T>
				T get() // T 객체를 리턴한다
				
				BooleanSupplier
				boolean getAsBoolean() // boolean 값을 리턴한다
				
				IntSupplier
				int getAsInt() // int 값을 리턴한다
						
			3. Function : 매개 변수와 리턴값이 둘 다 존재한다.
			
				Function<T, R>
				R apply(T t) // 객체 T를 객체 R로 매핑한다
				
				BiFunction<T,U,R> 
				R apply(T t, U u) // 객체 T와 U를 객체 R로 매핑한다
				
				IntFunction<R>
				R apply(int value) // int를 객체 R로 매핑한다
				Predicate
				매개 변수가 있고 boolean을 리턴한다.
				
			4. Predicate<T>
				boolean test(T t) // 객체 T를 판별
				
				BiPredicate<T, U> 
				boolean test(T t, U u) // 객체 T와 U를 판별
	     
	     */

	public final static Map<String, Supplier<DataEncryption> > map = new HashMap<>();
	
	/*
	 * 새로운 형태의 암호화 처리 클래스 발생시 신규 추가해야 함.
	 */
	static {
			map.put("db-awskms", 	DatabaseDataAwsKmsEncryption:: new);
			map.put("db-local",  	DatabaseDataLocalEncryption :: new);
			map.put("file-awskms", 	FileDataAwsKmsEncryption 	:: new);
			map.put("file-local", 	FileDataLocalEncryption 	:: new);
		   }

	/*
	 * 1. 메소드명: createObject
	 * 2. 클래스명: Factory<T>
	 * 3. 작성자명: knlee
	 * 4. 작성일자: 2020. 1. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * </PRE>
	 *   @param objType
	 *   @return
	 *   @throws InstantiationException
	 *   @throws IllegalAccessException
	 *   @throws ClassNotFoundException	
	 */
	
	@Override
	protected Object createObject(String objType)
			throws InstantiationException, IllegalAccessException, ClassNotFoundException {
		Supplier<DataEncryption> dataEncryptionSupplier = map.get(objType);
		return  dataEncryptionSupplier.get();
	}
		
		

}
