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
package com.icignal.loyalty.coupon.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.base.service.CommonService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.coupon.dto.request.LoyCouponDetailReqDto;
import com.icignal.loyalty.coupon.dto.request.LoyCouponListReqDto;
import com.icignal.loyalty.coupon.dto.response.LOYCpnPayUploadResDto;
import com.icignal.loyalty.coupon.dto.response.LoyCouponListResDto;
import com.icignal.loyalty.coupon.dto.response.LoyCpnOfferResDto;
import com.icignal.loyalty.coupon.mapper.LoyCouponMapper;
import com.icignal.loyalty.membership.dto.response.LoyMbrCCardResDto;
import com.icignal.loyalty.stamp.dto.request.LoyStampListReqDto;
import com.icignal.loyalty.stamp.dto.response.LoyStampListResDto;
import com.icignal.systemmanagement.batchrgst.util.ExcelRead;
import com.icignal.systemmanagement.batchrgst.util.ExcelReadOption;



/*
 * 1. 클래스명	: LoyCouponService
 * 2. 파일명	: LoyCouponService.java
 * 3. 패키지명	: com.icignal.loyalty.coupon.service
 * 4. 작성자명	: jk.kim
 * 5. 작성일자	: 2020. 7. 9.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */
@Service
public class LoyCouponService {

	@Autowired
	LoyCouponMapper loyCouponMapper;

	@Autowired
	CommonService commonService;

	@Autowired
	AddBatchService addBatchService;

