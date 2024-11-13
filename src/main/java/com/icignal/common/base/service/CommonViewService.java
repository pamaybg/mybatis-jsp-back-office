package com.icignal.common.base.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.common.apiservice.dto.response.WebServiceSearchZipCodeResDto;
import com.icignal.common.apiservice.dto.response.WebServiceZipCodeListResDto;
import com.icignal.common.apiservice.service.ApiService;
import com.icignal.common.base.dto.request.ComCondLogInsertReqDto;
import com.icignal.common.base.dto.request.CommonCodeReqDto;
import com.icignal.common.base.dto.request.ExportExcelReqDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.LoyChnlListResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.mapper.CommonViewMapper;
import com.icignal.common.filter.HTMLTagFilterRequestWrapper;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.DateUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.annotation.handler.PersonalDataHandler;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransListResDto;
import com.icignal.loyalty.benefit.point.dto.response.LoyTransactionNoResDto;
import com.icignal.loyalty.campaign.dto.request.LoyCamMstListReqDto;
import com.icignal.loyalty.channel.dto.response.LoyCamMstListResDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.common.dto.request.LoyExcelExportReqDto;
import com.icignal.loyalty.common.dto.request.LoyWebServiceSearchZipCodeReqDto;
import com.icignal.loyalty.common.dto.response.LOYChnlTransReqDto;
import com.icignal.loyalty.common.dto.response.LoyMbrMstListResDto;
import com.icignal.loyalty.common.dto.response.LoyPointDtlListResDto;
import com.icignal.loyalty.common.dto.response.LoyPurItemListResDto;
import com.icignal.loyalty.common.dto.response.LoyPurPayListResDto;
import com.icignal.loyalty.common.dto.response.LoyTierGrpListResDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrChnlHistListReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrItemReqDto;
import com.icignal.loyalty.membership.dto.request.LoyMbrProcReqDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrItemResDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrProcResDto;
import com.icignal.loyalty.product.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyPgmListResDto;
import com.icignal.loyalty.product.dto.response.LoyProdListResDto;
import com.icignal.loyalty.tiers.tiermaster.dto.request.LoyTierNewPageReqDto;
import com.icignal.loyalty.tiers.tiermaster.dto.response.LoyTierListNewPageResDto;
import com.icignal.systemmanagement.auth.dto.request.SystemAuthGroupEmployeeModalReqDto;
import com.icignal.systemmanagement.auth.dto.response.SystemAuthGroupEmployeeModalResDto;
import com.icignal.systemmanagement.commcode.dto.request.CommonSelectBoxListReqDto;
import com.icignal.systemmanagement.commcode.dto.request.ICNCommonCodeRequestDTO;
import com.icignal.systemmanagement.commcode.dto.response.CommonSelectBoxListResDto;
import com.icignal.systemmanagement.commcode.dto.response.ICNCommonCodeResponseDTO;
import com.icignal.systemmanagement.systemmgt.dto.request.SystemMgtListReqDto;
import com.icignal.systemmanagement.systemmgt.dto.response.SystemMgtListResDto;


@Service
public class CommonViewService {
	
	@Autowired
	private CommonViewMapper commonViewMapper;
	
	@Autowired
	private LoggingHelper loggingHelper;
	
	//@Autowired
	//private ThunderMailService thunderMailService;
	
	@Autowired
	private CommonService baseSevice;
	
	@Autowired
	private ApiService apiService;

	
	private static final String url = "";
    //private String zipUrl = "";

