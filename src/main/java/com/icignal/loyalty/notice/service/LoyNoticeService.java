/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyNoticeService.java
 * 2. Package	: com.icignal.loyalty.notice.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 9. 오후 4:44:59
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 9.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.notice.service;

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
import com.icignal.loyalty.notice.dto.request.LoyImageInsertReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeDetailReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeInsertReqDto;
import com.icignal.loyalty.notice.dto.request.LoyNoticeListReqDto;
import com.icignal.loyalty.notice.dto.response.LoyNoticeDetailResDto;
import com.icignal.loyalty.notice.dto.response.LoyNoticeListResDto;
import com.icignal.loyalty.notice.mapper.LoyNoticeMapper;



/*
 * 1. 클래스명	: LoyNoticeService
 * 2. 파일명	: LoyNoticeService.java
 * 3. 패키지명	: com.icignal.loyalty.notice.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyNoticeService {
	@Autowired
	private LoyNoticeMapper loyNoticeMapper;
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * @name : getNoticeList
	 * @date : 2017. 03. 20
	 * @author : mjpyo
	 * @description : 공지사항 리스트
	 */
	public GridPagingResDto<LoyNoticeListResDto> getNoticeList(LoyNoticeListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("a");
		return new GridPagingResHelper<LoyNoticeListResDto>().newGridPagingResDto(
				reqDTO.init(CommonUtil.getInstance().getDBType()),
				loyNoticeMapper.selectNoticeList(reqDTO));
	}

	/**
	 * @name : insertNotice
	 * @date : 2017. 03. 20
	 * @author : mjpyo
	 * @description : 공지사항 신규등록
	 */
	public StatusResDto insertNotice(LoyNoticeInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		if(reqDTO.getUpdateFlag() == true){
			rtnValue = this.updateNotice(reqDTO);
		}
		else{
			rtnValue = this.insertNotice(reqDTO);
			reqDTO.setNoticeSubId(rtnValue.getMessage());
		}
		try{

			//event 메인배너 이미지 등록
			if(rtnValue.getSuccess() == true && reqDTO.getSubImages() != null && reqDTO.getSubImages().size() > 0){
				//MultiUploadRequestDTO muReqSub = new MultiUploadRequestDTO();

				for(MultiUploadReqDto mur : reqDTO.getSubImages()) {
					mur.setParentId(reqDTO.getNoticeSubId());
					mur.setCategory(IMAGE_UPLOAD_TYPE.NOTICE);
					mur.setSchemas("com");
					mur.setLang(reqDTO.getLang());
					mur.setImageLang(reqDTO.getNoticeLang());
					mur.setSize(mur.getSize());

				}
				commonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(), reqDTO.getSubImages());

	        } else {
//	        	String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket");
	        	String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");

	        	MultiUploadReqDto muReqSub = new MultiUploadReqDto();
	        	muReqSub.setParentId(reqDTO.getNoticeSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.NOTICE);
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getNoticeLang());

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

		}
		catch( Exception e ){
			LogUtil.error(e);
			rtnValue.setSuccess(false);
			rtnValue.setMessage(e.getMessage());
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getNoticeDetail
	  * 2. 클래스명: LoyNoticeService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	public LoyNoticeDetailResDto getNoticeDetail(LoyNoticeDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		 LoyNoticeDetailResDto rtnValue = new LoyNoticeDetailResDto();

		 String noticeId = "";

		 reqDTO.setSVCAlias("");
		 noticeId = (String) loyNoticeMapper.getNoticeId(reqDTO);

		 if(noticeId != null){
			 reqDTO.setSVCAlias("ln");
			 reqDTO.setNoticeSubId(noticeId);
			 rtnValue = loyNoticeMapper.getNoticeDetail(reqDTO);
		 }


		 return rtnValue;
	}


	 /*
	  * 1. 메소드명: increaseNoticeCount
	  * 2. 클래스명: LoyNoticeService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	public StatusResDto increaseNoticeCount(LoyNoticeDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		 reqDTO.setSVCAlias("");

		 StatusResDto rtnValue = new StatusResDto();
		 rtnValue.setSuccess(false);

		 loyNoticeMapper.increaseNoticeCount(reqDTO);
		 rtnValue.setSuccess(true);

		 return rtnValue;
	}


	/**
	 * @name : insertNoticeMaster
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : 공지사항 마스터 등록
	 */
	public StatusResDto insertNoticeMaster(LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		StatusResDto rtnValue = new StatusResDto();

		if(reqDTO.getNoticeStatus().equals("true")){
			reqDTO.setNoticeStatus("Y");
		}
		else{
			reqDTO.setNoticeStatus("N");
		}

		if(reqDTO.getUpdateFlag() == true){
			rtnValue = this.updateNoticeMaster(reqDTO);
		}
		else{
			rtnValue = this.insertNoticesMaster(reqDTO);
		}

		return rtnValue;
	}


	/**
	 * @name : getNoticeMasterDetail
	 * @date : 2017. 03. 23
	 * @author : mjpyo
	 * @description : 공지사항 마스터 상세
	 */
	public LoyNoticeDetailResDto getNoticeMasterDetail(LoyNoticeDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lnm");
		return loyNoticeMapper.getNoticeMasterDetail(reqDTO);
	}


	 /*
	  * 1. 메소드명: removeNotice
	  * 2. 클래스명: LoyNoticeService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	public StatusResDto removeNotice(LoyNoticeInsertReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyNoticeMapper.deleteMstNotice(reqDTO);
		loyNoticeMapper.deleteSubNotice(reqDTO);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: updateNotice
	  * 2. 클래스명: LoyNoticeService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	public LoyImageInsertReqDto updateNotice(LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		reqDTO.setSVCAlias("");

		LoyImageInsertReqDto check = new LoyImageInsertReqDto();
		check.setSuccess(false);

		loyNoticeMapper.updateNotice(reqDTO);
		check.setSuccess(true);

		return check;
	}
	
	/**
	 * @name : insertNotice
	 * @date : 2017. 03. 20
	 * @author : mjpyo
	 * @description : 공지사항 등록
	 */
	public StatusResDto insertNotice(LoyNoticeInsertReqDto reqDTO) {
		 LogUtil.param(this.getClass(), reqDTO);
		 reqDTO.setSVCAlias("");

		 LoyImageInsertReqDto check = new LoyImageInsertReqDto();

		 check.setSuccess(false);

		 loyNoticeMapper.insertNotice(reqDTO);
	     check.setMessage(reqDTO.getNoticeId());
	     check.setSuccess(true);

		 return check;
	}
	
	 /*
	  * 1. 메소드명: updateNoticeMaster
	  * 2. 클래스명: LoyNoticeService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	public StatusResDto updateNoticeMaster(LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		reqDTO.setSVCAlias("");
		loyNoticeMapper.updateNoticeMaster(reqDTO);
		rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDTO.getNoticeId());

		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: insertNoticeMaster
	  * 2. 클래스명: LoyNoticeService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 9.
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
	public StatusResDto insertNoticesMaster(LoyNoticeInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);

		StatusResDto rtnValue = new StatusResDto();

		rtnValue.setSuccess(false);

		reqDTO.setSVCAlias("");
		loyNoticeMapper.insertNoticeMaster(reqDTO);

		rtnValue.setMessage(reqDTO.getNoticeId());
		rtnValue.setSuccess(true);

		return rtnValue;
	}
	
}
