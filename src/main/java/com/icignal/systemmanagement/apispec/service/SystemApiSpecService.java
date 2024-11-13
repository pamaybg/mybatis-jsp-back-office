package com.icignal.systemmanagement.apispec.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
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
import com.icignal.systemmanagement.apispec.mapper.SystemApiSpecMapper;


/*
 * 1. 클래스명	: SystemApiSpecService
 * 2. 파일명	: SystemApiSpecService.java
 * 3. 패키지명	: com.icignal.systemmanagement.apispec.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *		API 정의서 Service
 * </PRE>
 */ 
@Service("SystemApiSpecService")
public class SystemApiSpecService {

	@Autowired
	SystemApiSpecMapper SystemApiSpecMapper;

	 /*
	  * 1. 메소드명: getApiSpecList
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2019. 11. 12.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		 api정의서 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<SystemApiSpecListResDto> getApiSpecList(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<SystemApiSpecListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.getApiSpecList(reqDto), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: insertApiSpec
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2019. 11. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api정의서 신규
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto insertApiSpec(SystemApiSpecInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		String rid = CommonUtil.newRid();
		reqDTO.setRid(rid);
		SystemApiSpecMapper.insertApiSpec(reqDTO);
		rtnValue.setMessage(rid);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: deleteApiSpec
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2019. 11. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api정의서 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto deleteApiSpec(SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		
		SystemApiSpecMapper.deleteApiSpec(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: updateApiSpec
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2019. 11. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api정의서 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto updateApiSpec(SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		SystemApiSpecMapper.updateApiSpec(param);
		rtnValue.setMessage(param.getRid());
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: apiSpecDetail
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2019. 11. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api정의서 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public SystemApiSpecDetailResDto apiSpecDetail(SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return SystemApiSpecMapper.apiSpecDetail(param);
	}

	 /*
	  * 1. 메소드명: apiSpecFileListf
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api정의서 파일리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemApiSpecFileListResDto> apiSpecFileList(SystemApiSpecFileListReqDto param) {
		LogUtil.param(this.getClass(), param);
		param.setSVCAlias("");
		
		return new GridPagingResHelper<SystemApiSpecFileListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.apiSpecFileList(param), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: insertApiSpecFileList
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2019. 11.14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api 정의서 파일 첨부
	 * 2. 사용법
	 *		xml 구현 안되있음
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto insertApiSpecFileList(SystemApiSpecFileListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		SystemApiSpecMapper.insertApiSpecFileList(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: apiSpecUpload
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api 정의서 업로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto apiSpecUpload(SystemApiSpecFileListReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		reqDTO.setSVCAlias("");
		SystemApiSpecMapper.apiSpecUpload(reqDTO);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: fileRemove
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: yj.choi
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api정의서 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto fileRemove(SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		SystemApiSpecMapper.fileRemove(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getApiSendLogList
	  * 2. 클래스명: SystemApiSpecService
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
	public GridPagingResDto<SystemApiSendLogListResDto> getApiSendLogList(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemApiSendLogListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.selectApiSendLogList(reqDto));
	}

	 /*
	  * 1. 메소드명: getApiChnlList
	  * 2. 클래스명: SystemApiSpecService
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
	public GridPagingResDto<LoyChannelListPageResDto> getApiChnlList(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyChannelListPageResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.selectApiChnlList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: apiSpecJoinChnl
	  * 2. 클래스명: SystemApiSpecService
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
	 *   @return	
	 */
	public StatusResDto apiSpecJoinChnl(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		int apiChnlCnt = SystemApiSpecMapper.checkApiChnlCnt(reqDto);
		if(apiChnlCnt > 0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 존재하는 채널입니다.");
		}else {
			reqDto.setRid(CommonUtil.newRid());
			SystemApiSpecMapper.insertApiSpectJoinChnl(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeApiChnl
	  * 2. 클래스명: SystemApiSpecService
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
	 *   @return	
	 */
	public StatusResDto removeApiChnl(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		SystemApiSpecMapper.deleteApiChnl(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getApiSpecNo
	  * 2. 클래스명: SystemApiSpecService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		api 번호 채번
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public SystemApiSpecListResDto getApiSpecNo(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return SystemApiSpecMapper.selectApiSpecNo(reqDto);
	}
	

	 /*
	  * 1. 메소드명: getApiSpecListPop
	  * 2. 클래스명: SystemApiSpecService
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
	public GridPagingResDto<SystemApiSpecListResDto> getApiSpecListPop(SystemApiSpecListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<SystemApiSpecListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.selectApiSpecListPop(param), AnnotationType.CommCode) ;
	}

	 /*
	  * 1. 메소드명: copyApiChnl
	  * 2. 클래스명: SystemApiSpecService
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
	 *   @return	
	 */
	public StatusResDto copyApiChnl(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		SystemApiSpecMapper.copyApiChnl(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getapiParamList
	  * 2. 클래스명: SystemApiSpecService
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
	
	public GridPagingResDto<SystemApiParamResDto> getApiParamList(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemApiParamResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.selectApiParamList(reqDto), AnnotationType.CommCode) ;
	}

	 /*
	  * 1. 메소드명: getApiParamResList
	  * 2. 클래스명: SystemApiSpecService
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
	
	public GridPagingResDto<SystemApiParamResDto> getApiParamResList(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemApiParamResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.selectApiParamResList(reqDto), AnnotationType.CommCode) ;
	}

	 /*
	  * 1. 메소드명: getParamResDetail
	  * 2. 클래스명: SystemApiSpecService
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
	
	public SystemApiParamResDto getParamReqDetail(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return SystemApiSpecMapper.selectParamReqDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: getParamResDetail
	  * 2. 클래스명: SystemApiSpecService
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
	
	public SystemApiParamResDto getParamResDetail(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return SystemApiSpecMapper.selectParamResDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveApiParamReq
	  * 2. 클래스명: SystemApiSpecService
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
	
	public StatusResDto saveApiParamReq(SystemApiParamDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		reqDto.setRid(CommonUtil.newRid());
		String seqNo = SystemApiSpecMapper.selectParamSeqNo(reqDto);
		reqDto.setSeqNo(seqNo);
		SystemApiSpecMapper.insertApiParamReq(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editApiParamReq
	  * 2. 클래스명: SystemApiSpecService
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
	
	public StatusResDto editApiParamReq(SystemApiParamDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		SystemApiSpecMapper.updateApiParamReq(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeApiParam
	  * 2. 클래스명: SystemApiSpecService
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
	
	public StatusResDto removeApiParam(SystemApiParamDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		SystemApiSpecMapper.deleteApiParamReq(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getParParamList
	  * 2. 클래스명: SystemApiSpecService
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
	
	public GridPagingResDto<SystemApiParamResDto> getParParamList(SystemApiSpecListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<SystemApiParamResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), SystemApiSpecMapper.selectParParamList(reqDto), AnnotationType.CommCode) ;
	}


}