	 /*
	  * 1. 메소드명: getTierGrpList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyTierGrpListResDto> getTierGrpList(LoyCommonReqDto slr) {
		 LogUtil.param(this.getClass(), slr);
		 slr.setSVCAlias("a");
	     return new GridPagingResHelper<LoyTierGrpListResDto>().newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectTierGrpList(slr));
	}

	 /*
	  * 1. 메소드명: getChnlList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlListResDto> getChnlList(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("a");
		
		return new GridPagingResHelper<LoyChnlListResDto>().newGridPagingResDto(
				slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectChnlList(slr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getCamMstListPop
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyCamMstListResDto> getCamMstListPop(LoyCamMstListReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("mcm");
		return new GridPagingResHelper<LoyCamMstListResDto>().newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectCamMstList(slr));
	}

	 /*
	  * 1. 메소드명: getCategoryList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyCategoryListResDto> getCategoryList(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("lpc1");
		return new GridPagingResHelper<LoyCategoryListResDto>().newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectCategoryList(slr));
	}

	 /*
	  * 1. 메소드명: getProdListPop
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyProdListResDto> getProdListPop(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("lp");
		return new GridPagingResHelper<LoyProdListResDto>().newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectProdList(slr));
	}

	 /*
	  * 1. 메소드명: getPgmList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPgmListResDto> getPgmList(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("a");
		return new GridPagingResHelper<LoyPgmListResDto> ().newGridPagingResDto(
				slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectPgmList(slr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getMbrMstPop
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyMbrMstListResDto> getMbrMstPop(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("lm");
		return new GridPagingResHelper<LoyMbrMstListResDto>()
				.newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectMbrMstList(slr), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: getPointDtlListPop
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPointDtlListResDto> getPointDtlListPop(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("a");
		return new GridPagingResHelper<LoyPointDtlListResDto>().newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectPointDtlList(slr));
	}

	 /*
	  * 1. 메소드명: getPurItemList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPurItemListResDto> getPurItemList(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("t1");
        
        return new GridPagingResHelper<LoyPurItemListResDto>().newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectPurItemList(slr));
	}

	 /*
	  * 1. 메소드명: getPurPayList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyPurPayListResDto> getPurPayList(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("t1");
        
        return  new GridPagingResHelper<LoyPurPayListResDto>()
        		.newGridPagingResDto(slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectPurPayList(slr), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: clearMaskPurPayDtl
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public LoyPurPayListResDto clearMaskPurPayDtl(LoyCommonReqDto reqDto) {
		 LogUtil.param(this.getClass(), reqDto);
	     loggingHelper.insertCustReleaLog(reqDto, "loy_mbr_pur_pay");  //이력 저장
	     reqDto.setSVCAlias("t1");
	     LoyPurPayListResDto res = commonViewMapper.clearMaskPurPayDtl(reqDto);
	     //데상트용 마스킹 처리
	     //return  (LoyPurPayListResDto) new PersonalDataDecodeHandler<T>(res).getItem();
	     return  (LoyPurPayListResDto) new PersonalDataHandler<T>(res).getItem();
		 
	}

	 /*
	  * 1. 메소드명: excelExport
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	@SuppressWarnings("rawtypes")
	public StatusResDto excelExport(LoyExcelExportReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		ExportExcelReqDto exportData = new ExportExcelReqDto();
		String  col ;
		String  dataString;
		List<String> colList = new ArrayList<>();
		List<String> colNameList = new ArrayList<>();
		List<List<Object>> dataList = new ArrayList<>();

		//해더 세팅
		for( int i=0; i< reqDto.getHeader().size(); i++ ){

			HashMap header = new HashMap();
			header = (HashMap) reqDto.getHeader().get(i);    // 해더 속성


			if( ( header.get("hidden") == null || !(Boolean)header.get("hidden"))
				&& !header.get("name").equals("radio")){
				col = (String) header.get("name");
				colList.add(col);
				colNameList.add((String) reqDto.getHeaderName().get(i));    // 해더Text
			}

		}

		if(reqDto.getNewData() != null){
			//데이터 세팅
			for( int i=0; i < reqDto.getNewData().size() ; i++ ){


				HashMap data = new HashMap();
				data = (HashMap) reqDto.getNewData().get(i);    // 데이터 Row

				List<Object> dataRow = new ArrayList<>();
				for( int j=0; j< colList.size(); j++ ){
					dataString = (String)data.get(colList.get(j));
					if(dataString==null)dataString="";
					dataRow.add(dataString);
				}
				dataList.add(dataRow);
			}
		}else if(reqDto.getData()!= null){
			//데이터 세팅
			for( int i=0; i < reqDto.getData().size() ; i++ ){


				HashMap data = new HashMap();
				data = (HashMap) reqDto.getData().get(i);    // 데이터 Row

				List<Object> dataRow = new ArrayList();
				for( int j=0; j< colList.size(); j++ ){
					dataString = (String)data.get(colList.get(j));
					if(dataString==null)dataString="";
					dataRow.add(dataString);
				}
				dataList.add(dataRow);
			}
		}



		exportData.setHeaderList(colNameList);
		exportData.setDataList(dataList);
		exportData.setFileName(reqDto.getFileName());


		String realPath = reqDto.getRequest().getSession().getServletContext().getRealPath("/");
		exportData.setRealPath(realPath);

		baseSevice.generateExcel(reqDto.getRequest(), exportData);

		 String fileName = exportData.getFileName() + ".xlsx";
		 fileName = HTMLTagFilterRequestWrapper.decodeXSS(fileName);

		 String strPhyfullpath = "/"+ BeansUtil.getApplicationProperty("icignal.context.resource.tempImageUploadPath")  + fileName;

		 try {
			strPhyfullpath = new String ( strPhyfullpath.getBytes("euc-kr"), "iso-8859-1");
		} catch (UnsupportedEncodingException e) {

			LogUtil.error(e);
		}
		 
		rtnValue.setMessage(strPhyfullpath);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: transChnl
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 2. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	
	public StatusResDto transChnl(LOYChnlTransReqDto reqDto) {
		StatusResDto rtnVal = new StatusResDto();

		if(reqDto.getInsertFlag() == null || reqDto.getInsertFlag().length() == 0){
			LoyMbrChnlHistListReqDto actyDto = new LoyMbrChnlHistListReqDto();

			if(!reqDto.getChnlType().equals("email") && reqDto.getComment().getBytes().length >=80){
				reqDto.setChnlType("lms");
			}

			if(reqDto.getChnlType().equals("email")){
				actyDto.setChnlType("email");
				actyDto.setMsgSubject(reqDto.getEmailTitle());
			}else if(reqDto.getChnlType().equals("sms")||reqDto.getChnlType().equals("lms")){
				actyDto.setChnlType("sms");
			}
			actyDto.setCreateBy(reqDto.getCreateBy());
			actyDto.setModifyBy(reqDto.getModifyBy());

			actyDto.setRidCust(reqDto.getRidCust());
			actyDto.setComments(reqDto.getComment());
			actyDto.setCreatorLogin(reqDto.getCreatorLogin());
			if(reqDto.getChnlType().equals("email")){
				actyDto.setAtvyType("20");
			}else if(reqDto.getChnlType().equals("sms")||reqDto.getChnlType().equals("lms")){
				actyDto.setAtvyType("40");
			}
			actyDto.setAtvySubType("40");
			actyDto.setRidSvcreq(reqDto.getRidVocReq());

			//채널 이력 쌓기		
			actyDto.setRid(CommonUtil.newRid());
			commonViewMapper.insertVocActyHist(actyDto);
			StatusResDto rtnDto = new StatusResDto();
			rtnDto.setSuccess(true);
			rtnDto.setMessage(actyDto.getRid());
		}else if(reqDto.getInsertFlag().equals("1")){
			//상담요청 상세 > 활동이력  > 채널전송 시, 활동이력 중복 삽입 방지
			rtnVal.setSuccess(true);
			rtnVal.setMessage(reqDto.getActyRid());
		}

		if(rtnVal.getSuccess()){
			reqDto.setActionRID(rtnVal.getMessage());

			//채널 전송 I/F      com.icignal.external.thundermail.service.ThunderMailService를 사용하여 api를 이용할 것.
//			if(reqDto.getChnlType().equals("email")){
//				//rtnVal = thunderMailService.sendEmailAutoMail(reqDto);
//			}else if(reqDto.getChnlType().equals("sms") ||reqDto.getChnlType().equals("lms")){
//				//rtnVal = thunderMailService.sendSMS(reqDto);
//			}else if(reqDto.getChnlType().equals("webAnswer")){
//				//rtnVal = thunderMailService.sendEmailAboutWebAnswer(reqDto);
//			}
		}
		return rtnVal;
	}

	 /*
	  * 1. 메소드명: getCommCodeList2
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	public GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeList2(CommonCodeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		bccr.setSVCAlias("");
		return new GridPagingResHelper<ICNCommonCodeResponseDTO>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				commonViewMapper.getCommCodeList2(bccr));
	}
	
	 /*
	  * 1. 메소드명: getCommCodeList1
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	public GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeList1(ICNCommonCodeRequestDTO bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<ICNCommonCodeResponseDTO>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				commonViewMapper.getCommCodeList(bccr));
	}
	
	 /*
	  * 1. 메소드명: getZipCodeList
	  * 2. 클래스명: BaseCommonService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 * @throws ParseException 
	 */
	public GridPagingResDto<WebServiceSearchZipCodeResDto> getZipCodeList(LoyWebServiceSearchZipCodeReqDto reqDto) throws ParseException{
		GridPagingResDto<WebServiceSearchZipCodeResDto> rtnGrid = new GridPagingResDto<WebServiceSearchZipCodeResDto>();
		reqDto.setCurrentPage(Integer.toString(reqDto.getPage()));
		WebServiceSearchZipCodeResDto rtnZipCode =  this.searchZipCode(reqDto);

		if(rtnZipCode.getSuccess().equals("true")){
			rtnGrid.setTotal(Integer.parseInt(rtnZipCode.getCountPerPage()));
			rtnGrid.setRecords(Integer.parseInt(rtnZipCode.getTotalCount()));
			rtnGrid.setPage(Integer.parseInt(rtnZipCode.getCurrentPage()));
			rtnGrid.setSuccess(true);
			rtnGrid.setRows((List)rtnZipCode.getJuso());
		}else{

			rtnGrid.setSuccess(false);
			rtnGrid.setMessage(rtnZipCode.getMessage());
		}



		 return rtnGrid;
	}
	
	
	
