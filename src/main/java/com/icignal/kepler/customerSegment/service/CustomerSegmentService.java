package com.icignal.kepler.customerSegment.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.kepler.customerSegment.dto.request.CustSegMartReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegStageReqDto;
import com.icignal.kepler.customerSegment.dto.request.CustSegmentRuleReqDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegMartResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegStageResDto;
import com.icignal.kepler.customerSegment.dto.response.CustSegmentRuleResDto;
import com.icignal.kepler.customerSegment.mapper.CustomerSegmentMapper;
import com.icignal.kepler.segment.dto.request.KprCopySegmentReqDto;
import com.icignal.kepler.segment.dto.request.KprLogicalComponentDBInfoReqDto;
import com.icignal.kepler.segment.dto.request.KprSegmentListReqDto;
import com.icignal.kepler.segment.dto.response.KprSegmentListResDto;
import com.icignal.kepler.segment.service.KprSegmentService;

@Service("CustomerSegmentService")
public class CustomerSegmentService {
	@Autowired
	CustomerSegmentMapper customerSegmentMapper;

	@Autowired
	public MKTCallQueryDao mktCallQuery;
	
    @Autowired
    private KprSegmentService iKPRSegmentService;
    
	/*
	 * 1. 메소드명: getCustSegMartList
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 08.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<CustSegMartResDto> getCustSegMartList(CustSegMartReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<CustSegMartResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 customerSegmentMapper.selectCustSegMartList(reqDto), AnnotationType.CommCode);
	}
	
	/*
	 * 1. 메소드명: getCustSegMartDetail
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 08.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public CustSegMartResDto getCustSegMartDetail(CustSegMartReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
		
		return customerSegmentMapper.selectCustSegMartDetail(reqDto);
	}
	
	/*
	 * 1. 메소드명: insertCustSegmentMart
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 08.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto insertCustSegmentMart(CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
	
        StatusResDto rtnValue = new StatusResDto();
        customerSegmentMapper.insertCustSegmentMart(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: updateCustSegmentMart
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 08.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto updateCustSegmentMart(CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
        StatusResDto rtnValue = new StatusResDto();
        customerSegmentMapper.updateCustSegmentMart(reqDto);

        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: removeCustSegmentMart
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 08.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeCustSegmentMart(CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		customerSegmentMapper.delCustSegmentMart(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}


	/*
	 * 1. 메소드명: getLogicalCompList
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 08.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 마트 로지컬 컴포넌트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<CustSegMartResDto> getLogicalCompList(CustSegMartReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<CustSegMartResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 customerSegmentMapper.selectLogicalCompList(reqDto), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getCustSegList
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 09.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<CustSegResDto> getCustSegList(CustSegReqDto reqDto) {
		return new GridPagingResHelper<CustSegResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 customerSegmentMapper.selectCustSegList(reqDto), AnnotationType.CommCode);
	}
	
	/*
	 * 1. 메소드명: getCustSegDetail
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 09.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public CustSegResDto getCustSegDetail(CustSegReqDto reqDto) {
			
		LogUtil.param(this.getClass(), reqDto);	
		return customerSegmentMapper.selectCustSegDetail(reqDto);
	}

	public StatusResDto removeCustSegment(CustSegReqDto reqDto) {
	LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		customerSegmentMapper.delCustSegment(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	/*
	 * 1. 메소드명: addCustSegment
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 09.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 상세 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto addCustSegment(CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
        StatusResDto rtnValue = new StatusResDto();
        SimpleDateFormat formYYYYMMDD = new SimpleDateFormat("yyyyMMdd", Locale.KOREAN);
        String day = formYYYYMMDD.format(new Date()); //현재 날짜
        reqDto.setTodayDate(day);
        
        StatusResDto dupChk = typeCdDupChk(reqDto);       
        
        if(dupChk.getSuccess()) {
        	 Integer seq =customerSegmentMapper.selectTodaySeq(reqDto);
             seq++;
             String seqId= String.format("%07d", seq); 
             reqDto.setCsegHadId(day+seqId);       //YYYYMMDD+SEQ(15)
             customerSegmentMapper.insertCustSegment(reqDto);
        }else {
        	rtnValue.setMessage("이미 등록된 고객 세분화 유형입니다. 중복 등록 할 수 없습니다.");
        }
     
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: typeCdDupChk
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 09.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 세분화 유형 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	private StatusResDto typeCdDupChk(CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        
		Integer dupChk =customerSegmentMapper.selectTypeCdDupChk(reqDto);
		
		if(ObjectUtil.isNotEmpty(dupChk) && dupChk == 0) {
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);	
		}		
		return rtnValue;
	}

	/*
	 * 1. 메소드명: editCustSegment
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto editCustSegment(CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
        StatusResDto rtnValue = new StatusResDto();
        
        StatusResDto dupChk = typeCdDupChkForUpdate(reqDto);       
        
        if(dupChk.getSuccess()) {
        	customerSegmentMapper.updateCustSegment(reqDto);
        }else {
        	rtnValue.setMessage("이미 등록된 고객 세분화 유형입니다. 중복 등록 할 수 없습니다.");
        }
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: typeCdDupChkForUpdate
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 09.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 세분화 유형 중복 체크(수정시)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	private StatusResDto typeCdDupChkForUpdate(CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        
		Integer dupChk =customerSegmentMapper.selectTypeCdDupChkForUpdate(reqDto);
		
		if(ObjectUtil.isNotEmpty(dupChk) && dupChk == 0) {
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);	
		}		
		return rtnValue;
	}

	/*
	 * 1. 메소드명: getCustSegStageList
	 * 2. 클래스명: CustomerSegmentService
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 07. 10
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트(세분화) 단계 그리드 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<CustSegStageResDto> getCustSegStageList(CustSegStageReqDto reqDto) {
			LogUtil.param(this.getClass(), reqDto);
		
			return new GridPagingResHelper<CustSegStageResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 customerSegmentMapper.selectCustSegStageList(reqDto), AnnotationType.CommCode);
	}
	
	/*
	 * 1. 메소드명: getCustSegStageDetail
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 13
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 상세
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	public CustSegStageResDto getCustSegStageDetail(CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);	
		return customerSegmentMapper.selectCustSegStageDetail(reqDto);
	}

	/*
	 * 1. 메소드명: addCustSegment
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 13
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 상세 등록
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 

	public StatusResDto addCustSegmentStage(CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
        StatusResDto rtnValue = new StatusResDto();
        
        StatusResDto dupChkRtnValue = indexDupChk(reqDto);

        if(dupChkRtnValue.getSuccess()) {
            customerSegmentMapper.insertCustSegmentStage(reqDto);
         }else {
    		rtnValue.setMessage("이미 등록된 단계 순서입니다. 중복 등록 할 수 없습니다.");
        }
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	/*
	 * 1. 메소드명: indexDupChk
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 31
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 순서 중복 체크
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 

	
	private StatusResDto indexDupChk(CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        
		Integer dupChk =customerSegmentMapper.selectIndexDupChk(reqDto);
		
		if(ObjectUtil.isNotEmpty(dupChk) && dupChk == 0) {
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);	
		}		
		return rtnValue;
	}


	/*
	 * 1. 메소드명: editCustSegment
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 13
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 상세 수정
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 

	public StatusResDto editCustSegmentStage(CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
        StatusResDto rtnValue = new StatusResDto();
        
        StatusResDto dupChkRtnValue = indexDupChkforUpdate(reqDto);
        	
        if(dupChkRtnValue.getSuccess()) {
       		customerSegmentMapper.updateCustSegmentStage(reqDto);
        }else {
       		rtnValue.setMessage("이미 등록된 단계 순서입니다. 중복 등록 할 수 없습니다.");
        }
   
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	
	
	/*
	 * 1. 메소드명: indexDupChk
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 31
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 순서 중복 체크(수정일때 현재 단계 제외 체크)
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	
	private StatusResDto indexDupChkforUpdate(CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        StatusResDto rtnValue = new StatusResDto();
        
		Integer dupChk =customerSegmentMapper.selectIndexDupChkforUpdate(reqDto);
		
		if(ObjectUtil.isNotEmpty(dupChk) && dupChk == 0) {
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setSuccess(false);	
		}		
		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeCustSegmentStage
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 13
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 단계 상세 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	public StatusResDto removeCustSegmentStage(CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();
		
		customerSegmentMapper.delCustSegmentStage(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}

	/*
	 * 1. 메소드명: addCustSegmentRule
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 14
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 룰 등록
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	
	public StatusResDto addCustSegmentRule(CustSegmentRuleReqDto reqDto) {
		LogUtil.param( this.getClass() , reqDto );

		StatusResDto rtnValue = new StatusResDto();

		//세그먼트 복제
		KprCopySegmentReqDto csr = new KprCopySegmentReqDto();
        csr.setCreateBy(reqDto.getCreateBy());
        csr.setModifyBy(reqDto.getModifyBy());
        csr.setSegFilterId(reqDto.getSegFilterId());
        csr.setSegmentType(reqDto.getSegmentType());
        rtnValue = iKPRSegmentService.copySegmentBySegmentFilterId(csr);

        	if (rtnValue.getSuccess()) {
		    //세그먼트 필터 아이디 설정
			//reqDto.setSegFilterId(rtnValue.getMessage());
		    //고객 세그먼트 룰 생성	
		    String id = CommonUtil.newRid();
		    reqDto.setCustSegRuleId(id);

	     if(customerSegmentMapper.insertCustSegmentRule(reqDto)>0){
	            rtnValue.setSuccess(true);
	            rtnValue.setMessage(id);
	        }
			return rtnValue;
 		 }
        	
		return rtnValue;
	}
	/*
	 * 1. 메소드명: getCustSegRuleList
	 * 2. 클래스명: CustomerSegmentService 
	 * 3. 작성자명: sh.park 
	 * 4. 작성일자: 2020. 7. 16
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 세그먼트 룰 그리드 조회
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param request
	 * @param response
	 * @param reqDto
	 * @return
	 */	 
	public GridPagingResDto<CustSegmentRuleResDto> getCustSegRuleList(CustSegmentRuleReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
		 reqDto.setSVCAlias("t");
		 reqDto.setComprGroupTypeCode("CS");
	        return new GridPagingResHelper<CustSegmentRuleResDto>().newGridPagingResDto(
	        		reqDto.init(CommonUtil.getInstance().getDBType()),
	        		customerSegmentMapper.selectCustSegRuleList(reqDto));
	}
	  /*
   	 * 1. 메소드명: execSegMartSql
   	 * 2. 클래스명: CustomerSegmentService 
   	 * 3. 작성자명: sh.park 
   	 * 4. 작성일자: 2020. 7. 21
   	 */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		마트 쿼리 수동 실행
   	 * 2. 사용법
   	 * 
   	 * </PRE>
   	 * 
   	 * @param request
   	 * @param response
   	 * @param reqDto
   	 * @return
   	 */	 
	public StatusResDto execSegMartSql(CustSegMartReqDto reqDto) {
		StatusResDto rtnValue= new StatusResDto();
		
		String sqlQuery = "";
		KprLogicalComponentDBInfoReqDto lcdbir = new KprLogicalComponentDBInfoReqDto();
		lcdbir.setLang("ko");
		lcdbir.setLogicalCompId(reqDto.getLgcCompId());
		
		//접속 db 정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();
		dbInfo =iKPRSegmentService.getLogicalComponentDBInfo(lcdbir);
		
		CustSegMartResDto custMartList =	customerSegmentMapper.selectCustSegMartData(reqDto);
		sqlQuery=custMartList.getSql();
		sqlQuery =sqlQuery.replace(";","");  //쿼리문에 ; 포함 되어 있을 시 제거
		
		if(!"02".equals(custMartList.getCsegMtStatusCd())) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("활성 상태가 아닙니다.");
		}else {
			rtnValue = mktCallQuery.callUpdate("execSegMartSql", sqlQuery, new ArrayList<String>(), dbInfo, true);
		}
		
