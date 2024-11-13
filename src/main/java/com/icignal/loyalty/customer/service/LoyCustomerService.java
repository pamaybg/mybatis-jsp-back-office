/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyCustmerService.java
 * 2. Package	: com.icignal.loyalty.custmer.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 21. 오후 3:58:09
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 21.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.customer.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.customer.dto.request.LOYCustAddInfoReqDto;
import com.icignal.loyalty.customer.dto.request.LOYCustReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustAgreHistListReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBnftReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustBranchReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustDetailMbrReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustMbrRelReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustNewReqDto;
import com.icignal.loyalty.customer.dto.request.LoyCustSettleReqDto;
import com.icignal.loyalty.customer.dto.response.LOYCustAddInfoResDto;
import com.icignal.loyalty.customer.dto.response.LOYCustResDto;
import com.icignal.loyalty.customer.dto.response.LOYMemberResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrDtlResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrResDto;
import com.icignal.loyalty.customer.dto.response.LoyCertCustResDto;
import com.icignal.loyalty.customer.dto.response.LoyCorpDetailResDto;
import com.icignal.loyalty.customer.dto.response.LoyCorporationCustResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAgreHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAgreListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAlterHistResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustAppHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBnftResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustBranchResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustChangeHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailMbrListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailNewResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustDetailResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustLoginInfoListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustLoginListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustMbrRelResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustNewResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustSettleResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustSvrHistListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCustWebHistListResDto;
import com.icignal.loyalty.customer.mapper.LoyCustomerMapper;
import com.icignal.loyalty.membership.dto.response.LoyMbrSegmentHistListResDto;



