package com.icignal.systemmanagement.partner.service;

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
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.external.aws.S3Manager;
import com.icignal.systemmanagement.banner.dto.request.SystemImageInsertReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerDetailReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerInsertReqDto;
import com.icignal.systemmanagement.partner.dto.request.SystemPartnerListReqDto;
import com.icignal.systemmanagement.partner.dto.response.SystemPartnerDetailResDto;
import com.icignal.systemmanagement.partner.dto.response.SystemPartnerListResDto;
import com.icignal.systemmanagement.partner.mapper.SystemPartnerMapper;


/*
 * 1. 클래스명	: SystemPartnerService
 * 2. 파일명	: SystemPartnerService.java
 * 3. 패키지명	: com.icignal.systemmanagement.partner.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2017. 04. 05.
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템 운영 - 제휴 관리 Service
 * </PRE>
 */ 
@Service("SystemPartnerService")
public class SystemPartnerService {

	@Autowired
	private SystemPartnerMapper systemPartnerMapper;
	
	@Autowired
	private CommonService commonService;
	
//	@Autowired
//	private CommonMapper commonMapper;

	 /*
	  * 1. 메소드명: getPartnerList
	  * 2. 클래스명: SystemPartnerService
	  * 3. 작성자명: mj.kim 
	  * 4. 작성일자: 2019. 3. 22.
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
	public GridPagingResDto<SystemPartnerListResDto> getPartnerList(SystemPartnerListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("a");
		
		return new GridPagingResHelper<SystemPartnerListResDto>().newGridPagingResDto(
				reqDTO.init(CommonUtil.getInstance().getDBType()), systemPartnerMapper.getPartnerList(reqDTO), AnnotationType.CommCode);

	}


	 /*
	  * 1. 메소드명: insertPartner
	  * 2. 클래스명: SystemPartnerService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2019. 3. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @param session
	 *   @return	
	 */
	public StatusResDto insertPartner(SystemPartnerInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		SystemImageInsertReqDto check = new SystemImageInsertReqDto();

		check.setSuccess(false);
		rtnValue.setSuccess(false);
		reqDTO.setSVCAlias("");

		if(reqDTO.getUpdateFlag() ){
			systemPartnerMapper.insertPartner(reqDTO);
			
		}
		else{
			 systemPartnerMapper.insertPartner(reqDTO);
			reqDTO.setPtnrSubId(rtnValue.getMessage());
			
		}
		check.setMessage(reqDTO.getPtnrId());
	    check.setSuccess(true);
	    rtnValue.setSuccess(true);
//		try{

			//event 메인배너 이미지 등록
			if(rtnValue.getSuccess() && reqDTO.getSubImages() != null && reqDTO.getSubImages().size() > 0){

				for(MultiUploadReqDto mur : reqDTO.getSubImages()) {
					mur.setParentId(reqDTO.getPtnrSubId());
					mur.setCategory(IMAGE_UPLOAD_TYPE.PTNR_IMG);
					mur.setSchemas("com");
					mur.setLang(reqDTO.getLang());
					mur.setImageLang(reqDTO.getPtnrLang());
					mur.setSize(mur.getSize());

				}
				commonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(), reqDTO.getSubImages());

	        } else {
	        	//String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket");
	        	String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");

	        	MultiUploadReqDto muReqSub = new MultiUploadReqDto();
	        	muReqSub.setParentId(reqDTO.getPtnrSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.PTNR_IMG);
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getPtnrLang());

				List<String> orgImages = commonService.getParentImages(muReqSub);
				for(String orgImage : orgImages) {
					try {
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
//			event 배너 이미지 등록
			if(rtnValue.getSuccess() && reqDTO.getDetailImages() != null && reqDTO.getDetailImages().size() > 0){

				for(MultiUploadReqDto mur : reqDTO.getDetailImages()) {
					mur.setParentId(reqDTO.getPtnrSubId());
					mur.setCategory(IMAGE_UPLOAD_TYPE.PTNR_IMG_DETAIL);
					mur.setSchemas("com");
					mur.setLang(reqDTO.getLang());
					mur.setImageLang(reqDTO.getPtnrLang());
					mur.setSize(mur.getSize());

				}
				commonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(), reqDTO.getDetailImages());

	        } else {
	        	//String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket");
	        	String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");
	        	
	        	MultiUploadReqDto muReqSub = new MultiUploadReqDto();
	        	muReqSub.setParentId(reqDTO.getPtnrSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.PTNR_IMG_DETAIL);
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getPtnrLang());

				List<String> orgImages = commonService.getParentImages(muReqSub);
				for(String orgImage : orgImages) {
					try {
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

//		}
//		catch( Exception e ){
//			LogUtil.error(e);
//			rtnValue.setSuccess(false);
//			rtnValue.setMessage(e.getMessage());
//		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getPartnerDetail
	  * 2. 클래스명: SystemPartnerService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2017. 04. 05.
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
	public SystemPartnerDetailResDto getPartnerDetail(SystemPartnerDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lp");
		reqDTO.setPtnrSubId(reqDTO.getPtnrId());
		return systemPartnerMapper.getPartnerDetail(reqDTO);
	}

	 /*
	  * 1. 메소드명: insertPartnerMaster
	  * 2. 클래스명: SystemPartnerService
	  * 3. 작성자명: mjpyo 
	  * 4. 작성일자: 2017. 04. 05.
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
	public StatusResDto insertPartnerMaster(SystemPartnerInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		reqDTO.setSVCAlias("");
		
		if(reqDTO.getPtnrStatus().equals("true")){
			reqDTO.setPtnrStatus("Y");
		}
		else{
			reqDTO.setPtnrStatus("N");
		}

		if(reqDTO.getUpdateFlag() ){
			systemPartnerMapper.updatePartnerMaster(reqDTO);
		}
		else{
			reqDTO.setPtnrId(CommonUtil.newRid());
			systemPartnerMapper.insertPartnerMaster(reqDTO);
		}
		rtnValue.setMessage(reqDTO.getPtnrId());
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	 /*
	  * 1. 메소드명: getPartnerMasterDetail
	  * 2. 클래스명: SystemPartnerService
	  * 3. 작성자명:  
	  * 4. 작성일자: 2017. 04. 05.
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
	public SystemPartnerDetailResDto getPartnerMasterDetail(SystemPartnerDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		return systemPartnerMapper.getPartnerMasterDetail(reqDTO);
	}

}