	public WebServiceSearchZipCodeResDto searchZipCode(LoyWebServiceSearchZipCodeReqDto param) throws ParseException {
    //    StatusResDto rtnValue = new StatusResDto();
        WebServiceSearchZipCodeResDto resZip = new WebServiceSearchZipCodeResDto();
        HashMap<String, Object> ifReq = new HashMap<>();
        HashMap<String, String> reqObj = new HashMap<>();

        reqObj.put("currentPage", param.getCurrentPage());
        reqObj.put("keyword", param.getKeyword()); // 전문 유형

        ifReq.put("reqObj", reqObj);
        try {

            HashMap<String, Object> rtnMap = apiService.executeHttpRequest("https://dapi.kakao.com/v2/local/search/address.json", ifReq);

            resZip.setSuccess(rtnMap.get("success").toString());
            resZip.setMessage(rtnMap.get("message").toString());

            if (rtnMap.get("success").toString().equals("true")) {
                HashMap<String, Object> rtnResult = (HashMap<String, Object>) rtnMap.get("result");
                HashMap<String, Object> rtnResults = (HashMap<String, Object>) rtnResult.get("results");
                HashMap<String, Object> rtnCommon = (HashMap<String, Object>) rtnResults.get("common");
                ArrayList<HashMap<String, Object>> rtnJusoList = (ArrayList) rtnResults.get("juso");

                resZip.setCurrentPage(rtnCommon.get("currentPage").toString());
                resZip.setErrorCode(rtnCommon.get("errorCode").toString());
                resZip.setTotalCount(rtnCommon.get("totalCount").toString());
                resZip.setCountPerPage(rtnCommon.get("countPerPage").toString());
                resZip.setErrorMessage(rtnCommon.get("errorMessage").toString());
                ArrayList<WebServiceZipCodeListResDto> jusoList = new ArrayList<>();
                for (HashMap<String, Object> rtnJuso : rtnJusoList) {
                    WebServiceZipCodeListResDto juso = new WebServiceZipCodeListResDto();
                    juso.setDetBdNmList(rtnJuso.get("detBdNmList").toString());
                    juso.setEngAddr(rtnJuso.get("engAddr").toString());
                    juso.setRn(rtnJuso.get("rn").toString());
                    juso.setEmdNm(rtnJuso.get("emdNm").toString());
                    juso.setZipNo(rtnJuso.get("zipNo").toString());
                    juso.setRoadAddrPart2(rtnJuso.get("roadAddrPart2").toString());
                    juso.setEmdNo(rtnJuso.get("emdNo").toString());
                    juso.setSggNm(rtnJuso.get("sggNm").toString());
                    juso.setJibunAddr(rtnJuso.get("jibunAddr").toString());
                    juso.setSiNm(rtnJuso.get("siNm").toString());
                    juso.setRoadAddrPart1(rtnJuso.get("roadAddrPart1").toString());
                    juso.setBdNm(rtnJuso.get("bdNm").toString());
                    juso.setAdmCd(rtnJuso.get("admCd").toString());
                    juso.setUdrtYn(rtnJuso.get("udrtYn").toString());
                    juso.setLnbrMnnm(rtnJuso.get("lnbrMnnm").toString());
                    juso.setRoadAddr(rtnJuso.get("roadAddr").toString());
                    juso.setLnbrSlno(rtnJuso.get("lnbrSlno").toString());
                    juso.setBuldMnnm(rtnJuso.get("buldMnnm").toString());
                    juso.setBdKdcd(rtnJuso.get("bdKdcd").toString());
                    juso.setLiNm(rtnJuso.get("liNm").toString());
                    juso.setRnMgtSn(rtnJuso.get("rnMgtSn").toString());
                    juso.setMtYn(rtnJuso.get("mtYn").toString());
                    juso.setBdMgtSn(rtnJuso.get("bdMgtSn").toString());
                    juso.setBuldSlno(rtnJuso.get("buldSlno").toString());
                    jusoList.add(juso);
                }

                resZip.setJuso(jusoList);

            }
        }
        catch (IOException e) {
            LogUtil.error(e);
        }
        return resZip;
    }
	