/*
 * 1. 클래스명	: LoyCustmerService
 * 2. 파일명	: LoyCustmerService.java
 * 3. 패키지명	: com.icignal.loyalty.custmer.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyCustomerService {
	
	@Autowired 
	LoyCustomerMapper loyCustomerMapper;
	
	@Autowired
	LoggingHelper loggingService;
	
	
	 /*
	  * 1. 메소드명: getCustList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 * 고객 목록 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustNewResDto> getCustList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    //reqDto.setSVCAlias("a");
	    
	    return new GridPagingResHelper<LoyCustNewResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCustListPage(reqDto),AnnotationType.ALL);
	}



    /**
     * @programId : PLOY_004
     * @name : getCustDetail
     * @date : 2016. 12. 13.
     * @author : 이경남
     * @table : loy.loy_cust
     * @param : LOYCustRequestDTO.rid
     * @return : LOYCustResponseDTO
     * @description : 고객 상세 조회
     */
	public LoyCustDetailResDto getCustDetail(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		LoyCustDetailResDto res = loyCustomerMapper.selectCust(reqDto);
		
		return   new AnnotationHelper<LoyCustDetailResDto>(AnnotationType.ALL, res).getItem();
	}


	/**
     * @programId : PLOY_004
     * @name : updatePgm
     * @date : 2016. 12. 13.
     * @author : 이경남
     * @table : loy.loy_cust
     * @param : LOYCustRequestDTO
     * @return : StatusResDto
     * @description : 고객 상세 수정
     */
	public StatusResDto updateCust(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		loyCustomerMapper.updateCust(reqDto);

        rtnValue.setSuccess(true);

        //승인서버 데이터 동기화
        //iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_CUST, reqDto.getRid(), DATA_SYNC_TYPE.U);

        return rtnValue;
	}


	/**
     * @programId : PLOY_004
     * @name : insertPgm
     * @date : 2016. 12. 13.
     * @author : 이경남
     * @table : loy.loy_cust
     * @param : LOYCustRequestDTO
     * @return : StatusResDto
     * @description : 고객 등록
     */
	public StatusResDto insertCust(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setRid(CommonUtil.newRid());
        reqDto.setSVCAlias("");
        StatusResDto rtnValue = new StatusResDto();
        rtnValue = duplCust(reqDto);
        if ( rtnValue.getSuccess() ) {
	       	loyCustomerMapper.insertCust(reqDto);
	        rtnValue.setSuccess(true);
	        //승인서버 데이터 동기화
	        //iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_CUST, reqDto.getRid(), DATA_SYNC_TYPE.I);
	    }else{
	      	rtnValue.setMessage(Messages.getMessage("L00001", reqDto.getLang()));
	       	rtnValue.setSuccess(false);
        }
        return rtnValue;
	}

	 /*
	  * 1. 메소드명: duplCust
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 24.
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
	public StatusResDto duplCust(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto status = new StatusResDto();
		int result = loyCustomerMapper.duplCust(reqDto);

		if(result > 0 ) {
	    	  status.setSuccess(false);
	    	  status.setErrorType(IFVMErrorHelper.CUST_DUPLICATION_CHCK);
	    	  return status;
	      }

	      status.setSuccess(true);
	      return status;
	}


	/**
     * @programId : PLOY_004
     * @name : delCust
     * @date : 2016. 12. 13.
     * @author : 이경남
     * @table : loy.loy_cust
     * @param : LOYCustRequestDTO
     * @return : StatusResDto
     * @description : 고객 삭제
     */
	public StatusResDto delCust(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCustomerMapper.updateCustDel(reqDto);
		rtnValue.setSuccess(false);
		return rtnValue;
	}


	/**
     * @programId : PLOY_003
     * @name : clearMaskCust
     * @date : 2016. 12. 13.
     * @author : 이경남
     * @table : loy.loy_cust
     * @param : LOYCustRequestDTO
     * @return :
     * @description : 고객 마스킹해제 정보
     */
	public LOYCustResDto clearMaskCust(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingService.insertCustReleaLog(reqDto, "loy_cust");  //이력 저장
		
		reqDto.setSVCAlias("a");
		LOYCustResDto resDto =  loyCustomerMapper.clearMaskCust(reqDto);
		return   new AnnotationHelper<LOYCustResDto>(AnnotationType.ALL, resDto).getItem();
	}


	/**
     * @programId : PLOY_005
     * @name : getCustAddInfoList
     * @date : 2016. 12. 16.
     * @author : 이경남
     * @table : loy.cust_add_info
     * @param : LOYCustRequestDTO
     * @return :
     * @description : 고객 부가정보
     */
	public GridPagingResDto<LOYCustAddInfoResDto> getCustAddInfoList(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		
		return new GridPagingResHelper<LOYCustAddInfoResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCustAddInfoList(reqDto),AnnotationType.CommCode);
	}

	/**
	  * @programId :
	  * @name : getMemberList
	  * @date : 2016. 12. 16.
	  * @author : knlee
	  * @return :
	  * @변경이력 :
	  * @description :
	  * @param reqDto
	  * @return
	  */
	public GridPagingResDto<LOYMemberResDto> getMemberList(LOYCustReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		
		return new GridPagingResHelper<LOYMemberResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectMemberList(reqDto),AnnotationType.CommCode);
	}



	/**
	  * @programId : PLOY_005_01
	  * @name : getCustAddInfoDetail
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객 부가정보 상세 조회
	  * @param reqDto
	  * @return
	  */
	public LOYCustAddInfoResDto getCustAddInfoDetail(LOYCustAddInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("a");
		
		return loyCustomerMapper.selectCustAddInfo(reqDto);
	}



	/**
	  * @programId :
	  * @name : insertCustAddInfo
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객 부가정보 추가
	  * @param reqDto
	  * @return
	  */
	public StatusResDto insertCustAddInfo(LOYCustAddInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		
		StatusResDto rtnValue = new StatusResDto();
		reqDto.setRid(CommonUtil.newRid());
		loyCustomerMapper.insertCustAddInfo(reqDto);
        rtnValue.setSuccess(true);

        //승인서버 데이터 동기화
        //iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_CUST_ADD_INFO, reqDto.getRid(), DATA_SYNC_TYPE.I);

        return rtnValue;
	}



	/**
	  * @programId :
	  * @name : updateCustAddInfo
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객 부가정보 수정
	  * @param reqDto
	  * @return
	  */
	public StatusResDto updateCustAddInfo(LOYCustAddInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		
		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustAddInfo(reqDto);

        //승인서버 데이터 동기화
        //iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_CUST_ADD_INFO, reqDto.getRid(), DATA_SYNC_TYPE.U);
		rtnValue.setSuccess(true);
		
		return rtnValue;		
	}



	/**
	  * @programId :
	  * @name : delCustAddInfo
	  * @date : 2016. 12. 19.
	  * @author : knlee
	  * @table :
	  * @변경이력 :
	  * @description : 고객부가정보 삭제
	  * @param reqDto
	  * @return
	  */
	public StatusResDto delCustAddInfo(LOYCustAddInfoReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");

		StatusResDto rtnValue = new StatusResDto();
		
		loyCustomerMapper.updateCustAddInfoDel(reqDto);
        //승인서버 데이터 동기화
        //iMKTInterfaceService.loySyncDataSend(DATA_SYNC_TASK.LOY_CUST_ADD_INFO, reqDto.getRid(), DATA_SYNC_TYPE.U);

		rtnValue.setSuccess(true);
		return rtnValue;
	}



	 /*
	  * 1. 메소드명: getCustListPage
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 23.
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
	
	public GridPagingResDto<LoyCustNewResDto> getCustListPage(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    //reqDto.setSVCAlias("a");
	    
	    return new GridPagingResHelper<LoyCustNewResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCustListPage(reqDto),AnnotationType.ALL);
	}



	 /*
	  * 1. 메소드명: getCustDetailNewPage
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 23.
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
	
	public LoyCustDetailNewResDto getCustDetailNewPage(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	    //reqDto.setSVCAlias("a");
		LoyCustDetailNewResDto resDto = loyCustomerMapper.selectCustDetailNewPage(reqDto);
		return   new AnnotationHelper<LoyCustDetailNewResDto>(AnnotationType.ALL, resDto).getItem();
	}



	 /*
	  * 1. 메소드명: getCorpCustListPage
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	public GridPagingResDto<LoyCorporationCustResDto> getCorpCustListPage(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

	    return new GridPagingResHelper<LoyCorporationCustResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCorpCustListPage(reqDto),AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getCorpCustDetailNewPage
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	public LoyCorpDetailResDto getCorpCustDetailNewPage(LoyCustNewReqDto reqDto) {
		//LogUtil.param(this.getClass(), reqDto);
	    //reqDto.setSVCAlias("a");
		LoyCorpDetailResDto resDto = loyCustomerMapper.selectCorpCustDetailNewPage(reqDto);
		return   new AnnotationHelper<LoyCorpDetailResDto>(AnnotationType.ALL, resDto).getItem();
	}



	 /*
	  * 1. 메소드명: clearMaskCustList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	public LoyCustNewResDto clearMaskCustList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingService.insertCustReleaLog(reqDto, "CUST_BEFORE_DORMANT_LIST"); // 이력 저장
		LoyCustNewResDto resDto = loyCustomerMapper.clearMaskCustList(reqDto);
		return   new AnnotationHelper<LoyCustNewResDto>(AnnotationType.ALL, resDto).getItem();
	}



	 /*
	  * 1. 메소드명: clearMaskCorpCustList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 27.
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
	
	public LoyCorporationCustResDto clearMaskCorpCustList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyCorporationCustResDto resDto = loyCustomerMapper.clearMaskCorpCustList(reqDto);
		return   new AnnotationHelper<LoyCorporationCustResDto>(AnnotationType.ALL, resDto).getItem();
	}



	 /*
	  * 1. 메소드명: getCertList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	
	public GridPagingResDto<LoyCertCustResDto> getCertList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCertCustResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCertList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getCustLoginList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 28.
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
	
	public GridPagingResDto<LoyCustLoginListResDto> getCustLoginList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		String custNo = (String) loyCustomerMapper.selectCustRid(reqDto);
		reqDto.setCustNo(custNo);
		reqDto.setSVCAlias("lcwh");
		return new GridPagingResHelper<LoyCustLoginListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCustLoginList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getCustAgreList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 4. 29.
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
	
	public GridPagingResDto<LoyCustAgreListResDto> getCustAgreList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustAgreListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCustAgreList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getCustAgreHistList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 6.
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
	
	public GridPagingResDto<LoyCustAgreHistListResDto> getCustAgreHistList(LoyCustAgreHistListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustAgreHistListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyCustomerMapper.selectCustAgreHistList(reqDto),AnnotationType.CommCode);
	}
	
	 /*
	  * 1. 메소드명: getCustSvrHistList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 10.
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
	public GridPagingResDto<LoyCustSvrHistListResDto> getCustSvrHistList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustSvrHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyCustomerMapper.selectCustSvrHistList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getAlterSvrHistList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 11.
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
	
	public GridPagingResDto<LoyCustAlterHistResDto> getAlterSvrHistList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustAlterHistResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), 
				loyCustomerMapper.selectAlterSvrHistList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getAppSvrHistList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 11.
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
	
	public GridPagingResDto<LoyCustAppHistListResDto> getAppSvrHistList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustAppHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), 
				loyCustomerMapper.selectAppSvrHistList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getChangeHistList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 11.
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
	
	public GridPagingResDto<LoyCustChangeHistListResDto> getChangeHistList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustChangeHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), 
				loyCustomerMapper.selectChangeHistList(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getCustDetailMbrList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상세 회원 리스트 탭
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustDetailMbrListResDto> getCustDetailMbrList(LoyCustDetailMbrReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustDetailMbrListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCustDetailMbrList(reqDto), AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getCustLoginInfo
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 6. 13.
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
	
	public GridPagingResDto<LoyCustLoginInfoListResDto> getCustLoginInfo(LoyCustDetailMbrReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustLoginInfoListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCustLoginInfo(reqDto), AnnotationType.ALL);
	}

	/*
	 * 1. 메소드명: getCustList
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: jh.seo
	 * 4. 작성일자: 2020. 2. 24.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 * 고객 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyCustMbrRelResDto> getCustMbrRelList(LoyCustMbrRelReqDto  reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCustMbrRelResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCustMbrRelList(reqDto),AnnotationType.ALL);
	}


	/*
	 * 1. 메소드명: getCustBranchList
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyCustBranchResDto> getCustBranchList(LoyCustBranchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCustBranchResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyCustomerMapper.selectCustBranchList(reqDto));
	}

	/*
	 * 1. 메소드명: getCustBranchDetail
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCustBranchResDto getCustBranchDetail(LoyCustBranchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyCustomerMapper.selectCustBranchDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateCustBranch
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateCustBranch(LoyCustBranchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustBranch(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertCustBranch
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto insertCustBranch(LoyCustBranchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.insertCustBranch(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: delCustBranch
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 브랜치 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto delCustBranch(LoyCustBranchReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustBranchDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}


	/*
	 * 1. 메소드명: getCustSettleDetail
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCustSettleResDto getCustSettleDetail(LoyCustSettleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyCustomerMapper.selectCustSettleDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateCustSettle
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateCustSettle(LoyCustSettleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustSettle(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertCustSettle
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto insertCustSettle(LoyCustSettleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.insertCustSettle(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: delCustSettle
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 정산 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto delCustSettle(LoyCustSettleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustSettleDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/*
	 * 1. 메소드명: getCustBnftList
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 23.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 목록 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public GridPagingResDto<LoyCustBnftResDto> getCustBnftList(LoyCustBnftReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCustBnftResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyCustomerMapper.selectCustBnftList(reqDto));
	}

	/*
	 * 1. 메소드명: getCustBnftDetail
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public LoyCustBnftResDto getCustBnftDetail(LoyCustBnftReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		return loyCustomerMapper.selectCustBnftDetail(reqDto);
	}

	/*
	 * 1. 메소드명: updateCustBnft
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 5. 21.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 수정
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto updateCustBnft(LoyCustBnftReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustBnft(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: insertCustBnft
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 등록
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto insertCustBnft(LoyCustBnftReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		reqDto.setRid(CommonUtil.newRid());

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.insertCustBnft(reqDto);

		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: delCustBnft
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: nhlee
	 * 4. 작성일자: 2020. 6. 4.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		법인 고객 혜택 삭제
	 * 2. 사용법
	 *
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 */
	public StatusResDto delCustBnft(LoyCustBnftReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);

		StatusResDto rtnValue = new StatusResDto();
		loyCustomerMapper.updateCustBnftDel(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}


	public GridPagingResDto<LoyMbrSegmentHistListResDto> getCustSegmentRuleHist(LOYCustReqDto reqDto) {
		return new GridPagingResHelper<LoyMbrSegmentHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), 
				loyCustomerMapper.selectCustSegmentRuleHist(reqDto),AnnotationType.CommCode);
	}



	 /*
	  * 1. 메소드명: getCustWebHistList
	  * 2. 클래스명: LoyCustomerService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 상세 - 서비스 이용내역 - 웹이용내역 상세이력 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustWebHistListResDto> getCustWebHistList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustWebHistListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCustWebHistList(reqDto),AnnotationType.ALL);
	}


	/*
	 * 1. 메소드명: getCafe24MemList
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 20
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param reqDto
	 * @param
	 * @param 
	 * @return
	 */
	public GridPagingResDto<LoyCafe24MbrResDto> getCafe24MemList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCafe24MbrResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCafe24MemList(reqDto),AnnotationType.ALL);
	}

	/*
	 * 1. 메소드명: getCafe24MemListExcel
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 12. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param reqDto
	 * @param
	 * @param 
	 * @return
	 */
	public GridPagingResDto<LoyCafe24MbrDtlResDto> getCafe24MemListExcel(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCafe24MbrDtlResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCafe24MemListExcel(reqDto),AnnotationType.ALL);
	}


	/*
	 * 1. 메소드명: getCafe24MemDetail
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 26
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 상세 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param reqDto
	 * @param
	 * @param 
	 * @return
	 */
	public LoyCafe24MbrDtlResDto getCafe24MemDetail(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		LoyCafe24MbrDtlResDto resDto = loyCustomerMapper.selectCafe24MemDetail(reqDto);
		
		return new AnnotationHelper<LoyCafe24MbrDtlResDto>(AnnotationType.ALL,resDto).getItem();
	}
	
	
	/*
	 * 1. 메소드명: getCafe24MbrCamHist
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 11. 26
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 캠페인 이력 조회
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param reqDto
	 * @param
	 * @param 
	 * @return
	 */
	public GridPagingResDto<LoyCafe24MbrResDto> getCafe24MbrCamHist(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyCafe24MbrResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectCafe24MbrCamHist(reqDto),AnnotationType.CommCode);
	}

	
	/*
	 * 1. 메소드명: clearMaskCf24MbrList
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: yj.choi
	 * 4. 작성일자: 2020. 12. 09
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		카페 24 회원 마스킹해제
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param reqDto
	 * @param
	 * @param 
	 * @return
	 */

	public LoyCafe24MbrResDto clearMaskCf24MbrList(LoyCustNewReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingService.insertCustReleaLog(reqDto, "loy_lnl_cf24_mbr");  //이력 저장
		
		LoyCafe24MbrResDto resDto = loyCustomerMapper.selectClearMaskCf24(reqDto);
		
		return  new AnnotationHelper<LoyCafe24MbrResDto>(AnnotationType.ALL,resDto).getItem();

	}
	
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
	
	public GridPagingResDto<LoyCustLoginInfoListResDto> getMobileCustLoginInfo(LoyCustDetailMbrReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustLoginInfoListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectMobileCustLoginInfo(reqDto), AnnotationType.ALL);
	}
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
	
	public GridPagingResDto<LoyCustLoginInfoListResDto> getMbrMobileLoginPopGrid(LoyCustDetailMbrReqDto reqDto) {
		LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustLoginInfoListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.selectMbrMobileLoginPopGrid(reqDto), AnnotationType.ALL);
	}


	
	/*
	 * 1. 메소드명: loginFailCntInit
	 * 2. 클래스명: LoyCustomerService
	 * 3. 작성자명: 2sh.park
	 * 4. 작성일자: 2021. 03. 22
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로그인 실패 횟수 초기화
	 * 2. 사용법
	 *
	 * </PRE>
	 *
	 * @param reqDto
	 * @param
	 * @param 
	 * @return
	 */

	public GridPagingResDto<LoyCustLoginInfoListResDto> loginFailCntInit(LoyCustDetailMbrReqDto reqDto) {
			LogUtil.param(this.getClass(),reqDto);
		
		return new GridPagingResHelper<LoyCustLoginInfoListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustomerMapper.updateLoginFailCnt(reqDto), AnnotationType.ALL);
	}
		

}
