package com.icignal.systemmanagement.event.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.amazonaws.AmazonServiceException;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.external.aws.S3Manager;
import com.icignal.systemmanagement.event.dto.request.SystemEventAnnounceUpdateReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventInsertReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventListReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventPartiListReqDto;
import com.icignal.systemmanagement.event.dto.request.SystemEventSubInfoInsertReqDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventAnnounceDetailResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventDetailResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventListResDto;
import com.icignal.systemmanagement.event.dto.response.SystemEventPartiListResDto;
import com.icignal.systemmanagement.event.mapper.SystemEventMgtMapper;

/*
 * 1. 클래스명	: SystemEventMgtService
 * 2. 파일명	: SystemEventMgtService.java
 * 3. 패키지명	: com.icignal.systemmanagement.event.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		Event 관리 Controller
 * </PRE>
 */ 
@Service("SystemEventMgtService")
public class SystemEventMgtService {

	@Autowired
	SystemEventMgtMapper systemEventMgtMapper;
	
	@Autowired
	CommonService CommonService;
	
	 /*
	  * 1. 메소드명: getEventList
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		event 리스트
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public GridPagingResDto<SystemEventListResDto> getEventList(SystemEventListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lv");

		return new GridPagingResHelper<SystemEventListResDto>().newGridPagingResDto(
				reqDTO.init(CommonUtil.getInstance().getDBType()), systemEventMgtMapper.getEventList(reqDTO), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: insertEventInfo
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		event 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto insertEventInfo(SystemEventInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		reqDTO.setSVCAlias("");
		rtnValue.setSuccess(false);

		if (reqDTO.getUpdateFlag()) {
			systemEventMgtMapper.updateEventInfo(reqDTO);
			rtnValue.setMessage("updateEventInfo");
			rtnValue.setSuccess(true);
			
		} else {
			reqDTO.setEventId(CommonUtil.newRid());
			systemEventMgtMapper.insertEventInfo(reqDTO);
			rtnValue.setMessage("insertEventInfo");
			rtnValue.setSuccess(true);
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getEventInfoDetail
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventInfo 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemEventDetailResDto getEventInfoDetail(SystemEventListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("le");
		return systemEventMgtMapper.getEventInfoDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: getEventParti
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public GridPagingResDto<SystemEventPartiListResDto> getEventParti(SystemEventPartiListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lem");
		return new GridPagingResHelper<SystemEventPartiListResDto>().newGridPagingResDto(
				reqDTO.init(CommonUtil.getInstance().getDBType()), systemEventMgtMapper.getEventParti(reqDTO), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: updateWinnerFlag
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 참여 당첨 여부
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto updateWinnerFlag(SystemEventPartiListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("");
		StatusResDto rtnValue  = new StatusResDto();
		systemEventMgtMapper.updateWinnerFlag(reqDTO);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: updateAnnounce
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 03. 29.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventParti 이벤트 당첨자 발표
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto updateAnnounce(SystemEventAnnounceUpdateReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		reqDTO.setSVCAlias("");
		try {
			systemEventMgtMapper.updateMasterAnnounce(reqDTO);
			systemEventMgtMapper.updateAnnounce(reqDTO);
			rtnValue.setSuccess(true);
			
		} catch (IllegalArgumentException e) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("먼저 이벤트를 등록해주세요.");
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getEventSubInfoDetail
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventSubInfo 이벤트상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemEventDetailResDto getEventSubInfoDetail(SystemEventListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		SystemEventDetailResDto rtnValue = new SystemEventDetailResDto();
		SystemEventDetailResDto check = new SystemEventDetailResDto();

		reqDTO.setSVCAlias("");
		check = systemEventMgtMapper.getCheckEvent(reqDTO);

		if (check != null) {
			reqDTO.setSVCAlias("les");
			reqDTO.setEventSubId(check.getEventSubId());
			rtnValue = systemEventMgtMapper.getEventSubInfoDetail(reqDTO);
			List log = rtnValue.getImagesEvent();
			List log2 = rtnValue.getImages();

		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: insertEventSubInfo
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 04. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		eventSubInfo 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto insertEventSubInfo(SystemEventSubInfoInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		if (reqDTO.getUpdateFlag()) {
			systemEventMgtMapper.updateEventSubInfo(reqDTO);
			rtnValue.setMessage("updateEventSubInfo");
			rtnValue.setSuccess(true);
		} else {
			reqDTO.setEventSubId(CommonUtil.newRid());
			rtnValue = systemEventMgtMapper.insertEventSubInfo(reqDTO);
			rtnValue.setMessage("insertEventSubInfo");
			rtnValue.setSuccess(true);
		}

		try {

			// event 메인배너 이미지 등록
			if (rtnValue.getSuccess() && reqDTO.getAppMainBannerSubImages() != null
					&& reqDTO.getAppMainBannerSubImages().size() > 0) {
				for (MultiUploadReqDto mur : reqDTO.getAppMainBannerSubImages()) {
					mur.setParentId(reqDTO.getEventSubId());
					mur.setCategory(IMAGE_UPLOAD_TYPE.EVENT_MAIN_BANNER);
					mur.setSchemas("com");
					mur.setLang(reqDTO.getLang());
					mur.setImageLang(reqDTO.getEventLang());
					mur.setSize(mur.getSize());

				}
				CommonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(),
						reqDTO.getAppMainBannerSubImages());

			} else {
				String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");
				
				MultiUploadReqDto muReqSub = new MultiUploadReqDto();
				muReqSub.setParentId(reqDTO.getEventSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.EVENT_MAIN_BANNER);
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getEventLang());

				List<String> orgImages = CommonService.getParentImages(muReqSub);
				for (String orgImage : orgImages) {
					try {
						//AWSCloudFrontConfig.getS3Client().deleteObject(bucket, orgImage);
						System.out.format("Deleting %s to S3 bucket %s...\n", orgImage, bucket);
					} catch (AmazonServiceException e) {
						LogUtil.error(e);
					}
				}
			}

//			event 배너 이미지 등록
			if (rtnValue.getSuccess() && reqDTO.getEventBannerSubImages() != null
					&& reqDTO.getEventBannerSubImages().size() > 0) {
				for (MultiUploadReqDto mur : reqDTO.getEventBannerSubImages()) {
					mur.setParentId(reqDTO.getEventSubId());
					mur.setCategory(IMAGE_UPLOAD_TYPE.EVENT_BANNER);
					mur.setSchemas("com");
					mur.setLang(reqDTO.getLang());
					mur.setImageLang(reqDTO.getEventLang());
					mur.setSize(mur.getSize());

				}
				CommonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(),
						reqDTO.getEventBannerSubImages());

			} else {
				String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");
				
				MultiUploadReqDto muReqSub = new MultiUploadReqDto();
				muReqSub.setParentId(reqDTO.getEventSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.EVENT_BANNER);
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getEventLang());

				List<String> orgImages = CommonService.getParentImages(muReqSub);
				for (String orgImage : orgImages) {
					try {
						//AWSCloudFrontConfig.getS3Client().deleteObject(bucket, orgImage);
						S3Manager s3 = new S3Manager();
						s3.setBucketName(bucket);
						s3.deleteObject(orgImage);
						System.out.format("Deleting %s to S3 bucket %s...\n", orgImage, bucket);
					} catch (AmazonServiceException e) {
						LogUtil.error(e);
					}
				}
			}

			rtnValue.setSuccess(true);

		} catch (IllegalArgumentException e) {
			LogUtil.error(e);
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e.getMessage());
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAnnounceDetail
	  * 2. 클래스명: SystemEventMgtService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 04. 04.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		당첨자 발표 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemEventAnnounceDetailResDto getAnnounceDetail(SystemEventListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		SystemEventAnnounceDetailResDto rtnValue = new SystemEventAnnounceDetailResDto();

		reqDTO.setSVCAlias("");
		List<String> langList = new ArrayList<String>();
		langList = systemEventMgtMapper.getLangList(reqDTO);
		reqDTO.setSVCAlias("les");
		rtnValue = systemEventMgtMapper.getAnnounceDetail(reqDTO);
		rtnValue.setLangList(langList);

		return rtnValue;
	}

}
