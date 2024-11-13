package com.icignal.loyalty.benefit.point.service;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import com.icignal.loyalty.membership.dto.response.LoyMbrListNewPageResDto;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonViewService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.RestAPIUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.exception.DataBadRequestException;
import com.icignal.kepler.report.dto.request.KprReportPntReqDto;
import com.icignal.kepler.report.dto.response.KprReportPointOfMonthResDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyMbrPtnTxnHistReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransAddInfoReqDto;
import com.icignal.loyalty.benefit.point.dto.request.LoyTransApiReqDto;
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
import com.icignal.loyalty.benefit.point.mapper.LoyTransMapper;
import com.icignal.loyalty.membership.dto.request.LoyMbrDormancyPntListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrItemReqDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrDormancyPntListResDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrItemResDto;
import com.icignal.loyalty.product.service.LoyProductService;


@Service
public class LoyTransService {

	@Autowired LoyTransMapper loyTransMapper;
	
	@Autowired LoggingHelper loggingHelper;
	
	@Autowired CommonViewService commonViewService;
	
	/**
	 * @programId :
	 * @name : getTransactionList
	 * @date : 2017. 10. 13.
	 * @author : kimjunki
	 * @table : GridPagingResDto
	 * @return : GridPagingResDto
	 * @description : 포인트 거래리스트 조회
	 **/
	public GridPagingResDto<LoyTransListResDto> getTransactionList(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		GridPagingResDto<LoyTransListResDto> rtnList = new GridPagingResDto<LoyTransListResDto>();
		
		if(ObjectUtil.isEmpty(reqDto.getDefaultMbrRid()) 
				&& ObjectUtil.isEmpty(reqDto.getDefaultChnlRid()) 
				&& ObjectUtil.isEmpty(reqDto.getBatchTransIsYn())
	    		&& reqDto.getStrCondWhere().equals("1=1")){
	    	 rtnList.setSuccess(false);
	    	 rtnList.setMessage("조회조건이 충분하지 않습니다.");
	     }else{
	    	

	 	    Integer cnt = (Integer)loyTransMapper.selectTransListCnt(reqDto);
	 	    if(cnt>0){
	 	    	rtnList = new GridPagingResHelper<LoyTransListResDto>().newGridPagingResDto(
	 					reqDto.init(CommonUtil.getInstance().getDBType()),
	 					loyTransMapper.selectTransList(reqDto), AnnotationType.ALL
	 					);
	 	    	
	 	    	rtnList.setRecords(cnt);
	 	    	rtnList.setTotal(cnt);
	 	    }else{
	 	    	rtnList.setTotal(0);
	 	    	rtnList.setRecords(0);
	 	    }
	     }

		
		if(ObjectUtil.isEmpty(reqDto.getDefaultMbrRid()) 
				&& ObjectUtil.isEmpty(reqDto.getDefaultChnlRid()) 
				&& ObjectUtil.isEmpty(reqDto.getBatchTransIsYn())
	    		&& reqDto.getStrCondWhere().equals("1=1")){
	    	 rtnList.setSuccess(false);
	    	 rtnList.setMessage("조회조건이 충분하지 않습니다.");
	     }else{
	    	

	 	    Integer cnt = (Integer)loyTransMapper.selectTransListCnt(reqDto);
	 	    if(cnt>0){
	 	    	rtnList = new GridPagingResHelper<LoyTransListResDto>().newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType()),
	 					loyTransMapper.selectTransList(reqDto),AnnotationType.PersonalData);
	 	    	rtnList.setRecords(cnt);
	 	    	rtnList.setTotal(cnt);
	 	    }else{
	 	    	rtnList.setTotal(0);
	 	    	rtnList.setRecords(0);
	 	    }
	     }
		
	     return new GridPagingResHelper<LoyTransListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectTransList(reqDto),
	    		 AnnotationType.ALL);
	}

	/**
	 * @programId :
	 * @name : getPointDetailPop
	 * @date : 2017. 10. 13.
	 * @author : kimjunki
	 * @table : loy.loy_pnt_txn
	 * @return : GridPagingResDto
	 * @description :포인트 거래 상세 팝업 조회
	 **/
	public GridPagingResDto<LoyTransListResDto> getPointDetailPop(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTransListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.selectPointDtlPop(reqDto),
				AnnotationType.PersonalData);
			
	}

	/**
	 * @programId :
	 * @name : getTransactionDetail
	 * @date : 2017. 10. 13.
	 * @author : kimjunki
	 * @table : loy.loy_pnt_txn
	 * @return : GridPagingResDto
	 * @description : 포인트 거래 상세 조회
	 **/

	public GridPagingResDto<LoyTransDetailResDto> getTransactionDetail(LoyTransDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTransDetailResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.selectTransDtl(reqDto),
				AnnotationType.PersonalData);

	}


	/**
	 * @programId :
	 * @name : getTransArchiveDetail
	 * @date : 2018. 03. 19.
	 * @author : sw.lim
	 * @table : loy.loy_pnt_txn
	 * @return : GridPagingResDto
	 * @description : 과거 포인트 거래 상세 조회
	 **/

	public GridPagingResDto<LoyTransDetailResDto> getTransArchiveDetail(LoyTransDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTransDetailResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.selectTransArchiveDtl(reqDto),
				AnnotationType.PersonalData);
	}

	/**
	 * @programId :
	 * @name : getTransAddInfo
	 * @date : 2017. 10. 13.
	 * @author : kimjunki
	 * @table : loy.loy_pnt_txn
	 * @return : GridPagingResDto
	 * @description :추가 정보 탭 조회
	 */
	public GridPagingResDto<LoyTransAddInfoResDto> getTransAddInfo(LoyTransAddInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTransAddInfoResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.selectTransAddInfo(reqDto),
				AnnotationType.PersonalData);
	}

	/**
	  * @programId :
	  * @name : getTransPromoList
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : lpa.RID_PNT_TXN
	  * @return : GridPagingResDto
	  * @description : 프로모션 항목 조회
	 **/
	public GridPagingResDto<LoyTransPromoListResDto> getTransPromoList(LoyTransPromoListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("mcm");
		return new GridPagingResHelper<LoyTransPromoListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.selectTransPromoList(reqDto),AnnotationType.CommCode);
	}

	/**
	* @programId :
	* @name : getPntTxnItemList
	* @date : 2018. 1. 8.
	* @author : 이성원
	* @table :
	* @return : 
	* @description :유외 상품 조회, 사용하지 않는거 같습니다.
	*/
