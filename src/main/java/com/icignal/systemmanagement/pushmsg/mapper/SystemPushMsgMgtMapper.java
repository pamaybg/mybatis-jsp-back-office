package com.icignal.systemmanagement.pushmsg.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMemberListReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMsgDetailReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMsgInsertReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemTestPushResultListReqDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMemberListResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMsgDetailResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMsgListResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemTestPushResultListResDto;

/*
 * 1. 클래스명	: SystemPushMsgMgtMapper
 * 2. 파일명	: SystemPushMsgMgtMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.pushmsg.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 4.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템운영 - push message 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemPushMsgMgtMapper {

	List<SystemPushMsgListResDto> getPushMsgList(SystemPushMsgDetailReqDto reqDTO);

	void updatePushMsg(SystemPushMsgInsertReqDto reqDTO);
	
	void updatePushMsgLog(SystemPushMsgInsertReqDto reqDTO);

	void insertPushMsg(SystemPushMsgInsertReqDto reqDTO);
	
	void insertPushMsgLog(SystemPushMsgInsertReqDto reqDTO);

	void insertPushMbr(SystemPushMsgInsertReqDto reqDTO);

	SystemPushMsgDetailResDto getPushMsgDetail(SystemPushMsgDetailReqDto reqDTO);

	void getPushMsgCancel(SystemPushMsgDetailReqDto reqDTO);
	
	void getPushMsgLogCancel(SystemPushMsgDetailReqDto reqDTO);

	List<SystemPushMemberListResDto> selectPushMemberList(SystemPushMemberListReqDto reqDto);

	List<SystemTestPushResultListResDto> getTestPushResultList(SystemTestPushResultListReqDto reqDto);









}