	 /*
	  * 1. 메소드명: getTransNo
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @return	
	 */
	public LoyTransactionNoResDto getTransNo() {

		HashMap<String, String> mapData = new HashMap<String, String>();
		
		commonViewMapper.getTransNo(mapData);
		LoyTransactionNoResDto rtnVal = new LoyTransactionNoResDto();
    	
    	String tranNo = mapData.get("TranSerialNum");
    	String tranDate = mapData.get("TranDate");
    	String tranTime = mapData.get("TranTime");
    	
    	rtnVal.setTranNo(tranNo);
    	rtnVal.setTranDate(tranDate);
    	rtnVal.setTranTime(tranTime);
    	
    	return rtnVal;

	}
	
	 /*
	  * 1. 메소드명: viewAvlPoint
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 2.
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
	 * @throws ParseException 
	 */
	public LoyMbrItemResDto viewAvlPoint(LoyMbrItemReqDto param) throws ParseException {
   //     StatusResDto rtnValue = new StatusResDto();
        LoyMbrItemResDto resBal = new LoyMbrItemResDto();
        HashMap<String, Object> ifReq = new HashMap();

        HashMap<String, String> reqObj = new HashMap();

        LoyTransactionNoResDto tranRes = this.getTransNo();
        reqObj.put("MsgLen", "113");
        reqObj.put("MsgType", "0100"); // 전문 유형
        reqObj.put("WorkCase", "10"); // 업무 구분
        reqObj.put("TranDate", tranRes.getTranDate());
        reqObj.put("TranTime", tranRes.getTranTime());
        reqObj.put("TranSerialNum", "");//
        reqObj.put("RepCode", "");
        reqObj.put("Filler", "");
        reqObj.put("BusinessNum", "1148116585");
        reqObj.put("AccountCode", "10000");
        reqObj.put("KindCase", "M");
        reqObj.put("CardNum", param.getMbrNo());

        ifReq.put("interfaceId", "NET_2010");

        ifReq.put("reqObj", reqObj);
        try {

            HashMap<String, Object> rtnMap = apiService.executeHttpRequest(url, ifReq);
            if (rtnMap.get("success").toString().equals("true")) {
                List<Object> list = new ArrayList<Object>();

                list = (List<Object>) rtnMap.get("result");
                HashMap<String, Object> resList = (HashMap<String, Object>) list.get(0);
                List<Object> tmplist = (List<Object>) resList.get("res_0");

                HashMap<String, Object> iRtnVal = (HashMap<String, Object>) tmplist.get(0);

                if (rtnMap.get("success").toString().equals("true")) {
                    resBal.setSuccess(true);
                    resBal.setMessage(rtnMap.get("message").toString());
                    resBal.setAvlPoint(iRtnVal.get("E1Point").toString());
                }
                else {
                    resBal.setSuccess(false);
                    resBal.setMessage(rtnMap.get("message").toString());

                }
            }
            else {
                resBal.setSuccess(false);
                resBal.setMessage(rtnMap.get("message").toString());
            }

        }
        catch (IOException e) {
            LogUtil.error(e.getMessage(), e);
        }
        return resBal;
    }
	//신규 로직
	public StatusResDto setComCondLog(ComCondLogInsertReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		StatusResDto rtnValue = new StatusResDto(false, "");
		String srchDt = DateUtil.getToday("yyyy-MM-dd HH:mm:ss");
		rtnValue.setSuccess(false);
		String logNewRid = CommonUtil.newRid();
		param.setRid(logNewRid);
		
		
		ComCondLogInsertReqDto condLog = new ComCondLogInsertReqDto();
		condLog.setCreateBy(param.getCreateBy());
		condLog.setSrchDt(srchDt);
		condLog.setPageRid(param.getPageRid());
		condLog.setSrchCondRid(param.getItemRid()); //custRid
		condLog.setRsltCnt(param.getRsltCnt());
		Integer cnt = commonViewMapper.insertComCondLog(condLog);
		if(cnt > 0) {
			rtnValue.setSuccess(true);
		}
	
		return rtnValue;
	}
	// 기존 로직
//	public StatusResDto setComCondLog(ComCondLogInsertReqDto param) {
//		LogUtil.param(this.getClass(), param);
//		
//		StatusResDto rtnValue = new StatusResDto(false, "");
//		String srchDt = DateUtil.getToday("yyyy-MM-dd HH:mm:ss");
//		
//		String logNewRid = CommonUtil.newRid();
//		param.setRid(logNewRid);
//		
//		//조회조건 갯수만큼 조회이력 등록
//		for(CommonCodeItemReqDto comCond : param.getItem()) {
//			ComCondLogInsertReqDto condLog = new ComCondLogInsertReqDto();
//			condLog.setCreateBy(param.getCreateBy());
//			condLog.setSrchDt(srchDt);
//			condLog.setPageRid(param.getPageRid());
//			condLog.setSrchCondRid(comCond.getRid());
//			condLog.setRsltCnt(param.getRsltCnt());
////			condLog.setRsltContent(comCond.getCondName() +" : "+ comCond.getSrcCol() +", 조회조건 : "+ comCond.getWhereVal());
//			
//			Integer cnt = commonViewMapper.insertComCondLog(condLog);
//			if(cnt > 0) {
//				rtnValue.setSuccess(true);
//			}
//			
//		}
//		return rtnValue;
//	}
	
