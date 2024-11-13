/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemDatasetMapper.java
 * 2. Package	: com.icignal.systemmanagement.dataset.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 6. 16. 오전 10:44:54
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 6. 16.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.dataset.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetDetailReqDto;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetItemReqDto;
import com.icignal.systemmanagement.dataset.dto.request.SystemDatasetMasterReqDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemDatasetItemListResDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemDatasetListResDto;
import com.icignal.systemmanagement.dataset.dto.response.SystemGetDatasetListResDto;

/*
 * 1. 클래스명	: SystemDatasetMapper
 * 2. 파일명	: SystemDatasetMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.dataset.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 6. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface SystemDatasetMapper {

	 /*
	  * 1. 메소드명: selectDataSetMasterList
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	List<SystemDatasetListResDto> selectDataSetMasterList(SystemDatasetMasterReqDto mlr);

	 /*
	  * 1. 메소드명: deleteDataSet
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	void deleteDataSet(SystemDatasetMasterReqDto reqDto);

	 /*
	  * 1. 메소드명: selectDataSetItem
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	List<SystemDatasetItemListResDto> selectDataSetItem(SystemDatasetMasterReqDto mlr);

	 /*
	  * 1. 메소드명: selectDataSetDetail
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	SystemDatasetListResDto selectDataSetDetail(SystemDatasetMasterReqDto scl);

	 /*
	  * 1. 메소드명: insertDataSet
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	void insertDataSet(SystemDatasetDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateDataSet
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	void updateDataSet(SystemDatasetDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectDataSetItemDetail
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	SystemDatasetItemListResDto selectDataSetItemDetail(SystemDatasetMasterReqDto scl);

	 /*
	  * 1. 메소드명: insertDataSetItem
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	void insertDataSetItem(SystemDatasetItemReqDto reqDto);

	 /*
	  * 1. 메소드명: updateDataSetItem
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	void updateDataSetItem(SystemDatasetItemReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteDataSetItem
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 16.
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
	
	void deleteDataSetItem(SystemDatasetItemReqDto reqDto);
	
	List<SystemGetDatasetListResDto> getDataSetList(SystemDatasetMasterReqDto mlr);
	
	List<SystemGetDatasetListResDto> getDataItemSetList(SystemDatasetMasterReqDto mlr);
	
	/*
	  * 1. 메소드명: getSrcQuery
	  * 2. 클래스명: SystemDatasetMapper
	  * 3. 작성자명: jb.kim 
	  * 4. 작성일자: 2021. 1. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	 : [데이터셋 > 상세] 화면에서 '소스보기'버튼 클릭으로 테이블 소스보는 팝업을 열 시 해당 소스쿼리를 조회하는 메소드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	SystemGetDatasetListResDto getSrcQuery(SystemDatasetMasterReqDto reqDto);

}
