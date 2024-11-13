 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.base.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.icignal.common.util.*;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;import org.apache.commons.net.ftp.FTP;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.google.gson.Gson;
import com.icignal.auth.service.AuthCommonService;
import com.icignal.common.base.dto.request.EmailSendLogReqDto;
import com.icignal.common.base.dto.request.ExportExcelReqDto;
import com.icignal.common.base.dto.request.FileReqDto;
import com.icignal.common.base.dto.request.GridExcelExportReqDto;
import com.icignal.common.base.dto.request.ImageFileUploadReqDto;
import com.icignal.common.base.dto.request.ImageManageContentReqDto;
import com.icignal.common.base.dto.request.ImageManageOptionReqDto;
import com.icignal.common.base.dto.request.MessageSendLogReqDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.request.PushSendLogReqDto;
import com.icignal.common.base.dto.request.UploadImageReqDto;
import com.icignal.common.base.dto.response.CommCodeResDto;
import com.icignal.common.base.dto.response.ExcelMetaDataResDto;
import com.icignal.common.base.dto.response.FileUploadResDto;
import com.icignal.common.base.dto.response.ImageCondResDto;
import com.icignal.common.base.dto.response.ImageFileUploadResDto;
import com.icignal.common.base.dto.response.ImageManageOptionResDto;
import com.icignal.common.base.dto.response.MultiUploadResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.dto.response.TempUploadResDto;
import com.icignal.common.base.mapper.CommonMapper;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.session.SessionCommon;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.ExcelUtil.SfExcelAttribute;
import com.icignal.common.util.ExcelUtil.SpreadsheetWriter;
import com.icignal.external.aws.S3Manager;


/**
 * 1. FileName	: BaseService.java
 * 2. Package	: com.icignal.common.service
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 25. 오후 1:39:41
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 25.		 | knlee			|	최초작성

 * -----------------------------------------------------------------
 **/

@Service("commonService")
public class CommonService {

	private List<CommCodeResDto> commCodeList;
	
	@Autowired private CommonMapper commonMapper;
	
	@Autowired AuthCommonService authCommonService;
	
     /*
      * 1. 메소드명: findAllCommCodeLoading
      * 2. 클래스명: CommonService
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 3. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *	공통코드 전체 풀을 가져온다
     * 2. 사용법
     *		
     * </PRE>	
     */
    @PostConstruct
    public void findAllCommCodeLoading() {
    	LogUtil.info("CommonService findAllCommCodeLoading method start.");
    	commCodeList = commonMapper.selectCommCodeAll();
    }
    

     /*
      * 1. 메소드명: getCommCodeMarkName
      * 2. 클래스명: CommonService
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 3. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *	공통코드(그룹코드,코드이름,언어)에 대해 디스플레이명(markName)를 가져온다
     * 2. 사용법
     *		
     * </PRE>
     *   @param groupCode
     *   @param codeName
     *   @param lang
     *   @return	
     */
   // @Cacheable(value="commCodeCache", key= "{#groupCode , #codeName , #lang}" )
    public String getCommCodeMarkName(String groupCode,  String codeName,  String lang) {
       String markName = commCodeList.stream().filter(x ->  x.getGroupCode().equals(groupCode) &&
    			                           x.getCodeName().equals(codeName) &&
    			                           x.getLang().equals(lang)).findFirst().map(x -> x.getMarkName()).orElse("");
    	return markName;	
    	
    }
    
    
    
     /*
      * 1. 메소드명: removeCommCodeCach
      * 2. 클래스명: CommonService
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 3. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *	 해당 키에 대한 캐시를 삭제한다
     * 2. 사용법
     *		
     * </PRE>
     *   @param groupCode
     *   @param codeName
     *   @param lang	
     */
    //@CacheEvict(value="commCodeCache", key= "{#groupCode , #codeName , #lang}" )
    private void removeCommCodeCach(String groupCode,  String codeName,  String lang) {
       //캐시 삭제
    	LogUtil.info(groupCode+codeName+lang+"에 대한 캐시삭제");
    }

     /*
      * 1. 메소드명: removeCommCodeCash
      * 2. 클래스명: CommonService
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 3. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *	캐시를 전체 삭제한다
     * 2. 사용법
     *		
     * </PRE>	
     */
  //  @CacheEvict(value="commCodeCache" , allEntries=true)
    private boolean removeCommCodeCash() {
    	//System.out.println("removeCommCodeCash start.................");
    	return true;
    }
    
    
     /*
      * 1. 메소드명: editCommCodeList
      * 2. 클래스명: CommonService
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 3. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *	CommCodeList 수정
     * 2. 사용법
     *	시스템 운영 화면에서 신규,수정,삭제 발생시 호출되는 메소드
     * </PRE>
     *   @param commCode
     *   @return	
     */
    public StatusResDto editCommCodeList(CommCodeResDto commCode  ) {
    	StatusResDto res  = new StatusResDto();
    	
    	if ( commCode.getJobType() == CommCodeResDto.TYPE.CODENAME_ADD ) {  // 추가    		
    		commCodeList.add(commCode); // 리스트에 추가
    		getCommCodeMarkName(commCode.getGroupCode(), commCode.getCodeName(), commCode.getLang()); // 캐시 추가
    	}else if ( commCode.getJobType() == CommCodeResDto.TYPE.CODENAME_EDIT ) {  // 수정
    		
    		removeCommCodeCach(commCode.getGroupCode(), commCode.getCodeName(), commCode.getLang());
    		
    		commCodeList.stream().filter(o ->   o.getGroupCode().equals(commCode.getGroupCode()) 
    				&& o.getCodeName().equals(commCode.getCodeName())
    				&& o.getLang().equals(commCode.getLang())    				
    				).findFirst().orElse(new CommCodeResDto()).setMarkName(commCode.getMarkName());
    		
    		
    		
    	}else if ( commCode.getJobType() == CommCodeResDto.TYPE.CODENAME_DEL ) {  // 코드 삭제
    		
    		removeCommCodeCach(commCode.getGroupCode(), commCode.getCodeName(), commCode.getLang()); //캐시 삭제
    		
    		commCodeList.removeIf( o -> o.getGroupCode().equals(commCode.getGroupCode()) 
    								 && o.getCodeName().equals(commCode.getCodeName())
    								 && o.getLang().equals(commCode.getLang()));  // 리스트 삭제
    		
    	}else if ( commCode.getJobType() == CommCodeResDto.TYPE.GROUPCODE_DEL ) {  // 그룹코드에 속한 모든 코드들 삭제
    		
    		// 그룹코드에 속한 모든 코드 찾아서 캐시 제거
    		commCodeList.stream().filter(o -> o.getGroupCode().equals(commCode.getGroupCode()))
    							 .forEach(x -> removeCommCodeCach( x.getGroupCode(), x.getCodeName(), x.getLang()));
    		
    		commCodeList.removeIf( o -> o.getGroupCode().equals(commCode.getGroupCode()));  // 그룹코드에 속한 코드리스트 삭제
    		
    	}
    	
    	res.setSuccess(true);
    	return res;
    }
    
  
    
     /*
      * 1. 메소드명: initCommComcodeList
      * 2. 클래스명: CommonService
      * 3. 작성자명: knlee 
      * 4. 작성일자: 2020. 3. 6.
      */
    /**
     * <PRE>
     * 1. 설명
     *		시스템운영화면에서 공통코드 추가,수정,작업 수행시 공통코드 객체 초기화 및 캐시 삭제
     * 2. 사용법
     *		
     * </PRE>
     *   @param groupCode
     *   @param codeName
     *   @param country
     *   @param lang
     *   @return	
     */
    public StatusResDto reloadingCommComcodeList() {
    	findAllCommCodeLoading();
        removeCommCodeCash();
 
    	return new StatusResDto(true ,"");
    }
    
    
	
    
    
    
    
	

	
	

