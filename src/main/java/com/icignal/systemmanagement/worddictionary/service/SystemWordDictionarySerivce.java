package com.icignal.systemmanagement.worddictionary.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.worddictionary.dto.request.SystemWordDictionaryReqDto;
import com.icignal.systemmanagement.worddictionary.dto.response.SystemWordDictionaryResDto;
import com.icignal.systemmanagement.worddictionary.mapper.SystemWordDictionaryMapper;

/*
 * 1. 클래스명	: SystemWordDictionarySerivce
 * 2. 파일명	: SystemWordDictionarySerivce.java
 * 3. 패키지명	: com.icignal.systemmanagement.worddictionary.service
 * 4. 작성자명	: seungjun
 * 5. 작성일자	: 2020. 4. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service
public class SystemWordDictionarySerivce {

	@Autowired
	SystemWordDictionaryMapper systemWordDictionaryMapper;
	
	 /*
	  * 1. 메소드명: getWordDictionaryList
	  * 2. 클래스명: SystemWordDictionarySerivce
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemWordDictionaryResDto> getWordDictionaryList(SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("wd");
		return new GridPagingResHelper<SystemWordDictionaryResDto>().newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType()), systemWordDictionaryMapper.selectWordDictionary(reqDto));
	}


	 /*
	  * 1. 메소드명: getWordDicDetail
	  * 2. 클래스명: SystemWordDictionarySerivce
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public SystemWordDictionaryResDto getWordDicDetail(SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("wd");
		return systemWordDictionaryMapper.selectWordDicDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getWordDictionaryChk
	  * 2. 클래스명: SystemWordDictionarySerivce
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 중복체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public SystemWordDictionaryResDto getWordDictionaryChk(SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("wd");
		
		return systemWordDictionaryMapper.getWordDictionaryChk(reqDto);
	}

	
	 /*
	  * 1. 메소드명: setWordDictionary
	  * 2. 클래스명: SystemWordDictionarySerivce
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 17.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 데이터 삽입
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto setWordDictionary(SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		String rid = CommonUtil.newRid();
		reqDto.setRid(rid);

		systemWordDictionaryMapper.insertWordDictionary(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
		
	}
		
	 /*
	  * 1. 메소드명: editWordDictionary
	  * 2. 클래스명: SystemWordDictionarySerivce
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 데이터 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editWordDictionary(SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		systemWordDictionaryMapper.updateWordDictionary(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}
	
	 /*
	  * 1. 메소드명: delWordDictionary
	  * 2. 클래스명: SystemWordDictionarySerivce
	  * 3. 작성자명: seungjun 
	  * 4. 작성일자: 2020. 4. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		용어사전 데이터 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto delWordDictionary(SystemWordDictionaryReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnVal = new StatusResDto();
		systemWordDictionaryMapper.deleteWordDictionary(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	}
	
}



