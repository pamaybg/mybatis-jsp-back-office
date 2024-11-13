package com.icignal.systemmanagement.noticebo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.noticebo.dto.request.SystemNoticeBoListReqDto;
import com.icignal.systemmanagement.noticebo.dto.response.SystemNoticeBoListResDto;
import com.icignal.systemmanagement.noticebo.dto.response.SystemNoticeBoResDto;
import com.icignal.systemmanagement.noticebo.mapper.SystemNoticeBoMapper;

/*
 * 1. 클래스명	: SystemNoticeBoService
 * 2. 파일명	: SystemNoticeBoService.java
 * 3. 패키지명	: com.icignal.systemmanagement.noticebo.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 9. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 공지사항 (BO) Service
 * </PRE>
 */ 
@Service
public class SystemNoticeBoService {
	
	@Autowired
	private SystemNoticeBoMapper systemNoticeBoMapper;

	 /*
	  * 1. 메소드명: getNoticeBoList
	  * 2. 클래스명: SystemNoticeBoService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemNoticeBoListResDto> getNoticeBoList(SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemNoticeBoListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), systemNoticeBoMapper.selectNoticeBoList(reqDto));
	}

	 /*
	  * 1. 메소드명: saveNoticeBo
	  * 2. 클래스명: SystemNoticeBoService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveNoticeBo(SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		reqDto.setRid(CommonUtil.newRid());
		systemNoticeBoMapper.insertNoticeBo(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyNoticeBo
	  * 2. 클래스명: SystemNoticeBoService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyNoticeBo(SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		systemNoticeBoMapper.updateNoticeBo(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeNoticeBo
	  * 2. 클래스명: SystemNoticeBoService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeNoticeBo(SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		systemNoticeBoMapper.deleteNoticeBo(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getNoticeBoDetail
	  * 2. 클래스명: SystemNoticeBoService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 (BO) 상세 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public SystemNoticeBoResDto getNoticeBoDetail(SystemNoticeBoListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return systemNoticeBoMapper.selectNoticeBoDetail(reqDto);
	}

}
