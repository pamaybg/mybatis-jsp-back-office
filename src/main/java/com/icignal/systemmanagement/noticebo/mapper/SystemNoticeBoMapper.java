package com.icignal.systemmanagement.noticebo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.noticebo.dto.request.SystemNoticeBoListReqDto;
import com.icignal.systemmanagement.noticebo.dto.response.SystemNoticeBoListResDto;
import com.icignal.systemmanagement.noticebo.dto.response.SystemNoticeBoResDto;

/*
 * 1. 클래스명	: SystemNoticeBoMapper
 * 2. 파일명	: SystemNoticeBoMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.noticebo.mapper
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 9. 21.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 공지사항 (BO) Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemNoticeBoMapper {

	 /*
	  * 1. 메소드명: selectNoticeBoList
	  * 2. 클래스명: SystemNoticeBoMapper
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
	List<SystemNoticeBoListResDto> selectNoticeBoList(SystemNoticeBoListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertNoticeBo
	  * 2. 클래스명: SystemNoticeBoMapper
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
	 */
	void insertNoticeBo(SystemNoticeBoListReqDto reqDto);

	 /*
	  * 1. 메소드명: updateNoticeBo
	  * 2. 클래스명: SystemNoticeBoMapper
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
	 */
	void updateNoticeBo(SystemNoticeBoListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteNoticeBo
	  * 2. 클래스명: SystemNoticeBoMapper
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
	 */
	void deleteNoticeBo(SystemNoticeBoListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectNoticeBoDetail
	  * 2. 클래스명: SystemNoticeBoMapper
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
	SystemNoticeBoResDto selectNoticeBoDetail(SystemNoticeBoListReqDto reqDto);

}
