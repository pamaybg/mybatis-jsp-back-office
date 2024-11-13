package com.icignal.systemmanagement.worddictionary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.worddictionary.dto.request.SystemWordDictionaryReqDto;
import com.icignal.systemmanagement.worddictionary.dto.response.SystemWordDictionaryResDto;

/*
 * 1. 클래스명	: SystemWordDictionaryMapper
 * 2. 파일명	: SystemWordDictionaryMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.worddictionary.mapper
 * 4. 작성자명	: seungjun
 * 5. 작성일자	: 2020. 4. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *		용어사전 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemWordDictionaryMapper {

	List<SystemWordDictionaryResDto> selectWordDictionary(SystemWordDictionaryReqDto reqDto);
	
	SystemWordDictionaryResDto selectWordDicDetail(SystemWordDictionaryReqDto reqDto);
	
	SystemWordDictionaryResDto getWordDictionaryChk (SystemWordDictionaryReqDto reqDto);
	
	void insertWordDictionary(SystemWordDictionaryReqDto reqDto);
	
	void updateWordDictionary(SystemWordDictionaryReqDto reqDto);
	
	void deleteWordDictionary(SystemWordDictionaryReqDto reqDto);
	
}
