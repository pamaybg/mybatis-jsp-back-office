package com.icignal.offer.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.request.CommonCodeReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.loyalty.channel.dto.response.LoyChannelListPageResDto;
import com.icignal.loyalty.channel.dto.response.LoyProgramListResDto;
import com.icignal.offer.dto.request.CouponDtlReqDto;
import com.icignal.offer.dto.request.CouponGuideListReqDto;
import com.icignal.offer.dto.request.CouponGuideReqDto;
import com.icignal.offer.dto.request.CouponReqDto;
import com.icignal.offer.dto.request.OfferCouponPoolReqDto;
import com.icignal.offer.dto.request.OfferCpnPoolListCondReqDto;
import com.icignal.offer.dto.request.OfferGroupReqDto;
import com.icignal.offer.dto.request.OfferJoinChnlReqDto;
import com.icignal.offer.dto.request.OfferJoinPgmReqDto;
import com.icignal.offer.dto.request.OfferJoinProdReqDto;
import com.icignal.offer.dto.request.OfferReqDto;
import com.icignal.offer.dto.response.CouponDtlResDto;
import com.icignal.offer.dto.response.CouponGuideResDto;
import com.icignal.offer.dto.response.CouponHistResDto;
import com.icignal.offer.dto.response.CouponResDto;
import com.icignal.offer.dto.response.OfferCouponPoolResDto;
import com.icignal.offer.dto.response.OfferCpnPoolListCondResDto;
import com.icignal.offer.dto.response.OfferGroupResDto;
import com.icignal.offer.dto.response.OfferJoinChnlResDto;
import com.icignal.offer.dto.response.OfferJoinPgmResDto;
import com.icignal.offer.dto.response.OfferJoinProdResDto;
import com.icignal.offer.dto.response.OfferResDto;
import com.icignal.systemmanagement.commcode.dto.response.ICNCommonCodeResponseDTO;

/**
 * 1. FileName	: OfferMapper.java
 * 2. Package	: com.icignal.offer.OfferMapper
 * 3. Comments	:	
 * 4. Author	: 
 * 5. DateTime	: 2020. 6. 10. 오후 4:01:00
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 6. 10.		 | 			|	최초작성

 * -----------------------------------------------------------------

 */
