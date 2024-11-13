package com.icignal.common.base.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.request.ComCondLogInsertReqDto;
import com.icignal.common.base.dto.request.CommonCodeReqDto;
import com.icignal.common.base.dto.response.LoyChnlListResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.loyalty.campaign.dto.request.LoyCamMstListReqDto;
import com.icignal.loyalty.channel.dto.response.LoyCamMstListResDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.common.dto.response.LoyMbrMstListResDto;
import com.icignal.loyalty.common.dto.response.LoyPointDtlListResDto;
import com.icignal.loyalty.common.dto.response.LoyPurItemListResDto;
import com.icignal.loyalty.common.dto.response.LoyPurPayListResDto;
import com.icignal.loyalty.common.dto.response.LoyTierGrpListResDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlHistListReqDto;
import com.icignal.loyalty.product.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyPgmListResDto;
import com.icignal.loyalty.product.dto.response.LoyProdListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierNewPageReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewPageResDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.commcode.dto.request.CommonSelectBoxListReqDto;
import com.icignal.systemmanagement.commcode.dto.request.ICNCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.CommonSelectBoxListResDto;
import com.icignal.systemmanagement.commcode.dto.response.ICNCommonCodeResponseDTO;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtListReqDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtListResDto;

@Mapper
public interface CommonViewMapper {

	 /*
	  * 1. 메소드명: selectTierGrpList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyTierGrpListResDto> selectTierGrpList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectChnlList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyChnlListResDto> selectChnlList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectCamMstList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyCamMstListResDto> selectCamMstList(LoyCamMstListReqDto slr);

	 /*
	  * 1. 메소드명: selectCategoryList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyCategoryListResDto> selectCategoryList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectProdList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyProdListResDto> selectProdList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectPgmList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyPgmListResDto> selectPgmList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectMbrMstList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyMbrMstListResDto> selectMbrMstList(LoyCommonReqDto slr);


	 /*
	  * 1. 메소드명: selectPointDtlList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyPointDtlListResDto> selectPointDtlList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectPurItemList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyPurItemListResDto> selectPurItemList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectPurPayList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyPurPayListResDto> selectPurPayList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: clearMaskPurPayDtl
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
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
	
	LoyPurPayListResDto clearMaskPurPayDtl(LoyCommonReqDto reqDto);

	 /*
	  * 1. 메소드명: insertVocActyHist
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param actyDto	
	 */
	
	void insertVocActyHist(LoyMbrChnlHistListReqDto actyDto);

	 /*
	  * 1. 메소드명: getCommCodeList2
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	
	List<ICNCommonCodeResponseDTO> getCommCodeList2(CommonCodeReqDto bccr);

	 /*
	  * 1. 메소드명: getCommCodeList
	  * 2. 클래스명: BaseCommonMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	
	List<ICNCommonCodeResponseDTO> getCommCodeList(ICNCommonCodeRequestDTO bccr);

	 /*
	  * 1. 메소드명: getTransNo
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mapData	
	 */
	
	void getTransNo(HashMap<String, String> mapData);

	 /*
	  * 1. 메소드명: insertComCondLog
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	
	Integer insertComCondLog(ComCondLogInsertReqDto param);

	 /*
	  * 1. 메소드명: selectOfferListPop
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼 목록 조회 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	List<LoyClubOfferListResDto> selectOfferListPop(LoyClubOfferDetailReqDto param);

	 /*
	  * 1. 메소드명: selectSelectBoxList
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 22.
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
	
	List<CommonSelectBoxListResDto> selectSelectBoxList(CommonSelectBoxListReqDto bccr);

	List<LoyTierListNewPageResDto> selectTierList(LoyTierNewPageReqDto bccr);

	 /*
	  * 1. 메소드명: selectChnlMultiList
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyChnlListResDto> selectChnlMultiList(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectChnlMulitExcPopup
	  * 2. 클래스명: CommonViewMapper
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
	 *   @param slr
	 *   @return	
	 */
	
	List<LoyChnlListResDto> selectChnlMulitExcPopup(LoyCommonReqDto slr);

	 /*
	  * 1. 메소드명: selectEmpList
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bagem
	 *   @return	
	 */
	
	List<SystemAuthGroupEmployeeModalResDto> selectEmpList(SystemAuthGroupEmployeeModalReqDto bagem);

	 /*
	  * 1. 메소드명: selectSystemMgtList
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		서비스 관리 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	List<SystemMgtListResDto> selectSystemMgtListPop(SystemMgtListReqDto param);

	 /*
	  * 1. 메소드명: selectMbrListPop
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyMbrListPopResDto> selectMbrListPop(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: getCommCodeItemList
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 12. 30.
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
	
	List<ICNCommonCodeResponseDTO> getCommCodeItemList(CommonCodeReqDto bccr);


	 /*
	  * 1. 메소드명: getCommCodeListNew
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 12. 30.
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
	
	List<ICNCommonCodeResponseDTO> getCommCodeListNew(CommonCodeReqDto bccr);

	 /*
	  * 1. 메소드명: selectOfferIssListPop
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 2. 1.
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
	
	List<LoyClubOfferListResDto> selectOfferIssListPop(LoyClubOfferDetailReqDto param);

	List<LoyClubOfferListResDto> selectOfferListPopVoc(LoyClubOfferDetailReqDto param);
}