	 /*
	  * 1. 메소드명: bizNumCheck
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 3. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bizNum
	 *   @return	
	 */
	public StatusResDto bizNumCheck(String bizNum) {


		StatusResDto rtnValue = new StatusResDto();



	   String sChkNum = "";
       int sTotal = 0;
       int sNineth = 0;
       int sIndex = 1;

	    // 입력된Input 사업등록번호 받아오기
	    String sOriNum = bizNum;
	    String strDig ="";
	  
    	 // 사업자등록번호를 입력하지 않은 경우 Exit.
        if(StringUtils.isBlank(bizNum))  {
        	rtnValue.setSuccess(false);
        	rtnValue.setMessage("사업자등록번호 값이 없습니다.");
            return rtnValue;
        }
	    
	    
	        // 숫자만 거르기	 
	    	for (int i=0; i<sOriNum.length() ; i++)
	    	{
	    		strDig = sOriNum.substring(i,i+1);
	    		// 각각의 문자의 ASCII코드를 반환
	    		char inputValue = strDig.charAt(0);	// ASCII 값을 비교하기 위해 저장

	    		if (inputValue>47 && inputValue<58)	// 숫자값일때
	    		{
	    			sChkNum =sChkNum + strDig;
	    		}
	    	}
	    

	    if ( sChkNum.length() != 10 ) //사업자 등록번호 자리수가 틀린경우
	    {
	         rtnValue.setSuccess(false);
	         rtnValue.setMessage("사업자등록번호는 10자리입니다.");
	         return rtnValue;

	    }

	    int sMlt[] = new int[10]; //배수 할당을 위한 Array
	    sMlt[1] = 1;
	    sMlt[2] = 3;
	    sMlt[3] = 7;
	    sMlt[4] = 1;
	    sMlt[5] = 3;
	    sMlt[6] = 7;
	    sMlt[7] = 1;
	    sMlt[8] = 3;
	    sMlt[9] = 5;

	    for (sIndex=1; sIndex<=8; sIndex++)
	    {
	          sTotal = sTotal + (Integer.parseInt(sChkNum.substring(sIndex-1,sIndex))*(sMlt[sIndex]));
	    }

	    sNineth =  Integer.parseInt(sChkNum.substring(8,9))*(sMlt[9]);

	    if( sNineth < 10) //사업자등록번호9번째 자리수가 10보다 작은경우
	    {
	          sTotal = sTotal + sNineth;
	    }
	    else
	    {

             sTotal = sTotal + Integer.parseInt(Integer.toString(sNineth).substring(0,1))
                			 + Integer.parseInt(Integer.toString(sNineth).substring(1,2));
	    }

	    sTotal = sTotal + Integer.parseInt(sChkNum.substring(9,10));

	    sMlt = null;

	    int sMod = sTotal%10;
	    if(sMod ==0) // 나머지가 0인경우.
	    {
	     //하이픈 붙인 사업자등록번호 반환
	     String sValidBizNum = sChkNum.substring(0,1)
	         + sChkNum.substring(1,2)
	         + sChkNum.substring(2,3)
	         //+ "-"
	         + sChkNum.substring(3,4)
	         + sChkNum.substring(4,5)
	         //+ "-"
	         + sChkNum.substring(5,6)
	         + sChkNum.substring(6,7)
	         + sChkNum.substring(7,8)
	         + sChkNum.substring(8,9)
	         + sChkNum.substring(9,10);
	     rtnValue.setSuccess(true);
 		 rtnValue.setMessage(sValidBizNum);
         return rtnValue;

	    }
	    else
	    {
		     rtnValue.setSuccess(false);
	         rtnValue.setMessage("잘못된 사업자등록번호입니다");
	         return rtnValue;

	    }

	}
	
