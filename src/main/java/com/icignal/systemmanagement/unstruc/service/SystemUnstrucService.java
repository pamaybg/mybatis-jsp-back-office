package com.icignal.systemmanagement.unstruc.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.unstruc.dto.request.SystemUnstrucDetailReqDto;
import com.icignal.systemmanagement.unstruc.dto.request.SystemUnstrucListReqDto;
import com.icignal.systemmanagement.unstruc.dto.response.SystemUnstrucDetailResDto;
import com.icignal.systemmanagement.unstruc.dto.response.SystemUnstrucListResDto;
import com.icignal.systemmanagement.unstruc.mapper.SystemUnstrucMapper;

/*
 * 1. 클래스명	: SystemUnstrucService
 * 2. 파일명	: SystemUnstrucService.java
 * 3. 패키지명	: com.icignal.systemmanagement.unstruc.service
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		이벤트 함수 유형 관리형 Service
 * </PRE>
 */
@Service("SystemUnstrucService")
public class SystemUnstrucService {

	@Autowired
	SystemUnstrucMapper systemUnstrucMapper;

	 /*
	  * 1. 메소드명: getLoyUnstrucList
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 함수 유형 목록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemUnstrucListResDto> getLoyUnstrucList(SystemUnstrucListReqDto param) {
		LogUtil.param(this.getClass(), param);

		return new GridPagingResHelper<SystemUnstrucListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemUnstrucMapper.selectLoyUnstrucList(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getLoyUnstrucItem
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 함수 유형 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemUnstrucDetailResDto getLoyUnstrucItem(SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("t1");

		return systemUnstrucMapper.selectLoyUnstrucItem(param);
	}

	 /*
	  * 1. 메소드명: getUsingByCampaignChk
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형을 사용중인 캠페인 체크 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemUnstrucDetailResDto getUsingByCampaignChk(SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);

		return systemUnstrucMapper.selectUsingByCampaignChk(param);
	}

	 /*
	  * 1. 메소드명: getUnstrucChk
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 정형/비정형 중복체크 
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemUnstrucDetailResDto getUnstrucChk(SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("t1");

		return systemUnstrucMapper.selectUnstrucChk(param);
	}

	 /*
	  * 1. 메소드명: addUnstrucItem
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 함수 유형 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto addUnstrucItem(SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
        String rid = CommonUtil.newRid();
        param.setRid(rid);
		StatusResDto rtnValue = new StatusResDto();
		systemUnstrucMapper.insertUnstrucItem(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editUnstrucItem
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 함수 유형 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto editUnstrucItem(SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		systemUnstrucMapper.updateUnstrucItem(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeUnstrucItem
	  * 2. 클래스명: LoyUnstrucService
	  * 3. 작성자명: jh.kim 
	  * 4. 작성일자: 2017. 6. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		이벤트 함수 유형 삭제 ( Flag 변경 )
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto removeUnstrucItem(SystemUnstrucDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		systemUnstrucMapper.deleteUnstrucItem(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

}
