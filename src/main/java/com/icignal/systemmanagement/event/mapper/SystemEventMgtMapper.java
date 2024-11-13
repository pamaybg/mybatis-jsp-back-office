package com.icignal.systemmanagement.event.mapper;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventAnnounceUpdateReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventInsertReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventListReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventPartiListReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventSubInfoInsertReqDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventAnnounceDetailResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventDetailResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventListResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventPartiListResDto;

/*
 * 1. 클래스명	: SystemEventMgtMapper
 * 2. 파일명	: SystemEventMgtMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.event.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		Event 관리 Mapper
 * </PRE>
 */ 
public interface SystemEventMgtMapper {

	List<SystemEventListResDto> getEventList(SystemEventListReqDto reqDTO);

	void updateEventInfo(SystemEventInsertReqDto reqDTO);

	void insertEventInfo(SystemEventInsertReqDto reqDTO);

	SystemEventDetailResDto getEventInfoDetail(SystemEventListReqDto reqDTO);

	List<SystemEventPartiListResDto> getEventParti(SystemEventPartiListReqDto reqDTO);

	void updateWinnerFlag(SystemEventPartiListReqDto reqDTO);

	void updateMasterAnnounce(SystemEventAnnounceUpdateReqDto reqDTO);

	void updateAnnounce(SystemEventAnnounceUpdateReqDto reqDTO);

	SystemEventDetailResDto getCheckEvent(SystemEventListReqDto reqDTO);

	SystemEventDetailResDto getEventSubInfoDetail(SystemEventListReqDto reqDTO);

	void updateEventSubInfo(SystemEventSubInfoInsertReqDto reqDTO);

	StatusResDto insertEventSubInfo(SystemEventSubInfoInsertReqDto reqDTO);

	List<String> getLangList(SystemEventListReqDto reqDTO);

	SystemEventAnnounceDetailResDto getAnnounceDetail(SystemEventListReqDto reqDTO);

}
