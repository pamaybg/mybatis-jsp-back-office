/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemConditionMapper.java
 * 2. Package	: com.icignal.systemmanagement.condition.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 5. 오후 4:04:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 5.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.condition.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.commcode.dto.request.MKTCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.MKTCommonCodeResponseDTO;
import com.icignal.systemmanagement.condition.dto.request.SystemGetBaseTableListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetConditionDetailReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetConditionListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetDropDownListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetMenuListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemGetSrcColumListReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemModifyConditionReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemRemoveConditionReqDto;
import com.icignal.systemmanagement.condition.dto.request.SystemSetConditionReqDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetBaseTableListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetConditionDetailResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetConditionResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetDropDownListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemGetSrcColumListResDto;
import com.icignal.systemmanagement.condition.dto.response.SystemgetMenuListResDto;

/*
 * 1. 클래스명	: SystemConditionMapper
 * 2. 파일명	: SystemConditionMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.condition.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 5.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface SystemConditionMapper {

	 /*
	  * 1. 메소드명: selectMenuList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mlr
	 *   @return	
	 */
	
	List<SystemgetMenuListResDto> selectMenuList(SystemGetMenuListReqDto mlr);

	 /*
	  * 1. 메소드명: selectConditionList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param clr
	 *   @return	
	 */
	
	List<SystemGetConditionResDto> selectConditionList(SystemGetConditionListReqDto clr);

	 /*
	  * 1. 메소드명: selectDropDownList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param ddl
	 *   @return	
	 */
	
	List<SystemGetDropDownListResDto> selectDropDownList(SystemGetDropDownListReqDto ddl);

	 /*
	  * 1. 메소드명: selectBaseTableList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param btl
	 *   @return	
	 */
	
	List<SystemGetBaseTableListResDto> selectBaseTableList(SystemGetBaseTableListReqDto btl);

	 /*
	  * 1. 메소드명: selectSrcColumList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	List<SystemGetSrcColumListResDto> selectSrcColumList(SystemGetSrcColumListReqDto scl);

	 /*
	  * 1. 메소드명: insertCondition
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scr	
	 */
	
	void insertCondition(SystemSetConditionReqDto scr);

	 /*
	  * 1. 메소드명: selectConditionDetail
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param cdr
	 *   @return	
	 */
	
	SystemGetConditionDetailResDto selectConditionDetail(SystemGetConditionDetailReqDto cdr);

	 /*
	  * 1. 메소드명: updateCondition
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mcr	
	 */
	
	void updateCondition(SystemModifyConditionReqDto mcr);

	 /*
	  * 1. 메소드명: deleteCondition
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param rcr	
	 */
	
	void deleteCondition(SystemRemoveConditionReqDto rcr);

	 /*
	  * 1. 메소드명: selectGroupDetailList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slir
	 *   @return	
	 */
	
	List<MKTCommonCodeResponseDTO> selectGroupDetailList(MKTCommonCodeRequestDTO slir);

	 /*
	  * 1. 메소드명: selectDropDownListColumList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param scl
	 *   @return	
	 */
	
	List<SystemGetSrcColumListResDto> selectDropDownListColumList(SystemGetSrcColumListReqDto scl);

	 /*
	  * 1. 메소드명: callTableList
	  * 2. 클래스명: SystemConditionMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 1.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void callTableList(SystemGetSrcColumListReqDto reqDto);

}