	/**
	 * 파라미터로 실제 경로와 세션아이디, 요청 객체를 전달받아서 파일을 생성 year,month,day 폴더에 생성 기존에 저장된 목록을
	 * 조회하고 해당 데이터 삭제 파라미터로 전송받은 테이블 명에 이미지 정보를 insert 컬럼 -
	 * ID,IMAGE_FOLDER,IMAGE_FILE_NAME,IMAGE_FILE_TYPE,IMAGE_FLAG,SEQ,IMAGE_TYPE,PARENT_ID
	 */	
	public MultiUploadResDto multiUploadImage(String realPath, String sessionId, MultiUploadReqDto mur) {
		MultiUploadResDto rtnValue = new MultiUploadResDto();
		rtnValue.setSuccess(true);

		try {
			String[] files = mur.getFileName().split(",");
			String[] filePaths = mur.getFilePath().split(",");
			String[] oriNames = mur.getOriName().split(",");
			String[] angles = mur.getRotateAngle().split(",");
			Calendar cl = Calendar.getInstance();
			int year = cl.get(Calendar.YEAR);
			int month = cl.get(Calendar.MONTH) + 1;
			int day = cl.get(Calendar.DATE);


			File yearDic = new File(realPath + File.separator + BeansUtil.getApplicationProperty("icignal.context.resource.m")
					+ File.separator + mur.getCategory() + File.separator + year);

			if (!yearDic.isDirectory()) {
				yearDic.mkdirs();
			}

			File monthDic = new File(yearDic.getAbsolutePath() + File.separator + month);
			if (!monthDic.isDirectory()) {
				monthDic.mkdirs();
			}

			File dayDic = new File(monthDic.getAbsolutePath() + File.separator + day);
			if (!dayDic.isDirectory()) {
				dayDic.mkdirs();
			}

			String path = dayDic.getAbsolutePath().toString();

			if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)) {
				yearDic = new File(realPath + File.separator + BeansUtil.getApplicationProperty("icignal.context.resource.mmsimageUploadPath"));
				if (!yearDic.isDirectory()) {
					yearDic.mkdirs();
				}
				path = yearDic.getAbsolutePath().toString();
			} else if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
				// kj.kang 추가 :: CMS
//				yearDic = new File(realPath + File.separator + CommonUtil.getInstance().getCmsPath());
				yearDic = new File(realPath + File.separator +  BeansUtil.getApplicationProperty("icignal.context.resource.cmsImageUploadPath" ));
				if (!yearDic.isDirectory()) {
					yearDic.mkdirs();
				}
				path = yearDic.getAbsolutePath().toString();
			}


			// 기존에 저장된 이미지 목록을 조회 하고 먼저 해당 데이터는 삭제
	//		List<String> orgImages = iMKTBase.getParentImages(mur);
				List<String> orgImages = getParentImages(mur);

			for (String imgUrl : orgImages) {
				ImageUtil.deleteMImageFiles(realPath, imgUrl);
			}
			// 기존 이미지일 경우 삭제 안함 처리
			List<String> popImage = new ArrayList<String>();

			for (int i = 0; i < files.length; i++) {
				File orgFile = new File(realPath + File.separator 
						+ BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath")
						+ year + File.separator + month + File.separator + day + File.separator + sessionId
						+ File.separator + files[i]);

				if (!orgFile.isFile()) {
					String filePath = filePaths[i].replaceAll(CommonUtil.getInstance().getImageServerUrl(), "");
					orgFile = new File(realPath + File.separator + filePath);
				}

				File targetFile = new File(path + File.separator + files[i]);

				// IFVMStringUtility.charSetCheck(oriNames[i]);

				// String oriName = checkFileName(path, new
				// String(oriNames[i].getBytes(), "utf-8"));
				String oriName = checkFileName(path, oriNames[i]);

				// 캠페인 또는 콘텐츠 매니저 일 경우 싱크퓨전을 사용 원본파일명으로 파일이 존재하여야 화면에서 이미지가 나온다.
				File oriNameFile = new File(path + File.separator + oriName);

				if (orgFile == null || !orgFile.exists()) {
					for (int j = 0; j < orgImages.size(); j++) {
						if (orgImages.get(j).contains(files[i])) {
							orgFile = new File(realPath + File.separator + orgImages.get(j));

							if (targetFile.getAbsolutePath().equals(orgFile.getAbsolutePath())) {
								popImage.add(orgImages.get(j));
							}
							break;
						}
					}
				}

				if (Integer.parseInt(angles[i]) > 0) {
					ImageUtil.rotate(orgFile, targetFile, Integer.parseInt(angles[i]),
							files[i].substring(files[i].indexOf('.') + 1, files[i].length()));

					if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)
							|| mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
						ImageUtil.rotate(orgFile, oriNameFile, Integer.parseInt(angles[i]),
								files[i].substring(files[i].indexOf('.') + 1, files[i].length()));
					}
				}

				if (!orgFile.getAbsolutePath().equals(targetFile.getAbsolutePath())) {
					FileUtils.copyFile(orgFile, targetFile);

					if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)
							|| mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
						FileUtils.copyFile(targetFile, oriNameFile);
					}
				}
				// orgFile.renameTo(targetFile);
				UploadImageReqDto uploadimage = new UploadImageReqDto();

				uploadimage.setId(CommonUtil.newRid());
				if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)) {
					uploadimage.setImageFolder(BeansUtil.getApplicationProperty("icignal.context.resource.mmsimageUploadPath"));
				} else if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
					uploadimage.setImageFolder(BeansUtil.getApplicationProperty("icignal.context.resource.cmsImageUploadPath"));
				} else {
					uploadimage.setImageFolder(
							BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath")  
							+ mur.getCategory() + "/"
							+ year + "/" + month + "/" + day + "/");
				}

				uploadimage.setImageFileName(files[i].substring(0, files[i].indexOf('.')));
				uploadimage.setImageFileType(files[i].substring(files[i].indexOf('.'), files[i].length()));
				uploadimage.setSeq(i);
				uploadimage.setImageType(mur.getCategory());
				uploadimage.setParentId(mur.getParentId());
				uploadimage.setImageFlag(1);
				uploadimage.setSchemas(mur.getSchemas());
				uploadimage.setImageLang(mur.getImageLang());

				String oriImageFileName = new String(oriName.substring(0, oriName.indexOf('.')));
				uploadimage.setOriImageFileName(oriImageFileName);
				uploadimage.setSize(mur.getSize());

				if (mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)
						|| mur.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
					uploadimage.setImageType(CommonUtil.IMAGE_UPLOAD_TYPE.USERCONTS);
				}

				uploadimage.setLang(mur.getLang());

				if (mur.getEmpId() != null) {
					uploadimage.setEmpId(mur.getEmpId());
				}

				// 멀티 이미지 테이블이 확장될 경우 추가 // product_image테이블을 제외하고 image테이블로 통합
				// 예정
				if (mur.getCategory() == IMAGE_UPLOAD_TYPE.Product) {
					uploadimage.setMultiTableName(CommonUtil.getInstance().getMultiImageTableProduct());
				} else {
					uploadimage.setMultiTableName("image");
				}

				// 이미지 테이블 저장
				Integer result = commonMapper.multiUploadImage(uploadimage);				 				
				if ( result == null || result == 0 ) rtnValue.setSuccess(false);
				
			}

			File orgFolder = new File(realPath + File.separator 
					+ BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath") 
					+ sessionId);
				orgFolder.delete();

			for (String imgUrl : popImage) {
				orgImages.remove(imgUrl);
			}

		} catch (IOException e) {
			LogUtil.error(e.getMessage(),e);
		}

		return rtnValue;
	}

	/**
	* @programId :
	* @name : multiUploadImageS3
	* @date : 2018. 11. 7.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
	
	public MultiUploadResDto multiUploadImageS3(String realPath, String sessionId, List<MultiUploadReqDto> mur) {
		MultiUploadResDto rtnValue = new MultiUploadResDto();
		rtnValue.setSuccess(true);
		
    	S3Manager s3Manager = new S3Manager();  	
		

		//S3 버킷명
	//	String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket");
		/*String[] files = mur.getFileName().split(",");*/
		/*String[] filePaths = mur.getFilePath().split(",");*/
		/*String[] oriNames = mur.getOriName().split(",");*/
		/*String[] angles = mur.getRotateAngle().split(",");*/

		//저장요청 파일이 없는 경우 - parentId 기준으로 모두 삭제
		if(ObjectUtil.isEmpty(mur)) {
			List<String> orgImages = getParentImages(mur.get(0));
			for(String orgImage : orgImages)  s3Manager.deleteObject(orgImage);
			return rtnValue;
		}

		//parentId 기준으로 모두 삭제
		getParentImages(mur.get(0));

		int i = 0;
		for (MultiUploadReqDto file : mur) {
			i++;

			//원본파일명 중복체크
			String oriName = checkFileNameS3(file.getOriName());
			//rotate 적용 시 기존 이미지 삭제 후 재업로드
			int angle = Integer.parseInt(file.getRotateAngle());
			if (angle > 0) {
				try {
						File tempFile = new File(realPath + File.separator + "org_" + oriName); //원본UUID파일
						File rotatedFile = new File(realPath + File.separator + file.getFileName()); //rotate 적용할 신규UUID파일
						s3Manager.writeFile(file.getFileName(), tempFile);
						ImageUtil.rotate(tempFile, rotatedFile, angle, oriName.substring(oriName.indexOf('.') + 1, oriName.length()));
						
						//UUID파일 삭제
						s3Manager.deleteObject(file.getFileName());
						//System.out.format("Deleting %s to S3 bucket %s...\n", file.getFileName(), bucket);
	
						//rotate 적용된 UUID파일 재업로드
						//System.out.format("Uploading %s (original name is %s) to S3 bucket %s...\n", file.getFileName(), oriName, bucket);
						s3Manager.putObject(file.getFileName(), tempFile);
	
						//서버 임시파일 삭제
						tempFile.delete();
						rotatedFile.delete();
					} catch( IOException e) {
						LogUtil.error(e);
					}

			} 
				//서버 임시파일 생성
				File tempFile = new File(realPath + File.separator + oriName);
		
				//s3Manager.writeFile(file.getFileName(), tempFile);
				s3Manager.writeFile(file.getFileName(), tempFile);
				
				//원본파일 업로드
				//System.out.format("Uploading %s (original name is %s) to S3 bucket %s...\n", tempFile.getName(), oriName, bucket);
				s3Manager.putObject(oriName, tempFile);

				//서버 임시파일 삭제
				tempFile.delete();

		

			//DB데이터 세팅 (com.image)
			UploadImageReqDto uploadimage = new UploadImageReqDto();

			uploadimage.setId(CommonUtil.newRid());
			uploadimage.setImageFileName(file.getFileName().substring(0, file.getFileName().indexOf(".")));
			uploadimage.setImageFileType(file.getFileName().substring(file.getFileName().indexOf("."), file.getFileName().length()));
			uploadimage.setSeq(i);
			uploadimage.setImageType(file.getCategory());
			uploadimage.setParentId(file.getParentId());
			uploadimage.setImageFlag(1);
			uploadimage.setSchemas(file.getSchemas());
			uploadimage.setImageLang(file.getImageLang());

			String oriImageFileName = new String(oriName.substring(0, oriName.indexOf('.')));
			uploadimage.setOriImageFileName(oriImageFileName);
			uploadimage.setSize(file.getSize());

			if (file.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)
					|| file.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
				uploadimage.setImageType(CommonUtil.IMAGE_UPLOAD_TYPE.USERCONTS);
			}

			uploadimage.setLang(file.getLang());

			if (file.getEmpId() != null) {
				uploadimage.setEmpId(file.getEmpId());
			}

			// 멀티 이미지 테이블이 확장될 경우 추가 // product_image테이블을 제외하고 image테이블로 통합
			// 예정
			if (file.getCategory() == IMAGE_UPLOAD_TYPE.Product) {
				uploadimage.setMultiTableName(CommonUtil.getInstance().getMultiImageTableProduct());
			} else {
				uploadimage.setMultiTableName("image");
			}

			// 이미지 테이블 저장
	//		Boolean result = iMKTBase.multiuploadImage(uploadimage);
           Integer result = commonMapper.multiUploadImage(uploadimage);
           
			if( result != null && result > 0)	rtnValue.setSuccess(false);
			
		}

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : multiUploadImageFTP
	 * @date : 2022.02.15
	 * @author : bg.yoon
	 * @table : COM.IMAGE
	 * @return :
	 * @description : 임시업로드한 파일을 FTP 업로드, Image 테이블에 저장
	 */

	public MultiUploadResDto multiUploadImageFTP(String realPath, String sessionId, List<MultiUploadReqDto> mur) {
		MultiUploadResDto rtnValue = new MultiUploadResDto();
		rtnValue.setSuccess(true);

		int i = 0;
		String middlePath = "";
		for (MultiUploadReqDto file : mur) {
			i++;

			//DB데이터 세팅 (com.image)
			UploadImageReqDto uploadimage = new UploadImageReqDto();

			uploadimage.setId(CommonUtil.newRid());
			uploadimage.setImageFileName(file.getFileName().substring(0, file.getFileName().indexOf(".")));
			uploadimage.setImageFileType(file.getFileName().substring(file.getFileName().indexOf(".")));
			uploadimage.setSeq(i);
			uploadimage.setImageType(file.getCategory());
			uploadimage.setParentId(file.getParentId());
			uploadimage.setImageFlag(1);
			uploadimage.setSchemas(file.getSchemas());
			uploadimage.setImageLang(file.getImageLang());

			String oriImageFileName = file.getOriName().substring(0, file.getOriName().indexOf('.'));
			uploadimage.setOriImageFileName(oriImageFileName);
			uploadimage.setSize(file.getSize());

			if (file.getCategory().equals(IMAGE_UPLOAD_TYPE.CAMPAIGN)
					|| file.getCategory().equals(IMAGE_UPLOAD_TYPE.CONTENT_MANAGER)) {
				uploadimage.setImageType(CommonUtil.IMAGE_UPLOAD_TYPE.USERCONTS);
			}
			else if(file.getCategory().equals(IMAGE_UPLOAD_TYPE.USERCONTS_EMAIL)
			|| file.getCategory().equals(IMAGE_UPLOAD_TYPE.USERCONTS_MMS)
			|| file.getCategory().equals(IMAGE_UPLOAD_TYPE.USERCONTS_PUSH)){
				String folderPath = "content_images";
				String category = file.getCategory().toString();
				middlePath = category.substring(category.indexOf("_")+1).toLowerCase();
				folderPath += "/" + middlePath;
				uploadimage.setImageFolder(folderPath);
			}

			uploadimage.setLang(file.getLang());

			if (file.getEmpId() != null) {
				uploadimage.setEmpId(file.getEmpId());
			}

			// 멀티 이미지 테이블이 확장될 경우 추가 // product_image테이블을 제외하고 image테이블로 통합
			// 예정
			if (file.getCategory() == IMAGE_UPLOAD_TYPE.Product) {
				uploadimage.setMultiTableName(CommonUtil.getInstance().getMultiImageTableProduct());
			} else {
				uploadimage.setMultiTableName("image");
			}

			// 이미지 테이블 저장
			Integer result = commonMapper.multiUploadImage(uploadimage);

			if( result != null && result > 0)	rtnValue.setSuccess(false);

			FTPUtil.saveFile(CommonUtil.IMAGE_UPLOAD_TYPE.CONTENT.name(), middlePath, realPath + file.getFilePath());

		}

		return rtnValue;
	}

	/**
	 * @name : checkFileName
	 * @date : 2016. 10. 17.
	 * @author : 류동균
	 * @return :
	 * @description : 파일명 중복 확인
	 */
	public String checkFileName(String path, String name) {
		String fileName = name;
		String filePath = path;
		File check = new File(filePath + File.separator + name);

		// 파일 중복 체크하여 Rename
		if (check.exists()) {
			String type = fileName.substring(fileName.indexOf('.') + 1, fileName.length());
			String realName = fileName.substring(0, fileName.indexOf('.'));

			int i = 1;
			while (true) {
				String num = realName + "(" + i + ")" + '.' + type;
				File detailCheck = new File(filePath + File.separator + num);

				if (detailCheck.exists()) {
					i++;
					continue;
				} else {
					fileName = num;
					break;
				}
			}
		}

		return fileName;
	}

	
	
	/**
	* @programId :
	* @name : checkFileNameS3
	* @date : 2018. 11. 7.
	* @author : hy.jun
	* @table :
	* @return : String
	* @description : 원본파일명 중복체크 후 중복되지 않는 파일명으로 리턴한다. ex)test(1).jpg
	*/
	private String checkFileNameS3(String name) {
		String fileName = name;
		
		try {
			String extension = fileName.substring(fileName.lastIndexOf('.'), fileName.length()); //확장자
			String regExp = "\\(\\d*\\)" + extension + "$";
			
			int i = 1;
			Pattern p = Pattern.compile(regExp);
			//파일명 중복 체크
	        while(true) {
	        	if(checkDupFile(fileName)) {
	        		Matcher m = p.matcher(fileName);
	        		
	        		if(m.find()) {
	        			i = Integer.parseInt(m.group().replaceAll("[(]","").replaceAll("[)]","").replaceAll(extension,"")) + 1;
	        			fileName = fileName.substring(0,m.start());		
	        		}
	        		
	        		fileName = fileName.replace(extension,"") + "(" + i + ")" + extension;
	        		//System.out.println(fileName);
	        		
	        	} else {
	        		break;
	        	}
	        }
		} catch(IOException e) {
			LogUtil.error(e);
		}
	    
		return fileName;
	}
	
	/**
	* @programId :
	* @name : checkDupFile
	* @date : 2019. 4. 29.
	* @author : hy.jun
	* @table :
	* @return : int
	* @description : AWS S3 파일 존재 체크
	*/
	private boolean checkDupFile(String fileName) throws IOException {
		//파일명 중복 체크
        URL url = new URL(BeansUtil.getApplicationProperty("icignal.context.imageServerUrl") + "/" + URLEncoder.encode(fileName, "UTF-8"));
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.connect();
        
        int resCode = connection.getResponseCode();
        connection.disconnect();
        
        if(resCode == 200)  return true;
        
       	return false;
        
	}

	/**
	 * 실제 경로와 세션아이디 파일 객체를 파라미터로 전달받아서 임시파일에 저장 year,month,day 폴더에 생성
	 */
	
	public List<TempUploadResDto> tempUpload(String realPath, String sessionId, MultipartFile file) {

		List<TempUploadResDto> rtnValue = new ArrayList<TempUploadResDto>();

		if (file.getSize() != 0 && file.getSize() < 102400000) { //100MB 제한
			try {
				// StringUtility.printformat(file.getOriginalFilename());

				// String oriFileName = new
				// String(file.getOriginalFilename().getBytes("8859_1"),"UTF-8");
				// //MyltipartFile 의 getOriginalFileNmae 은 file 의 실제 파일명을 가져온다.
				String oriFileName = new String(file.getOriginalFilename());
				String[] fileTypeArr = oriFileName.split("\\.");

				String fileType = fileTypeArr[fileTypeArr.length - 1]; // 파일 유형
				if(ObjectUtil.isNotEmpty(fileType) && ("xls".equalsIgnoreCase(fileType) || "xlsx".equalsIgnoreCase(fileType) || "cvs".equalsIgnoreCase(fileType)
					    || "gif".equalsIgnoreCase(fileType) || "jpg".equalsIgnoreCase(fileType) || "png".equalsIgnoreCase(fileType)
					    || "tif".equalsIgnoreCase(fileType) || "bmp".equalsIgnoreCase(fileType) || "tiff".equalsIgnoreCase(fileType))

				) {

						// getBytes 는 문자열을 바이트 배열로 바꿔줌
						String fileName = oriFileName.replace(" ", ""); // 파일명의 공백을 없애준다.
						//substring은 .의   갯수로부터 파일의 길이까지를 추출
						fileName = UUID.randomUUID() + oriFileName.substring(oriFileName.indexOf("."));
						// Unique User Identidfier 고유한 방문자를 구분할 수 있는 그 무엇. key 로는 주민번호나
						// 회원아이디로 사용됨 UUID.randomUUID()는 유니크한 아이디를 생성함

						Calendar cl = Calendar.getInstance(); // 날짜와 시간을 객체모델링화한 클래스.시스템으로부터
																// 시간 정보를 얻기 때문에
																// getInstance() 클래스 메서드를 이용
						int year = cl.get(Calendar.YEAR);
						int month = cl.get(Calendar.MONTH) + 1;
						int day = cl.get(Calendar.DATE);
						File yearDic = new File(realPath + File.separator 
								+ BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath")
								+ File.separator + year); // 파일객체 생성 , 디랙토리 경로 설정, 경로값 , 날짜로
															// 분류
						// 주어진 경로명을 추상 경로명으로 변환하여 새로운 file 객체 생성
						// File.separator 는 운영체제에 맞는 구분자를 표시해 주기위해 사용 (리눅스와 윈도우의 경로 구분자가 다르기
						// 때문)
						if (!yearDic.isDirectory()) {
							yearDic.mkdirs(); // 디렉토리 유무 판별 없으면 생성, mkdir은 만들고자 하는 디렉토리의 상위
												// 디렉토리가 존재하지 않을 경우 생성 불가, mkdirs 는 존재하지 않을
												// 경우 디렉토리 까지 생성
						}

						File monthDic = new File(yearDic.getAbsolutePath() + File.separator + month); // 경로 + month에 파일생성
						if (!monthDic.isDirectory()) {
							monthDic.mkdirs();
						}

						File dayDic = new File(monthDic.getAbsolutePath() + File.separator + day); // 경로  + day에  파일생성
						if (!dayDic.isDirectory()) {
							dayDic.mkdirs();
						}

						// getAbsolutePath 파일의 절대경로를 반환해 주는 함수인데 경로에 입력된 그대로를 표현한다.
						// getCanonicalPath() 는 실제로 위치하는 절대경로를 표현
						// 날짜 폴더까지만 생성
						file.transferTo(new File(dayDic.getAbsolutePath() + File.separator + fileName)); // 파일복사

						// TempUploadResDto u = new TempUploadResDto(fileName, Long.valueOf(file.getSize()).intValue(), CommonUtil.getInstance().getTempImageUploadUrl() + year + "/" + month + "/" + day + "/" + sessionId + "/" + fileName, oriFileName); // 최종경로
						TempUploadResDto u = new TempUploadResDto(fileName, (int)(long)file.getSize(),
							BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath")
									+ year + "/" + month + "/" + day + "/" + fileName, oriFileName); // 최종경로

						rtnValue.add(u);

					/*  sessionId에 해당하는 폴더까지 생성
						String path = dayDic.getAbsolutePath().toString();

						File dir = new File(path + File.separator + sessionId); // 경로 + 세션아이디에  파일생성
						if (!dir.isDirectory()) {
							dir.mkdirs();
						}

						file.transferTo(new File(dir.getAbsolutePath() + File.separator + fileName)); // 파일복사

//						TempUploadResDto u = new TempUploadResDto(fileName, Long.valueOf(file.getSize()).intValue(), CommonUtil.getInstance().getTempImageUploadUrl() + year + "/" + month + "/" + day + "/" + sessionId + "/" + fileName, oriFileName); // 최종경로
						TempUploadResDto u = new TempUploadResDto(fileName, (int)(long)file.getSize(), 
								BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath")							
								+ year + "/" + month + "/" + day + "/" + sessionId + "/" + fileName, oriFileName); // 최종경로
					*/
				} else {
					LogUtil.error("비인가된 파일확장자 오류: " + fileType);
				}
			} catch (IOException e) {
				LogUtil.error(e.getMessage(),e);
			}
		}

		return rtnValue;
	}

	/**
	* @programId :
	* @name : tempUploadS3
	* @date : 2018. 11. 7.
	* @author : hy.jun
	* @table :
	* @return :
	* @description :
	*/
	
	public List<TempUploadResDto> tempUploadS3(String realPath, String sessionId, MultipartFile file) {

		List<TempUploadResDto> rtnValue = new ArrayList<TempUploadResDto>();

		if (file.getSize() != 0 && file.getSize() < 100240000) { //100MB 제한
			try {
			//	String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket");

				String oriFileName = new String(file.getOriginalFilename());
				String fileName = oriFileName.replace(" ", ""); // 파일명의 공백을 없애준다.
				fileName = UUID.randomUUID().toString() + fileName.substring(fileName.lastIndexOf( '.' ), fileName.length());
				
				String tempFileFullPath = realPath + File.separator + oriFileName;
				File tempFile = new File(tempFileFullPath);
				file.transferTo(tempFile);
				LogUtil.info("이미지 파일 경로 : "+tempFileFullPath);
			//	System.out.format("Uploading %s (original name is %s) to S3 bucket %s...\n", fileName, oriFileName, bucket);
				S3Manager s3Manager = new S3Manager();
				s3Manager.putObject(fileName, tempFile);
				
				//서버 임시파일 삭제
				tempFile.delete();

				String imageServerUrl = BeansUtil.getApplicationProperty("icignal.context.imageServerUrl") + "/"+ fileName;
				TempUploadResDto u = new TempUploadResDto(fileName, (int)(long)file.getSize(), imageServerUrl, oriFileName); // 최종경로
				rtnValue.add(u);
			} catch (AmazonServiceException | IllegalStateException | IOException e) {
			    LogUtil.error(e);
			}
		}

		return rtnValue;
	}

	/**
	 * @name : exportExcel
	 * @date : 2016. 8. 10.
	 * @author : 류동균
	 * @return :
	 * @description : export Excel
	 */
	
	public void exportExcel(HttpServletRequest request, HttpServletResponse response, ExportExcelReqDto eer) {
		StatusResDto rtnValue = new StatusResDto();
		String realPath = request.getSession().getServletContext().getRealPath("/");
		eer.setRealPath(realPath);

		rtnValue.setSuccess(generateExcel(request, eer));

		if (rtnValue.getSuccess()) {
			BufferedInputStream fin = null;
			BufferedOutputStream outs = null;
			File file = null;

			response.reset();

			try {
				/*
				 * Export Excel
				 */
				String fileName = eer.getFileName() + ".xlsx";
				fileName = HTMLTagFilterRequestWrapper.decodeXSS(fileName);

//				String strPhyfullpath = realPath + CommonUtil.getInstance().getTempImageUploadUrl() + fileName;
				String strPhyfullpath = realPath + BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath") + fileName;

				strPhyfullpath = new String(strPhyfullpath.getBytes("euc-kr"), "iso-8859-1");
				file = new File(strPhyfullpath); // 저장된 위치에서 뽑아옴.
				// request.setAttribute("fileName", strPhyfullpath);
				if (file.isFile()) {

					fin = new BufferedInputStream(new FileInputStream(file));
					outs = new BufferedOutputStream(response.getOutputStream());

					int filelength = (int) file.length();

					if (filelength > 0) {
						byte[] bytestream = new byte[filelength];

						int read = 0;

						// response.setContentType("application/x-msdownload");
						response.setContentType("application/octet-stream");

						String userAgent = request.getHeader("User-Agent");
						boolean isIE = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") > -1;

						if (isIE) {
							fileName = new String(fileName.getBytes("x-windows-949"), "ISO-8859-1");
						} else {
							fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
						}

						response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
						response.setContentLength(filelength);
						response.setHeader("Content-Length", String.valueOf(filelength));
						response.setHeader("Content-Transfer-Encoding", "binary;");
						response.setHeader("Pragma", "no-cache;");
						response.setHeader("Expires", "0");

						read = fin.read(bytestream);

						while (read != -1) {
							outs.write(bytestream, 0, read);

							read = fin.read(bytestream);
						}

						outs.flush();
					} else {
						LogUtil.info("no file");
					}
				} else {
					LogUtil.info("no file");
				}

			} catch (IOException e) {

				LogUtil.error(e.getMessage(), e);
			} finally {
				try {

					if (fin != null)
						fin.close();
					if (outs != null)
						outs.close();
				} catch (IOException e) {

					LogUtil.error(e);
				}
			}
		} else {
			rtnValue.setMessage("MSG_S0007");
		}

		// return rtnValue;
	}

	/**
	 * @name : generateExcel
	 * @date : 2016. 8. 10.
	 * @author : 류동균
	 * @return :
	 * @description : generate Excel
	 */
	
	public boolean generateExcel(HttpServletRequest request, ExportExcelReqDto eer) {
		Writer fw = null;
		XSSFWorkbook wb = null;
		FileOutputStream out = null;
		FileOutputStream os = null;
		// get temp path
		String fileTempPath = eer.getRealPath() + BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath");
		File file = new File(fileTempPath);
		if (!file.isDirectory()) {
			file.mkdirs();
		}

		String xlsxName = eer.getFileName();

		try {
			// Step 1. Create a template file. Setup sheets and workbook-level
			// objects such as
			// cell styles, number formats, etc.
			wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet("Big Grid");

			Map<String, CellStyle> styles = ExcelStyles.createStyles(wb);
			// name of the zip entry holding sheet data, e.g.
			// /xl/worksheets/sheet1.xml
			String sheetRef = sheet.getPackagePart().getPartName().getName();

			// save the template
			new File(fileTempPath + "template.xlsx");
			os = new FileOutputStream(fileTempPath + "template.xlsx");
			wb.write(os);

			// Step 2. Generate XML file.
			File tmp = new File(fileTempPath + "/dataXml/", "sheet.xml");
			if (!tmp.getParentFile().isDirectory()) {
				tmp.getParentFile().mkdirs();
			}
			tmp.createNewFile();

			fw = new OutputStreamWriter(new FileOutputStream(tmp), "UTF-8");
			this.generateSheet(fw, styles, request, eer);
			fw.close();

			// Step 3. Substitute the template entry with the generated data
			out = new FileOutputStream(fileTempPath + "/" + xlsxName + ".xlsx");
			ExcelUtil.substitute(new File(fileTempPath + "/template.xlsx"), tmp, sheetRef.substring(1), out);
			out.close();
			wb.close();
		} catch (FileNotFoundException e) {
			LogUtil.error(e);
			return false;
		} catch (IOException e) {
			LogUtil.error(e);
			return false;
		} finally {

				try {
					if(fw != null)	fw.close();
				} catch (IOException e) {
                      LogUtil.error(e);
                      fw = null;
				}

				try {
					if(out != null)	out.close();
				} catch (IOException e) {
					LogUtil.error(e);
					out = null;
				}
				
				try {
					if(wb != null)	out.close();
				} catch (IOException e) {
					LogUtil.error(e);
					wb = null;
				}
				
				try {
					if(os != null)	out.close();
				} catch (IOException e) {
					LogUtil.error(e);
					os = null;
				}
				
				
		}

		return true;
	}

	/**
	 * @name : generateSheet
	 * @date : 2016. 8. 10.
	 * @author : 류동균
	 * @return :
	 * @description : generate Sheet
	 */
	public void generateSheet(Writer out, Map<String, CellStyle> styles, HttpServletRequest request,
				  ExportExcelReqDto eer) {
		try {
			SpreadsheetWriter sw = new SpreadsheetWriter(out);
			sw.beginSheet();
			// column size
			List<SfExcelAttribute> customCellSizeList = new ArrayList<>();
			for (int i = 0; i < eer.getHeaderList().size(); i++) {
				customCellSizeList.add(new SfExcelAttribute(i + 1, i + 1, 15, i + 1));
			}

			sw.customCell(customCellSizeList);
			sw.beginSheet();

			// insert header row
			sw.insertRow(0);
			int styleIndex = styles.get("header").getIndex();
			int index = 0;
			for (String name : eer.getHeaderList()) {
				sw.createCell(index++, name, styleIndex);
			}
			sw.endRow();

			// insert row / create cell data
			int rownum = 1;
			for (List<Object> rows : eer.getDataList()) {
				sw.insertRow(rownum++);

				int cellnum = 0;
				for (Object obj : rows) {
					if (obj == null) {
						sw.createCell(cellnum++, "");
					} else {
						if ("Integer".equals(obj.getClass().getSimpleName())) {
							sw.createCell(cellnum++, (Integer) obj);
						} else if ("Double".equals(obj.getClass().getSimpleName())) {
							sw.createCell(cellnum++, (Double) obj);
						} else {
							sw.createCell(cellnum++, (String) obj);
						}
					}
				}

				sw.endRow();
			}

			sw.endSheet();

			// end
			sw.endWorkSheet();

			LogUtil.info("dataMergeList SIZE : " + rownum);
		} catch (IOException e) {
			LogUtil.error(e);
		}
	}

	/**
	 * @name : getRowID
	 * @date : 2016. 11. 3.
	 * @author : dg.ryu
	 * @table : com.getRowID()
	 * @return : String
	 * @description : rowId 추출
	 */
	
	public String getRowID() {

		return CommonUtil.newRid();
	//	return iMKTBase.getRowID();
	}

	/**
	 * @name : addMessageSendLog
	 * @date : 2016. 11. 14.
	 * @author : dg.ryu
	 * @table : mkt.mkt_msg_send_log
	 * @return : StatusResDto
	 * @description : message send log 등록
	 */
	
	public StatusResDto addMessageSendLog(MessageSendLogReqDto reqDto) {

		StatusResDto rtnValue = new StatusResDto();
		if (ObjectUtil.isEmpty(reqDto.getId())) {
			reqDto.setId(CommonUtil.newRid());
		}
		//rtnValue = iMKTBase.addMessageSendLog(mmslr);
        commonMapper.insertMessageSendLog(reqDto);
        rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDto.getId());
		
		return rtnValue;
	}

	/**
	 * @name : addEmailSendLog
	 * @date : 2016. 11. 14.
	 * @author : dg.ryu
	 * @table : mkt.mkt_email_send_log
	 * @return : StatusResDto
	 * @description : email send log 등록
	 */
	
	public StatusResDto addEmailSendLog(EmailSendLogReqDto reqDto) {
		
		StatusResDto rtnValue = new StatusResDto();
		if (ObjectUtil.isEmpty(reqDto.getId())) {
			reqDto.setId(CommonUtil.newRid());
		}
		//rtnValue = iMKTBase.addMessageSendLog(mmslr);
        commonMapper.insertEmailSendLog(reqDto);
        rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDto.getId());	

		return rtnValue;
	}

	/**
	 * @programId : addPushSendLog
	 * @name : addPushSendLog
	 * @date : 2016. 11. 25.
	 * @author : dg.ryu
	 * @table : mkt.mkt_push_send_log
	 * @return : StatusResDto
	 * @description : push send log 등록
	 */
	
	public StatusResDto addPushSendLog(PushSendLogReqDto reqDto) {
		
		StatusResDto rtnValue = new StatusResDto();
		if (ObjectUtil.isEmpty(reqDto.getId())) {
			reqDto.setId(CommonUtil.newRid());
		}
		//rtnValue = iMKTBase.addMessageSendLog(mmslr);
        commonMapper.insertPushSendLog(reqDto);
        rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDto.getId());	

		return rtnValue;
		
	}

	/**
	 * @programId :
	 * @name : gridExcelExport
	 * @date : 2017. 6. 7.
	 * @author : "dg.ryu"
	 * @table :
	 * @return : StatusResDto
	 * @description : 그리드 엑셀 보내기
	 */
	@SuppressWarnings("rawtypes")
	
	public StatusResDto gridExcelExport(GridExcelExportReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		ExportExcelReqDto exportData = new ExportExcelReqDto();
		String col;
		String dataString;
		List<String> colList = new ArrayList<>();
		List<String> colNameList = new ArrayList<>();
		List<List<Object>> dataList = new ArrayList<>();

		// 해더 세팅
		for (int i = 0; i < reqDto.getHeader().size(); i++) {

			HashMap header = new HashMap();
			header = (HashMap) reqDto.getHeader().get(i); // 해더 속성

			if (header.get("hidden") == null || !(Boolean) header.get("hidden")) {
				col = (String) header.get("name");
				colList.add(col);
				colNameList.add((String) reqDto.getHeaderName().get(i)); // 해더Text
			}

		}

		// 데이터 세팅
		for (int i = 0; i < reqDto.getData().size(); i++) {

			HashMap data = new HashMap();
			data = (HashMap) reqDto.getData().get(i); // 데이터 Row

			List<Object> dataRow = new ArrayList<>();
			for (int j = 0; j < colList.size(); j++) {
				dataString = (String) data.get(colList.get(j));
				dataRow.add(dataString);
			}
			dataList.add(dataRow);
		}

		exportData.setHeaderList(colNameList);
		exportData.setDataList(dataList);
		exportData.setFileName(reqDto.getFileName());

		String realPath = reqDto.getRequest().getSession().getServletContext().getRealPath("/");
		exportData.setRealPath(realPath);

		generateExcel(reqDto.getRequest(), exportData);

		String fileName = exportData.getFileName() + ".xlsx";
		fileName = HTMLTagFilterRequestWrapper.decodeXSS(fileName);

		String strPhyfullpath = "/" + BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath") + fileName;

		try {
			strPhyfullpath = new String(strPhyfullpath.getBytes("euc-kr"), "iso-8859-1");
		} catch (UnsupportedEncodingException e) {

			LogUtil.error(e);
		}

		rtnValue.setMessage(strPhyfullpath);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	/**
	 * @name : fileUpload
	 * @date : 2017. 6. 28.
	 * @author : "dg.ryu"
	 * @return : MKTFileUploadResDto
	 * @description : 파일업로드
	 */
	
	public FileUploadResDto fileUpload(String realPath, String sessionId, MultipartFile file) {

		FileUploadResDto rtnValue = new FileUploadResDto();

		if (file.getSize() != 0 && file.getSize() < 102400000) { //100MB 제한
			try {
				//String id = iMKTBase.getRowID(); // 아이디
				String id = CommonUtil.newRid(); // 아이디
				String oriFileName = new String(file.getOriginalFilename().getBytes("8859_1"), "UTF-8"); // 파일명 얻기

				String[] fileTypeArr = oriFileName.split("\\.");

				String fileType = fileTypeArr[fileTypeArr.length - 1]; // 파일 유형

				if("xls".equals(fileType) || "xlsx".equals(fileType) || "cvs".equals(fileType)) {
					String fileName = id + "." + fileType; // 업로드 파일명


					long fileSize = file.getSize(); // 파일 크기


					//String filePath = CommonUtil.getInstance().getFileUploadPath(); // 파일 경로
					String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path"); // 파일 경로

					String uploadPath = realPath + File.separator + filePath; // 업로드 경로

					LogUtil.info("파라미터이름:" + file.getName());
					LogUtil.info("파일명:" + file.getOriginalFilename());
					LogUtil.info("파일사이즈:" + file.getSize());
					LogUtil.info("실제 파일 업로드 경로 : " + filePath);

					// 업로드 디렉토리 확인
					File uploadfile = new File(uploadPath);
					if (!uploadfile.isDirectory()) {
						uploadfile.mkdirs();
					}

					// 지정한주소에 파일 저장
					file.transferTo(new File(uploadPath + fileName));

					// 반환값
					rtnValue = new FileUploadResDto(id, fileName, oriFileName, filePath, fileSize, fileType);

				}else {
					LogUtil.error("비인가된 파일확장자 오류: " + fileType);

				}


			} catch (IllegalStateException e) {

				LogUtil.error(e);
			} catch (IOException e) {

				LogUtil.error(e);
			}
		}

		return rtnValue;
	}

	/**
	 * @name : fileUpload
	 * @date : 2017. 12. 7.
	 * @author : "dg.ryu"
	 * @return : MKTFileUploadResDto
	 * @description : 파일 업로드 및 DB 저장
	 */
	
	public FileUploadResDto fileUpload(String realPath, FileReqDto param) {

		FileUploadResDto rtnValue = new FileUploadResDto();

		if (ObjectUtil.isNotEmpty(param) && ObjectUtil.isNotEmpty(param.getFile())) {
			MultipartFile file = param.getFile();

			if (file.getSize() != 0  && file.getSize() < 102400000) { //100MB 제한
				try {
					//String id = iMKTBase.getRowID(); // 아이디
					String id = CommonUtil.newRid(); // 아이디
					String oriFileName = new String(file.getOriginalFilename().getBytes("8859_1"), "UTF-8"); // 파일명
																												// 얻기

					String[] fileTypeArr;
					fileTypeArr = oriFileName.split("\\.");
					String fileType = fileTypeArr[fileTypeArr.length - 1]; // 파일 유형

					if("xls".equals(fileType) || "xlsx".equals(fileType) || "cvs".equals(fileType)) {

						String fileName = id + "." + fileType; // 업로드 파일명
						long fileSize = file.getSize(); // 파일 크기
//						String filePath = CommonUtil.getInstance().getFileUploadPath(); 
						
						String filePath = BeansUtil.getApplicationProperty("icignal.context.resource.file-upload-path"); // 파일 경로 

						String uploadPath = realPath + File.separator + filePath; // 업로드
																					// 경로

						LogUtil.debug("파라미터이름:" + file.getName());
						LogUtil.debug("파일명:" + file.getOriginalFilename());
						LogUtil.debug("파일사이즈:" + file.getSize());
						LogUtil.debug("실제 파일 업로드 경로 : " + filePath);

						// 업로드 디렉토리 확인
						File uploadfile = new File(uploadPath);
						if (!uploadfile.isDirectory()) {
							uploadfile.mkdirs();
						}

						// 지정한주소에 파일 저장
						file.transferTo(new File(uploadPath + fileName));

						// 파일정보 DB 저장
						param.setFileName(fileName);
						param.setOriFileName(oriFileName);
						param.setFilePath(filePath);
						param.setFileSize(Long.toString(fileSize));
						param.setFileType(fileType);

					//	this.addFile(param);
				//		iMKTBase.addFile(param);

						commonMapper.insertFile(param);
						// 반환값
						rtnValue = new FileUploadResDto(id, fileName, oriFileName, filePath, fileSize, fileType);

					} else {
						LogUtil.error("비인가된 파일확장자 오류: " + fileType);
					}
				} catch (IllegalStateException e) {
					LogUtil.error(e);
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
		}

		return rtnValue;
	}

	/**
	 * @programId :
	 * @name : addFile
	 * @date : 2017. 6. 29.
	 * @author : "dg.ryu"
	 * @table : com.com_file
	 * @return : StatusResDto
	 * @description : 파일 등록
	 */
	
	public StatusResDto addFile(FileReqDto reqDto) {

		
		StatusResDto rtnValue = new StatusResDto();
		if (ObjectUtil.isEmpty(reqDto.getId())) {
			reqDto.setId(CommonUtil.newRid());
		}
		
        commonMapper.insertFile(reqDto);
        rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDto.getId());
		
		return rtnValue;
		
	}

	/**
	 * @name : deleteFile
	 * @date : 2017. 7. 4.
	 * @author : jun.lee
	 * @return : StatusResDto
	 * @description : 파일 삭제
	 */
	
	public StatusResDto deleteFile(FileReqDto reqDto) {

		StatusResDto rtnValue = new StatusResDto();
		if (ObjectUtil.isEmpty(reqDto.getId())) {
			reqDto.setId(CommonUtil.newRid());
		}
		
        commonMapper.deleteFile(reqDto);
        rtnValue.setSuccess(true);
		rtnValue.setMessage(reqDto.getId());
		
		return rtnValue;
		
	//	return iMKTBase.deleteFile(param);
	}

	/**
	 * @programId :
	 * @name : insertSearchLog
	 * @date : 2017. 10. 24.
	 * @author : 이성원
	 * @table :
	 * @return :
	 * @description :
	 */	
	 /*
	  * 1. 메소드명: insertSearchLog
	  * 2. 클래스명: BaseService
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	몽고DB에 로그 적재
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	/*public StatusResDto insertSearchLog(Object param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnVal = new StatusResDto();
		
		try{
		CommonDataAuthReqDto searchParam = (CommonDataAuthReqDto) param;
		
		
		
		SearchLogReqDto log = new SearchLogReqDto();
		
		BasicDBList logList = new BasicDBList();
	    
	    String searchKey = UUID.randomUUID().toString();
	  
	    
		
		log.setDate(new Date());		
		log.setSearch_key(UUID.randomUUID().toString());
		log.setUrl(searchParam.getUrl());
		log.setUrl_include(searchParam.getUrlInclude());
		log.setUser_rid(searchParam.getLoginId());
		
		if(searchParam.getItem() != null || searchParam.getItem().size() > 0){
			for(int i=0; i<searchParam.getItem().size(); i++){
			BasicDBObject dbObject = new BasicDBObject();
				String type = searchParam.getItem().get(i).getCondType().trim();					
				String operation = searchParam.getItem().get(i).getOperationType().trim();
				String field = searchParam.getItem().get(i).getSrcCol(); 
				String value = searchParam.getItem().get(i).getWhereVal();	
				
				dbObject.put("date", new Date());
			    dbObject.put("searchKey",searchKey);
			    dbObject.put("url", searchParam.getUrl());
			    dbObject.put("urlInclude", searchParam.getUrlInclude());
			    dbObject.put("userRid", searchParam.getLoginId());
				dbObject.put("type",type );
				dbObject.put("operation", operation);
				dbObject.put("field", field);
				dbObject.put("value",value );
				
				
				
				log.setField(field);
				log.setOperation(operation);
				if (type.equals("DATE") && operation.equals("BETWEEN") ) {
					dbObject.put("value1",searchParam.getItem().get(i).getStartDate() );
					dbObject.put("value2",searchParam.getItem().get(i).getEndDate() );
					
					log.setValue1(searchParam.getItem().get(i).getStartDate());
					log.setValue2(searchParam.getItem().get(i).getEndDate());
				}else{
					dbObject.put("value1",value );
					log.setValue1(value);
				}
				
				logList.add(dbObject);
//				iMKTMongoDBDAO.insert(dbObject, "search_log");
			}
		}else{
				// 전체 조회 
				log.setField("ALL");				
//				iMKTMongoDBDAO.insert(log, "search_log");
		}
		
		rtnVal.setSuccess(true);
		}catch(Exception e){
			rtnVal.setSuccess(false);
		    LogUtil.error(e);
		}
		return rtnVal;
		

		//return iMKTBase.insertSearchLog(param);
	}
*/
	/**
	* @programId :
	* @name : deleteUploadS3
	* @date : 2019. 10. 30.
	* @author : dw.keum
	* @table :
	* @return : 
	* @description : S3 파일삭제
	*/
	
	public StatusResDto deleteUploadS3(String fileName) {
		LogUtil.param(this.getClass(), fileName);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
			
		S3Manager s3Manager = new S3Manager();			
		s3Manager.deleteObject(fileName);
		rtnValue.setSuccess(true);
		return rtnValue;
		
	}
	
	public List<String> getParentImages(MultiUploadReqDto mur) {
		List<String> rtnValue = null;
		mur.setSVCAlias("i");
		rtnValue = commonMapper.selectParentImages(mur);
		mur.setSVCAlias("");
		commonMapper.deleteParentImages(mur);

		return rtnValue;
	}
	

	 /*
	  * 1. 메소드명: getExcelHeader
	  * 2. 클래스명: CommonService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 3. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		db에서 엑셀 헤더 가져오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param programId
	 *   @param title
	 *   @return	
	 */
	public List<ExcelMetaDataResDto> getExcelHeader(String programId, String objCode){
		LogUtil.param(this.getClass(), objCode);
		
		return commonMapper.selectExcelMetaData(programId, objCode);
	}

	/**
	 * @programId : MKT_CHL_P03
	 * @name : getNewImgUpType
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<ImageManageOptionResponseDTO>
	 * @description : 해당 채널에 관련된 이미지 업로드 타입 반환.
	 */
	public List<ImageManageOptionResDto> getNewImgUpType(ImageManageOptionReqDto mcr){
		LogUtil.param(this.getClass(), mcr);
		mcr.setSVCAlias("mcc");

		List<ImageManageOptionResDto> rtnvalue = commonMapper.selectImgUpType(mcr);
		return rtnvalue;
	}

	/**
	 * @programId : MKT_CHL_P03
	 * @name : getImageUpType
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : mkt_chnl_capa (채널 용량 관리 테이블)
	 * @return : List<ImageCondResponseDTO>
	 * @description : 해당 채널에 관련된 이미지 업로드 타입 반환.
	 */
	public List<ImageCondResDto> getImageUpType(ImageManageContentReqDto mcr){
		LogUtil.param(this.getClass(), mcr);

		mcr.setSVCAlias("mcc");
		List<ImageCondResDto> rtnvalue = commonMapper.selectImageUpType(mcr);

		return rtnvalue;
	}
	    
    /**
	 * @programId : MKT_CTE_002
	 * @name : getFileList
	 * @date : 2018. 09. 11.	
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : List<ImageFileUploadResponseDTO>
	 * @description : 콘텐츠 파일 리스트 조회
	 */
	public List<ImageFileUploadResDto> getFileList(ImageFileUploadReqDto mfr){
		LogUtil.param(this.getClass(), mfr);

		mfr.setSVCAlias("ci");

		List<ImageFileUploadResDto> rtnValue = new ArrayList<>();
		
		rtnValue = commonMapper.selectFileList(mfr);
		
		return rtnValue;
	}    
		
		
	/**
	 * @programId : MKT_CTE_002
	 * @name : removeImage
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 콘텐츠 이미지 파일 삭제
	 */
	public StatusResDto removeImage(ImageFileUploadReqDto mfr,String realPath){
		LogUtil.param(this.getClass(), mfr);


		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		mfr.setSVCAlias("");
		commonMapper.deleteImageFile(mfr);

		String imgpath = commonMapper.selectImagePath(mfr);

		File delRealFile = new File(realPath + imgpath);

		if(delRealFile.exists()){
			delRealFile.delete();
		}

		rtnValue.setSuccess(true);

		return rtnValue;
	}
	
	/**
	 * @programId : MKT_CTE_003
	 * @name : eidtDescFile
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @table : image (이미지 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 이미지 파일 설명 업데이트
	 */
	public StatusResDto eidtDescFile(ImageFileUploadReqDto mcr){
		LogUtil.param(this.getClass(), mcr);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		mcr.setSVCAlias("");
		commonMapper.updateDescFile(mcr);

		rtnValue.setSuccess(true);

		return rtnValue;
	}
	
	/**
	 * @programId : MKT_CTE_002
	 * @name : getContenttypeList
	 * @date : 2018. 09. 11.
	 * @author : 금동우
	 * @param :
	 * @table : mkt_contents (콘텐츠 관리 테이블)
	 * @return : StatusResponseDTO
	 * @description : 이미지 넣기
	 */
	public StatusResDto addImage(String empId,String ralpath, String sessionId, MultipartFile file) {

		StatusResDto rtnValue = new StatusResDto();

		//임시 업로드
		List<TempUploadResDto> tempUploadList = tempUpload(ralpath, sessionId, file);

		//임시파일 업로드 여부 확인
		if (ObjectUtil.isNotEmpty(tempUploadList)) {
			MultiUploadReqDto muReqSub = new MultiUploadReqDto();

			//파일명, 원본파일명 목록 (콤마 구분)
			StringBuilder fileName = new StringBuilder();
			StringBuilder oriName = new StringBuilder();
			StringBuilder filePath = new StringBuilder();

			for(TempUploadResDto tempUpload : tempUploadList) {
				fileName.append(tempUpload.getName());
				fileName.append(',');

				oriName.append(tempUpload.getOriName());
				oriName.append(',');

				filePath.append(tempUpload.getUrl());
				filePath.append(',');
			}

			String fileNames =  fileName.length() > 0 ? fileName.substring(0, fileName.length() - 1): "";
			String oriNames =  oriName.length() > 0 ? oriName.substring(0, oriName.length() - 1): "";
			String filePaths =  filePath.length() > 0 ? filePath.substring(0, filePath.length() - 1): "";

			muReqSub.setCategory(IMAGE_UPLOAD_TYPE.CAMPAIGN);
			muReqSub.setFileName(fileNames);
			muReqSub.setOriName(oriNames);
			muReqSub.setFilePath(filePaths);
			muReqSub.setRotateAngle("0");
			muReqSub.setSchemas("com");
			muReqSub.setSize(file.getSize());
			muReqSub.setEmpId(empId);

			//이미지 업로드
			MultiUploadResDto mur = multiUploadImage(ralpath, sessionId, muReqSub);
			rtnValue.setSuccess(mur.getSuccess());
		}

		return rtnValue;
	}


	public List<ImageFileUploadResDto> getFileListS3(ImageFileUploadReqDto mfr) {
		mfr.setSVCAlias("ci");

		List<ImageFileUploadResDto> rtnValue = new ArrayList<>();
		
		rtnValue = commonMapper.selectFileListS3(mfr);
		
		return rtnValue;
	}

	public List<ImageFileUploadResDto> getFileListFTP(ImageFileUploadReqDto mfr) {
		mfr.setSVCAlias("ci");

		List<ImageFileUploadResDto> rtnValue = new ArrayList<>();

		rtnValue = commonMapper.selectFileListFTP(mfr);

		//단위 kb로 전환
		for(int i = 0; i<rtnValue.size(); i++){
			rtnValue.get(i).setImgSize(Integer.toString(Integer.parseInt(rtnValue.get(i).getImgSize())/1024));

		}
		return rtnValue;
	}


	public StatusResDto removeImageS3(ImageFileUploadReqDto mfr, String realPath) {
		LogUtil.param(this.getClass(), mfr);
		S3Manager s3Manager = new S3Manager();  	
		
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		mfr.setSVCAlias("");
		commonMapper.deleteImageFile(mfr);

		String imgpath = commonMapper.selectImagePath(mfr);
		String imgpathContentManager = commonMapper.selectImagePathContentsManager(mfr);
		try {
//			String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket-name");
			String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");
			
			//원본 이미지 삭제
			//AWSCloudFrontConfig.getS3Client().deleteObject(bucket, imgpath);
			
			s3Manager.deleteObject(imgpath);
			
			System.out.format("Deleting %s to S3 bucket %s...\n", imgpath, bucket);
			//컨텐츠매니저 UUID 로 생성된 카피이미지 삭제
			//AWSCloudFrontConfig.getS3Client().deleteObject(bucket, imgpathContentManager);
			
			s3Manager.deleteObject(imgpathContentManager);
			
			System.out.format("Deleting %s to S3 bucket %s...\n", imgpathContentManager, bucket);
		} catch(AmazonServiceException e) {
			LogUtil.error(e);
		}
		
		rtnValue.setSuccess(true);

		return rtnValue;
	}


	public StatusResDto removeImageFTP(ImageFileUploadReqDto mfr, String realPath) {
		LogUtil.param(this.getClass(), mfr);

		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);

		mfr.setSVCAlias("");
		String imagePath = commonMapper.selectImagePathFTP(mfr);
		commonMapper.deleteImageFile(mfr);

		FTPUtil.deleteFile(imagePath);

		rtnValue.setSuccess(true);

		return rtnValue;
	}

	public StatusResDto addImageS3(String empId, String realPath, String sessionId, MultipartFile fileUpload,
			String imageType) {
		StatusResDto rtnValue = new StatusResDto();

		//임시 업로드
		List<TempUploadResDto> tempUploadList = tempUploadS3(realPath, sessionId, fileUpload);

		List<MultiUploadReqDto> muReq = new ArrayList<MultiUploadReqDto>();
		
		if (ObjectUtil.isNotEmpty(tempUploadList)) {
		
			for(TempUploadResDto tempUpload : tempUploadList) {
				MultiUploadReqDto muReqSub = new MultiUploadReqDto();
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.valueOf(imageType));
				muReqSub.setFileName(tempUpload.getName());
				muReqSub.setOriName(tempUpload.getOriName());
				muReqSub.setFilePath(tempUpload.getUrl());
				muReqSub.setRotateAngle("0");
				muReqSub.setSchemas("com");
				muReqSub.setSize(fileUpload.getSize());
				muReqSub.setEmpId(empId);
				
				muReq.add(muReqSub);
			}
		}
		
		MultiUploadResDto muRes = multiUploadImageS3(realPath, sessionId, muReq);
		rtnValue.setSuccess(muRes.getSuccess());
		
		//임시파일 업로드 여부 확인
		/*if (ObjectUtil.isNotEmpty(tempUploadList)) {
			MultiUploadRequestDTO muReqSub = new MultiUploadRequestDTO();

			//파일명, 원본파일명 목록 (콤마 구분)
			StringBuilder fileName = new StringBuilder();
			StringBuilder oriName = new StringBuilder();
			StringBuilder filePath = new StringBuilder();

			for(TempUploadResponseDTO tempUpload : tempUploadList) {
				fileName.append(tempUpload.getName());
				fileName.append(",");

				oriName.append(tempUpload.getOriName());
				oriName.append(",");

				filePath.append(tempUpload.getUrl());
				filePath.append(",");
			}

			String fileNames =  fileName.length() > 0 ? fileName.substring(0, fileName.length() - 1): "";
			String oriNames =  oriName.length() > 0 ? oriName.substring(0, oriName.length() - 1): "";
			String filePaths =  filePath.length() > 0 ? filePath.substring(0, filePath.length() - 1): "";

			muReqSub.setCategory(IMAGE_UPLOAD_TYPE.CAMPAIGN);
			muReqSub.setFileName(fileNames);
			muReqSub.setOriName(oriNames);
			muReqSub.setFilePath(filePaths);
			muReqSub.setRotateAngle("0");
			muReqSub.setSchemas("com");
			muReqSub.setSize(file.getSize());
			muReqSub.setEmpId(empId);

			//이미지 업로드
			MultiUploadResponseDTO mur = baseService.multiUploadImageS3(ralpath, sessionId, muReqSub);
			rtnValue.setSuccess(mur.getSuccess());
		}*/

		return rtnValue;
	}


	public StatusResDto addImageFTP(String empId, String realPath, String sessionId, MultipartFile fileUpload,
								   String imageType) {
		StatusResDto rtnValue = new StatusResDto();


		//임시 업로드
		List<TempUploadResDto> tempUploadList = tempUpload(realPath, sessionId, fileUpload);

		List<MultiUploadReqDto> muReq = new ArrayList<>();

		if (ObjectUtil.isNotEmpty(tempUploadList)) {

			for(TempUploadResDto tempUpload : tempUploadList) {
				MultiUploadReqDto muReqSub = new MultiUploadReqDto();
				muReqSub.setCategory(IMAGE_UPLOAD_TYPE.valueOf(imageType));
				muReqSub.setFileName(tempUpload.getName());
				muReqSub.setOriName(tempUpload.getOriName());
				muReqSub.setFilePath(tempUpload.getUrl());
				muReqSub.setRotateAngle("0");
				muReqSub.setSchemas("com");
				muReqSub.setSize(fileUpload.getSize());
				muReqSub.setEmpId(empId);

				muReq.add(muReqSub);
			}
		}

		MultiUploadResDto muRes = multiUploadImageFTP(realPath, sessionId, muReq);
		rtnValue.setSuccess(muRes.getSuccess());

		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: getExcelMetaData
	  * 2. 클래스명: CommonService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 4. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		DB MetaData를 이용한 엑셀 다운로드시 필요한 데이터 가져오기
	 * 2. 사용법
	 * 
	 * 	# 주석빼고 그대로 사용하시면 됩니다. #
	 *		//session 접근 허용 -> 								HttpSession session = request.getSession(true);
	 *		//(버튼이 메인페이지에 없을때)내부페이지 url -> 	String programPath = (String) session.getAttribute("URL_INCLUDE");
	 *		//(버튼이 메인페이지에 있을때)메인페이지 url ->	if("".equals(programPath)) {
	 *																			programPath = (String) session.getAttribute("URL");
	 *																		}
	 *																		ProgramCache proResDto = null;
	 *		//key 값이될 objCode 호출 -> 						String ObjCode = requestDto.getObjCode();
	 *		//메소트 호출 -> 											commonService.getExcelMetaData(session,programPath,proResDto,ObjCode, model);
	 * 		
	 * </PRE>
	 *   @param session
	 *   @param programPath
	 *   @param proResDto
	 *   @param model
	 */
	public void getExcelMetaData(HttpSession session, String programPath, ProgramCache proResDto, String objCode, ModelMap model) {
		Gson gson = new Gson();
		
		String result = null;
		String userId = null;
		if(programPath.lastIndexOf('.') > -1 ) {
			result = programPath.substring(0, programPath.lastIndexOf('.'));
		}else {
			result = programPath;
		}
		userId = (String)session.getAttribute(SessionCommon.SESSION_USER_KEY_PROP);
		ProgramCache proResDto1 =  authCommonService.getProgramAuth(userId, result);
		String programId = proResDto1.getPgmRid();
		
		List<ExcelMetaDataResDto>  header = getExcelHeader(programId, objCode);
		String excelHeader = gson.toJson(header);
		model.addAttribute("excelType", header.get(0).getExcelType());
		model.addAttribute("fileName", header.get(0).getTitle());
		model.addAttribute("excelHeader", excelHeader);
		model.addAttribute("headerType","DB");
	}
	
}

