 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.base.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.icignal.common.base.dto.request.EmailSendLogReqDto;
import com.icignal.common.base.dto.request.FileReqDto;
import com.icignal.common.base.dto.request.ImageFileUploadReqDto;
import com.icignal.common.base.dto.request.ImageManageContentReqDto;
import com.icignal.common.base.dto.request.ImageManageOptionReqDto;
import com.icignal.common.base.dto.request.MessageSendLogReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.request.PushSendLogReqDto;
import com.icignal.common.base.dto.request.UploadImageReqDto;
import com.icignal.common.base.dto.response.CommCodeResDto;
import com.icignal.common.base.dto.response.ExcelMetaDataResDto;
import com.icignal.common.base.dto.response.ImageCondResDto;
import com.icignal.common.base.dto.response.ImageFileUploadResDto;
import com.icignal.common.base.dto.response.ImageManageOptionResDto;

/**
 * 1. FileName	: BaseMapper.java
 * 2. Package	: com.icignal.common.service.mapper
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 25. 오후 8:44:21
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 25.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: BaseMapper
 * 2. 파일명	: BaseMapper.java
 * 3. 패키지명	: com.icignal.common.service.mapper
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Mapper
public interface CommonMapper {
	
	public Integer multiUploadImage(UploadImageReqDto reqDto);
	public void insertMessageSendLog(MessageSendLogReqDto reqDto);
	public void insertEmailSendLog(EmailSendLogReqDto reqDto);
	public void insertPushSendLog(PushSendLogReqDto reqDto);
	public void insertFile(FileReqDto reqDto);
	public void deleteFile(FileReqDto reqDto);	
	
	public List<CommCodeResDto> selectCommCodeAll();
	 /*
	  * 1. 메소드명: selectParentImages
	  * 2. 클래스명: CommonMapper
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
	 *   @param mur
	 *   @return	
	 */
	
	public List<String> selectParentImages(MultiUploadReqDto mur);
	 /*
	  * 1. 메소드명: deleteParentImages
	  * 2. 클래스명: CommonMapper
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
	 *   @param mur	
	 */
	
	public void deleteParentImages(MultiUploadReqDto mur);
	

	 /*
	  * 1. 메소드명: getExcelMetaData
	  * 2. 클래스명: CommonMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		엑셀 다운로드 메타정보 가져오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param pgmId
	 *   @param title
	 *   @return	
	 */
	public List<ExcelMetaDataResDto> selectExcelMetaData(@Param("programId") String programId, @Param("objCode") String objCode);

	public List<ImageManageOptionResDto> selectImgUpType(ImageManageOptionReqDto mcr);
	
	public List<ImageCondResDto> selectImageUpType(ImageManageContentReqDto mcr);
	
	public List<ImageFileUploadResDto> selectFileList(ImageFileUploadReqDto mfr);
	
	public void deleteImageFile(ImageFileUploadReqDto mfr);
	
	public String selectImagePath(ImageFileUploadReqDto mfr);

	public String selectImagePathFTP(ImageFileUploadReqDto mfr);
	
	public void updateDescFile(ImageFileUploadReqDto mcr);
	
	public List<ImageFileUploadResDto> selectFileListS3(ImageFileUploadReqDto mfr);

	public List<ImageFileUploadResDto> selectFileListFTP(ImageFileUploadReqDto mfr);
	
	public String selectImagePathContentsManager(ImageFileUploadReqDto mfr);

	public String selectImagePathParent(MultiUploadReqDto mur);

	
	
}

