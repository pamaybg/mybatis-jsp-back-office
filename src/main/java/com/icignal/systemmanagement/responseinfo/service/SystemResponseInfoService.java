/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemResponseInfoService.java
 * 2. Package	: com.icignal.systemmanagement.responseinfo.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 6. 오후 2:39:31
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 6.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.responseinfo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemCheckDuplicationReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemDelResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemGetResponseInfoDetailReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemModifyResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.request.SystemSetResponseInfoReqDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemCheckDuplicationResDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemGetResponseInfoDetailResDto;
import com.icignal.systemmanagement.responseinfo.dto.response.SystemResponseInfoResDto;
import com.icignal.systemmanagement.responseinfo.mapper.SystemResponseInfoMapper;


/*
 * 1. 클래스명	: SystemResponseInfoService
 * 2. 파일명	: SystemResponseInfoService.java
 * 3. 패키지명	: com.icignal.systemmanagement.responseinfo.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 6.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class SystemResponseInfoService {
	@Autowired
	private SystemResponseInfoMapper systemResponseInfoMapper;
	
	
	/**
	 * @name : getResponseInfoList
	 * @date : 2016. 01. 27..
	 * @author : 안형욱
	 * @return : MKTResponseInfoResopnseDTO
	 * @description : 반응정보 목록 조회 
	 */
	public GridPagingResDto<SystemResponseInfoResDto> getResponseInfoList(SystemResponseInfoReqDto rir){
		LogUtil.param(this.getClass(), rir);
		
		rir.setSVCAlias("mrim");
		GridPagingResDto<SystemResponseInfoResDto> resDto = new GridPagingResDto<SystemResponseInfoResDto>();
		resDto = new GridPagingResHelper<SystemResponseInfoResDto>().newGridPagingResDto(
				rir.init(CommonUtil.getInstance().getDBType()),
				systemResponseInfoMapper.selectResponseInfoList(rir), AnnotationType.CommCode);
		return resDto;
	}

	/**
	 * @name : getResponseInfoDetail
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : MKTResponseInfoDetailResponseDTO
	 * @description : 반응정보세부사항 조회 
	 */
	public SystemGetResponseInfoDetailResDto getResponseInfoDetail(SystemGetResponseInfoDetailReqDto grir){
		LogUtil.param(this.getClass(), grir);

		grir.setSVCAlias("mrim");
		SystemGetResponseInfoDetailResDto resDto = systemResponseInfoMapper.selectResponseInfoDetail(grir);
		
		return new AnnotationHelper<SystemGetResponseInfoDetailResDto>(AnnotationType.Nothing,resDto).getItem();
	}	

	/**
	 * @name : insertResponseInfo
	 * @date : 22016. 01. 27.
	 * @author : 안형욱
	 * @return : StatusResopnseDTO
	 * @description : 반응정보 추가 
	 */
	public StatusResDto insertResponseInfo(SystemSetResponseInfoReqDto srir){
		LogUtil.param(this.getClass(), srir);
		srir.setSVCAlias("");
		
		StatusResDto rtnVal = new StatusResDto();
		
		//dp_Seq으로 받아온 6자리 숫자를 RCxxxxxx 형식으로 변환 
		String dpSeq ="";
		dpSeq = "RC"+srir.getDpSeq();
		
		srir.setDpSeq(dpSeq);
		
		
		SystemCheckDuplicationReqDto ckDupl = new SystemCheckDuplicationReqDto();
		
		ckDupl.setDpSeq(srir.getDpSeq());
		ckDupl.setCamRspnsNm(srir.getCamRspnsNm());
		ckDupl.setCamRspnsCd(srir.getCamRspnsCd());
		ckDupl.setStrSVCType(srir.getStrSVCType());
		
		//노출순서 중복체크
		String duplicationSeq = (String) systemResponseInfoMapper.selectCheckDuplicationSeq(ckDupl);
	
		//code 중복체크
		String duplicationCode = (String) systemResponseInfoMapper.selectCheckDuplicationCode(ckDupl);
		
		//name 중복체크
		String duplicationName = (String) systemResponseInfoMapper.selectCheckDuplicationName(ckDupl);		
		
		rtnVal.setSuccess(false);
		
		//노출 순서 중복 에러
		if(duplicationSeq.equals("1")){
			rtnVal.setErrorType(IFVMErrorHelper.SEQUENCE_DUPLICATION_CHCK);
		}
		//코드 중복 에러
		else if (duplicationCode.equals("1")){
			rtnVal.setErrorType(IFVMErrorHelper.CODE_DUPLICATION_CHCK);
		}
		//명칭 중복 에러
		else if(duplicationName.equals("1")){
			rtnVal.setErrorType(IFVMErrorHelper.NAME_DUPLICATION_CHCK);
		}
		else{
			srir.setId(CommonUtil.newRid());
			systemResponseInfoMapper.insertResponseInfo(srir);
			
			rtnVal.setSuccess(true);
		}
		
		return rtnVal;
		
	}	

	/**
	 * @name : updateResponseInfo
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : StatusResopnseDTO
	 * @description : 반응정보 수정 
	 */
	public StatusResDto updateResponseInfo(SystemModifyResponseInfoReqDto mrir){
		LogUtil.param(this.getClass(), mrir);
		StatusResDto rtnVal = new StatusResDto();
		mrir.setSVCAlias("");
		
		
		//dp_Seq으로 받아온 6자리 숫자를 RCxxxxxx 형식으로 변환 
		String dpSeq ="";
		dpSeq = "RC"+mrir.getDpSeq();
		mrir.setDpSeq(dpSeq);
		
		
		//중복 체크할 데이터 저장
		SystemCheckDuplicationReqDto ckDupl = new SystemCheckDuplicationReqDto();
		
		ckDupl.setDpSeq(mrir.getDpSeq());
		ckDupl.setId(mrir.getId());
		ckDupl.setCamRspnsNm(mrir.getCamRspnsNm());
		ckDupl.setCamRspnsCd(mrir.getCamRspnsCd());
		ckDupl.setStrSVCType(mrir.getStrSVCType());
		
		
		rtnVal.setSuccess(false);
		
		SystemCheckDuplicationResDto checkDupl = new SystemCheckDuplicationResDto();
		
		//변경전 중복체크할 데이터
		checkDupl = systemResponseInfoMapper.selectcheckDuplication(ckDupl);
		
		//노출순서 중복체크
		String duplicationSeq = (String) systemResponseInfoMapper.selectCheckDuplicationSeq(ckDupl);
		
		//code 중복체크
		String duplicationCode = (String) systemResponseInfoMapper.selectCheckDuplicationCode(ckDupl);
		
		//name 중복체크
		String duplicationName = (String) systemResponseInfoMapper.selectCheckDuplicationName(ckDupl);
		
		
		rtnVal.setSuccess(false);
		
		//영문일경우를 생각해서 대문자 비교를 통해 원래 입력했던 값과 같았을 경우는 루틴 안걸리게 설정.
		//노출 순서 중복 에러(원래 값과 틀린 값이 있을 경우)
		if(!checkDupl.getSeq().equalsIgnoreCase(mrir.getDpSeq()) && duplicationSeq.equals("1")){
			rtnVal.setErrorType(IFVMErrorHelper.SEQUENCE_DUPLICATION_CHCK);
		}
		//코드 중복 에러
		else if (!checkDupl.getCode().equalsIgnoreCase(mrir.getCamRspnsCd()) &&duplicationCode.equals("1")){
			rtnVal.setErrorType(IFVMErrorHelper.CODE_DUPLICATION_CHCK);
		}
		//명칭 중복 에러
		else if(!checkDupl.getName().equalsIgnoreCase(mrir.getCamRspnsNm()) &&duplicationName.equals("1")){
			rtnVal.setErrorType(IFVMErrorHelper.NAME_DUPLICATION_CHCK);
		}
		else{
			//에러 없을시 업데이트.
			systemResponseInfoMapper.updateResponseInfo(mrir);
			
			rtnVal.setSuccess(true);
		}
		
		return rtnVal;
	}	
	
	/**
	 * @name : deleteResponseInfo
	 * @date : 2016. 01. 27.
	 * @author : 안형욱
	 * @return : StatusResopnseDTO
	 * @description : 반응정보 삭제 
	 */
	public StatusResDto deleteResponseInfo(SystemDelResponseInfoReqDto drir){
		LogUtil.param(this.getClass(), drir);
		StatusResDto rtnVal = new StatusResDto();
		
		drir.setSVCAlias("");
		rtnVal.setSuccess(false);
		
		//삭제할 반응코드를 상위반응코드로 가지고 있는 하위 반응코드 우선 삭제
		systemResponseInfoMapper.deleteAboutParId(drir);
		
		//반응코드 삭제
		systemResponseInfoMapper.deleteResponseInfo(drir);		
		
		rtnVal.setSuccess(true);
		
		return rtnVal;
	}
}