//	public GridPagingResDto getPntTxnItemList(LoyTransPntItemListReqDto param) {
//		 LogUtil.param(this.getClass(), param);
//		 param.setSVCAlias("a");
//	     GridPagingResDto rtnValue = new GridPagingResDto();
//	     rtnValue = loyTransMapper.getPntTxnItemList(param);
//	     return rtnValue;
//	}
	
//	public GridPagingResDto getTransSearchTestList(LoyTransSearchTestInfoReqDto param) {
//		 LogUtil.param(this.getClass(), param);
//		 param.setSVCAlias("rdm");
//	     GridPagingResDto rtnValue = new GridPagingResDto();
//	     rtnValue = loyTransMapper.getTransSearchTestList(param);
//	     return rtnValue;
//	}
	

	/**
	 * @programId :
	 * @name : excelDownTransaction
	 * @date : 2018. 3. 22.
	 * @author : dgh
	 * @table :
	 * @변경이력 :
	 * @description : 포인트 거래 이력 엑셀 다운로드
	 * @param reqDto
	 * @return
	 */
	public GridPagingResDto<LoyTransListResDto> excelDownTransaction(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
	     return new GridPagingResHelper<LoyTransListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectTransListExcelDown(reqDto),
	    		 AnnotationType.ALL);
	}



	/**
	 * @programId :
	 * @name : clearMaskTrans
	 * @date : 
	 * @author : 
	 * @table :
	 * @변경이력 :	사용하지 않는거 같습니다.
	 * @description : 포인트 거래 이력 마스킹해제
	 * @param reqDto
	 * @return
	 */
	public LoyTransListResDto clearMaskTrans(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
		LoyTransListResDto res =      loyTransMapper.selectClearMaskTrans(reqDto);
	    return new AnnotationHelper<LoyTransListResDto>(AnnotationType.ALL, res).getItem();
	}


	/**
	 * @programId :
	 * @name : pointCancelApiRequest
	 * @date : 
	 * @author : 
	 * @table :
	 * @변경이력 :
	 * @description : 포인트 거래 취소 api 호출
	 * @param reqDto
	 * @return
	 */
	public StatusResDto pointCancelApiRequest(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		LoyTransApiReqDto ltar= new LoyTransApiReqDto();
		LoyTransApiReqDto.Response rtnValue = new LoyTransApiReqDto.Response();

		ltar.setREQ_TYPE("REQ_INT_1016");
		ltar.setSEND_DT(DateUtil.getCurrentDate("yyyyMMdd"));
		ltar.setSEND_TIME(DateUtil.getCurrentDate("HHmmss"));
		ltar.setTR_NO(UUID.randomUUID().toString().replaceAll("-", "").substring(0, 24));
		ltar.setTR_DT(DateUtil.getCurrentDate("yyyyMMdd"));
		ltar.setTR_TIME(DateUtil.getCurrentDate("HHmmss"));
		ltar.setPGM_NO("P000001");
		ltar.setQUERY_CD("M"); 
		ltar.setQUERY_VAL(reqDto.getMbrNo());	//회원번호
		if("100".equals(reqDto.getPntTxnType2code()) ) {
			ltar.setCHNL_CD("GloLiveBO");			//채널명 ex) rental,GloLiveBO
			ltar.setO_TR_ACRL_APPR_DT(reqDto.getApprDate()); //원거래적립승인일자
			ltar.setO_TR_ACRL_APPR_NO(reqDto.getApprNo());	 //원거래 적립 승인번호
			ltar.setO_TR_USE_APPR_DT("");
			ltar.setO_TR_USE_APPR_NO("");
		}else if("200".equals(reqDto.getPntTxnType1code()) ) {
			ltar.setCHNL_CD(reqDto.getChnlNo());			//채널명 ex) rental,GloLiveBO
			ltar.setO_TR_USE_APPR_DT(reqDto.getApprDate());
			ltar.setO_TR_USE_APPR_NO(reqDto.getApprNo());
			ltar.setO_TR_ACRL_APPR_DT("");
			ltar.setO_TR_ACRL_APPR_NO("");
		} 
		ltar.setO_TR_RECEIPT_NO(reqDto.getTxnUniqNo());	 //원거래 영수증번호
		ltar.setRECEIPT_NO(UUID.randomUUID().toString().replaceAll("-", "").substring(0, 24));

		try {
			rtnValue = pointTransApi(ltar);
		}catch (Exception e) {
			throw new DataBadRequestException();
		}

		if(rtnValue == null) {
			LogUtil.error("기기등록 - api 응답 에러");
			throw new DataBadRequestException();
		}
		else if(rtnValue.getHEAD_DATA()!=null) {
			LoyTransApiReqDto.RespHeadData respHead = rtnValue.getHEAD_DATA().get(0);
			if(!respHead.getRST().equals("S")) {

				LogUtil.error("기기등록 - 기타 오류: " + respHead.getRST_MSG());


			} else {

				if(rtnValue.getBODY_DATA()==null || rtnValue.getBODY_DATA().size()==0) {
					LogUtil.error("기기등록 - 기타 오류");
					throw new DataBadRequestException();
				}

			}
		} 

		return rtnValue;
	}
	
	public LoyTransApiReqDto.Response pointTransApi(LoyTransApiReqDto param) throws Exception{
		String apiUrl = CommonUtil.getInstance().getServletProp("loyalty.api.url");
		apiUrl = apiUrl + "/loy_api/point/cancelPoint";

		LoyTransApiReqDto.Response rtnValue	= (LoyTransApiReqDto.Response) RestAPIUtil.jsonPost(apiUrl, param, LoyTransApiReqDto.Response.class);

		if(rtnValue != null && rtnValue.getHEAD_DATA() != null) {
			LoyTransApiReqDto.RespHeadData headDTO = rtnValue.getHEAD_DATA().get(0);

			if(headDTO.getRST().equals("S")) {
				rtnValue.setSuccess(true);
			}
			rtnValue.setMessage(headDTO.getRST_MSG());
		}

		return rtnValue;
	}
	
	
	 /*
	  * 1. 메소드명: getMbrPtnTxnHistList
	  * 2. 클래스명: LoyTransService
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
	public GridPagingResDto<LoyMbrPtnTxnHistResDto> getMbrPtnTxnHistList(LoyMbrPtnTxnHistReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
	     reqDto.setSVCAlias("lpt");
	     
	     return new GridPagingResHelper<LoyMbrPtnTxnHistResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectMbrPtnTxnHistList(reqDto),
	    		 AnnotationType.CommCode);
	}
	
	 /*
	  * 1. 메소드명: getTotAcrlPoint
	  * 2. 클래스명: LoyTransService
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
	public LoyMbrPtnTxnHistResDto getTotAcrlPoint(LoyMbrPtnTxnHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyTransMapper.selectMbrTotAcrlAmt(reqDto);
	}

	 /*
	  * 1. 메소드명: getTotRdmPoint
	  * 2. 클래스명: LoyTransService
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
	public LoyMbrPtnTxnHistResDto getTotRdmPoint(LoyMbrPtnTxnHistReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return loyTransMapper.selectMbrTotRdmAmt(reqDto);
	}
	
	 /*
	  * 1. 메소드명: excelMbrPointTxnList
	  * 2. 클래스명: LoyTransService
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
	public GridPagingResDto<LoyMbrPtnTxnHistResDto> excelMbrPointTxnList(LoyMbrPtnTxnHistReqDto param) {
		LogUtil.param(this.getClass(), param);
		loggingHelper.insertCustReleaLog(param, "LOY_PNT_TXN");  //이력 저장
		param.setSVCAlias("");
		return new GridPagingResHelper<LoyMbrPtnTxnHistResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 loyTransMapper.excelMbrPointTxnList(param),AnnotationType.CommCode);
	}
	
	 /*
	  * 1. 메소드명: getDormancyPntListByMbr
	  * 2. 클래스명: LoyTransService
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
	public GridPagingResDto<LoyMbrDormancyPntListResDto> getDormancyPntListByMbr(LoyMbrDormancyPntListReqDto param) {
        LogUtil.param(this.getClass(), param);
        param.setSVCAlias("lpt");
        return new GridPagingResHelper<LoyMbrDormancyPntListResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 loyTransMapper.selectDormancyPntListByMbr(param));
	}
	
	 /*
	  * 1. 메소드명: viewAvlPoint
	  * 2. 클래스명: LoyTransService
<<<<<<< HEAD
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 4. 20.
=======
	  * 3. 작성자명: 
	  * 4. 작성일자: 
>>>>>>> 6fe0f7791187d11a54c78d0fe2ca9be5672b0cc0
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
	public LoyMbrItemResDto viewAvlPoint(LoyMbrItemReqDto param) throws ParseException {
		LogUtil.param(this.getClass(), param);
		return commonViewService.viewAvlPoint(param);
	}
	
	 /*
	  * 1. 메소드명: getTransSearchTestList
	  * 2. 클래스명: LoyTransService
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
	public GridPagingResDto<LoyTransSearchTestInfoResDto> getTransSearchTestList(LoyTransSearchTestInfoReqDto param) {
		LogUtil.param(this.getClass(), param);
	    param.setSVCAlias("rdm");
	    return new GridPagingResHelper<LoyTransSearchTestInfoResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 loyTransMapper.selectTransSearchTestList(param));
	}
	
	 /*
	  * 1. 메소드명: getPntTxnItemList
	  * 2. 클래스명: LoyTransService
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
	public GridPagingResDto<LoyTransPntItemListResDto> getPntTxnItemList(LoyTransPntItemListReqDto param) {
		LogUtil.param(this.getClass(), param);
	    param.setSVCAlias("a");
	    return new GridPagingResHelper<LoyTransPntItemListResDto>().newGridPagingResDto(
				 param.init(CommonUtil.getInstance().getDBType()),
				 loyTransMapper.selectPntTxnItemList(param));
	}
	
	 /*
	  * 1. 메소드명: getTransactionListExcel
	  * 2. 클래스명: LoyTransService
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
	 *   @param reqDto
	 *   @param request
	 *   @return	
	 */
	public StatusResDto getTransactionListExcel(LoyTransListReqDto reqDto, HttpServletRequest request) {
		LogUtil.param(this.getClass(), reqDto);
		GridPagingResDto<LoyTransListResDto> dataDto = getTransactionList(reqDto);
		return commonViewService.getExcelData(dataDto, reqDto.getExcelObj(), request);
	}

	 /*
	  * 1. 메소드명: getMbrTxnHistList
	  * 2. 클래스명: LoyTransService
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
	
	public GridPagingResDto<LoyPurTxnHistListResDto> getMbrTxnHistList(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		GridPagingResDto<LoyPurTxnHistListResDto> rtnValueCnt = new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType()),loyTransMapper.selectMbrTxnHistListCnt(reqDto));

		int totalCnt = rtnValueCnt.getRows().get(0).getTotalCount();
				
	     return new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectMbrTxnHistList(reqDto),
	    		 AnnotationType.ALL,totalCnt);
	}
	
	public GridPagingResDto<LoyPurTxnHistListResDto> getMbrTxnHistListExcel(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
				
	     return new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectMbrTxnHistListExcel(reqDto),
	    		 AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: clearPutTxnMbr
	  * 2. 클래스명: LoyTransService
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
	
	public LoyPurTxnHistListResDto clearPutTxnMbr(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_mbr"); // 이력 저장
		LoyPurTxnHistListResDto res =      loyTransMapper.clearPutTxnMbr(reqDto);
	    return new AnnotationHelper<LoyPurTxnHistListResDto>(AnnotationType.ALL, res).getItem();
	}

	public GridPagingResDto<LoyTransCpnListResDto> getloyCouponList(LoyTransCpnListReqDto reqDto) {
				LogUtil.param(this.getClass(), reqDto);
				
		 for(int i= 0; i<reqDto.getItem().size();i++) {
	            if("통합".equals(reqDto.getItem().get(i).getWhereVal())) {
	            	reqDto.getItem().get(i).setWhereVal("N");
	            	reqDto.setOfrYn("N");
	            }else if("오프라인".equals(reqDto.getItem().get(i).getWhereVal())) {
	            	reqDto.getItem().get(i).setWhereVal("Y");
	            	reqDto.setOfrYn("Y");
	            }
		 }
		return new GridPagingResHelper<LoyTransCpnListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.getloyCouponList(reqDto),
				AnnotationType.ALL); //CommCode
	}
	
	
	 /*
	  * 1. 메소드명: getMonthOfPoint
	  * 2. 클래스명: LoyTransService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 1. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		트랜잭션 월별 포인트 현황
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return GridPagingResDto
	 */
	public GridPagingResDto<KprReportPointOfMonthResDto> getMonthOfPoint(KprReportPntReqDto reqDto) {
	LogUtil.param(LoyProductService.class, reqDto);
		
	return new GridPagingResHelper<KprReportPointOfMonthResDto>().newGridPagingResDto(
			reqDto.init(CommonUtil.getInstance().getDBType()), loyTransMapper.selectMonthOfPoint(reqDto));
		
	}
	 
	/*
	  * 1. 메소드명: getPurNotMbrTxnHistList
	  * 2. 클래스명: LoyTransService
	  * 3. 작성자명: 2sh.park
	  * 4. 작성일자: 2020. 02. 09
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		비회원 구매
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param request
	 *   @param response
	 *   @param reqDto
	 *   @return GridPagingResDto
	 */
	public GridPagingResDto<LoyPurTxnHistListResDto> getPurNotMbrTxnHistList(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
	     return new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectPurNotMbrTxnHistList(reqDto),
	    		 AnnotationType.ALL);
	}

	public GridPagingResDto<LoyTransPromoListResDto> getPointUseTxnList(LoyTransPromoListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<LoyTransPromoListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyTransMapper.selectPointUseTxnList(param),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: gePurTxnOptionHistList
	  * 2. 클래스명: LoyTransService
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
	
	public GridPagingResDto<LoyPurTxnHistListResDto> getPurTxnOptionHistList(LoyTransListReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);

		GridPagingResDto<LoyPurTxnHistListResDto> rtnValueCnt = new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(reqDto.init(CommonUtil.getInstance().getDBType()),loyTransMapper.selectPurTxnOptionHistListCnt(reqDto));

		int totalCnt = rtnValueCnt.getRows().get(0).getTotalCount();
		
	     return new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectPurTxnOptionHistList(reqDto),
	    		 AnnotationType.ALL,totalCnt);
	}

	 /*
	  * 1. 메소드명: getPurTxnOptionHistExcelList
	  * 2. 클래스명: LoyTransService
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
	
	public GridPagingResDto<LoyPurTxnHistListResDto> getPurTxnOptionHistExcelList(LoyTransListReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
		
	     return new GridPagingResHelper<LoyPurTxnHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectPurTxnOptionHistExcelList(reqDto),
	    		 AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: geProdRevwTxnHistList
	  * 2. 클래스명: LoyTransService
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
	
	public GridPagingResDto<LoyProdRevwHistListResDto> geProdRevwTxnHistList(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
	     return new GridPagingResHelper<LoyProdRevwHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectProdRevwTxnHistList(reqDto),
	    		 AnnotationType.ALL);
	}
	
	public GridPagingResDto<LoyProdRevwHistExcelListResDto> prodRevwHistExcelList(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
	     return new GridPagingResHelper<LoyProdRevwHistExcelListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTransMapper.selectProdRevwExcelHistList(reqDto),
	    		 AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getProdRevwDetail
	  * 2. 클래스명: LoyTransService
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
	
	public LoyProdRevwHistListResDto getProdRevwDetail(LoyTransListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyProdRevwHistListResDto res =    loyTransMapper.selectProdRevwDetail(reqDto);
		return res;
	}




}