/*
 * 1. 클래스명	: OfferMapper
 * 2. 파일명	: OfferMapper.java
 * 3. 패키지명	: com.icignal.offer.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface OfferMapper {

	List<OfferResDto> selectOfferList(OfferReqDto reqDto);
	
	OfferResDto selectOfferDetail(OfferReqDto reqDto);
	
	void updateOffer(OfferReqDto reqDto);
	
	void insertOffer(OfferReqDto reqDto);

	void updateOfferDel(OfferReqDto reqDto);

	CouponDtlResDto selectCouponDetail(CouponDtlReqDto slr);

	void updateCoupon(CouponDtlReqDto slr);

	void insertCoupon(CouponDtlReqDto slr);

	CouponResDto selectCouponExtAttr(CouponReqDto slr);

	List<CouponHistResDto> selectCpnStatusList(CouponReqDto slr);

	List<OfferJoinPgmResDto> selectOfferJoinPgmList(OfferJoinPgmReqDto reqDto);
	
	void insertOfferJoinPgm(OfferJoinPgmReqDto reqDto);
	
	void updateOfferJoinPgmDel(OfferJoinPgmReqDto reqDto);

	void editCoupGuide(CouponGuideReqDto slr);

	void insertCpnAttr(CouponReqDto slr);

	void updateCpnAttr(CouponReqDto slr);

	CouponResDto selectCouponChk(CouponReqDto slr);

	void insertCouponGuide(CouponGuideListReqDto reqDto);

	List<CouponGuideResDto> selectCouponGuide(CouponReqDto slr);

	void updateCouponGuide(CouponGuideListReqDto reqDto);

	List<OfferJoinChnlResDto> selectOfferJoinChnlList(OfferJoinChnlReqDto reqDto);
	
	void insertOfferJoinChnl(OfferJoinChnlReqDto reqDto);
	
	void updateOfferJoinChnlDel(OfferJoinChnlReqDto reqDto);
	
	void updateOfferJoinAllChnlDel(OfferJoinChnlReqDto reqDto);
	
	List<OfferJoinProdResDto> selectOfferJoinProdList(OfferJoinProdReqDto reqDto); 
	
	List<OfferJoinProdResDto> selectOfferJoinProdNotUsedList(OfferJoinProdReqDto reqDto);
	
	void insertOfferJoinProd(OfferJoinProdReqDto reqDto);
	
	void updateOfferJoinProdDel(OfferJoinProdReqDto reqDto);
	
	void updateOfferJoinAllProdDel(OfferJoinProdReqDto reqDto);
	
	void updateOfferJoinNotAllProdDel(OfferJoinProdReqDto reqDto);

	List<OfferGroupResDto> selectOfferGroupList(OfferGroupReqDto reqDto);
	
	List<OfferCouponPoolResDto> selectOfferCouponPoolList(OfferCouponPoolReqDto reqDto);
	
	OfferCpnPoolListCondResDto selectOfferCpnPoolListCond(OfferCpnPoolListCondReqDto reqDto);

	 /*
	  * 1. 메소드명: updateOfferJoinPgm
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 -프로그램 리스트 상세 수정 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateOfferJoinPgm(OfferJoinPgmReqDto reqDto);
	
	 /*
	  * 1. 메소드명: initOfrCouponDetail
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 상세 쿠폰정책 초기화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void initOfrCouponDetail(CouponDtlReqDto reqDto);
	
	 /*
	  * 1. 메소드명: initOfrCouponGuide
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼&쿠폰 상세 이용안내 초기화
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void initOfrCouponGuide(CouponGuideListReqDto reqDto);

	 /*
	  * 1. 메소드명: chekOfrPgmRel
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼쿠폰 상세 프로그램 탭 프로그램 존재여부 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer chekOfrPgmRel(OfferJoinPgmReqDto reqDto);
	
	List<LoyProgramListResDto> ofrSelectLoyPgmListNew();

	LoyChannelListPageResDto selectOfrChnlListPage(LoyChnlMasterReqDto reqDto);

	void updateOfferProdLimitYCheck(OfferJoinProdReqDto reqDto);

	void updateOfferChnlLimitYCheck(OfferJoinChnlReqDto reqDto);

	Integer selectChkCnt(OfferJoinChnlReqDto reqDto);

	Integer selectChkProdCnt(OfferJoinProdReqDto reqDto);

	Integer selectChkCntY(OfferJoinChnlReqDto reqDto);

	LoyChannelListPageResDto selectOfrProdListPage(LoyChnlMasterReqDto ridProdM);

	Integer selectProdDupChk(LoyChannelListPageResDto prodData);

	Integer selectIsProdData(LoyChannelListPageResDto prodData);

	Integer selectChnlDupChk(LoyChannelListPageResDto chnlRID);

	OfferJoinProdResDto selectOfferProdDupChk(OfferJoinProdReqDto reqDto);

	ArrayList<String> selectOfferProdRidList(OfferJoinProdReqDto reqDto);

	 /*
	  * 1. 메소드명: selectOfrCpnCnt
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 23.
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
	
	int selectOfrCpnCnt(OfferReqDto reqDto);

	 /*
	  * 1. 메소드명: updateOfrStatCdStop
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 23.
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
	
	void updateOfrStatCdStop(OfferReqDto reqDto);

	 /*
	  * 1. 메소드명: updateOfrStatCdStart
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 23.
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
	
	void updateOfrStatCdStart(OfferReqDto reqDto);

	 /*
	  * 1. 메소드명: selectOfferPointCommCodeList
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 26.
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
	
	List<ICNCommonCodeResponseDTO> selectOfferPointCommCodeList(CommonCodeReqDto bccr);

	 /*
	  * 1. 메소드명: selectOfferPointList
	  * 2. 클래스명: OfferMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 4. 26.
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
	
	List<OfferResDto> selectOfferPointList(OfferReqDto reqDto);
	
	String OfflineYCheck(OfferJoinChnlReqDto reqDto);
	
	void updateOfferOfflineYCheck(OfferJoinChnlReqDto reqDto);

}
