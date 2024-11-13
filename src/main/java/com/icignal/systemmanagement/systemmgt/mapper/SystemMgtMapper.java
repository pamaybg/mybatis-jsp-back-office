package com.icignal.systemmanagement.systemmgt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtDetailReqDto;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtListReqDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtDetailResDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtListResDto;

@Mapper
public interface SystemMgtMapper {

	 /*
	  * 1. 메소드명: selectSystemMgtList
	  * 2. 클래스명: SystemMgtMapper
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
	List<SystemMgtListResDto> selectSystemMgtList(SystemMgtListReqDto param);

	 /*
	  * 1. 메소드명: selectSystemMgtDetail
	  * 2. 클래스명: SystemMgtMapper
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
	SystemMgtDetailResDto selectSystemMgtDetail(SystemMgtListReqDto param);

	 /*
	  * 1. 메소드명: deleteSystemMgt
	  * 2. 클래스명: SystemMgtMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	void deleteSystemMgt(SystemMgtListReqDto param);

	 /*
	  * 1. 메소드명: insertSystemMgtDetail
	  * 2. 클래스명: SystemMgtMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		사이트 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param	
	 */
	void insertSystemMgtDetail(SystemMgtDetailReqDto param);

	 /*
	  * 1. 메소드명: updateSystemMgtDetail
	  * 2. 클래스명: SystemMgtMapper
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
	 */
	void updateSystemMgtDetail(SystemMgtDetailReqDto param);

}
