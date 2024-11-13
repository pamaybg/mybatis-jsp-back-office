/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyStampMapper.java
 * 2. Package	: com.icignal.loyalty.stamp.mapper
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 25. 오후 5:26:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 25.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.stamp.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.stamp.dto.request.LoyStampListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpDetailReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpItemDetailReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpItemListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtDeleteReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtInsertReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtRemoveReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreDeleteReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreInsertReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreListReqDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampDetailResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpDetailResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpItemListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpMbrListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpMbrTgtListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpStoreListResDto;

/*
 * 1. 클래스명	: LoyStampMapper
 * 2. 파일명	: LoyStampMapper.java
 * 3. 패키지명	: com.icignal.loyalty.stamp.mapper
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyStampMapper {

	 /*
	  * 1. 메소드명: selectStampTxntListCount
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyStampListResDto> selectStampTxntListCount(LoyStampListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectStampTxntList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyStampListResDto> selectStampTxntList(LoyStampListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectStampDetail
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStampDetailResDto> selectStampDetail(LoyStampListReqDto param);

	 /*
	  * 1. 메소드명: selectStampDetailPop
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStampDetailResDto> selectStampDetailPop(LoyStampListReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStmpListResDto> getLoyStmpList(LoyStmpListReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpDetail
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	LoyStmpDetailResDto getLoyStmpDetail(LoyStmpDetailReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpDetail2
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	LoyStmpDetailResDto getLoyStmpDetail2(LoyStmpDetailReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpItemList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStmpItemListResDto> getLoyStmpItemList(LoyStmpItemListReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpStoreList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStmpStoreListResDto> getLoyStmpStoreList(LoyStmpStoreListReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpStoreList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStmpMbrListResDto> getLoyStmpStoreList(LoyStmpMbrListReqDto param);

	 /*
	  * 1. 메소드명: setLoyStmp
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	void setLoyStmp(LoyStmpDetailReqDto param);

	 /*
	  * 1. 메소드명: setLoyStmpItem
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param stmpItemList	
	 */
	
	void setLoyStmpItem(List<LoyStmpItemDetailReqDto> stmpItemList);

	 /*
	  * 1. 메소드명: removeLoyStmp
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void removeLoyStmp(LoyStmpDetailReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpItemList2
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param stmpItemReq
	 *   @return	
	 */
	
	ArrayList<LoyStmpItemListResDto> getLoyStmpItemList2(LoyStmpItemListReqDto stmpItemReq);

	 /*
	  * 1. 메소드명: getLoyStmpMbrTgtCnt
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param rid
	 *   @return	
	 */
	
	Integer getLoyStmpMbrTgtCnt(String rid);

	 /*
	  * 1. 메소드명: getLoyStmpStoreCnt
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param rid
	 *   @return	
	 */
	
	Integer getLoyStmpStoreCnt(String rid);

	 /*
	  * 1. 메소드명: editLoyStmpStmpStatus
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void editLoyStmpStmpStatus(LoyStmpDetailReqDto param);

	 /*
	  * 1. 메소드명: editLoyStmp
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void editLoyStmp(LoyStmpDetailReqDto param);

	 /*
	  * 1. 메소드명: removeLoyStmpItem
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param stmpItemRmvReq	
	 */
	
	void removeLoyStmpItem(LoyStmpItemDetailReqDto stmpItemRmvReq);

	 /*
	  * 1. 메소드명: editLoyStmpItemPurCntInitialize
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param stmpItemInitReq	
	 */
	
	void editLoyStmpItemPurCntInitialize(LoyStmpItemDetailReqDto stmpItemInitReq);

	 /*
	  * 1. 메소드명: editLoyStmpItem
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void editLoyStmpItem(LoyStmpItemDetailReqDto param);

	 /*
	  * 1. 메소드명: removeLoyStmpStore
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void removeLoyStmpStore(LoyStmpStoreDeleteReqDto param);

	 /*
	  * 1. 메소드명: getStmpItemDetail
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	LoyStmpItemListResDto getStmpItemDetail(LoyStmpItemDetailReqDto param);

	 /*
	  * 1. 메소드명: checkExistLoyStmpStore
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	Integer checkExistLoyStmpStore(LoyStmpStoreInsertReqDto param);

	 /*
	  * 1. 메소드명: setLoyStmpStore
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void setLoyStmpStore(LoyStmpStoreInsertReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpMbrTgtList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyStmpMbrTgtListResDto> getLoyStmpMbrTgtList(LoyStmpMbrTgtListReqDto reqDto);

	 /*
	  * 1. 메소드명: removeLoyStmpMbrTgt
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void removeLoyStmpMbrTgt(LoyStmpMbrTgtRemoveReqDto param);

	 /*
	  * 1. 메소드명: checkExistLoyStmpMbrTgt
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	int checkExistLoyStmpMbrTgt(LoyStmpMbrTgtInsertReqDto param);

	 /*
	  * 1. 메소드명: setLoyStmpMbrTgt
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void setLoyStmpMbrTgt(LoyStmpMbrTgtInsertReqDto param);

	 /*
	  * 1. 메소드명: removeLoyStmpMbrTgt2
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void removeLoyStmpMbrTgt2(LoyStmpMbrTgtDeleteReqDto param);

	 /*
	  * 1. 메소드명: removeLoyStmpItemCamNo
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	
	void removeLoyStmpItemCamNo(LoyStmpItemDetailReqDto param);

	 /*
	  * 1. 메소드명: getLoyStmpMbrList
	  * 2. 클래스명: LoyStampMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	List<LoyStmpMbrListResDto> getLoyStmpMbrList(LoyStmpMbrListReqDto param);

}