		if(rtnValue.getSuccess()) {
			rtnValue.setMessage("성공적으로 실행되었습니다.");
		}else {
			rtnValue.setMessage("실행 중 오류 발생");
		}
		return rtnValue;
	}
	
	  /*
   	 * 1. 메소드명: getCustRuleListBySegId
   	 * 2. 클래스명: CustomerSegmentService 
   	 * 3. 작성자명: sh.park 
   	 * 4. 작성일자: 2020. 7. 22
   	 */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		고객 세그먼트 룰 그리드 조회(세그먼트 아이디에 따른 조회)
   	 * 2. 사용법
   	 * 
   	 * </PRE>
   	 * 
   	 * @param request
   	 * @param response
   	 * @param reqDto
   	 * @return
   	 */	 
	public GridPagingResDto<CustSegmentRuleResDto> getCustRuleListBySegId(CustSegmentRuleReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
		 reqDto.setSVCAlias("t");
		 reqDto.setComprGroupTypeCode("CS");
	        return new GridPagingResHelper<CustSegmentRuleResDto>().newGridPagingResDto(
	        		reqDto.init(CommonUtil.getInstance().getDBType()),
	        		customerSegmentMapper.selectCustRuleBySegId(reqDto));
	}
   
	/*
   	 * 1. 메소드명: removeCustSegmentRule
   	 * 2. 클래스명: CustomerSegmentService 
   	 * 3. 작성자명: sh.park 
   	 * 4. 작성일자: 2020. 7. 23
   	 */
   	/**
   	 * <PRE>
   	 * 1. 설명
   	 *		고객 세그먼트 룰 삭제
   	 * 2. 사용법
   	 * 
   	 * </PRE>
   	 * 
   	 * @param request
   	 * @param response
   	 * @param reqDto
   	 * @return
   	 */	 
	public StatusResDto removeCustSegmentRule(CustSegReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
        
		StatusResDto rtnValue = new StatusResDto();		
		customerSegmentMapper.delCustSegmentRule(reqDto);
        
        rtnValue.setSuccess(true);
        return rtnValue;
	}
	  /*
 	 * 1. 메소드명: getCustSegmentList
 	 * 2. 클래스명: CustomerSegmentService 
 	 * 3. 작성자명: sh.park 
 	 * 4. 작성일자: 2020. 7. 28
 	 */
 	/**
 	 * <PRE>
 	 * 1. 설명
 	 *	고객 세그먼트 룰만 조회 
 	 * 2. 사용법
 	 * 
 	 * </PRE>
 	 * 
 	 * @param request
 	 * @param response
 	 * @param reqDto
 	 * @return
 	 */	 
	public GridPagingResDto<KprSegmentListResDto> getCustSegmentList(KprSegmentListReqDto slr) {
		LogUtil.param(KprSegmentService.class, slr);
		slr.setSVCAlias("s");
		return new GridPagingResHelper<KprSegmentListResDto>().newGridPagingResDto(
				slr.init(CommonUtil.getInstance().getDBType()),
				customerSegmentMapper.selectCustSegmentList(slr));
	}
	
    /*
 	 * 1. 메소드명: getCustSegStageDetail
 	 * 2. 클래스명: CustomerSegmentController 
 	 * 3. 작성자명: sh.park 
 	 * 4. 작성일자: 2020. 7. 30
 	 */
 	/**
 	 * <PRE>
 	 * 1. 설명
 	 *		고객 세분화 단계 인덱스
 	 * 2. 사용법
 	 * 
 	 * </PRE>
 	 * 
 	 * @param request
 	 * @param response
 	 * @param reqDto
 	 * @return
 	 */	 
	public Integer getCustSegStageIdx(CustSegStageReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
				
	     Integer stageIdx =customerSegmentMapper.selectCustSegStageIdx(reqDto);
	     stageIdx= stageIdx+1;
	     
	     return stageIdx;
   	}

	public CustSegmentRuleResDto setSegmentCond(CustSegmentRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);	
		return customerSegmentMapper.selectSegmentCond(reqDto);
	}

	public CustSegmentRuleResDto getCustRuleNmForTxt(CustSegmentRuleReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);	
		return customerSegmentMapper.selectCustRuleNmForTxt(reqDto);
	}









}
