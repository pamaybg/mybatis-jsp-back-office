/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCouponMapper.java
 * 2. Package	: com.icignal.loyalty.stamp.mapper
 * 3. Comments	:
 * 4. Author	: jk.kim
 * 5. DateTime	: 2020. 7. 9. 오후 5:26:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 7. 9.		 | jk.kim			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.coupon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.coupon.dto.request.LoyCouponDetailReqDto;
import com.icignal.loyalty.coupon.dto.request.LoyCouponListReqDto;
import com.icignal.loyalty.coupon.dto.response.LOYCpnPayUploadResDto;
import com.icignal.loyalty.coupon.dto.response.LoyCouponListResDto;
import com.icignal.loyalty.coupon.dto.response.LoyCpnOfferResDto;
import com.icignal.loyalty.stamp.dto.request.LoyStampListReqDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampListResDto;

/*
 * 1. 클래스명	: LoyCouponMapper
 * 2. 파일명	: LoyCouponMapper.java
 * 3. 패키지명	: com.icignal.loyalty.coupon.mapper
 * 4. 작성자명	: jk.kim
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface LoyCouponMapper {

	 /*
	  * 1. 메소드명: selectStampTxntListCount
	  * 2. 클래스명: LoyCouponMapper
	  * 3. 작성자명: jk.kim
	  * 4. 작성일자: 2020. 7. 9.
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
	  * 2. 클래스명: LoyCouponMapper
	  * 3. 작성자명: jk.kim
	  * 4. 작성일자: 2020. 7. 9.
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

	void insertPaymentCouponHeader(LOYCpnPayUploadResDto reqDto);

	List<LoyCouponListResDto> selectCouponUploadList(LoyCouponListReqDto reqDto);

	public void callSaveMbrCoupon(LoyCouponDetailReqDto param);

	public void callUseMbrCoupon(LoyCouponDetailReqDto param);

	public void callSaveCnclMbrCoupon(LoyCouponDetailReqDto param);

	public void callUseCnclMbrCoupon(LoyCouponDetailReqDto param);

	LoyCpnOfferResDto selectCpnOffer(LoyCouponDetailReqDto param);

	LoyCpnOfferResDto selectCpnChnl(LoyCouponDetailReqDto param);

}
