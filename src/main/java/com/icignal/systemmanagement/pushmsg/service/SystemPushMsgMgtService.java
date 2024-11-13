package com.icignal.systemmanagement.pushmsg.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;

import com.icignal.common.util.LogUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMemberListReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMsgDetailReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemPushMsgInsertReqDto;
import com.icignal.systemmanagement.pushmsg.dto.request.SystemTestPushResultListReqDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMemberListResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMsgDetailResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemPushMsgListResDto;
import com.icignal.systemmanagement.pushmsg.dto.response.SystemTestPushResultListResDto;
import com.icignal.systemmanagement.pushmsg.mapper.SystemPushMsgMgtMapper;

/*
 * 1. 클래스명	: PushMsgMgtService
 * 2. 파일명	: PushMsgMgtService.java
 * 3. 패키지명	: com.icignal.systemmanagement.pushmsg.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - push message 관리 Controller
 * </PRE>
 */ 
@Service("PushMsgMgtService")
public class SystemPushMsgMgtService {

	@Autowired
	SystemPushMsgMgtMapper syspushMsgMgtMapper;

	 /*
	  * 1. 메소드명: getPushMsgList
	  * 2. 클래스명: PushMsgMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public GridPagingResDto<SystemPushMsgListResDto> getPushMsgList(SystemPushMsgDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		return new GridPagingResHelper<SystemPushMsgListResDto>().newGridPagingResDto(
				reqDTO.init(CommonUtil.getInstance().getDBType()), syspushMsgMgtMapper.getPushMsgList(reqDTO), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: insertPushMsg
	  * 2. 클래스명: PushMsgMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto insertPushMsg(SystemPushMsgInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);

		StatusResDto rtnValue = new StatusResDto();

		if (reqDTO.getUpdateFlag()) {

			syspushMsgMgtMapper.updatePushMsg(reqDTO);
			syspushMsgMgtMapper.updatePushMsgLog(reqDTO);

			rtnValue.setSuccess(true);
		} else {

			if (reqDTO.getPushLang().equals("ko")) {
				reqDTO.setNatnCd("KR");
			} else if (reqDTO.getPushLang().equals("zh")) {
				reqDTO.setNatnCd("CN");
			} else {
				reqDTO.setNatnCd("US");
			}
			
			// 조회 테이블 등록
			reqDTO.setInsertPushMsgRid(CommonUtil.newRid());
			syspushMsgMgtMapper.insertPushMsg(reqDTO);
			rtnValue.setMessage(reqDTO.getPushMsgId());
			// log 테이블 등록
			reqDTO.setInsertPushMsgLogRid(CommonUtil.newRid());
			syspushMsgMgtMapper.insertPushMsgLog(reqDTO);

			reqDTO.setInsertPushMbrRid(CommonUtil.newRid()); 
			syspushMsgMgtMapper.insertPushMbr(reqDTO);
			rtnValue.setSuccess(true);

			rtnValue.setSuccess(true);
		}

		if (rtnValue.getSuccess() && reqDTO.getSubImages() != null && reqDTO.getSubImages().size() > 0) {
			MultiUploadReqDto muReqSub = new MultiUploadReqDto();

			for (int i = 0; i < reqDTO.getSubImages().size(); i++) {
				muReqSub.setParentId(reqDTO.getPushMsgId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.PUSH_MESSAGE);
				muReqSub.setFileName(reqDTO.getSubImageFileNames());
				muReqSub.setFilePath(reqDTO.getSubImageFilePaths());
				muReqSub.setOriName(reqDTO.getSubImageOriNames());
				muReqSub.setRotateAngle(reqDTO.getSubImageRotateAngles());
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getImageLang());

				// MKTBaseService.multiUploadImage(session.getServletContext().getRealPath("/"),
				// session.getId(), muReqSub);
			}

		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getPushMsgDetail
	  * 2. 클래스명: PushMsgMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemPushMsgDetailResDto getPushMsgDetail(SystemPushMsgDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		return syspushMsgMgtMapper.getPushMsgDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: getPushMsgCancel
	  * 2. 클래스명: PushMsgMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 10
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 메세지 취소
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto getPushMsgCancel(SystemPushMsgDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		syspushMsgMgtMapper.getPushMsgCancel(reqDTO);
		syspushMsgMgtMapper.getPushMsgLogCancel(reqDTO);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getPushMemberList
	  * 2. 클래스명: PushMsgMgtService
	  * 3. 작성자명: km1.park 
	  * 4. 작성일자: 2017. 7. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		푸시 발송 대상 선정을 위한 회원 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	public GridPagingResDto<SystemPushMemberListResDto> getPushMemberList(SystemPushMemberListReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		// reqDto.setCiperKey(CryptoManager.getCipherKey());
		return new GridPagingResHelper<SystemPushMemberListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), syspushMsgMgtMapper.selectPushMemberList(reqDto), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: getTestPushResultList
	  * 2. 클래스명: PushMsgMgtService
	  * 3. 작성자명: km1.park 
	  * 4. 작성일자: 2017. 7. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		테스트 푸시 발송 결과 조회(푸시 발송 대상자들의 발송 상태)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 *   @throws Exception	
	 */
	public GridPagingResDto<SystemTestPushResultListResDto> getTestPushResultList(SystemTestPushResultListReqDto reqDto)
			throws Exception {
		LogUtil.param(this.getClass(), reqDto);
		// reqDto.setCiperKey(CryptoManager.getCipherKey());
		return new GridPagingResHelper<SystemTestPushResultListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), syspushMsgMgtMapper.getTestPushResultList(reqDto), AnnotationType.PersonalData);
	}

}
