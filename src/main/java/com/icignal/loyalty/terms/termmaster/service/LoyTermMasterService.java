/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyTermMasterService.java
 * 2. Package	: com.icignal.loyalty.terms.termmaster.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 2. 27. 오후 2:34:33
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 2. 27.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.terms.termmaster.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsDetailListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.request.LoyTermsListReqDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsDetailListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsLoyPgmListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsRcvChnlListResDto;
import com.icignal.loyalty.terms.termmaster.dto.response.LoyTermsValidChekResDto;
import com.icignal.loyalty.terms.termmaster.mapper.LoyTermMasterMapper;


/*
 * 1. 클래스명	: LoyTermMasterService
 * 2. 파일명	: LoyTermMasterService.java
 * 3. 패키지명	: com.icignal.loyalty.terms.termmaster.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyTermMasterService {
	
	@Autowired
	LoyTermMasterMapper loyTermMasterMapper;
	
	/**
	* @programId :
	* @name : getTermsList
	* @date : 2018. 10. 31.
	* @author : mj.kim
	* @table :
	* @return :
	* @description :약관관리 조회
	*/
	public GridPagingResDto<LoyTermsListResDto> getTermsList(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTermsListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTermMasterMapper.selectTermsList(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getTermsDetailList
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세 정보
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsDetailListResDto getTermsDetail(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyTermMasterMapper.selectTermsDetail(reqDto);
	}
	

	 /*
	  * 1. 메소드명: saveTermsList
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 신규 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveTermsList(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyTermsValidChekResDto rtnValue = new LoyTermsValidChekResDto();

		int checkTermsTypeSub = loyTermMasterMapper.validCheckTermsTypeSub(reqDto);
		LoyTermsDetailListResDto seqDupChk = loyTermMasterMapper.selectTermsSeqNoChk(reqDto);

		if(checkTermsTypeSub > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 약관이 존재합니다.");
		}else if(StringUtil.isNotEmpty(seqDupChk)) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 표시순서가 존재합니다.");
		}else {
			String rid = CommonUtil.newRid();
			reqDto.setRid(rid);
			rtnValue.setRid(rid);
			loyTermMasterMapper.insertTermsList(reqDto);
			rtnValue.setMessage("저장되었습니다.");
			rtnValue.setSuccess(true);
			
		}
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : modifyTermsList
	* @date : 2018. 10. 31.
	* @author : mj.kim
	* @table :
	* @return :
	* @description :약관관리 상세 수정
	*/
	public StatusResDto modifyTermsList(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		LoyTermsDetailListResDto seqDupChk = loyTermMasterMapper.selectTermsSeqNoChk(reqDto);
		LoyTermsDetailListResDto selectNowSeqNo = loyTermMasterMapper.selectNowSeqNo(reqDto);

		if(reqDto.getTermsNo().equals(selectNowSeqNo.getSeqNo())) {
			loyTermMasterMapper.updateTermsList(reqDto);
			rtnValue.setSuccess(true);
			rtnValue.setMessage("저장되었습니다.");
			return rtnValue;
		}
		
		if(StringUtil.isEmpty(seqDupChk)) {
			loyTermMasterMapper.updateTermsList(reqDto);
			rtnValue.setSuccess(true);
			rtnValue.setMessage("저장되었습니다.");
			return rtnValue;
		}else {
			rtnValue.setSuccess(true);
			rtnValue.setMessage("dupSeq");
			return rtnValue;
		}
	}
	
	 /*
	  * 1. 메소드명: getTermsVerList
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관버전 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyTermsListResDto> getTermsVerList(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);		
		return new GridPagingResHelper<LoyTermsListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTermMasterMapper.selectTermsVerList(reqDto), AnnotationType.CommCode);
	}
		
	 /*
	  * 1. 메소드명: getTermsRcvChnl
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyTermsRcvChnlListResDto> getTermsRcvChnl(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);		
		return new GridPagingResHelper<LoyTermsRcvChnlListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTermMasterMapper.selectTermsRcvChnl(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: saveTermsVersion
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	@Transactional
	public StatusResDto saveTermsVersion(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
//		SimpleDateFormat formatX = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		SimpleDateFormat formatY = new SimpleDateFormat("YYYY-MM-dd", Locale.KOREAN);
		Date currentTime = new Date(); 
//		String todayX = formatX.format(currentTime);
		String todayY = formatY.format(currentTime);
		int checkVer = loyTermMasterMapper.validChekVer(reqDto);
		if(checkVer > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 버전이 존재합니다.");
		}else {
			String rid = CommonUtil.newRid();
			reqDto.setRid(rid);
			if(todayY.equals(reqDto.getStartDate())) {
				reqDto.setStartDate(null);
			}
			//신규 가입시 최상위 버전의 프로그램 리스트 자동 추가(수정중)
			List<LoyTermsDetailListReqDto> pgmList = new ArrayList<LoyTermsDetailListReqDto>();
			pgmList = loyTermMasterMapper.selectInsertPgmList(reqDto);
			
			//로직상 최상위를 뽑으려면 프로그램을 먼저 조회하고 그데이터를 가지고 있다가 약관 insert를 해주고 바로 로열티 프로그램을 insert해준다
			loyTermMasterMapper.insertTermsVersion(reqDto);

			
			for(LoyTermsDetailListReqDto reqPgm : pgmList) {
				reqPgm.setEmpId(reqDto.getEmpId());
				reqPgm.setVerRid(rid);
				reqPgm.setRid(CommonUtil.newRid());
				loyTermMasterMapper.insertNewTermsLoyPgm(reqPgm);
			}
			
			
			rtnValue.setSuccess(true);
		}
		return rtnValue;

	}

	 /*
	  * 1. 메소드명: removeTermsVersion
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeTermsVersion(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyTermMasterMapper.deleteTermsVersion(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getTermsVerDetail
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 상세 팝업 불러오기(rid)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsDetailListResDto getTermsVerDetail(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyTermMasterMapper.selectTermsVerDetail(reqDto);
	}


	 /*
	  * 1. 메소드명: modifyTermsVersion
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 버전 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyTermsVersion(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		
		int checkVer = loyTermMasterMapper.validChekVer(reqDto);
		if(checkVer > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 버전이 존재합니다.");
		}else {
			loyTermMasterMapper.modifyTermsVersion(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: removeTermsList
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 삭제 flag =0 - LOY_TERMS_M, LOY_TERMS_VER, LOY_TEMRS_RCV_CHNL(FLAG =0 처리 필요시 주석 빼면됩니다.)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeTermsList(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//약관 마스터 삭제
		loyTermMasterMapper.deleteTermsList(reqDto);
		//약관 버전 삭제
		//loyTermMasterMapper.deleteTermsVerList(reqDto);
		//마켓팅 수신동의 항목 삭제
		//loyTermMasterMapper.deleteTermsRcvList(reqDto);
		//약관 로열티 프로그램 삭제
		//loyTermMasterMapper.deleteLoyPgmList(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getTermsContent
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		버전에 따른 약과 내용 보여주기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsDetailListResDto getTermsContent(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyTermMasterMapper.selectTermsContent(reqDto);
	}

	 /*
	  * 1. 메소드명: saveRcvChnl
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveTermsRcvChnl(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		int checkRcvChnl = vaildCheckRcvChnl(reqDto);
		if(checkRcvChnl > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 채널이 존재합니다.");
		}else {
			reqDto.setRid(CommonUtil.newRid());
			loyTermMasterMapper.insertTermsRcvChnl(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: modifyRcvChnl
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyTermsRcvChnl(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		int checkRcvChnl = vaildCheckRcvChnl(reqDto);
		if(checkRcvChnl > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("동일한 채널이 존재합니다.");
		}else {
			loyTermMasterMapper.updateTermsRcvChnl(reqDto);
			rtnValue.setSuccess(true);
		}
		
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: vaildCheckRcvChnl
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public int vaildCheckRcvChnl(LoyTermsDetailListReqDto reqDto) {
		int checkRcvChnl = loyTermMasterMapper.vaildCheckRcvChnl(reqDto);
		return checkRcvChnl;
	}

	 /*
	  * 1. 메소드명: getTermsLoyPgmList
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyTermsLoyPgmListResDto> getTermsLoyPgmList(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyTermsLoyPgmListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTermMasterMapper.selectTermsLoyPgmList(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getRcvChnlDetail
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 수신채널 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsDetailListResDto getRcvChnlDetail(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyTermMasterMapper.selectRcvChnlDetail(reqDto);
	}
	
	 /*
	  * 1. 메소드명: getLoyPgmTList
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 리스트 팝업 (TABLE - LOY.LOY_PGM)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyTermsLoyPgmListResDto> getLoyPgmTList(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyTermsLoyPgmListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyTermMasterMapper.selectLoyPgmTList(reqDto), AnnotationType.CommCode);
	}


	 /*
	  * 1. 메소드명: getLoyPgmDetai
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 상세 팝업 데이터 불러오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsLoyPgmListResDto getLoyPgmDetail(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyTermsLoyPgmListResDto rtnValue = new LoyTermsLoyPgmListResDto();
		rtnValue = loyTermMasterMapper.selectLoyPgmDetail(reqDto);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: saveTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveTermsLoyPgm(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//로열티 프로그램 중복체크
		int validTermLoyPgmCnt = loyTermMasterMapper.validTermLoyPgmCnt(reqDto);
		if(validTermLoyPgmCnt>0) {
			rtnValue.setMessage("동일한 로열티 프로그램이 존재합니다.");
			rtnValue.setSuccess(false);
		}else {
			reqDto.setRid(CommonUtil.newRid());
			loyTermMasterMapper.insertTermsLoyPgm(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: modifyTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 로열티 프로그램 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyTermsLoyPgm(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//로열티 프로그램 중복체크
		int validTermLoyPgmCnt = loyTermMasterMapper.validTermLoyPgmCnt(reqDto);
		if(validTermLoyPgmCnt>0) {
			rtnValue.setMessage("동일한 로열티 프로그램이 존재합니다.");
			rtnValue.setSuccess(false);
		}else {
			loyTermMasterMapper.updateTermsLoyPgm(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getTermsInfoDetail
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 관리 약관 내용 보기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsDetailListResDto getTermsInfoDetail(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyTermsDetailListResDto rtnValue = new LoyTermsDetailListResDto(); 
		int checkTermInfoCnt = loyTermMasterMapper.checkTermInfoCnt(reqDto);
		if(checkTermInfoCnt>0) {
			rtnValue = loyTermMasterMapper.selectTermsInfoDetail(reqDto);
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setMessage("약관 내용이 없습니다.");
			rtnValue.setSuccess(false);
		}
		return rtnValue;
		
	}


	 /*
	  * 1. 메소드명: validLoyaltyPgm
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 상세에서  사용여부 == 'Y' 인상태로 저장할때 로열티 프로그램 등록 확인(무조건 1개 이상 프로그램이 등록 되있어야한다)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsValidChekResDto validLoyaltyPgm(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyTermsValidChekResDto rtnValue = new LoyTermsValidChekResDto();
		int validLoyaltyPgmCnt =loyTermMasterMapper.validLoyaltyPgmCnt(reqDto);
		if(validLoyaltyPgmCnt> 0) {
			rtnValue = loyTermMasterMapper.validLoyaltyPgm(reqDto);
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setMessage("로열티 프로그램을 등록하시오.");
			rtnValue.setSuccess(false);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: validTermsStatCheck
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		기존에 활성, 중지 상태였다면 작성중 상태로 돌아갈수 없습니다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyTermsValidChekResDto validTermsStatCheck(LoyTermsDetailListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyTermsValidChekResDto rtnValue = new LoyTermsValidChekResDto();
		rtnValue = loyTermMasterMapper.validTermsStatCheck(reqDto);
		if("W".equals(rtnValue.getStatCd())) {
			rtnValue.setSuccess(true);
		}else {
			rtnValue.setMessage("작성중으로 돌아갈 수 없습니다.");
			rtnValue.setSuccess(false);
		}
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: removeTermsLoyPgm
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		약관 버전 로열티 프로그램 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeTermsLoyPgm(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyTermMasterMapper.deleteTermsLoyPgm(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: removeTermsRcvChnl
	  * 2. 클래스명: LoyTermMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		수신채널 항목 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeTermsRcvChnl(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyTermMasterMapper.deleteTermsRcvChn(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	/**
	* @programId :
	* @name : insertTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 조회
	*/
	public GridPagingResDto<LoyTermsListResDto> getTermsGrp(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTermsListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTermMasterMapper.selectTermsGrp(reqDto), AnnotationType.CommCode);
	}	
	/**
	* @programId :
	* @name : insertTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 신규
	*/
	public StatusResDto insertTermsGrp(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		reqDto.setTermsGrpCdChangeVal(reqDto.getTermsGrpCd());
		LoyTermsListResDto alreadyCheck =  loyTermMasterMapper.selectAlreadyTermsGrp(reqDto);
		if(StringUtil.isEmpty(alreadyCheck)) {
			loyTermMasterMapper.insertTermsGrp(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getTermsGrpTermsPop
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관 그룹용 약관관리 조회
	*/
	public GridPagingResDto<LoyTermsListResDto> getTermsGrpTermsPop(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTermsListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTermMasterMapper.selectTermsGrpTermsPop(reqDto), AnnotationType.CommCode);
	}
	
	/**
	* @programId :
	* @name : getAlreadyTermsGrp
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관 그룹용 약관관리 조회
	*/
	public LoyTermsListResDto getAlreadyTermsGrp(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return  loyTermMasterMapper.selectAlreadyTermsGrp(reqDto);
	}
	
	/**
	* @programId :
	* @name : updateTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 수정
	*/
	public StatusResDto updateTermsGrp(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		LoyTermsListResDto alreadyCheck =  loyTermMasterMapper.selectAlreadyTermsGrp(reqDto);
		if(StringUtil.isEmpty(alreadyCheck)) {
			loyTermMasterMapper.updateTermsGrp(reqDto);		
			 rtnValue.setSuccess(true);
		} else {
			if(alreadyCheck.getTermsGrpCd().equals(reqDto.getTermsGrpCd())) {
				loyTermMasterMapper.updateTermsGrp(reqDto);		
				 rtnValue.setSuccess(true);
			}
		}
		
		return rtnValue;
	}
	/**
	* @programId :
	* @name : deleteTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 삭제
	*/
	public StatusResDto deleteTermsGrp(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		loyTermMasterMapper.deleteTermsGrp(reqDto);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}	
	/**
	* @programId :
	* @name : getTermsGrpTermsList
	* @table :
	* @return :
	* @description :약관 조회
	*/
	public GridPagingResDto<LoyTermsListResDto> getTermsGrpTermsList(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyTermsListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyTermMasterMapper.selectTermsGrpTermsList(reqDto), AnnotationType.CommCode);
	}	
	
	/**
	* @programId :
	* @name : insertTermsGrpTerms
	* @table :
	* @return :
	* @description :약관그룹의 약관 신규
	*/
	public StatusResDto insertTermsGrpTerms(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		LoyTermsListResDto alreadySeqCheck =  loyTermMasterMapper.selectAlreadyTermsListGrp(reqDto);
		LoyTermsListResDto alreadyNameCheck =  loyTermMasterMapper.selectAlreadyTermsListGrpTermsName(reqDto);

		if(StringUtil.isEmpty(alreadySeqCheck) && StringUtil.isEmpty(alreadyNameCheck)) {
			loyTermMasterMapper.insertTermsGrpTerms(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getAlreadyTermsGrp
	* @table :
	* @return : GridPagingResponseDTO
	* @description : 약관 그룹용 약관관리 조회
	*/
	public LoyTermsListResDto getAlreadyTermsGrpTerms(LoyTermsListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return  loyTermMasterMapper.selectAlreadyTermsGrpTerms(reqDto);
	}
	
	/**
	* @programId :
	* @name : updateTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 수정
	*/
	public StatusResDto updateTermsListGrp(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		LoyTermsListReqDto dataRequestDto = new  LoyTermsListReqDto();
		dataRequestDto.setTermsGrpCd(reqDto.getTermsGrpCd());
		dataRequestDto.setSeqNo(reqDto.getSeqNo());
		dataRequestDto.setRidTerms(reqDto.getRidTermsChangeVal());
		//기존 약관그룹에 약관순서(번호)가 존재하는지 확인하기
		LoyTermsListResDto alreadySeqCheck =  loyTermMasterMapper.selectAlreadyTermsListGrp(dataRequestDto);
		//기존 약관그룹에 있는 약관인지 확인하기
		LoyTermsListResDto alreadyNameCheck =  loyTermMasterMapper.selectAlreadyTermsListGrpTermsName(dataRequestDto);

		if(StringUtil.isEmpty(alreadySeqCheck) && StringUtil.isEmpty(alreadyNameCheck)) {
			loyTermMasterMapper.updateTermsListGrp(reqDto);		
			 rtnValue.setSuccess(true);
		} else {
			if(StringUtil.isNotEmpty(alreadyNameCheck)){
				if(StringUtil.isEmpty(alreadySeqCheck)){
					if(!alreadyNameCheck.getRidTerms().equals(reqDto.getRidTermsChangeVal())) {
						loyTermMasterMapper.updateTermsListGrp(reqDto);		
						rtnValue.setSuccess(true);
					} else {
						if(alreadyNameCheck.getRidTerms().equals(reqDto.getRidTerms())) {
							loyTermMasterMapper.updateTermsListGrp(reqDto);		
							rtnValue.setSuccess(true);
						}
					}
				}  else {
					if(alreadySeqCheck.getRidTerms().equals(reqDto.getRidTerms())) {
						if(!alreadyNameCheck.getRidTerms().equals(reqDto.getRidTermsChangeVal())) {
							loyTermMasterMapper.updateTermsListGrp(reqDto);		
							rtnValue.setSuccess(true);
						}
						if(alreadyNameCheck.getRidTerms().equals(reqDto.getRidTerms())) {
							loyTermMasterMapper.updateTermsListGrp(reqDto);		
							rtnValue.setSuccess(true);
						}
					}
				}
			} else {
				if(StringUtil.isEmpty(alreadySeqCheck)){
						loyTermMasterMapper.updateTermsListGrp(reqDto);		
						rtnValue.setSuccess(true);
				} else {
					loyTermMasterMapper.updateTermsListGrp(reqDto);		
					rtnValue.setSuccess(true);
				}
			}
		}
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : deleteTermsGrp
	* @table :
	* @return :
	* @description :약관그룹 삭제
	*/
	public StatusResDto deleteGrpTerms(LoyTermsListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		
		loyTermMasterMapper.deleteGrpTerms(reqDto);

		rtnValue.setSuccess(true);
		
		return rtnValue;
	}	

}