	/**
     * @programId :
     * @name : rereqCertiCode
     * @date : 2017. 12. 18.
     * @author : 임소원
     * @table :
     * @return : LOYMbrProcResponseDTO
	 * @throws ParseException 
     * @description : 휴대폰 인증번호 재전송
     */
	public LoyMbrProcResDto rereqCertiCode(LoyMbrProcReqDto param) throws ParseException {
        LoyMbrProcResDto resBal = new LoyMbrProcResDto();
        HashMap<String, Object> ifReq = new HashMap<>();

        HashMap<String, String> reqObj = new HashMap<>();

        reqObj.put("Id", "EUG005");
        reqObj.put("MsgType", "0200"); // 전문 유형
        reqObj.put("WorkCase", "311"); // 업무 구분
        reqObj.put("RepCode", "");
        reqObj.put("Seq", "");
        reqObj.put("BirthDay", param.getBirthDay());
        reqObj.put("Sex", param.getSex());
        reqObj.put("ForeignFlg", param.getForeignFlg());
        reqObj.put("ServiceNo", param.getServiceNo());
        reqObj.put("TranSerialNum", param.getTranSerialNum());//
        reqObj.put("Name", param.getName());
        reqObj.put("TelecomCode", param.getTelecomCode());
        reqObj.put("Mobile", param.getMobile());
        reqObj.put("MobileCertiSeq", param.getMobileCertiSeq());
        reqObj.put("CertiSeq", param.getCertiSeq());

        ifReq.put("interfaceId", "NET_1014");

        ifReq.put("reqObj", reqObj);
        try {

            HashMap<String, Object> rtnMap = apiService.executeHttpRequest(url, ifReq);
            if (rtnMap.get("success").toString().equals("true")) {
                List<Object> list = new ArrayList<Object>();

                list = (List<Object>) rtnMap.get("result");
                HashMap<String, Object> resList = (HashMap<String, Object>) list.get(0);
                List<Object> tmplist = (List<Object>) resList.get("res_0");

                HashMap<String, Object> iRtnVal = (HashMap<String, Object>) tmplist.get(0);
                /*
                 * HashMap<String, Object> iRtnVal = (HashMap<String, Object>)rtnMap.get("result");
                 */
                String mobileCertiCode = iRtnVal.get("MobileCertiCode").toString();
                if (iRtnVal.get("ResultFlg").toString().equals("Y") && mobileCertiCode.equals("NME0000")) {
                    resBal.setSuccess(true);
                    resBal.setRtnVal(iRtnVal);
                }
                else {
                    resBal.setSuccess(false);
                    if (mobileCertiCode.equals("NME0011")) {
                        resBal.setMessage(Messages.getMessage("L01936", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0012")) {
                        resBal.setMessage(Messages.getMessage("L01937", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0013")) {
                        resBal.setMessage(Messages.getMessage("L01938", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0015")) {
                        resBal.setMessage(Messages.getMessage("L01939", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0017")) {
                        resBal.setMessage(Messages.getMessage("L01940", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0024")) {
                        resBal.setMessage(Messages.getMessage("L01941", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0031")) {
                        resBal.setMessage(Messages.getMessage("L01942", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0035")) {
                        resBal.setMessage(Messages.getMessage("L01943", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0040")) {
                        resBal.setMessage(Messages.getMessage("L01944", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0070")) {
                        resBal.setMessage(Messages.getMessage("L01945", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0071")) {
                        resBal.setMessage(Messages.getMessage("L01946", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0072")) {
                        resBal.setMessage(Messages.getMessage("L01947", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0073")) {
                        resBal.setMessage(Messages.getMessage("L01948", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0096")) {
                        resBal.setMessage(Messages.getMessage("L01949", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0097")) {
                        resBal.setMessage(Messages.getMessage("L01950", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0098")) {
                        resBal.setMessage(Messages.getMessage("L01951", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0099")) {
                        resBal.setMessage(Messages.getMessage("L01952", param.getLang()));
                    }
                    else {
                        resBal.setMessage(rtnMap.get("message").toString());
                    }
                }
            }
            else {
                resBal.setSuccess(false);
                resBal.setMessage(rtnMap.get("message").toString());
            }
        }
        catch (IOException e) {
            LogUtil.error(e.getMessage(), e);
        }
        return resBal;
    }
	
	/**
     * @programId :
     * @name : checkCertiCode
     * @date : 2017. 12. 18.
     * @author : 임소원
     * @table :
     * @return : LOYMbrProcResponseDTO
	 * @throws ParseException 
     * @description : 휴대폰 인증번호 확인
     */
    public LoyMbrProcResDto checkCertiCode(LoyMbrProcReqDto param) throws ParseException {
        LoyMbrProcResDto resBal = new LoyMbrProcResDto();
        HashMap<String, Object> ifReq = new HashMap();

        HashMap<String, String> reqObj = new HashMap();

        LoyTransactionNoResDto tranRes = this.getTransNo();
        reqObj.put("Id", "EUG005");
        reqObj.put("MsgType", "0200"); // 전문 유형
        reqObj.put("WorkCase", "312"); // 업무 구분
        reqObj.put("RepCode", "");
        reqObj.put("Seq", "");
        reqObj.put("BirthDay", param.getBirthDay());
        reqObj.put("Sex", param.getSex());
        reqObj.put("ForeignFlg", param.getForeignFlg());
        reqObj.put("ServiceNo", param.getServiceNo());
        reqObj.put("TranSerialNum", param.getTranSerialNum());//
        reqObj.put("Name", param.getName());
        reqObj.put("TelecomCode", param.getTelecomCode());
        reqObj.put("Mobile", param.getMobile());
        reqObj.put("RequestDate", tranRes.getTranDate());
        reqObj.put("MobileCertiSeq", param.getMobileCertiSeq());
        reqObj.put("CertiSeq", param.getCertiSeq());
        reqObj.put("SmsendSeq", param.getSmsendSeq());
        reqObj.put("SmsCertiNo", param.getCertiNo());

        ifReq.put("interfaceId", "NET_1015");

        ifReq.put("reqObj", reqObj);
        try {

            HashMap<String, Object> rtnMap = apiService.executeHttpRequest(url, ifReq);

            if (rtnMap.get("success").toString().equals("true")) {
                List<Object> list = new ArrayList<Object>();

                list = (List<Object>) rtnMap.get("result");
                HashMap<String, Object> resList = (HashMap<String, Object>) list.get(0);
                List<Object> tmplist = (List<Object>) resList.get("res_0");

                HashMap<String, Object> iRtnVal = (HashMap<String, Object>) tmplist.get(0);
                /*
                 * HashMap<String, Object> iRtnVal = (HashMap<String, Object>)rtnMap.get("result");
                 */
                String mobileCertiCode = iRtnVal.get("MobileCertiCode").toString();
                if (iRtnVal.get("ResultFlg").toString().equals("Y") && mobileCertiCode.equals("NME0000")) {
                    resBal.setSuccess(true);
                    resBal.setRtnVal(iRtnVal);
                }
                else {
                    resBal.setSuccess(false);
                    if (mobileCertiCode.equals("NME0011")) {
                        resBal.setMessage(Messages.getMessage("L01936", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0012")) {
                        resBal.setMessage(Messages.getMessage("L01937", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0013")) {
                        resBal.setMessage(Messages.getMessage("L01938", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0015")) {
                        resBal.setMessage(Messages.getMessage("L01939", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0017")) {
                        resBal.setMessage(Messages.getMessage("L01940", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0024")) {
                        resBal.setMessage(Messages.getMessage("L01941", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0031")) {
                        resBal.setMessage(Messages.getMessage("L01942", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0035")) {
                        resBal.setMessage(Messages.getMessage("L01943", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0040")) {
                        resBal.setMessage(Messages.getMessage("L01944", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0070")) {
                        resBal.setMessage(Messages.getMessage("L01945", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0071")) {
                        resBal.setMessage(Messages.getMessage("L01946", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0072")) {
                        resBal.setMessage(Messages.getMessage("L01947", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0073")) {
                        resBal.setMessage(Messages.getMessage("L01948", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0096")) {
                        resBal.setMessage(Messages.getMessage("L01949", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0097")) {
                        resBal.setMessage(Messages.getMessage("L01950", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0098")) {
                        resBal.setMessage(Messages.getMessage("L01951", param.getLang()));
                    }
                    else if (mobileCertiCode.equals("NME0099")) {
                        resBal.setMessage(Messages.getMessage("L01952", param.getLang()));
                    }
                    else {
                        resBal.setMessage(rtnMap.get("message").toString());
                    }
                }
            }
            else {
                resBal.setSuccess(false);
                resBal.setMessage(rtnMap.get("message").toString());
            }
        }
        catch (IOException e) {
            LogUtil.error(e.getMessage(),e);
        }
        return resBal;
    }
    
    public StatusResDto getExcelData(GridPagingResDto<LoyTransListResDto> excelDto, LoyExcelExportReqDto excelData, HttpServletRequest request){
		StatusResDto rtnValue = new StatusResDto();
		ObjectMapper oMapper = new ObjectMapper();
		List<Map<String, String>> tmpArray = new ArrayList();

		for(int i = 0 ; i < excelDto.getRows().size() ; i++){
			Object tmpObj = excelDto.getRows().get(i);
			Map<String, String> tmpmap = oMapper.convertValue(tmpObj, Map.class);
			tmpArray.add(i, tmpmap);
		}

		excelData.setNewData(tmpArray);
		excelData.setFileName(excelData.getFileName());
		excelData.setRequest(request);


		rtnValue = excelExport(excelData);

		return rtnValue;

	}

	 /*
	  * 1. 메소드명: getOfferListPop
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		오퍼 목록 조회 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<LoyClubOfferListResDto> getOfferListPop(LoyClubOfferDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectOfferListPop(param), AnnotationType.CommCode);
	}
	public GridPagingResDto<LoyClubOfferListResDto> getOfferIssListPop(LoyClubOfferDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectOfferIssListPop(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getSelectBoxList
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public GridPagingResDto<CommonSelectBoxListResDto> getSelectBoxList(CommonSelectBoxListReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<CommonSelectBoxListResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectSelectBoxList(bccr));
	}

	 /*
	  * 1. 메소드명: getTierListPop
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 8. 11.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *	등급 목록 조회	
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	public GridPagingResDto<LoyTierListNewPageResDto> getTierListPop(LoyTierNewPageReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		return new GridPagingResHelper<LoyTierListNewPageResDto>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectTierList(bccr));
	}

	 /*
	  * 1. 메소드명: getChnlMulitPopup
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlListResDto> getChnlMulitPopup(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("a");
		
		return new GridPagingResHelper<LoyChnlListResDto>().newGridPagingResDto(
				slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectChnlMultiList(slr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getChnlMulitExcPopup
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param slr
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlListResDto> getChnlMulitExcPopup(LoyCommonReqDto slr) {
		LogUtil.param(this.getClass(), slr);
		slr.setSVCAlias("a");
		
		return new GridPagingResHelper<LoyChnlListResDto>().newGridPagingResDto(
				slr.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectChnlMulitExcPopup(slr), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getEmpList
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 7. 28.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bagem
	 *   @return	
	 */
	public GridPagingResDto<SystemAuthGroupEmployeeModalResDto> getEmpList(SystemAuthGroupEmployeeModalReqDto bagem) {
		LogUtil.param(this.getClass(), bagem);
		
		return new GridPagingResHelper<SystemAuthGroupEmployeeModalResDto>().newGridPagingResDto(
				bagem.init(CommonUtil.getInstance().getDBType()),
				commonViewMapper.selectEmpList(bagem), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getSystemMgtList
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		서비스 관리 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<SystemMgtListResDto> getSystemMgtListPop(SystemMgtListReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<SystemMgtListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				commonViewMapper.selectSystemMgtListPop(param), AnnotationType.PersonalData);
	}

	 /*
	  * 1. 메소드명: getMbrListPop
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 9. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 리스트 팝업(같은 프로그램내에서)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrListPopResDto> getMbrListPop(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyMbrListPopResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectMbrListPop(reqDto), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getCommCodeList
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 12. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeListNew(CommonCodeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		bccr.setSVCAlias("");
		return new GridPagingResHelper<ICNCommonCodeResponseDTO>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				commonViewMapper.getCommCodeListNew(bccr), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getCommCodeItemList
	  * 2. 클래스명: CommonViewService
	  * 3. 작성자명: jh.seo 
	  * 4. 작성일자: 2020. 12. 30.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param bccr
	 *   @return	
	 */
	
	public GridPagingResDto<ICNCommonCodeResponseDTO> getCommCodeItemList(CommonCodeReqDto bccr) {
		LogUtil.param(this.getClass(), bccr);
		bccr.setSVCAlias("");
		return new GridPagingResHelper<ICNCommonCodeResponseDTO>().newGridPagingResDto(
				bccr.init(CommonUtil.getInstance().getDBType()),
				commonViewMapper.getCommCodeItemList(bccr), AnnotationType.ALL);
	}

	public GridPagingResDto<LoyClubOfferListResDto> getOfferListPopVoc(LoyClubOfferDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), commonViewMapper.selectOfferListPopVoc(param), AnnotationType.CommCode);
	}

}
