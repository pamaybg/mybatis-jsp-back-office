package com.icignal.systemmanagement.apispec.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.channel.dto.response.LoyChannelListPageResDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiParamDetailReqDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiSpecFileListReqDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiSpecInsertReqDto;
import com.icignal.systemmanagement.apispec.dto.request.SystemApiSpecListReqDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiParamResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSendLogListResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSpecDetailResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSpecFileListResDto;
import com.icignal.systemmanagement.apispec.dto.response.SystemApiSpecListResDto;

/*
 * 1. 클래스명	: SystemApiSpecMapper
 * 2. 파일명	: SystemApiSpecMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.apispec.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *		API 정의서 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemApiSpecMapper {

	List<SystemApiSpecListResDto> getApiSpecList(SystemApiSpecListReqDto reqDto);

	void insertApiSpec(SystemApiSpecInsertReqDto reqDTO);

	void deleteApiSpec(SystemApiSpecListReqDto param);

	void updateApiSpec(SystemApiSpecListReqDto param);

	SystemApiSpecDetailResDto apiSpecDetail(SystemApiSpecListReqDto param);

	List<SystemApiSpecFileListResDto> apiSpecFileList(SystemApiSpecFileListReqDto param);

	void apiSpecUpload(SystemApiSpecFileListReqDto reqDTO);

	void fileRemove(SystemApiSpecListReqDto param);

	void insertApiSpecFileList(SystemApiSpecFileListReqDto param);

	 /*
	  * 1. 메소드명: selectApiSendLogList
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api명세서 - api 전송로그 리스트 탭
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<SystemApiSendLogListResDto> selectApiSendLogList(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectApiChnlList
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 명세서 - 상세 채널리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyChannelListPageResDto> selectApiChnlList(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertApiSpectJoinChnl
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 명세서 상세 채널 등록 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertApiSpectJoinChnl(SystemApiSpecListReqDto reqDto);
	Integer checkApiChnlCnt(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteApiChnl
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 명세서 상세 채널 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteApiChnl(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectApiSpecNo
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api번호 채번
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	SystemApiSpecListResDto selectApiSpecNo(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectApiSpecListPop
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api 리스트 팝업(API 상세 채널탭 -  채널 복사에 사용)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	List<SystemApiSpecListResDto> selectApiSpecListPop(SystemApiSpecListReqDto param);
	
	 /*
	  * 1. 메소드명: copyApiChnl
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		API 상세 채널 복사
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void copyApiChnl(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectApiParamList
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<SystemApiParamResDto> selectApiParamList(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectApiParamResList
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<SystemApiParamResDto> selectApiParamResList(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectParamResDetail
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	SystemApiParamResDto selectParamReqDetail(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectParamResDetail
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	SystemApiParamResDto selectParamResDetail(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: insettApiParamReq
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void insertApiParamReq(SystemApiParamDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateApiParamReq
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void updateApiParamReq(SystemApiParamDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteApiParamReq
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	
	void deleteApiParamReq(SystemApiParamDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectParParamList
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	List<SystemApiParamResDto> selectParParamList(SystemApiSpecListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectParamSeqNo
	  * 2. 클래스명: SystemApiSpecMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 9. 24.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	String selectParamSeqNo(SystemApiParamDetailReqDto reqDto);

}