	//스탬프 아이템 구매횟수 초기값
	//private static final int STMP_ITEM_PUR_CNT_INIT_VALUE = 1;


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
	    		 loyCouponMapper.selectStampTxntListCount(reqDto));

	    Integer cnt = rtnCnt.getRows().size();

	    GridPagingResDto<LoyStampListResDto> rtnList = new GridPagingResDto<LoyStampListResDto>();

	    if(cnt>0){
	    	rtnList = new GridPagingResHelper<LoyStampListResDto>().newGridPagingResDto(
		    		 reqDto.init(CommonUtil.getInstance().getDBType()),
		    		 loyCouponMapper.selectStampTxntList(reqDto),AnnotationType.CommCode);
	    	rtnList.setRecords(cnt);
	    	rtnList.setTotal(cnt);
	    }else{
	    	rtnList.setTotal(0);
	    	rtnList.setRecords(0);
	    }
	    return rtnList;
    }

    //쿠폰 업로드
    public LOYCpnPayUploadResDto parymentCpnMultiUpload(MultipartHttpServletRequest request, MultipartFile file ) throws Exception {
		LOYCpnPayUploadResDto rtnValue = new LOYCpnPayUploadResDto();

		MultipartHttpServletRequest multiRequest = request;
		try {
			multiRequest.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e.getMessage());
		}

		// excelFile Path
		String rid = CommonUtil.newRid();
		String orgName = file.getOriginalFilename();
		String exc = FilenameUtils.getExtension(file.getOriginalFilename());
		String filePath =  BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadFullPath").replaceAll("/", Matcher.quoteReplacement(File.separator)) + "coupon" + File.separator;
		String fileFullPath = filePath + rid + "." + exc;

		// excelFile validCheck
		LOYCpnPayUploadResDto valid = paymentCpnUploadValidation(file,exc);
		if(!valid.isValid()){
			return valid;
		}

		//RID 파일명
		File mkdirFile = new File(filePath);

		if(!mkdirFile.isDirectory()){
			mkdirFile.mkdirs();
		}

		File saveFileOrg = new File(fileFullPath);

		//해당경로 폴더에 파일등록
		try {
			file.transferTo(saveFileOrg);
		} catch (IOException e) {
			LogUtil.error(e.getMessage());
		}

		//excel read Option
		ExcelReadOption ro = new ExcelReadOption();
		ro.setOutputColumns("A","B","C");
		ro.setStartRow(2);
		ro.setFilePath(fileFullPath);

		rtnValue.setFileName(orgName);
		rtnValue.setFilePath(fileFullPath);
		rtnValue.setArray(ExcelRead.parymentCpnUpldRead(ro));

		return rtnValue;
    }

    //validation
    public LOYCpnPayUploadResDto paymentCpnUploadValidation(MultipartFile file,String exc){
		LOYCpnPayUploadResDto rtnValue = new LOYCpnPayUploadResDto();

    	if(!exc.equals("xlsx") && !exc.equals("xls")){
			rtnValue.setValid(false);
			rtnValue.setUploadValidCheck("EXT");
			return rtnValue;
		}else if(file.getSize() > 12000000){
			rtnValue.setValid(false);
			rtnValue.setUploadValidCheck("SIZE");
    		return rtnValue;
		}else{
			rtnValue.setValid(true);
		}

		return rtnValue;
	}

	//쿠폰 업로드 DB INSERT
	@Transactional
	public StatusResDto insertPaymentCoupon(LOYCpnPayUploadResDto resDto) {
    	LogUtil.param(this.getClass(),resDto);
    	StatusResDto rtnValue = new StatusResDto();
    	rtnValue.setSuccess(false);

    	//쿠폰헤더 RID
		resDto.setHeaderRid(CommonUtil.newRid());
    	//쿠폰헤더 INSERT 파일경로
		loyCouponMapper.insertPaymentCouponHeader(resDto);

		//쿠폰 ITEM INSERT addBatch
		StringBuffer sql = new StringBuffer();
		sql.append(" INSERT INTO LOY.LOY_CPN_REQ_MANY")
		   .append(" ( ")
		   .append(" RID ,")
		   .append(" CREATE_BY ,")
		   .append(" MODIFY_BY, ")
		   .append(" CREATE_DATE ,")
		   .append(" MODIFY_DATE ,")
		   .append(" FLAG ,")
		   .append(" RID_MBR ,")
		   .append(" RID_OFR ,")
		   .append(" QTY ,")
		   .append(" REQ_DATE ,")
		   .append(" REQ_COMP_YN ,")
		   .append(" RID_HEADER")
		   .append(" ) values (")
		   .append(" com.getNewId('') ,")
		   .append(" ? ,")
		   .append(" ? ,")
		   .append(" sysdate ,")
		   .append(" sysdate ,")
		   .append(" 1 ,")
		   .append(" (select rid from loy.loy_mbr where mbr_no = ? and rownum = 1) ,")
		   .append(" (select rid from loy.loy_ofr where ofr_no = ?  and rownum = 1) ,")
		   .append(" ? ,")
		   .append(" sysdate ,")
		   .append(" 'N' ,")
		   .append(" ? ")
		   .append(" ) ");

		List<Map<Integer,Object>> params = new ArrayList<>();

		for(LOYCpnPayUploadResDto cpur : resDto.getArray()){
			int idx = 1;
			Map<Integer,Object> reqDto = new HashMap<>();

			reqDto.put(idx ++ ,resDto.getCreateBy());
			reqDto.put(idx ++ ,resDto.getModifyBy());
			reqDto.put(idx ++ ,cpur.getMbrNo());
			reqDto.put(idx ++ ,cpur.getOfferNo());
			reqDto.put(idx ++ ,cpur.getQty());
			reqDto.put(idx ,resDto.getHeaderRid());

			params.add(reqDto);
		}

		addBatchService.addBatch(sql.toString(),params);

		rtnValue.setSuccess(true);
		rtnValue.setMessage("업로드 완료");
		return rtnValue;
	}

	public  GridPagingResDto<LoyCouponListResDto> getCouponUploadList(LoyCouponListReqDto reqDto) throws Exception {
		LogUtil.param(this.getClass(), reqDto);

		return new GridPagingResHelper<LoyCouponListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyCouponMapper.selectCouponUploadList(reqDto), AnnotationType.ALL
				);
	}

	public StatusResDto saveMbrCoupon(LoyCouponDetailReqDto param) throws ParseException{
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		if("N".equals(param.getSaveNewCoupon())){
			/*쿠폰 재발급*/
			Date valisdStdate = transFormat.parse(param.getValidStartDay());
			param.setValidStDate(valisdStdate);
			param.setCpnAmt(1);
		}
		
		Date issueDate = transFormat.parse(param.getIssueDt());
		param.setIssueDate(issueDate);
						
		rtnValue.setSuccess(false);

		loyCouponMapper.callSaveMbrCoupon(param);

		
		if ("S".equals(param.getRst())) {
			rtnValue.setSuccess(true);
		}else{
			rtnValue.setMessage(param.getRstMsg());
		}
		return rtnValue;
	}

	public StatusResDto useMbrCoupon(LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCouponMapper.callUseMbrCoupon(param);

		if ("S".equals(param.getRst())) {
			rtnValue.setSuccess(true);
		}else{
			rtnValue.setMessage(param.getRstMsg());
		}
		return rtnValue;
	}

	public StatusResDto saveCnclMbrCoupon(LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCouponMapper.callSaveCnclMbrCoupon(param);

		if ("S".equals(param.getRst())) {
			rtnValue.setSuccess(true);
		}else{
			rtnValue.setMessage(param.getRstMsg());
		}
		return rtnValue;
	}

	public StatusResDto useCnclMbrCoupon(LoyCouponDetailReqDto param){
		LogUtil.param(this.getClass(), param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCouponMapper.callUseCnclMbrCoupon(param);

		if ("S".equals(param.getRst())) {
			rtnValue.setSuccess(true);
		}else{
			rtnValue.setMessage(param.getRstMsg());
		}
		return rtnValue;
	}

	public LoyCpnOfferResDto getCpnOffer(LoyCouponDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		LoyCpnOfferResDto rtnValue = new LoyCpnOfferResDto();
		rtnValue.setSuccess(false);
		rtnValue = loyCouponMapper.selectCpnOffer(param);
		rtnValue.setSuccess(true);
		
		return rtnValue;
	}

	public LoyCpnOfferResDto getCpnChnl(LoyCouponDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		LoyCpnOfferResDto rtnValue = new LoyCpnOfferResDto();
		rtnValue.setSuccess(false);
		rtnValue = loyCouponMapper.selectCpnChnl(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}



}
