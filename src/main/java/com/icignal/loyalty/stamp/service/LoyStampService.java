/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: LoyStampService.java
 * 2. Package	: com.icignal.loyalty.stamp.service
 * 3. Comments	:	
 * 4. Author	: jh.seo
 * 5. DateTime	: 2020. 3. 25. 오후 5:26:19
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 3. 25.		 | jh.seo			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.loyalty.stamp.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Matcher;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.AmazonServiceException;
import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.request.MultiUploadReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.ExcelUtil.HeaderInfo;
import com.icignal.common.util.ExcelUtil.HeaderInfoList;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.component.Messages;
import com.icignal.core.exception.DataBadRequestException;
import com.icignal.core.exception.DataUnhandledException;
import com.icignal.loyalty.stamp.dto.request.LoyStampListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpDetailReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpItemDetailReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpItemListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtDeleteReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtInsertReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtRemoveReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpMbrTgtUpldReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreDeleteReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreInsertReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreListReqDto;
import com.icignal.loyalty.stamp.dto.request.LoyStmpStoreUpldReqDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampDetailResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpDetailResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpItemListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpMbrListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpMbrTgtListResDto;
import com.icignal.loyalty.stamp.dto.response.LoyStmpStoreListResDto;
import com.icignal.loyalty.stamp.mapper.LoyStampMapper;
import com.opencsv.CSVReader;



