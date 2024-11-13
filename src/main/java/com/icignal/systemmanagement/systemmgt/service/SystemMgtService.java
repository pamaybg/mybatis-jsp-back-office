package com.icignal.systemmanagement.systemmgt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtDetailReqDto;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtListReqDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtDetailResDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtListResDto;
import com.icignal.systemmanagement.systemmgt.mapper.SystemMgtMapper;

@Service
public class SystemMgtService {

	@Autowired
	private SystemMgtMapper systemMgtMapper;
	
	 /*
	  * 1. 메소드명: getSystemMgtList
	  * 2. 클래스명: SystemMgtService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemMgtListResDto> getSystemMgtList(SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<SystemMgtListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), systemMgtMapper.selectSystemMgtList(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getSystemMgtDetail
	  * 2. 클래스명: SystemMgtService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 관리 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemMgtDetailResDto getSystemMgtDetail(SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(), param);
//		return new AnnotationHelper<SystemMgtDetailResDto>(AnnotationType.ALL, systemMgtMapper.selectSystemMgtDetail(param)).getItem();
		return systemMgtMapper.selectSystemMgtDetail(param);
	}

	 /*
	  * 1. 메소드명: removeSystemMgt
	  * 2. 클래스명: SystemMgtService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto removeSystemMgt(SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		systemMgtMapper.deleteSystemMgt(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: saveSystemMgtDetail
	  * 2. 클래스명: SystemMgtService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 상세 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemMgtDetailResDto saveSystemMgtDetail(SystemMgtDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		SystemMgtDetailResDto rtnValue = new SystemMgtDetailResDto();
		rtnValue.setSuccess(false);
		String rid = CommonUtil.newRid();
		param.setRid(rid);
		systemMgtMapper.insertSystemMgtDetail(param);
		rtnValue.setRid(rid);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifySystemMgtDetail
	  * 2. 클래스명: SystemMgtService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemMgtDetailResDto modifySystemMgtDetail(SystemMgtDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		SystemMgtDetailResDto rtnValue = new SystemMgtDetailResDto();
		rtnValue.setSuccess(false);
		systemMgtMapper.updateSystemMgtDetail(param);
		rtnValue.setRid(param.getRid());
		rtnValue.setSuccess(true);
		return rtnValue;
	}

}
