/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyProdGrpMapper.java
 * 2. Package	: com.icignal.loyalty.prodgrp.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 13. 오후 5:31:20
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 13.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.prodgrp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.prodgrp.dto.request.LoyCategoryGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpDetailReqDto;
import com.icignal.loyalty.prodgrp.dto.request.LoyProdGrpListReqDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpDetailResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpItemListResDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpListResDto;

/*
 * 1. 클래스명	: LoyProdGrpMapper
 * 2. 파일명	: LoyProdGrpMapper.java
 * 3. 패키지명	: com.icignal.loyalty.prodgrp.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyProdGrpMapper {

	 /*
	  * 1. 메소드명: selectProdGrpList
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyProdGrpListResDto> selectProdGrpList(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectProdGrpDetail
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	LoyProdGrpDetailResDto selectProdGrpDetail(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: insertProdGrpDetail
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void insertProdGrpDetail(LoyProdGrpDetailReqDto bccr);

	 /*
	  * 1. 메소드명: updateProdGrpDetail
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void updateProdGrpDetail(LoyProdGrpDetailReqDto bccr);

	 /*
	  * 1. 메소드명: selectProdItemList
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyProdGrpItemListResDto> selectProdItemList(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteAllTProdItem
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteAllTProdItem(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteProdItem
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteProdItem(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectProdIdCheck
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lplr
	 *   @return	
	 */
	
	Integer selectProdIdCheck(LoyProdGrpListReqDto prodRid);

	 /*
	  * 1. 메소드명: insertProdItem
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param prodList	
	 */
	
	void insertProdItem(LoyProdGrpListReqDto prodList);

	 /*
	  * 1. 메소드명: selectProdRidCheck
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lplr
	 *   @return	
	 */
	
	String selectProdRidCheck(LoyProdGrpListReqDto lplr);

	 /*
	  * 1. 메소드명: selectProdXmCnt
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param batchUpload
	 *   @return	
	 */
	
	Integer selectProdXmCnt(LoyProdGrpListReqDto batchUpload);

	 /*
	  * 1. 메소드명: updateProdXmCnt
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param prodXmCnt	
	 */
	
	void updateProdXmCnt(LoyProdGrpListReqDto batchUpload);

	 /*
	  * 1. 메소드명: selectCategoryList
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	List<LoyCategoryListResDto> selectCategoryList(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectCatRidCheck
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lplr
	 *   @return	
	 */
	
	String selectCatRidCheck(LoyCategoryGrpListReqDto lplr);

	 /*
	  * 1. 메소드명: selectCatIdCheck
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param lplr
	 *   @return	
	 */
	
	Integer selectCatIdCheck(LoyCategoryGrpListReqDto lplr);

	 /*
	  * 1. 메소드명: deleteCategory
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteCategory(LoyProdGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteAllTCategory
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteAllTCategory(LoyProdGrpListReqDto bccr);


	 /*
	  * 1. 메소드명: insertCategory
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param prodList	
	 */
	
	void insertCategory(LoyCategoryGrpListReqDto prodList);

	 /*
	  * 1. 메소드명: insertCategoryItem
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param prodList	
	 */
	
	void insertCategoryItem(LoyCategoryGrpListReqDto prodList);

	 /*
	  * 1. 메소드명: deleteProdGrp
	  * 2. 클래스명: LoyProdGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr	
	 */
	
	void deleteProdGrp(LoyProdGrpListReqDto bccr);
	
	List<LoyProdGrpItemListResDto> getProdListItemPop(LoyProdGrpListReqDto bccr);

	List<LoyProdGrpItemListResDto> getGiftsPopList(LoyProdGrpListReqDto reqDto);


}
