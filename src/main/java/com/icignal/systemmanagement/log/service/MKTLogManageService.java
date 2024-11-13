package com.icignal.systemmanagement.log.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.systemmanagement.log.dto.request.MKTLogManageListReqDto;
import com.icignal.systemmanagement.log.dto.response.MKTLogManageListResDto;
import com.icignal.systemmanagement.log.mapper.MKTLogManageMapper;


/*
 * 1. 클래스명	: MKTLogManageService
 * 2. 파일명	: MKTLogManageService.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 마켓팅 로그 관리 Service
 * </PRE>
 */ 
@Service("MKTLogManageService")
public class MKTLogManageService  {
	
	@Autowired
	private MKTLogManageMapper MKTLogManageMapper;

    /**
     * @name : getLogList
     * @date : 2018. 03. 08.
     * @author : hy.jun
     * @table : qim.qim_log
     * @return : GridPagingResponseDTO
     * @description : 인터페이스 목록 조회
     */
	public GridPagingResDto<MKTLogManageListResDto> getLogList(MKTLogManageListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<MKTLogManageListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), MKTLogManageMapper.getLogList(param));
	}
}
