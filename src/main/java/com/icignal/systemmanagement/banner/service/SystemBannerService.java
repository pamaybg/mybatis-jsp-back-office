package com.icignal.systemmanagement.banner.service;

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
import com.icignal.external.aws.S3Manager;
import com.icignal.systemmanagement.banner.dto.request.SystemBannerInsertReqDto;
import com.icignal.systemmanagement.banner.dto.request.SystemBannerReqDto;
import com.icignal.systemmanagement.banner.dto.response.SystemBannerDetailResDto;
import com.icignal.systemmanagement.banner.dto.response.SystemBannerListResDto;
import com.icignal.systemmanagement.banner.mapper.SystemBannerMapper;

/*
 * 1. 클래스명	: SystemBannerService
 * 2. 파일명	: SystemBannerService.java
 * 3. 패키지명	: com.icignal.systemmanagement.banner.service
 * 4. 작성자명	: mjpyo
 * 5. 작성일자	: 2017. 03. 20
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 배너 관리 Service
 * </PRE>
 */ 
@Service("SystemBannerService")
public class SystemBannerService {

	@Autowired
	private SystemBannerMapper systemBannerMapper;
	
	@Autowired
	private CommonService CommonService;

	 /*
	  * 1. 메소드명: getBannerList
	  * 2. 클래스명: SystemBannerService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 20
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public GridPagingResDto<SystemBannerListResDto> getBannerList(SystemBannerReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("a");

		
		 return new GridPagingResHelper<SystemBannerListResDto>().newGridPagingResDto(reqDTO.init(CommonUtil.getInstance().getDBType()), systemBannerMapper.getBannerList(reqDTO));
		 

	}

	 /*
	  * 1. 메소드명: insertBanner
	  * 2. 클래스명: SystemBannerService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 20
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 신규등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto insertBanner(SystemBannerInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		reqDTO.setSVCAlias("");

		rtnValue.setSuccess(false);

		if(reqDTO.getUpdateFlag()){
			systemBannerMapper.updateBanner(reqDTO);
			rtnValue.setMessage("updateBanner");
			rtnValue.setSuccess(true);
		}
		else{
			reqDTO.setBannerId(CommonUtil.newRid());
			systemBannerMapper.insertBanner(reqDTO);
			rtnValue.setMessage("insertBanner");
			rtnValue.setSuccess(true);
			reqDTO.setBannerSubId(rtnValue.getMessage());
		}

		try{

			//event 메인배너 이미지 등록
			if(rtnValue.getSuccess() && reqDTO.getSubImages() != null && reqDTO.getSubImages().size() > 0){

				for(MultiUploadReqDto mur : reqDTO.getSubImages()) {
					mur.setParentId(reqDTO.getBannerSubId());
					mur.setCategory(IMAGE_UPLOAD_TYPE.Banner);
					/*mur.setFileName(reqDTO.getAppMainBannerSubImageFileNames());
					mur.setFilePath(reqDTO.getAppMainBannerSubImageFilePaths());
					mur.setOriName(reqDTO.getAppMainBannerSubImageOriNames());
					mur.setRotateAngle(reqDTO.getAppMainBannerSubImageRotateAngles());*/
					mur.setSchemas("com");
					mur.setLang(reqDTO.getLang());
					mur.setImageLang(reqDTO.getBannerLang());
					mur.setSize(mur.getSize());

				}
				CommonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(), reqDTO.getSubImages());

	        } else {
	        	String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");

	        	MultiUploadReqDto muReqSub = new MultiUploadReqDto();
	        	muReqSub.setParentId(reqDTO.getBannerSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.Banner);
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getBannerLang());

				List<String> orgImages = CommonService.getParentImages(muReqSub);
				for(String orgImage : orgImages) {
					try {
						// AWSCloudFrontConfig 아직 이관하지 않음
						//AWSCloudFrontConfig.getS3Client().deleteObject(bucket, orgImage);
	
						S3Manager s3 = new S3Manager();
						s3.setBucketName(bucket);
						s3.deleteObject(orgImage);
						
						System.out.format("Deleting %s to S3 bucket %s...\n", orgImage, bucket);
					} catch(AmazonServiceException e) {
						LogUtil.error(e);
					}
				}
	        }

			rtnValue.setSuccess(true);

		}
		catch( Exception e ){
			LogUtil.error(e);
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e.getMessage());
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getBannerDetail
	  * 2. 클래스명: SystemBannerService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2017. 03. 20
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemBannerDetailResDto getBannerDetail(SystemBannerReqDto  reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		SystemBannerDetailResDto rtnValue = new SystemBannerDetailResDto();
		reqDTO.setSVCAlias("");
		String BannerId = systemBannerMapper.getBannerId(reqDTO);
		 
		 if(BannerId != null){
			 reqDTO.setSVCAlias("ln");
			 reqDTO.setBannerSubId(BannerId);
			 rtnValue= systemBannerMapper.getBannerDetail(reqDTO);
		 }


		return rtnValue;
	}


	 /*
	  * 1. 메소드명: increaseBannerCount
	  * 2. 클래스명: SystemBannerService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2017. 03. 20
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto increaseBannerCount(SystemBannerReqDto  reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		reqDTO.setSVCAlias("");
		systemBannerMapper.increaseBannerCount(reqDTO);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: insertBannerMaster
	  * 2. 클래스명: SystemBannerService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 04. 05
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 마스터 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto insertBannerMaster(SystemBannerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();

		if(reqDTO.getBannerStatus().equals("true")){
			reqDTO.setBannerStatus("Y");
		}
		else{
			reqDTO.setBannerStatus("N");
		}

		if(reqDTO.getUpdateFlag()){
			systemBannerMapper.updateBannerMaster(reqDTO);
			rtnValue.setMessage("updateBannerMaster");
			rtnValue.setSuccess(true);
		}
		else{
			reqDTO.setBannerId(CommonUtil.newRid());
			systemBannerMapper.insertBannerMaster(reqDTO);
			rtnValue.setMessage("insertBannerMaster");
			rtnValue.setSuccess(true);
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getBannerMasterDetail
	  * 2. 클래스명: SystemBannerService
	  * 3. 작성자명: mjpyo
	  * 4. 작성일자: 2017. 03. 23
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		공지사항 마스터 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public SystemBannerDetailResDto getBannerMasterDetail(SystemBannerReqDto  reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lnm");

		return systemBannerMapper.getBannerMasterDetail(reqDTO);
	}

}
