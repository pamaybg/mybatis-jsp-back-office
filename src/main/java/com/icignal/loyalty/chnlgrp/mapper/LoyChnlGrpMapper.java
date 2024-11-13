/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyChnlGrpMapper.java
 * 2. Package	: com.icignal.loyalty.chnlgrp.mapper
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 7. 14. 오후 5:13:17
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 14.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.chnlgrp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpDetailReqDto;
import com.icignal.loyalty.chnlgrp.dto.request.LoyChnlGrpListReqDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpDetailResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpItemListResDto;
import com.icignal.loyalty.chnlgrp.dto.response.LoyChnlGrpListResDto;

/*
 * 1. 클래스명	: LoyChnlGrpMapper
 * 2. 파일명	: LoyChnlGrpMapper.java
 * 3. 패키지명	: com.icignal.loyalty.chnlgrp.mapper
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 7. 14.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyChnlGrpMapper {

	 /*
	  * 1. 메소드명: selectChnlGrpList
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	List<LoyChnlGrpListResDto> selectChnlGrpList(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectChnlGrpDetail
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	LoyChnlGrpDetailResDto selectChnlGrpDetail(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: insertChnlGrpDetail
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	void insertChnlGrpDetail(LoyChnlGrpDetailReqDto bccr);

	 /*
	  * 1. 메소드명: updateChnlGrpDetail
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	void updateChnlGrpDetail(LoyChnlGrpDetailReqDto bccr);

	 /*
	  * 1. 메소드명: selectChnlItemList
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	List<LoyChnlGrpItemListResDto> selectChnlItemList(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteAllTChnlItem
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	void deleteAllTChnlItem(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteProdItem
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	void deleteChnlItem(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectProdRidCheck
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	LoyChnlGrpListReqDto selectChnlRidCheck(LoyChnlGrpListReqDto lplr);

	 /*
	  * 1. 메소드명: selectProdIdCheck
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	Integer selectChnlIdCheck(LoyChnlGrpListReqDto lplr);


	 /*
	  * 1. 메소드명: insertChnlItem
	  * 2. 클래스명: LoyChnlGrpMapper
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
	 *   @param chnlList	
	 */
	
	void insertChnlItem(LoyChnlGrpListReqDto chnlList);

	 /*
	  * 1. 메소드명: deleteChnlGrp
	  * 2. 클래스명: LoyChnlGrpMapper
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
	
	void deleteChnlGrp(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectChnlExcIdCheck
	  * 2. 클래스명: LoyChnlGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param chnlList
	 *   @return	
	 */
	
	Integer selectChnlExcIdCheck(LoyChnlGrpListReqDto chnlList);

	 /*
	  * 1. 메소드명: insertChnlExc
	  * 2. 클래스명: LoyChnlGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param chnlList	
	 */
	
	void insertChnlExc(LoyChnlGrpListReqDto chnlList);

	 /*
	  * 1. 메소드명: deleteChnlExc
	  * 2. 클래스명: LoyChnlGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	void deleteChnlExc(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: deleteAllTChnlExc
	  * 2. 클래스명: LoyChnlGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	void deleteAllTChnlExc(LoyChnlGrpListReqDto bccr);

	 /*
	  * 1. 메소드명: selectChnlExcList
	  * 2. 클래스명: LoyChnlGrpMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
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
	
	List<LoyChnlGrpItemListResDto> selectChnlExcList(LoyChnlGrpListReqDto bccr);

}
