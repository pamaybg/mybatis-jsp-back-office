/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemAppPopupService.java
 * 2. Package	: com.icignal.systemmanagement.apppopup.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 10. 오후 5:20:35
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 10.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.apppopup.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopListReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopMasterDetailReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopMasterInsertReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopNoticeListReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopSubDetailReqDto;
import com.icignal.systemmanagement.apppopup.dto.request.SystemAppPopSubInsertReqDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopListResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopMasterDetailResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopNoticeListResDto;
import com.icignal.systemmanagement.apppopup.dto.response.SystemAppPopSubDetailResDto;
import com.icignal.systemmanagement.apppopup.mapper.SystemAppPopupMapper;


/*
 * 1. 클래스명	: SystemAppPopupService
 * 2. 파일명	: SystemAppPopupService.java
 * 3. 패키지명	: com.icignal.systemmanagement.apppopup.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class SystemAppPopupService {
	
	@Autowired
	private SystemAppPopupMapper systemAppPopupMapper;
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * @name : getAppPopList
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 리스트
	 */
	public GridPagingResDto<SystemAppPopListResDto> getAppPopList(SystemAppPopListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lap");
		
		return new GridPagingResHelper<SystemAppPopListResDto>().newGridPagingResDto(
				reqDTO.init(CommonUtil.getInstance().getDBType()),
				systemAppPopupMapper.selectAppPopList(reqDTO),AnnotationType.CommCode);
	}

	
	/**
	 * @name : getNoticeSelectList
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 공지사항 리스트
	 */
	public List<SystemAppPopNoticeListResDto> getNoticeSelectList(SystemAppPopNoticeListReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("ln");
		
		return systemAppPopupMapper.selectNoticeSelectList(reqDTO);
	}


	/**
	 * @name : insertAppPopMaster
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 마스터 등록 / 수정
	 */
	public StatusResDto insertAppPopMaster(SystemAppPopMasterInsertReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		if(reqDTO.getUpdateFlag()){
			systemAppPopupMapper.updateAppPopMaster(reqDTO);
			rtnValue.setSuccess(true);
		}
		else{
			reqDTO.setAppPopId(CommonUtil.newRid());
			systemAppPopupMapper.insertAppPopMaster(reqDTO);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	
	/**
	 * @name : getAppPopMaster
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 마스터 상세
	 */
	public SystemAppPopMasterDetailResDto getAppPopMaster(SystemAppPopMasterDetailReqDto reqDTO) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lapm");
		return systemAppPopupMapper.selectAppPopMaster(reqDTO);
	}

	
	/**
	 * @name : insertAppPopSub
	 * @date : 2017. 04. 05
	 * @author : mjpyo
	 * @description : AppPop 등록 / 수정
	 */
	public StatusResDto insertAppPopSub(SystemAppPopSubInsertReqDto reqDTO,  HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		
		if(reqDTO.getUpdateFlag()){
			systemAppPopupMapper.updateAppPopSub(reqDTO);
			rtnValue.setSuccess(true);
		} else {
			reqDTO.setAppPopSubId(CommonUtil.newRid());
			systemAppPopupMapper.insertAppPopSub(reqDTO);
			rtnValue.setMessage(reqDTO.getAppPopId()); 
			rtnValue.setSuccess(true);
		}
		
		if(rtnValue.getSuccess() && reqDTO.getSubImages() != null && reqDTO.getSubImages().size() > 0){
			MultiUploadReqDto muReqSub = new MultiUploadReqDto();
			
			for(int i=0; i<reqDTO.getSubImages().size(); i++) {
				muReqSub.setParentId(reqDTO.getAppPopSubId());
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.APP_POPUP );
				muReqSub.setFileName(reqDTO.getSubImageFileNames());
				muReqSub.setFilePath(reqDTO.getSubImageFilePaths());
				muReqSub.setOriName(reqDTO.getSubImageOriNames());
				muReqSub.setRotateAngle(reqDTO.getSubImageRotateAngles());
				muReqSub.setSchemas("com");
				muReqSub.setLang(reqDTO.getLang());
				muReqSub.setImageLang(reqDTO.getAppPopLang());

				commonService.multiUploadImage(session.getServletContext().getRealPath("/"), session.getId(), muReqSub);
			}
			
        }
			
		return rtnValue;

}


	
	/**
	 * @name : getAppPopSubDetail
	 * @date : 2017. 04. 10
	 * @author : mjpyo
	 * @description : AppPop Sub 상세
	 */
	public SystemAppPopSubDetailResDto getAppPopSubDetail(SystemAppPopSubDetailReqDto reqDTO, HttpSession session) {
		LogUtil.param(this.getClass(), reqDTO);
		reqDTO.setSVCAlias("lap");
		String appPopSubId = (String) systemAppPopupMapper.selectAppPopSubId(reqDTO);
		SystemAppPopSubDetailResDto rtnValue = new SystemAppPopSubDetailResDto();
		 if(appPopSubId !=null){
			 reqDTO.setSVCAlias("lap");
			 reqDTO.setAppPopId(appPopSubId);
			 rtnValue = systemAppPopupMapper.selectAppPopSubDetail(reqDTO);
		 }
		 
		 return rtnValue;
		 
	}
}