/*
 * 1. 클래스명	: LoyStampService
 * 2. 파일명	: LoyStampService.java
 * 3. 패키지명	: com.icignal.loyalty.stamp.service
 * 4. 작성자명	: jh.seo
 * 5. 작성일자	: 2020. 3. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyStampService {
	
	@Autowired
	LoyStampMapper loyStampMapper;
	
	@Autowired
	CommonService commonService;
	
	//스탬프 아이템 구매횟수 초기값
	private static final int STMP_ITEM_PUR_CNT_INIT_VALUE = 1;
	
	
	/**
     * @programId :
     * @name : getStampTxnList
     * @date : 2017. 10. 13.
     * @author : kimjunki
     * @table : loy.loy_stmp_txn 
     * @return : GridPagingResDto
     * @description : 스탬프 거래 리스트 조회
    **/
    public GridPagingResDto<LoyStampListResDto> getStampTxnList(LoyStampListReqDto reqDto) {
        LogUtil.param(this.getClass(), reqDto);
        reqDto.setSVCAlias("lst");
        
        GridPagingResDto<LoyStampListResDto> rtnCnt = new GridPagingResHelper<LoyStampListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampMapper.selectStampTxntListCount(reqDto));
        
	    Integer cnt = rtnCnt.getRows().size();

	    GridPagingResDto<LoyStampListResDto> rtnList = new GridPagingResDto<LoyStampListResDto>();
	    
	    if(cnt>0){
	    	rtnList = new GridPagingResHelper<LoyStampListResDto>().newGridPagingResDto(
		    		 reqDto.init(CommonUtil.getInstance().getDBType()),
		    		 loyStampMapper.selectStampTxntList(reqDto),AnnotationType.CommCode);
	    	rtnList.setRecords(cnt);
	    	rtnList.setTotal(cnt);
	    }else{
	    	rtnList.setTotal(0);
	    	rtnList.setRecords(0);
	    }
	    return rtnList; 	     
    }

	/**
	  * @programId :
	  * @name : getStampTxnDetail
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table : loy.loy_stmp_txn
	  * @return : GridPagingResDto<>
	  * @description : 스탬프 상세 조회
	 **/
	public GridPagingResDto<LoyStampDetailResDto> getStampTxnDetail(LoyStampListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<LoyStampDetailResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampMapper.selectStampDetail(param));    
	}

	/**
	  * @programId :
	  * @name : getStampDetailPop
	  * @date : 2017. 10. 13.
	  * @author : kimjunki
	  * @table :  loy.loy_stmp_txn
	  * @return : GridPagingResDto<>
	  * @description : 스탬프 상세 팝업
	 **/
	public GridPagingResDto<LoyStampDetailResDto> getStampDetailPop(LoyStampListReqDto param) {
		LogUtil.param(this.getClass(), param);
        		
		return new GridPagingResHelper<LoyStampDetailResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampMapper.selectStampDetailPop(param));  
	}
    
	/* ========================= 다이소 스탬프 ========================= */
    /**
    * @programId :
    * @name : getLoyStmpList
    * @date : 2019. 3. 5.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 스탬프 목록 조회
    */
    public GridPagingResDto<LoyStmpListResDto> getLoyStmpList(LoyStmpListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return new GridPagingResHelper<LoyStmpListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampMapper.getLoyStmpList(param));  
    }
    
    /**
    * @programId :
    * @name : getLoyStmpDetail
    * @date : 2019. 3. 5.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 스탬프 상세 조회
    */
    public LoyStmpDetailResDto getLoyStmpDetail(LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return loyStampMapper.getLoyStmpDetail(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpDetail2
    * @date : 2019. 3. 26.
    * @author : hy.jun
    * @table :
    * @return : LOYStmpDetailResponseDTO
    * @description :
    */
    public LoyStmpDetailResDto getLoyStmpDetail2(LoyStmpDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return loyStampMapper.getLoyStmpDetail2(param);
    }
    
    /**
    * @programId :
    * @name : getLoyStmpItemList
    * @date : 2019. 3. 5.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 스탬프 구간별 스탬프 목록 조회
    */
    public GridPagingResDto<LoyStmpItemListResDto> getLoyStmpItemList(LoyStmpItemListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return new GridPagingResHelper<LoyStmpItemListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		loyStampMapper.getLoyStmpItemList(param)); 
    }
    
    /**
    * @programId :
    * @name : getLoyStmpStoreList
    * @date : 2019. 3. 5.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 스탬프 적용채널 목록 조회
    */
    public GridPagingResDto<LoyStmpStoreListResDto> getLoyStmpStoreList(LoyStmpStoreListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return new GridPagingResHelper<LoyStmpStoreListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		loyStampMapper.getLoyStmpStoreList(param));
    }
    
    /**
    * @programId :
    * @name : getLoyStmpMbrList
    * @date : 2019. 3. 5.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 스탬프 참여 회원 조회
    */
    public GridPagingResDto<LoyStmpMbrListResDto> getLoyStmpMbrList(LoyStmpMbrListReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return new GridPagingResHelper<LoyStmpMbrListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
	    		loyStampMapper.getLoyStmpMbrList(param));
    }

	/**
	* @programId :
	* @name : setLoyStmp
	* @date : 2019. 3. 5.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 등록
	*/
	public StatusResDto setLoyStmp(LoyStmpDetailReqDto param, HttpSession session) {
        LogUtil.param(this.getClass(), param);
        
        StatusResDto rtnValue = new StatusResDto(false, "");
        
        //스탬프 저장
        String loyStmpRid = CommonUtil.newRid();
        param.setRid(loyStmpRid);
        loyStampMapper.setLoyStmp(param);
        
        //스탬프 이미지 업로드
        uploadStmpImgS3(param, param.getBgImg(), IMAGE_UPLOAD_TYPE.STMP_BG, session);
        uploadStmpImgS3(param, param.getBoardImg(), IMAGE_UPLOAD_TYPE.STMP_BOARD, session);
        uploadStmpImgS3(param, param.getStmpImg1(), IMAGE_UPLOAD_TYPE.STMP_IMG_1, session);
        uploadStmpImgS3(param, param.getStmpImg2(), IMAGE_UPLOAD_TYPE.STMP_IMG_2, session);
        uploadStmpImgS3(param, param.getStmpImg3(), IMAGE_UPLOAD_TYPE.STMP_IMG_3, session);
        uploadStmpImgS3(param, param.getStmpImg4(), IMAGE_UPLOAD_TYPE.STMP_IMG_4, session);
        uploadStmpImgS3(param, param.getStmpImg1Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_1_SECT, session);
        uploadStmpImgS3(param, param.getStmpImg2Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_2_SECT, session);
        uploadStmpImgS3(param, param.getStmpImg3Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_3_SECT, session);
        uploadStmpImgS3(param, param.getStmpImg4Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_4_SECT, session);
        
        //스탬프 아이템 생성
        List<LoyStmpItemDetailReqDto> stmpItemList = new ArrayList<LoyStmpItemDetailReqDto>();
        for(int i=1; i<=param.getStmpCnt(); i++) {
        	LoyStmpItemDetailReqDto stmpItemReq = new LoyStmpItemDetailReqDto();
        	stmpItemReq.setRidStmp(param.getRid());
        	stmpItemReq.setCreateBy(param.getCreateBy());
        	stmpItemReq.setModifyBy(param.getModifyBy());
        	stmpItemReq.setItemNo(i);
        	stmpItemReq.setStmpCnt(STMP_ITEM_PUR_CNT_INIT_VALUE);
        	stmpItemList.add(stmpItemReq);
        }
        loyStampMapper.setLoyStmpItem(stmpItemList);
   
        rtnValue.setSuccess(true);
        rtnValue.setMessage(loyStmpRid);
        return rtnValue;
	}
	
	/**
	* @programId :
	* @name : uploadStmpImgS3
	* @date : 2019. 4. 2.
	* @author : hy.jun
	* @table :
	* @return : void
	* @description : 스탬프 이미지 업로드 공통화
	*/
	private void uploadStmpImgS3(LoyStmpDetailReqDto param, List<MultiUploadReqDto> imgArr, IMAGE_UPLOAD_TYPE category, HttpSession session) {
        //스탬프 Check  이미지 저장
        if(ObjectUtil.isNotEmpty(imgArr)) {
        	for(MultiUploadReqDto mur : imgArr) {
        		mur.setParentId(param.getRid());
        		mur.setCategory(category);
        		mur.setSchemas("com");
        		/*mur.setAppServiceId(param.getAppServiceId());
        		mur.setCountry(param.getCountry());*/
        		mur.setLang(param.getLang());
        		mur.setImageLang(param.getLang());
        		mur.setSize(mur.getSize());
        	}
        	commonService.multiUploadImageS3(session.getServletContext().getRealPath("/"), session.getId(), imgArr);
        }
	}
	
	/**
	* @programId :
	* @name : removeLoyStmp
	* @date : 2019. 3. 5.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 삭제
	*/
	public StatusResDto removeLoyStmp(LoyStmpDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		//스탬프 조회
		LoyStmpDetailResDto stmpDetail = loyStampMapper.getLoyStmpDetail(param);
		if(!stmpDetail.getStmpStatus().equals(CommonUtil.Loy_STMP_SATUS_CD.W.toString())) {
			rtnValue.setMessage("1");
			return rtnValue;
		}
		
		loyStampMapper.removeLoyStmp(param);
		
//    	String bucket = CommonUtil.getInstance().getServletProp("aws.s3.bucket");
		String bucket = BeansUtil.getApplicationProperty("aws.s3.bucket-name");

    	//등록된 스탬프 배경 이미지 삭제
    	MultiUploadReqDto muReqSub = new MultiUploadReqDto();
    	muReqSub.setParentId(param.getRid());
		muReqSub.setCategory(IMAGE_UPLOAD_TYPE.EVENT_MAIN_BANNER);
		muReqSub.setSchemas("com");
		/*muReqSub.setAppServiceId(param.getAppServiceId());
		muReqSub.setCountry(param.getCountry());*/
		muReqSub.setLang(param.getLang());
		muReqSub.setImageLang(param.getLang());

		List<String> orgImages = commonService.getParentImages(muReqSub);
		for(String orgImage : orgImages) {
			try {
				//AWSCloudFrontConfig.getS3Client().deleteObject(bucket, orgImage);
				System.out.format("Deleting %s to S3 bucket %s...\n", orgImage, bucket);
			} catch(AmazonServiceException e) {
				LogUtil.error(e);
			}
		}
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/**
	* @programId :
	* @name : activeStmp
	* @date : 2019. 3. 6.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 활성
	*/
	public StatusResDto activeStmp(LoyStmpDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		boolean isExistCampaign = false; //캠페인 등록여부 체크
		boolean isInactiveCampaign = false; //캠페인 활성여부 체크
		boolean isDatetermOutOfRange = false; //캠페인기간-스탬프기간 체크
		
		//스탬프 조회
		LoyStmpDetailResDto stmpDetail = loyStampMapper.getLoyStmpDetail(param);
		
		//스탬프 아이템 조회
		LoyStmpItemListReqDto stmpItemReq = new LoyStmpItemListReqDto();
		stmpItemReq.setRidStmp(param.getRid());
		ArrayList<LoyStmpItemListResDto> stmpItemList = loyStampMapper.getLoyStmpItemList2(stmpItemReq);
		
		if(!(ObjectUtil.isNotEmpty(stmpItemList) && stmpItemList.size() > 0)) {
			rtnValue.setMessage("0"); //구간별 스탬프가 존재하지 않습니다.
			return rtnValue;
		}
		
		//특정회원여부 Y 인 경우 업로드된 특정회원 필수
		if(ObjectUtil.isNotEmpty(stmpDetail.getMbrTgtYn()) && stmpDetail.getMbrTgtYn().equals("Y")) {
			Integer stmpMbrTgtCnt = loyStampMapper.getLoyStmpMbrTgtCnt(param.getRid());
			if(stmpMbrTgtCnt <= 0) {
				rtnValue.setMessage("8"); //특정회원이 존재하지 않습니다.
				return rtnValue;
			}
		}
		
		/**
		 * 캠페인 체크
		 */
		for(LoyStmpItemListResDto stmpItem : stmpItemList) {
			
			//스탬프 아이템에 등록된 캠페인 체크
			if(ObjectUtil.isNotEmpty(stmpItem.getCamNo())) {
				//존재여부
				if(!isExistCampaign) {
					isExistCampaign = true;
				}
				
				//활성여부
				if(!stmpItem.getCamStatusCd().equals(CommonUtil.CAMPAIGN_STATUS_TYPE.A.toString())) {
					isInactiveCampaign = true;
					break;
				}
				
				//캠페인기간
				if(stmpDetail.getStmpStartDtFullFmt().compareTo(stmpItem.getCamStartDd()) < 0
						|| stmpDetail.getStmpEndDtFullFmt().compareTo(stmpItem.getCamEndDd()) > 0) {
					isDatetermOutOfRange = true;
					break;
				}
			}
		}
		
		if(!isExistCampaign) {
			rtnValue.setMessage("2"); //최소 1개의 캠페인이 등록되어 있어야 합니다.
			return rtnValue;
		}
		
		if(isInactiveCampaign) {
			rtnValue.setMessage("3"); //등록된 캠페인의 상태가 활성중이 아닙니다.
			return rtnValue;
		}
		
		if(isDatetermOutOfRange) {
			rtnValue.setMessage("4"); //스탬프 행사기간이 등록된 캠페인 기간을 벗어났습니다.
			return rtnValue;
		}
		
		/**
		 * 누적거래 체크
		 */
		if(stmpDetail.getCalcTypeCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_CD.COND_MULTIPLE.getValue())) {
			
			//구매금액AND구매횟수
			if(stmpDetail.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURAMT_AND_PURCNT.getValue())) {
				int size = stmpItemList.size();
				for(int i=0; i<size; i++) {
					
					if(stmpDetail.getPurCntMinAmt() > stmpItemList.get(i).getStmpAmt()) {
						rtnValue.setMessage("1"); //구간별 스탬프들의 구매금액은 구매횟수 최소금액보다 커야합니다.
						return rtnValue;
					}
					
					if(i > 0) {
						if(stmpItemList.get(i-1).getStmpAmt() > stmpItemList.get(i).getStmpAmt()) {
							rtnValue.setMessage("5"); //구간별 스탬프들의 구매금액은 이전 구간의 금액보다 커야합니다.
							return rtnValue;
						}
						if(stmpItemList.get(i-1).getStmpCnt() > stmpItemList.get(i).getStmpCnt()) {
							rtnValue.setMessage("6"); //구간별 스탬프들의 구매횟수는 이전 구간의 구매횟수보다 커야합니다.
							return rtnValue;
						}
					}
				}
			}
			
			//구매금액
			if(stmpDetail.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURAMT.getValue())) {
				int size = stmpItemList.size();
				for(int i=1; i<size; i++) {
					if(stmpItemList.get(i-1).getStmpAmt() >= stmpItemList.get(i).getStmpAmt()) {
						rtnValue.setMessage("5"); //구간별 스탬프들의 구매금액은 이전 구간의 금액보다 커야합니다.
						return rtnValue;
					}
				}
			}
			
			//구매횟수
			if(stmpDetail.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURCNT.getValue())) {
				int size = stmpItemList.size();
				for(int i=1; i<size; i++) {
					if(stmpItemList.get(i-1).getStmpCnt() >= stmpItemList.get(i).getStmpCnt()) {
						rtnValue.setMessage("6"); //구간별 스탬프들의 구매횟수는 이전 구간의 구매횟수보다 커야합니다.
						return rtnValue;
					}
				}
			}
		}
		
		/**
		 * 적용채널 체크
		 */
		if(stmpDetail.getApplyChnlCd().equals(CommonUtil.Loy_STMP_APPLY_CHNL_CD.INCLUDE_CHNL.getValue())) {
			//적용채널 개수 조회
			Integer storeCnt = loyStampMapper.getLoyStmpStoreCnt(param.getRid());
			if(storeCnt < 1) {
				rtnValue.setMessage("7"); //적용채널이 존재하지 않습니다.
				return rtnValue;
			}
		}
		
		//스탬프 활성
		param.setStmpStatus(CommonUtil.Loy_STMP_SATUS_CD.A.toString());
		loyStampMapper.editLoyStmpStmpStatus(param);
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	 * @programId :
	 * @name : inactiveStmp
	 * @date : 2019. 3. 6.
	 * @author : hy.jun
	 * @table :
	 * @return : 
	 * @description : 스탬프 비활성
	 */
	public StatusResDto inactiveStmp(LoyStmpDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		LoyStmpDetailResDto stmpDetail = loyStampMapper.getLoyStmpDetail(param);
		if(!stmpDetail.getStmpStatus().equals(CommonUtil.Loy_STMP_SATUS_CD.A.toString())) {
			rtnValue.setMessage("1");
			return rtnValue;
		}
		
		param.setStmpStatus(CommonUtil.Loy_STMP_SATUS_CD.I.toString());
		loyStampMapper.editLoyStmpStmpStatus(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : editLoyStmp
	* @date : 2019. 3. 6.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 수정
	*/
	public StatusResDto editLoyStmp(LoyStmpDetailReqDto param, HttpSession session) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		//스탬프 조회
		LoyStmpDetailResDto stmpDetail = loyStampMapper.getLoyStmpDetail(param);

		//활성상태가 아닌 경우
		if(!(stmpDetail.getStmpStatus().equals(CommonUtil.Loy_STMP_SATUS_CD.A.toString()))) {
			//스탬프 수정
			loyStampMapper.editLoyStmp(param);
		}
		
		//작업중인 경우
		if(stmpDetail.getStmpStatus().equals(CommonUtil.Loy_STMP_SATUS_CD.W.toString())) {
			
	        //스탬프 이미지 업로드
	        uploadStmpImgS3(param, param.getBgImg(), IMAGE_UPLOAD_TYPE.STMP_BG, session);
	        uploadStmpImgS3(param, param.getBoardImg(), IMAGE_UPLOAD_TYPE.STMP_BOARD, session);
	        uploadStmpImgS3(param, param.getStmpImg1(), IMAGE_UPLOAD_TYPE.STMP_IMG_1, session);
	        uploadStmpImgS3(param, param.getStmpImg2(), IMAGE_UPLOAD_TYPE.STMP_IMG_2, session);
	        uploadStmpImgS3(param, param.getStmpImg3(), IMAGE_UPLOAD_TYPE.STMP_IMG_3, session);
	        uploadStmpImgS3(param, param.getStmpImg4(), IMAGE_UPLOAD_TYPE.STMP_IMG_4, session);
	        uploadStmpImgS3(param, param.getStmpImg1Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_1_SECT, session);
	        uploadStmpImgS3(param, param.getStmpImg2Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_2_SECT, session);
	        uploadStmpImgS3(param, param.getStmpImg3Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_3_SECT, session);
	        uploadStmpImgS3(param, param.getStmpImg4Sect(), IMAGE_UPLOAD_TYPE.STMP_IMG_4_SECT, session);
	        
			//이전 스탬프 갯수와 다른 경우 기존 스탬프 아이템 삭제 후 생성
			if(stmpDetail.getStmpCnt() != param.getStmpCnt()) {
				LoyStmpItemDetailReqDto stmpItemRmvReq = new LoyStmpItemDetailReqDto();
				stmpItemRmvReq.setRidStmp(param.getRid());
				loyStampMapper.removeLoyStmpItem(stmpItemRmvReq);
				
		        List<LoyStmpItemDetailReqDto> stmpItemList = new ArrayList<LoyStmpItemDetailReqDto>();
		        for(int i=1; i<=param.getStmpCnt(); i++) {
		        	LoyStmpItemDetailReqDto stmpItemNewReq = new LoyStmpItemDetailReqDto();
		        	stmpItemNewReq.setRidStmp(param.getRid());
		        	stmpItemNewReq.setCreateBy(param.getCreateBy());
		        	stmpItemNewReq.setModifyBy(param.getModifyBy());
		        	stmpItemNewReq.setItemNo(i);
		        	stmpItemNewReq.setStmpCnt(STMP_ITEM_PUR_CNT_INIT_VALUE);
		        	stmpItemList.add(stmpItemNewReq);
		        }
		        loyStampMapper.setLoyStmpItem(stmpItemList);
			} else {
				//스탬프 계산유형 상세 단일거래 인 경우 or 스탬프 계산상세유형 구매금액 인 경우
				if(stmpDetail.getCalcTypeCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_CD.COND_SINGLE.getValue())
						|| stmpDetail.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURAMT.getValue())) {
					
					//구매횟수 초기화
					LoyStmpItemDetailReqDto stmpItemInitReq = new LoyStmpItemDetailReqDto();
					stmpItemInitReq.setRidStmp(param.getRid());
					stmpItemInitReq.setStmpCnt(STMP_ITEM_PUR_CNT_INIT_VALUE);
					stmpItemInitReq.setModifyBy(param.getModifyBy());
					loyStampMapper.editLoyStmpItemPurCntInitialize(stmpItemInitReq);
				}
			}
		}
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : editLoyStmpItem
	* @date : 2019. 3. 6.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 아이템 수정 (구간별 스탬프 수정)
	*/
	public StatusResDto editLoyStmpItem(LoyStmpItemDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		//기존 스탬프 상세 조회
		LoyStmpDetailReqDto stmpReq = new LoyStmpDetailReqDto();
		stmpReq.setRid(param.getRidStmp());
		LoyStmpDetailResDto stmpRes = loyStampMapper.getLoyStmpDetail(stmpReq);
		
		//기존 스탬프 아이템 목록 조회
		LoyStmpItemListReqDto stmpItemReq = new LoyStmpItemListReqDto();
		stmpItemReq.setRidStmp(param.getRidStmp());
		ArrayList<LoyStmpItemListResDto> stmpItemRes = loyStampMapper.getLoyStmpItemList2(stmpItemReq);
		
		//활성 상태 체크
		if(stmpRes.getStmpStatus().equals("A")) {
			rtnValue.setMessage("4");
			return rtnValue;
		}
		
		/**
		 * 단일거래 스탬프인 경우
		 * - 모든 아이템의 구매횟수는 0이어야 한다.
		 */
//		if(stmpRes.getCalcTypeCd().equals(CommonUtil.LOY_STMP_CALC_TYPE_CD.COND_SINGLE.getValue())) {
//			if(param.getStmpCnt() != 0) {
//				rtnValue.setMessage("1");
//				return rtnValue;
//			}
//		}
		/**
		 * 누적거래 스탬프인 경우
		 * - 계산유형 > 구매금액 또는 구매금액AND구매횟수 일 경우
		 * 	-> 2 ~ N번 아이템의 경우 이전 스탬프보다 구매금액이 커야한다.
		 *  -> 2 ~ N번 아이템의 경우 이전 스탬프보다 구매횟수가 커야한다.
		 * - 계산유형 > 구매금액 일 경우
		 *  -> 2 ~ N번 아이템의 경우 이전 스탬프보다 구매금액이 커야한다.
		 * - 계산유형 > 구매횟수 일 경우
		 * 	-> 2 ~ N번 아이템의 경우 이전 스탬프보다 구매횟수가 커야한다.
		 */
		if(stmpRes.getCalcTypeCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_CD.COND_MULTIPLE.getValue())) {
			if(param.getItemNo() > 1) {
				if(stmpRes.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURAMT_AND_PURCNT.getValue())) {
						//2 ~ N번 아이템의 경우 이전 스탬프보다 구매금액이 커야한다.
						if(stmpItemRes.get(param.getItemNo()-2).getStmpAmt() > param.getStmpAmt()) {
							rtnValue.setMessage("2");
							return rtnValue;
						}
						
						//2 ~ N번 아이템의 경우 이전 스탬프보다 구매횟수가 커야한다.
						if(stmpItemRes.get(param.getItemNo()-2).getStmpCnt() > param.getStmpCnt()) {
							rtnValue.setMessage("3");
							return rtnValue;
						}
				}
				else if(stmpRes.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURAMT.getValue())) {
					//2 ~ N번 아이템의 경우 이전 스탬프보다 구매금액이 커야한다.
					if(stmpItemRes.get(param.getItemNo()-2).getStmpAmt() >= param.getStmpAmt()) {
						rtnValue.setMessage("2");
						return rtnValue;
					}
				} 
				else if(stmpRes.getCalcTypeSubCd().equals(CommonUtil.Loy_STMP_CALC_TYPE_SUB_CD.PURCNT.getValue())) {
					//2 ~ N번 아이템의 경우 이전 스탬프보다 구매횟수가 커야한다.
					if(param.getItemNo() > 1 && stmpItemRes.get(param.getItemNo()-2).getStmpCnt() >= param.getStmpCnt()) {
						rtnValue.setMessage("3");
						return rtnValue;
					}
				}
			}
		}
		
		loyStampMapper.editLoyStmpItem(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : excelUploadStmpStoreTemplate
	* @date : 2019. 3. 14.
	* @author : hy.jun
	* @table :
	* @return : 
	 * @throws IOException 
	* @description : 스탬프 적용채널 엑셀 업로드
	*/
	@SuppressWarnings({ "resource", "rawtypes" })
	public StatusResDto excelUploadStmpStoreTemplate(MultipartFile file, LoyStmpStoreUpldReqDto param){
		
		//업로드파일에서 읽어온 채널 목록
		ArrayList<String> chnlNoList = new ArrayList<String>();
		
        // 파일 확장자 초기화
        String fileName = "";
        String fileType = "";
		
        // 파일 확장자 검사
        try {
			fileName = URLDecoder.decode(file.getOriginalFilename(), "utf-8");
			fileType = fileName.substring(fileName.lastIndexOf('.') + 1);
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e);
			throw new DataBadRequestException("xls, xlsx, csv 형식의 파일만 가능합니다.");
		}

        // 파일 확장자가 올바른가?
        if (!fileType.equalsIgnoreCase("xls")&& !fileType.equalsIgnoreCase("xlsx")  && !fileType.equalsIgnoreCase("csv")) {
            throw new DataBadRequestException(Messages.getMessage("M00703", param.getLang()));
        }
        // 파일의 용량이 10MB 이하인가?
        else if (file.getSize() > 10485760) {
            throw new DataBadRequestException(Messages.getMessage("M02506", param.getLang()));
        }
        
        //xlsx 파일 읽기
        if(fileType.equalsIgnoreCase("xls") || fileType.equalsIgnoreCase("xlsx")) {
        	Workbook wb = null;
            try {
				
				if(fileType.equalsIgnoreCase("xls")) {
					wb = new HSSFWorkbook(file.getInputStream());
				} else	wb = new XSSFWorkbook(file.getInputStream());
			
				Sheet sheet = wb.getSheetAt(0);
				
				int firstRowNum = sheet.getFirstRowNum();
				int lastRowNum = sheet.getLastRowNum();

				//템플릿 형식 체크
				//-> 첫번째 행이 '채널코드,채널명' 이 맞는가?
				Row firstRow = sheet.getRow(firstRowNum);
				String firstCellValue = firstRow.getCell(0).getStringCellValue();
				String secondCellValue = firstRow.getCell(1).getStringCellValue();
				
				if(ObjectUtil.isEmpty(firstCellValue) || !firstCellValue.equals(Messages.getMessage("L00128", param.getLang()))) {
//					throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
				}
				if(ObjectUtil.isEmpty(secondCellValue) || !secondCellValue.equals(Messages.getMessage("L00129", param.getLang()))) {
//					throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
				}
				
				DataFormatter formatter = new DataFormatter();
				//엑셀 데이터 읽기
				for (int i = firstRowNum+1; i <= lastRowNum; i++) {
					
                    Row row = sheet.getRow(i);
                    Iterator cells = row.cellIterator();
                    
                    while (cells.hasNext()) {
                    	Cell cell = (Cell) cells.next();
                    	
                    	int cellIdx = cell.getColumnIndex();
                    	String cellValue = formatter.formatCellValue(row.getCell(cellIdx));
                    	
                    	if(cellIdx == 0) {
                    		//개행문자 & 공백 제거
                    		cellValue = StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,"")).replaceAll(" ", "");
                    		chnlNoList.add(cellValue);
						}
                    	
                    }
                    
				}
				
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException(Messages.getMessage("M02506", param.getLang()));
			} finally {
				try {
					wb.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
        } 
        //csv 파일 읽기
        else if(fileType.equalsIgnoreCase("csv")) {
            CSVReader reader = null;
            try {
				reader = new CSVReader(new InputStreamReader(file.getInputStream(), "EUC-KR"));
                String[] nextLine;

				//템플릿 형식 체크
				//-> 첫번째 행이 '채널코드,채널명' 이 맞는가?
                nextLine = reader.readNext();
                if(nextLine == null || nextLine.length != 2 
                		|| !nextLine[0].equals(Messages.getMessage("L00128", param.getLang())) 
                		|| !nextLine[0].equals(Messages.getMessage("L00129", param.getLang()))) {
//                	throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
                }
                
                //csv 데이터 읽기
                while ((nextLine = reader.readNext()) != null) {
                    for (int i = 0; i < nextLine.length; i++) {
                    	if(i == 0) {
                    		chnlNoList.add(nextLine[i]);
						}
                    }
                    
                }
                
            } catch (UnsupportedEncodingException e) {
            	LogUtil.error(e);
				throw new DataUnhandledException();
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException();
			}finally {
				try {
					reader.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
        }
        
        //업로드 파일에서 읽어낸 채널코드 목록 세팅
        param.setChnlNoList(chnlNoList);
        
        //적용채널 DB INSERT (sqlldr)
		return this.setLoyStmpStoreBulks(param);
	}
	
	/**
	* @programId :
	* @name : removeLoyStmpStore
	* @date : 2019. 3. 14.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 적용채널 삭제
	*/
	public StatusResDto removeLoyStmpStore(LoyStmpStoreDeleteReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		loyStampMapper.removeLoyStmpStore(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
    /**
    * @programId :
    * @name : getStmpItemDetail
    * @date : 2019. 3. 14.
    * @author : hy.jun
    * @table :
    * @return : 
    * @description : 스탬프 아이템 상세 조회
    */
    public LoyStmpItemListResDto getStmpItemDetail(LoyStmpItemDetailReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	return loyStampMapper.getStmpItemDetail(param);
    }

	/**
	* @programId :
	* @name : setLoyStmpStore
	* @date : 2019. 4. 12.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 적용채널 등록
	*/
	public StatusResDto setLoyStmpStore(LoyStmpStoreInsertReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	
    	StatusResDto rtnValue = new StatusResDto();
    	if( loyStampMapper.checkExistLoyStmpStore(param) > 0) {
    		rtnValue.setMessage("1"); //이미 등록된 적용채널입니다.
    		return rtnValue;
    	}
    	
    	loyStampMapper.setLoyStmpStore(param);
    	rtnValue.setSuccess(true);
    	
    	return rtnValue;
	}
	
	/**
	* @programId :
	* @name : getLoyStmpMbrTgtList
	* @date : 2019. 4. 22.
	* @author : hy.jun
	* @table :
	* @return : GridPagingResDto<>
	* @description : 스탬프 적용회원 목록 조회
	*/
	public GridPagingResDto<LoyStmpMbrTgtListResDto> getLoyStmpMbrTgtList(LoyStmpMbrTgtListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyStmpMbrTgtListResDto>().newGridPagingResDto(
	    		 reqDto.init(CommonUtil.getInstance().getDBType()),
	    		 loyStampMapper.getLoyStmpMbrTgtList(reqDto),AnnotationType.ALL);
	}
	
	/**
	* @programId :
	* @name : removeLoyStmpMbrTgt
	* @date : 2019. 4. 22.
	* @author : hy.jun
	* @table :
	* @return : StatusResDto
	* @description : 스탬프 적용회원 초기화
	*/
	public StatusResDto removeLoyStmpMbrTgt(LoyStmpMbrTgtRemoveReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		LoyStmpDetailReqDto stmpDetailReq = new LoyStmpDetailReqDto();
		stmpDetailReq.setRid(param.getRidStmp());
		LoyStmpDetailResDto stmpDetail = loyStampMapper.getLoyStmpDetail(stmpDetailReq);
		
		//작업중인 스탬프만 적용회원 초기화 가능
		if(!stmpDetail.getStmpStatus().equals(CommonUtil.Loy_STMP_SATUS_CD.W.toString())) {
			rtnValue.setMessage("1");
			return rtnValue;
		}
		
		loyStampMapper.removeLoyStmpMbrTgt(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	/**
	* @programId :
	* @name : excelUploadStmpMbrTgtTemplate
	* @date : 2019. 4. 22.
	* @author : hy.jun
	* @table :
	* @return : 
	 * @throws IOException 
	* @description : 스탬프 적용회원 업로드
	*/
	@SuppressWarnings({ "resource", "rawtypes" })
	public StatusResDto excelUploadStmpMbrTgtTemplate(MultipartFile file, LoyStmpMbrTgtUpldReqDto param){
		
		
		
		//업로드파일에서 읽어온 채널 목록
		ArrayList<String> mbrNoList = new ArrayList<String>();
		
        // 파일 확장자 초기화
        String fileName = "";
        String fileType = "";
		
        
        // 파일 확장자 검사
        try {
        	   
				fileName = URLDecoder.decode( Optional.ofNullable(file.getOriginalFilename()).orElse(""), "utf-8");
				fileType = fileName.substring(fileName.lastIndexOf('.') + 1);
        			} catch (UnsupportedEncodingException e) {
			LogUtil.error(e);
			throw new DataBadRequestException("xls, xlsx, csv 형식의 파일만 가능합니다.");
		}

        // 파일 확장자가 올바른가?
        if (!fileType.equalsIgnoreCase("xls") && !fileType.equalsIgnoreCase("xlsx")  && !fileType.equalsIgnoreCase("csv")) {
            throw new DataBadRequestException(Messages.getMessage("M00703", param.getLang()));
        }
        // 파일의 용량이 10MB 이하인가?
        else if (file.getSize() > 10485760) {
            throw new DataBadRequestException(Messages.getMessage("M02506", param.getLang()));
        }
        
        //xlsx 파일 읽기
        if(fileType.equalsIgnoreCase("xls") || fileType.equalsIgnoreCase("xlsx")) {
        	Workbook wb = null;
            try {
			
				if(fileType.equalsIgnoreCase("xls")) {
					wb = new HSSFWorkbook(file.getInputStream());
				} else  {
					wb = new XSSFWorkbook(file.getInputStream());
				}
				
				Sheet sheet = wb.getSheetAt(0);
				
				int firstRowNum = sheet.getFirstRowNum();
				int lastRowNum = sheet.getLastRowNum();

				//템플릿 형식 체크
				//-> 첫번째 행이 '회원번호' 가 맞는가?
				Row firstRow = sheet.getRow(firstRowNum);
				String firstCellValue = firstRow.getCell(0).getStringCellValue();
				
				if(ObjectUtil.isEmpty(firstCellValue) || !firstCellValue.equals(Messages.getMessage("L00690", param.getLang()))) {
//					throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
				}
				
				DataFormatter formatter = new DataFormatter();
				//엑셀 데이터 읽기
				for (int i = firstRowNum+1; i <= lastRowNum; i++) {
					
                    Row row = sheet.getRow(i);
                    Iterator cells = row.cellIterator();
                    
                    while (cells.hasNext()) {
                    	Cell cell = (Cell) cells.next();
                    	
                    	int cellIdx = cell.getColumnIndex();
                    	String cellValue = formatter.formatCellValue(row.getCell(cellIdx));
                    	
                    	if(cellIdx == 0) {
                    		//개행문자 & 공백 제거
                    		cellValue = StringUtil.removeLinebreak(StringUtil.convertNull(cellValue,"")).replaceAll(" ", "");
                    		mbrNoList.add(cellValue);
						}
                    	
                    }
                    
				}
				
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException(Messages.getMessage("M02506", param.getLang()));
			}finally {
				try {
					wb.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
			}
        } 
        //csv 파일 읽기
        else if(fileType.equalsIgnoreCase("csv")) {
            CSVReader reader = null;
            try {
				reader = new CSVReader(new InputStreamReader(file.getInputStream(), "EUC-KR"));
                String[] nextLine;

				//템플릿 형식 체크
				//-> 첫번째 행이 '채널코드,채널명' 이 맞는가?
                nextLine = reader.readNext();
                if(nextLine == null || nextLine.length != 2 
                		|| !nextLine[0].equals(Messages.getMessage("L00128", param.getLang())) 
                		|| !nextLine[0].equals(Messages.getMessage("L00129", param.getLang()))) {
//                	throw new DataBadRequestException(Messages.getMessage("M02506", loginInfo.getLang()));
					throw new DataBadRequestException("유효한 템플릿 형식이 아닙니다.");
                }
                
                //csv 데이터 읽기
                while ((nextLine = reader.readNext()) != null) {
                    for (int i = 0; i < nextLine.length; i++) {
                    	if(i == 0) {
                    		mbrNoList.add(nextLine[i]);
						}
                    }
                    
                }
                reader.close();
            } catch (UnsupportedEncodingException e) {
            	LogUtil.error(e);
				throw new DataUnhandledException();
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException();
			}finally {
				try {
					reader.close();
				} catch (IOException e) {
					LogUtil.error(e);
				}
				
			}
        }
        
        //업로드 파일에서 읽어낸 채널코드 목록 세팅
        param.setMbrNoList(mbrNoList);
        
        //적용채널 DB INSERT (sqlldr)
        return this.setLoyStmpMbrTgtBulks(param);
	}

	/**
	* @programId :
	* @name : createDownloadMbrTgtTemplate
	* @date : 2019. 4. 22.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description : 스탬프 적용회원 템플릿 다운로드
	*/
	public void createDownloadMbrTgtTemplate(HttpServletResponse response, LoginResDto loginInfo) {
		
		String FILE_NAME = "stamp_mbr_template.xlsx";
		XSSFWorkbook wb = null;
		ServletOutputStream sos = null;
		
		try {		
			wb = new XSSFWorkbook();
			Sheet sheet = wb.createSheet("Memeber List");
			
			//5.엑셀 헤더정보 세팅
			HeaderInfoList headers = new HeaderInfoList();
			HeaderInfo headerMbrNo = new HeaderInfo();
			headerMbrNo.setVariableName("MBRNO");
			headerMbrNo.setDisplayName(Messages.getMessage("L00690", loginInfo.getLang()));
			headerMbrNo.setIndex(0);
			
			headers.add(headerMbrNo);
			
			int cellIdx = 0;
			Row rowHeader = sheet.createRow(0);
			for(HeaderInfo header : headers) {
				rowHeader.createCell(cellIdx).setCellValue(header.getDisplayName());
				cellIdx++;
			}
			
			for(int i = 0; i < headers.size(); i++) {
	            sheet.autoSizeColumn(i);
	        }

			response.setContentType("application/vnd.ms-excel"); //Tell the browser to expect an excel file
			response.setHeader("Content-Disposition", "attachment; filename="+FILE_NAME); //Tell the browser it should be named as the custom file name
			
			sos = response.getOutputStream();
			wb.write(sos);
			sos.flush();
			wb.close();
			
		} catch (Exception e) {
			LogUtil.error(e);
		} finally {
			try {
				if(sos != null) { sos.flush(); sos.close(); }
				if(wb != null) { wb.close(); }
			} catch (IOException e) {
				LogUtil.error(e);
				throw new DataUnhandledException("");
			}
		}
	}

	/**
	* @programId :
	* @name : setLoyStmpMbrTgt
	* @date : 2019. 4. 24.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto setLoyStmpMbrTgt(LoyStmpMbrTgtInsertReqDto param) {
    	LogUtil.param(this.getClass(), param);
    	
    	StatusResDto rtnValue = new StatusResDto();
    	if(loyStampMapper.checkExistLoyStmpMbrTgt(param) > 0) {
    		rtnValue.setMessage("1"); //이미 등록된 회원입니다.
    		return rtnValue;
    	}
    	
    	loyStampMapper.setLoyStmpMbrTgt(param);
    	rtnValue.setSuccess(true);
    	
    	return rtnValue;
	}

	/**
	* @programId :
	* @name : removeLoyStmpMbrTgt2
	* @date : 2019. 4. 24.
	* @author : hy.jun
	* @table :
	* @return : 
	* @description :
	*/
	public StatusResDto removeLoyStmpMbrTgt2(LoyStmpMbrTgtDeleteReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto();
		loyStampMapper.removeLoyStmpMbrTgt2(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}
	
	/**
	* @programId :
	* @name : removeLoyStmpItemCamNo
	* @date : 2019. 4. 24.
	* @author : hy.jun
	* @table :
	* @return : StatusResDto
	* @description :
	*/
	public StatusResDto removeLoyStmpItemCamNo(LoyStmpItemDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		
		loyStampMapper.removeLoyStmpItemCamNo(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: setLoyStmpStoreBulks
	  * 2. 클래스명: LoyStampService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto setLoyStmpStoreBulks(LoyStmpStoreUpldReqDto param) {
    	
		StatusResDto rtnValue = new StatusResDto(false, "");
    	
	    String filePath = CommonUtil.getInstance().getServletProp("icignal.context.resource.fileUpload-sqlloader-external").replaceAll("/", Matcher.quoteReplacement(File.separator));
	    filePath = filePath.replaceAll("해당업무", "loyStamp");
        String fileName = param.getRidStmp() + "_" + DateUtil.getToday("yyyyMMddhh24mmss");
        fileName = filePath + fileName;
        
        //파일 디렉토리 존재여부 체크
        if(!new File(filePath).isDirectory()) {
	    	new File(filePath).mkdirs();
	    }
        
        //기존 등록 건수 조회
	    Integer storeCntLegacy = getLoyStmpStoreCnt(param.getRidStmp());
    	
	    try {
	    	String sysdate = DateUtil.getCurrentDate();
	    	
		    StringBuilder sb = new StringBuilder();
		    for(String chnlNo : param.getChnlNoList()) {
	            sb.append(UUID.randomUUID().toString().replace("-",""));
	            sb.append("|").append(param.getCreateBy());
	            sb.append("|").append(param.getModifyBy());
	            sb.append("|").append(sysdate);
	            sb.append("|").append(sysdate);
	            sb.append("|").append("1");
	            sb.append("|").append(param.getRidStmp());
	            sb.append("|").append(chnlNo);
	            sb.append("|").append(sysdate);
	            sb.append("|\r\n");
		    }
		    
		    this.createFile(sb.toString(), fileName + ".dat");
		    
			StringBuilder ctlSb = new StringBuilder();
			
	    	ctlSb.append("load data ")
	    	.append(" CHARACTERSET UTF8 ")
	    	.append(" infile '" + fileName + ".dat' " + "\"str '|\\r\\n'\"")
	    	.append(" badfile '" + fileName + ".bad'")
	    	.append(" append")
	    	.append(" into table loy.loy_stmp_store")
	    	.append(" fields terminated by '|'")
	    	.append(" (")
	    	.append(" RID, ")
	    	.append(" CREATE_BY, ")
	    	.append(" MODIFY_BY, ")
	    	.append(" CREATE_DATE DATE 'YYYY-MM-DD HH24:MI:SS', ")
	    	.append(" MODIFY_DATE DATE 'YYYY-MM-DD HH24:MI:SS', ")
	    	.append(" FLAG, ")
	    	.append(" RID_STMP, ")
	    	.append(" RID_CHNL \"(select RID from loy.LOY_CHANNEL where CHNL_NO = :RID_CHNL and CHNL_STAT_CD = 'A' and flag = 1)\", ")
	    	.append(" REG_DT DATE 'YYYY-MM-DD HH24:MI:SS'")
	    	.append(")");
	    	
	    	this.createFile(ctlSb.toString(), fileName+".ctl");
	    	
	    	//callSqlLdr(fileName);
	    	
	    } catch(Exception e) {
	    	LogUtil.error(e);
		} /*
			 * finally { removeFile(fileName + ".dat"); removeFile(fileName + ".ctl"); }
			 */
	    
	    //업로드 후 등록 건수 조회
	    Integer storeCnt = getLoyStmpStoreCnt(param.getRidStmp());

	    //업로드 결과 세팅
	    if(storeCnt == param.getChnlNoList().size() + storeCntLegacy) {
	    	//업로드 성공 시 sql loader 관련 데이터 삭제
	    	removeFile(fileName + ".log");
	    	removeFile(fileName + ".dat");
	    	removeFile(fileName + ".ctl");
	    	
	    	rtnValue.setSuccess(true);
	    }
	    
	    return rtnValue;
    }
	
	 /*
	  * 1. 메소드명: getLoyStmpStoreCnt
	  * 2. 클래스명: LoyStampService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public Integer getLoyStmpStoreCnt(String param) {
		LogUtil.param(this.getClass(), param);
		return loyStampMapper.getLoyStmpStoreCnt(param);
	}	
	
	 /*
	  * 1. 메소드명: createFile
	  * 2. 클래스명: LoyStampService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param sqlStr
	 *   @param fileName
	 *   @return
	 *   @throws IOException	
	 */
	public String createFile(String sqlStr, String fileName) throws IOException {
        File dataFile = new File(fileName);
        PrintWriter pw = null;
        FileOutputStream fos = null;
        try {
            dataFile.createNewFile();
            fos = new FileOutputStream(dataFile);

            pw = new PrintWriter(new OutputStreamWriter(fos, "utf-8"), true);
            pw.write(sqlStr);
            pw.flush();

            fos.close();
        }
        finally {
            if (pw != null) pw.close();
            if (fos != null) try {
                fos.close();
            }
            catch (IOException e) {

            }
        }

        LogUtil.debug("[CREATE IMPORT FILE] " + fileName);
        return fileName;
    }
	
	 /*
	  * 1. 메소드명: callSqlLdr
	  * 2. 클래스명: LoyStampService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param fileName	
	 */
//	private void callSqlLdr(String fileName) {
//		LogUtil.debug("[LOYStampDAO - callSqlLdr] Start");
//		try {
//			HashMap<String, String> dbInfo = AWSSecretsManagerConfig.getDefaultDBInfo();
//			String userid = dbInfo.get("username");
//			String password = dbInfo.get("password");
//			String sid = CommonUtil.getInstance().getServletProp("jdbc.sid");
//			
//			String sqlldr = "sqlldr "+ userid +"/\""+ password +"\"@"+ sid +" control='"+ fileName +".ctl' log='" + fileName +".log'";
//			
//			Process p = Runtime.getRuntime().exec(sqlldr);
//			BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
//			String line = null;
//			while ((line = br.readLine()) != null) {
//				LogUtil.debug(line);
//			}
//			p.waitFor();
//		} catch (Exception e) {
//			LogUtil.error(e.toString());
//		}
//	}
	
	 /*
	  * 1. 메소드명: removeFile
	  * 2. 클래스명: LoyStampService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param fileName	
	 */
	public void removeFile(String fileName) {
        File dataFile = new File(fileName);
		if (dataFile.exists()) {
		    dataFile.delete();
		}
    }
	

	 /*
	  * 1. 메소드명: setLoyStmpMbrTgtBulk
	  * 2. 클래스명: LoyStampService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto setLoyStmpMbrTgtBulks(LoyStmpMbrTgtUpldReqDto param) {
    	
		StatusResDto rtnValue = new StatusResDto(false, "");
    	
	    String filePath = CommonUtil.getInstance().getServletProp("icignal.context.resource.fileUpload-sqlloader-external").replaceAll("/", Matcher.quoteReplacement(File.separator));
	    filePath = filePath.replaceAll("해당업무", "loyStamp");
        String fileName = param.getRidStmp() + "_" + DateUtil.getToday("yyyyMMddhh24mmss");
        fileName = filePath + fileName;
        
        //파일 디렉토리 존재여부 체크
        if(!new File(filePath).isDirectory()) {
	    	new File(filePath).mkdirs();
	    }
        
        //기존 등록 건수 조회
	    int storeCntLegacy = getLoyStmpMbrTgtCnt(param.getRidStmp());
    	
	    try {
	    	String sysdate = DateUtil.getCurrentDate();
	    	
		    StringBuilder sb = new StringBuilder();
		    for(String mbrNo : param.getMbrNoList()) {
	            sb.append(UUID.randomUUID().toString().replace("-",""));
	            sb.append("|").append(param.getCreateBy());
	            sb.append("|").append(param.getModifyBy());
	            sb.append("|").append(sysdate);
	            sb.append("|").append(sysdate);
	            sb.append("|").append(param.getRidStmp());
	            sb.append("|").append(mbrNo);
	            sb.append("|").append("1");
	            sb.append("|\r\n");
		    }
		    
		    this.createFile(sb.toString(), fileName + ".dat");
		    
			StringBuilder ctlSb = new StringBuilder();
			
	    	ctlSb.append("load data ")
	    	.append(" CHARACTERSET UTF8 ")
	    	.append(" infile '" + fileName + ".dat' " + "\"str '|\\r\\n'\"")
	    	.append(" badfile '" + fileName + ".bad'")
	    	.append(" append")
	    	.append(" into table loy.loy_stmp_mbr_tgt")
	    	.append(" fields terminated by '|'")
	    	.append(" (")
	    	.append(" RID, ")
	    	.append(" CREATE_BY, ")
	    	.append(" MODIFY_BY, ")
	    	.append(" CREATE_DATE DATE 'YYYY-MM-DD HH24:MI:SS', ")
	    	.append(" MODIFY_DATE DATE 'YYYY-MM-DD HH24:MI:SS', ")
	    	.append(" RID_STMP, ")
	    	.append(" MBR_NO, ")
	    	.append(" FLAG ")
	    	.append(")");
	    	
	    	this.createFile(ctlSb.toString(), fileName+".ctl");
	    	
	    	//callSqlLdr(fileName);
	    	
	    } catch(Exception e) {
	    	LogUtil.error(e);
		} /*
			 * finally { removeFile(fileName + ".dat"); removeFile(fileName + ".ctl"); }
			 */
	    
	    //업로드 후 등록 건수 조회
	    int storeCnt = getLoyStmpMbrTgtCnt(param.getRidStmp());

	    //업로드 결과 세팅
	    if(storeCnt == param.getMbrNoList().size() + storeCntLegacy) {
	    	//업로드 성공 시 sql loader 관련 데이터 삭제
	    	removeFile(fileName + ".log");
	    	removeFile(fileName + ".dat");
	    	removeFile(fileName + ".ctl");
	    	
	    	rtnValue.setSuccess(true);
	    }
	    
	    return rtnValue;
	}	
	
	public int getLoyStmpMbrTgtCnt(String param) {
		LogUtil.param(this.getClass(), param);
		return loyStampMapper.getLoyStmpMbrTgtCnt(param);
	}
}
