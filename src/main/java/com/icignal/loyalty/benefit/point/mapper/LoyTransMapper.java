package com.icignal.loyalty.benefit.point.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.kepler.report.dto.request.KprReportPntReqDto;
import com.icignal.kepler.report.dto.response.KprReportPointOfMonthResDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyMbrPtnTxnHistReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransAddInfoReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransCpnListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransDetailReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransPntItemListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransPromoListReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransSearchTestInfoReqDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyMbrPtnTxnHistResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyProdRevwHistExcelListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyProdRevwHistListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyPurTxnHistListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransAddInfoResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransCpnListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransDetailResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransPntItemListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransPromoListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransSearchTestInfoResDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrDormancyPntListReqDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrDormancyPntListResDto;


@Mapper
public interface LoyTransMapper {

	Integer selectTransListCnt(LoyTransListReqDto reqDto);

	List<LoyTransListResDto> selectTransList(LoyTransListReqDto reqDto);

	List<LoyTransListResDto> selectPointDtlPop(LoyTransListReqDto reqDto);

	List<LoyTransDetailResDto> selectTransArchiveDtl(LoyTransDetailReqDto reqDto);

	List<LoyTransAddInfoResDto> selectTransAddInfo(LoyTransAddInfoReqDto reqDto);

	List<LoyTransListResDto> selectTransListExcelDown(LoyTransListReqDto reqDto);

	LoyTransListResDto selectClearMaskTrans(LoyTransListReqDto reqDto);

	List<LoyTransDetailResDto> selectTransDtl(LoyTransDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrPtnTxnHistList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	List<LoyMbrPtnTxnHistResDto> selectMbrPtnTxnHistList(LoyMbrPtnTxnHistReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrTotAcrlAmt
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	LoyMbrPtnTxnHistResDto selectMbrTotAcrlAmt(LoyMbrPtnTxnHistReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrTotRdmAmt
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	LoyMbrPtnTxnHistResDto selectMbrTotRdmAmt(LoyMbrPtnTxnHistReqDto reqDto);

	 /*
	  * 1. 메소드명: selectMbrChnlRelList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	List<LoyMbrPtnTxnHistResDto> selectMbrChnlRelList(LoyMbrPtnTxnHistReqDto param);

	 /*
	  * 1. 메소드명: selectDormancyPntListByMbr
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 25.
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
	
	List<LoyMbrDormancyPntListResDto> selectDormancyPntListByMbr(LoyMbrDormancyPntListReqDto param);

	 /*
	  * 1. 메소드명: excelMbrPointTxnList
	  * 2. 클래스명: LoyTransMapper
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
	
	List<LoyMbrPtnTxnHistResDto> excelMbrPointTxnList(LoyMbrPtnTxnHistReqDto param);

	 /*
	  * 1. 메소드명: selectTransPromoList
	  * 2. 클래스명: LoyTransMapper
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
	 *   @param reqDto
	 *   @return	
	 */
	
	List<LoyTransPromoListResDto> selectTransPromoList(LoyTransPromoListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectTransSearchTestList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 20.
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
	
	List<LoyTransSearchTestInfoResDto> selectTransSearchTestList(LoyTransSearchTestInfoReqDto param);

	 /*
	  * 1. 메소드명: selectPntTxnItemList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 20.
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
	
	List<LoyTransPntItemListResDto> selectPntTxnItemList(LoyTransPntItemListReqDto param);

	 /*
	  * 1. 메소드명: selectMbrTxnHistList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 11.
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

	List<LoyPurTxnHistListResDto> selectMbrTxnHistListCnt(LoyTransListReqDto reqDto);

	List<LoyPurTxnHistListResDto> selectMbrTxnHistList(LoyTransListReqDto reqDto);
	
	List<LoyPurTxnHistListResDto> selectMbrTxnHistListExcel(LoyTransListReqDto reqDto);


	 /*
	  * 1. 메소드명: clearPutTxnMbr
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 11.
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
	
	LoyPurTxnHistListResDto clearPutTxnMbr(LoyTransListReqDto reqDto);

	List<LoyTransCpnListResDto> getloyCouponList(LoyTransCpnListReqDto reqDto);

	
	List<KprReportPointOfMonthResDto> selectMonthOfPoint(KprReportPntReqDto reqDto);
	
	/*
	  * 1. 메소드명: selectPurNotMbrTxnHistList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: 2sh.park 
	  * 4. 작성일자: 2020. 02. 09.
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
	
	List<LoyPurTxnHistListResDto> selectPurNotMbrTxnHistList(LoyTransListReqDto reqDto);

	List<LoyTransPromoListResDto> selectPointUseTxnList(LoyTransPromoListReqDto param);

	 /*
	  * 1. 메소드명: selectPurTxnOptionHistList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 27.
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
	
	List<LoyPurTxnHistListResDto> selectPurTxnOptionHistList(LoyTransListReqDto reqDto);

	/*
	 * 1. 메소드명: selectPurTxnOptionHistListCnt
	 * 2. 클래스명: LoyTransMapper
	 */

	List<LoyPurTxnHistListResDto> selectPurTxnOptionHistListCnt(LoyTransListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectPurTxnOptionHistExcelList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 5. 27.
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
	
	List<LoyPurTxnHistListResDto> selectPurTxnOptionHistExcelList(LoyTransListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProdRevwTxnHistList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 7. 6.
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
	
	List<LoyProdRevwHistListResDto> selectProdRevwTxnHistList(LoyTransListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProdRevwExcelHistList
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 7. 6.
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
	
	List<LoyProdRevwHistExcelListResDto> selectProdRevwExcelHistList(LoyTransListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectProdRevwDetail
	  * 2. 클래스명: LoyTransMapper
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2021. 7. 12.
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
	
	LoyProdRevwHistListResDto selectProdRevwDetail(LoyTransListReqDto reqDto);
	
}
