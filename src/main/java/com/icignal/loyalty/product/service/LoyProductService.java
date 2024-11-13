package com.icignal.loyalty.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.base.service.AddBatchService;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.StringUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.core.component.Messages;
import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.loyprogram.dto.response.LoyCustItemConfListResDto;
import com.icignal.loyalty.membership.dto.response.LoyMbrChangeHistListResDto;
import com.icignal.loyalty.product.dto.request.LoyEditCategoryListReqDto;
import com.icignal.loyalty.product.dto.request.LoyEditProdListReqDto;
import com.icignal.loyalty.product.dto.request.LoyGetCategoryListReqDto;
import com.icignal.loyalty.product.dto.request.LoyGetProdListReqDto;
import com.icignal.loyalty.product.dto.request.LoyProdSpecReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductByBrdDto;
import com.icignal.loyalty.product.dto.request.LoyProductDtlTabInfoReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductInsertReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductListReqDto;
import com.icignal.loyalty.product.dto.request.LoyProductSearchHelpReqDto;
import com.icignal.loyalty.product.dto.request.LoySetCategoryListReqDto;
import com.icignal.loyalty.product.dto.request.LoySetProdListReqDto;
import com.icignal.loyalty.product.dto.response.LoyCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyGetCategoryListResDto;
import com.icignal.loyalty.product.dto.response.LoyGetProdListResDto;
import com.icignal.loyalty.product.dto.response.LoyGetProdPosResDto;
import com.icignal.loyalty.product.dto.response.LoyGetProdSpecListResDto;
import com.icignal.loyalty.product.dto.response.LoyProdListResDto;
import com.icignal.loyalty.product.dto.response.LoyProductDtlTabInfoResDto;
import com.icignal.loyalty.product.dto.response.LoyProductListResDto;
import com.icignal.loyalty.product.dto.response.LoyProductSearchHelpResDto;
import com.icignal.loyalty.product.mapper.LoyProductMapper;
import com.icignal.marketing.plan.dto.response.MktPlanListResDto;



/*
 * 1. 클래스명	: LoyProductService
 * 2. 파일명	: LoyProductService.java
 * 3. 패키지명	: com.icignal.loyalty.product.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 24.
 */
/**
 * <PRE>
 * 1. 설명
 *		카테고리, 브렌드, 상품 Service
 * </PRE>
 */ 
@Service("LoyProductService")
public class LoyProductService {

	@Autowired
	LoyProductMapper loyProductMapper;
	
	@Autowired
	AddBatchService addBatchService;

	 /*
	  * 1. 메소드명: getCategoryListPop
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 카테고리 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : POP_908
	 *   @table : loy_prod_category
	 *   @return	
	 */
	public GridPagingResDto<LoyCategoryListResDto> getCategoryListPop(LoyCommonReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lpc1");
		
		return new GridPagingResHelper<LoyCategoryListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getCategoryListPop(reqDto));
	}

	 /*
	  * 1. 메소드명: getProdListPop
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품  조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : POP_908
	 *   @table : loy_prod
	 *   @return	
	 */
	public GridPagingResDto<LoyProdListResDto> getProdListPop(LoyCommonReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("lp");
		
		return new GridPagingResHelper<LoyProdListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProdListPop(reqDto));
	}

	 /*
	  * 1. 메소드명: getProdList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_022
	 *   @table : loy_prod, loy_brd_category, loy_channel
	 *   @return	
	 */
	public GridPagingResDto<LoyGetProdListResDto> getProdList(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);

//		String prodListData;
//		for(LoyGetProdListResDto prodList: rtnValue.getRows()) {
//			prodListData = prodList.getLpc_mm_cate();
//			if(prodListData != null) {
//				String[] subProdListDataArray = prodListData.split(",");
//				prodList.setMmCate1(subProdListDataArray[0]);
//				prodList.setMmCate2(subProdListDataArray[1]);
//				prodList.setMmCate3(subProdListDataArray[2]);
//			} else {
//				break;
//			}
//		}

		return new GridPagingResHelper<LoyGetProdListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProdList(reqDto));
	}

	 /*
	  * 1. 메소드명: getProdDtl
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_023
	 *   @table : loy_prod, loy_brd_category, loy_channel
	 *   @return	
	 */
	public LoyGetProdListResDto getProdDtl(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lp");
		
		return new AnnotationHelper<LoyGetProdListResDto>(AnnotationType.CommCode , loyProductMapper.getProdDtl(reqDto)).getItem();
	}

     /*
      * 1. 메소드명: setProdDtl
      * 2. 클래스명: LoyProductService
      * 3. 작성자명: 이원준 
      * 4. 작성일자: 2016. 12. 9.
      */
    /**
     * <PRE>
     * 1. 설명
     *		상품 목록 상세 저장
     * 2. 사용법
     *		
     * </PRE>
     *   @param reqDto
     *   @programId : PLOY_023
     *   @table : loy_prod
     *   @return	
     */
    public StatusResDto setProdDtl(LoySetProdListReqDto reqDto) {
        LogUtil.param(LoyProductService.class, reqDto);
        StatusResDto rtnVal = new StatusResDto();
        String rid = CommonUtil.newRid();
        reqDto.setRid(rid);
		loyProductMapper.setProdDtl(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
    } 

	 /*
	  * 1. 메소드명: editProdDtl
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_023
	 *   @table : loy_prod
	 *   @return	
	 */
	public StatusResDto editProdDtl(LoyEditProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
        StatusResDto rtnVal = new StatusResDto();
		loyProductMapper.editProdDtl(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
	} 

	 /*
	  * 1. 메소드명: getProdChk
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품명 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_023
	 *   @table : loy_prod
	 *   @return	
	 */
	public LoyGetProdListResDto getProdChk(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lp");
		
		return loyProductMapper.getProdChk(reqDto);
	}

	 /*
	  * 1. 메소드명: getCategoryList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_024
	 *   @table : loy_prod_category
	 *   @return	
	 */
	public GridPagingResDto<LoyGetCategoryListResDto> getCategoryList(LoyGetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lpc");

		return new GridPagingResHelper<LoyGetCategoryListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.getCategoryList(reqDto));
	}

	 /*
	  * 1. 메소드명: getCategoryDtl
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 상세조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @return	
	 */
	public LoyGetCategoryListResDto getCategoryDtl(LoyGetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lpc");
		
		return loyProductMapper.getCategoryDtl(reqDto);
	}

     /*
      * 1. 메소드명: setCategoryDtl
      * 2. 클래스명: LoyProductService
      * 3. 작성자명: 이원준 
      * 4. 작성일자: 2016. 12. 9.
      */
    /**
     * <PRE>
     * 1. 설명
     *		상품카테고리 상세저장
     * 2. 사용법
     *		
     * </PRE>
     *   @param reqDto
     *   @programId : PLOY_025
     *   @table : loy_prod_category
     *   @return	
     */
    public StatusResDto setCategoryDtl(LoySetCategoryListReqDto reqDto) {
        LogUtil.param(LoyProductService.class, reqDto);
        StatusResDto rtnVal = new StatusResDto();
        String rid = CommonUtil.newRid();
        reqDto.setRid(rid);
        loyProductMapper.setCategoryDtl(reqDto);
        rtnVal.setSuccess(true);
        return rtnVal;
    } 

	 /*
	  * 1. 메소드명: editCategoryDtl
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준 
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리 상세수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @return	
	 */
	public StatusResDto editCategoryDtl(LoyEditCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
        StatusResDto rtnVal = new StatusResDto();
        loyProductMapper.editCategoryDtl(reqDto);
        rtnVal.setSuccess(true);
        return rtnVal;
	} 

	 /*
	  * 1. 메소드명: getCategoryChk
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품카테고리명 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_025
	 *   @table : loy_prod_category
	 *   @return	
	 */
	public LoyGetCategoryListResDto getCategoryChk(LoyGetCategoryListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lpc");
		
		return loyProductMapper.getCategoryChk(reqDto);
	}

	 /*
	  * 1. 메소드명: getProdSpecList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: ps.lee
	  * 4. 작성일자: 2018. 5. 21. 
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 스펙 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyGetProdSpecListResDto> getProdSpecList(LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lps");

		return new GridPagingResHelper<LoyGetProdSpecListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProdSpecList(reqDto), AnnotationType.CommCode) ;
	}

	 /*
	  * 1. 메소드명: saveProdSpec
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: ps.lee
	  * 4. 작성일자: 2018. 5. 21. 
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 스펙 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveProdSpec(LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto(true, "");
		
    	if (!reqDto.getProdSpecRid().equals("")) {
    		loyProductMapper.updateProdSpec(reqDto);
    		rtnValue.setSuccess(true);
    	} else {
    		reqDto.setProdSpecRid(CommonUtil.newRid());
    		loyProductMapper.insertProdSpec(reqDto);
    		rtnValue.setSuccess(true);
    	}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: deleteProdSpec
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: ps.lee 
	  * 4. 작성일자: 2018. 5. 21. 
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 스펙 삭제
	 *		xml 쿼리 없음!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto deleteProdSpec(LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		StatusResDto rtnValue = new StatusResDto(false, "");
		rtnValue.setMessage("삭제할 목록이 없습니다.");
		if (reqDto.getRids().size() > 0) {
			loyProductMapper.deleteProdSpec(reqDto);
			rtnValue.setSuccess(true);
			rtnValue.setMessage("삭제 되었습니다.");
		}

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: deleteProd
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: dw.keum 
	  * 4. 작성일자: 2019. 6. 14.
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
	public StatusResDto deleteProd(LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		
		StatusResDto rtnValue = new StatusResDto();
		
		loyProductMapper.deleteProd(reqDto);
		rtnValue.setSuccess(true);

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: insertProdList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: dw.keum 
	  * 4. 작성일자: 2019. 6. 14.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param batchUpload
	 *   @return	
	 */
	public StatusResDto insertProdList(LoySetProdListReqDto batchUpload) {
		LogUtil.error("파일 사이즈 : " + batchUpload.getArray().size());
		LogUtil.param(LoyProductService.class, batchUpload);
		LogUtil.error("param");
		
		//this.update("LOYProd.deleteTempTable", batchUpload, true);
		loyProductMapper.deleteTempTable(batchUpload);
		
		StatusResDto rtnValue = new StatusResDto();
		
		rtnValue.setSuccess(false);
		StringBuffer sql = new StringBuffer();
		sql.append("insert into loy.TEMP_LOY_PRD")
		.append("(")
		.append("  create_date")
		.append(", brd_type")
		.append(", prd_id")
		.append(", color")
		.append(", base_ymd")
		.append(") values (")
		.append("  sysdate")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(", ?")
		.append(")");

		
		List<Map<Integer,Object>> params = new ArrayList<Map<Integer,Object>>();
		for(LoySetProdListReqDto lplr : batchUpload.getArray()) {
			lplr.setRid(lplr.getSerialNo());
			
				int idx = 1;
				Map<Integer,Object> param = new HashMap<Integer,Object>();
				
				param.put(idx++, StringUtil.convertNull(lplr.getBrndType(),""));
				param.put(idx++, StringUtil.convertNull(lplr.getSerialNo(),""));
				param.put(idx++, StringUtil.convertNull(lplr.getColor(),""));
				param.put(idx++, StringUtil.convertNull(lplr.getStanYearMonth(),""));
				params.add(param);
		}
		try {
		addBatchService.addBatch(sql.toString(), params);

		batchUpload.setRid(CommonUtil.newRid());
		loyProductMapper.tempTableInsert(batchUpload);
		loyProductMapper.deleteTempTable(batchUpload);
		
		rtnValue.setSuccess(true);
		rtnValue.setMessage("저장되었습니다");
		}catch(Exception e) {
			LogUtil.error(e);
		}
		return rtnValue;

		
		
		//return loyProductMapper.insertProdList(batchUpload);
	}

     /*
      * 1. 메소드명: getProdSearchHelp
      * 2. 클래스명: LoyProductService
      * 3. 작성자명: 이성원 
      * 4. 작성일자: 2017. 10. 16.
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
    public GridPagingResDto<LoyProductSearchHelpResDto> getProdSearchHelp(LoyProductSearchHelpReqDto param) {
        LogUtil.param(LoyProductService.class, param);
        
        return new GridPagingResHelper<LoyProductSearchHelpResDto>().newGridPagingResDto(
        		param.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProdSearchHelp(param));
    }

	 /*
	  * 1. 메소드명: getProductList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 리스트 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<LoyProductListResDto> getProductList(LoyProductListReqDto param) {
        LogUtil.param(LoyProductService.class, param);
        
        return new GridPagingResHelper<LoyProductListResDto>().newGridPagingResDto(
        		param.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProductList(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: insertProductDetail
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상세 정보 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto insertProductDetail(LoyProductInsertReqDto param) {
        LogUtil.param(LoyProductService.class, param);
        List<LoyProductListResDto> checkProdId = new ArrayList<LoyProductListResDto>();
        StatusResDto rtnValue = new StatusResDto();
        rtnValue.setSuccess(true);
		param.setRid(CommonUtil.newRid());
		checkProdId = loyProductMapper.getProdutCodeId(param);
		
		if(checkProdId.size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01587", param.getLang()));
			return rtnValue;
		}
		loyProductMapper.insertProductDetail(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	
	}

	 /*
	  * 1. 메소드명: updateProductDetail
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상세 정보 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto updateProductDetail(LoyProductInsertReqDto param) {
		LogUtil.param(LoyProductService.class, param);
        List<LoyProductListResDto> checkProdId = new ArrayList<LoyProductListResDto>();
        StatusResDto rtnValue = new StatusResDto();
		checkProdId = loyProductMapper.getProdutCodeId(param);
		
		if(param.getIdCheckFlg().equals("N") && checkProdId.size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01587", param.getLang()));
			return rtnValue;
			
		}
	
		loyProductMapper.updateProductDetail(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProductDetail
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상세 정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public LoyProductListResDto getProductDetail(LoyProductListReqDto param) {
		  LogUtil.param(LoyProductService.class, param);
	      return new AnnotationHelper<LoyProductListResDto>(AnnotationType.CommCode , loyProductMapper.getProductDetail(param)).getItem();
	}

	 /*
	  * 1. 메소드명: getProductPriceList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<LoyProductDtlTabInfoResDto> getProductPriceList(LoyProductDtlTabInfoReqDto param) {
		  LogUtil.param(LoyProductService.class, param);
	      return new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
	    		  param.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.getProductPriceList(param));
	}

	 /*
	  * 1. 메소드명: insertProductPrice
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 정보 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto insertProductPrice(LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		GridPagingResDto<LoyProductDtlTabInfoResDto> validList = new GridPagingResDto<LoyProductDtlTabInfoResDto>();
		StatusResDto rtnValue = new StatusResDto();
		String rid =null;
		rid= CommonUtil.newRid();
		
		param.setRid(rid);
		param.setTabDiv("P");
		//날짜 유효성 체크
		validList = new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.checkProdPriceValidationDate(param));

		if(validList.getRows().size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01424", param.getLang()));
			return rtnValue;
		}
		loyProductMapper.insertProductPrice(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: deleteProductPrice
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki 
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto deleteProductPrice(LoyProductDtlTabInfoReqDto param) {
	    LogUtil.param(LoyProductService.class, param);
		GridPagingResDto<LoyProductDtlTabInfoResDto> checkDelValidation = new GridPagingResDto<LoyProductDtlTabInfoResDto>();
		param.setTabDiv("P");
		//삭제 유효성 체크
		checkDelValidation = new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyProductMapper.checkDelPriceValidation(param));
	    StatusResDto rtnValue = new StatusResDto();
		if(checkDelValidation.getRows().size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01423", param.getLang()));
			return rtnValue;
		}
		loyProductMapper.deleteProductPrice(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProductCodeList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명:  kimjunki
	  * 4. 작성일자: 22017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<LoyProductDtlTabInfoResDto> getProductCodeList(LoyProductDtlTabInfoReqDto param) {
		  LogUtil.param(LoyProductService.class, param);
	      return new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
	    		  param.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.getProductCodeList(param));
	}

	 /*
	  * 1. 메소드명: insertProductCodeDetail
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 상세정보 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto insertProductCodeDetail(LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		GridPagingResDto<LoyProductDtlTabInfoResDto> validList = new GridPagingResDto<LoyProductDtlTabInfoResDto>();
		String rid =null;
		rid= CommonUtil.newRid();
		param.setTabDiv("C");
		param.setRid(rid);
		//날짜 유효성 체크
		validList = new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.checkProdCodeValidationDate(param));
		
		if(validList.getRows().size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01424", param.getLang()));
			return rtnValue;
		}
		
		loyProductMapper.insertProductCodeDetail(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: deleteProductCode
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto deleteProductCode(LoyProductDtlTabInfoReqDto param) {
	    LogUtil.param(LoyProductService.class, param);
		GridPagingResDto<LoyProductDtlTabInfoResDto> checkDelValidation = new GridPagingResDto<LoyProductDtlTabInfoResDto>();
		param.setTabDiv("C");
		//삭제 유효성 체크
		checkDelValidation = new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyProductMapper.checkDelCodeValidation(param));
	    StatusResDto rtnValue = new StatusResDto();
		if(checkDelValidation.getRows().size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01423", param.getLang()));
			return rtnValue;
		}
		
	 loyProductMapper.deleteProductCode(param);
	 rtnValue.setSuccess(true);
	 return rtnValue;
	}

	 /*
	  * 1. 메소드명: updateProdStatusCd
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 상태 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto updateProdStatusCd(LoyProductInsertReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		loyProductMapper.updateProdStatusCd(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProductPriceDtl
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 상세정보 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<LoyProductDtlTabInfoResDto> getProductPriceDtl(LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		return new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
			param.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProductPriceDtl(param));
	}

	 /*
	  * 1. 메소드명: updateProductPrice
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 가격 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto updateProductPrice(LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		GridPagingResDto<LoyProductDtlTabInfoResDto> validList = new GridPagingResDto<LoyProductDtlTabInfoResDto>();
		param.setTabDiv("P");
		//날짜 유효성 체크
		validList = new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.checkProdPriceValidationDate(param));
		
		if(validList.getRows().size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01424", param.getLang()));
			return rtnValue;
		}
		
		loyProductMapper.updateProductPrice(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProductCodeDetail
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 상세 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public GridPagingResDto<LoyProductDtlTabInfoResDto> getProductCodeDetail(LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		return new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProductCodeDetail(param));
	}

	 /*
	  * 1. 메소드명: updateProductCode
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimjunki
	  * 4. 작성일자: 2017. 12. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 정보 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto updateProductCode(LoyProductDtlTabInfoReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		GridPagingResDto<LoyProductDtlTabInfoResDto> validList = new GridPagingResDto<LoyProductDtlTabInfoResDto>();
		param.setTabDiv("C");
		//날짜 유효성 체크
		validList = new GridPagingResHelper<LoyProductDtlTabInfoResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),  loyProductMapper.checkProdCodeValidationDate(param));
		
		if(validList.getRows().size()>0){
			rtnValue.setSuccess(false);
			rtnValue.setMessage(Messages.getMessage("L01424", param.getLang()));
			return rtnValue;
		}
		
		loyProductMapper.updateProductCode(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getProductByBrd
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: kimTaeUk 
	  * 4. 작성일자: 2018. 07. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 코드 정보 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public List<LoyProductByBrdDto> getProductByBrd(LoyProductByBrdDto param) {
		LogUtil.param(LoyProductService.class, param);
	    return loyProductMapper.getProductByBrd(param);
	}

	 /*
	  * 1. 메소드명: removeCategory
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 카테고리 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto removeCategory(LoyCommonReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyProductMapper.deleteCategory(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeProduct
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 7. 7.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	public StatusResDto removeProduct(LoyCommonReqDto param) {
		LogUtil.param(LoyProductService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyProductMapper.deleteProduct(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	 /*
	  * 1. 메소드명: 
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: LEE GYEONG YOUNG
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_022
	 *   @table : loy_prod, loy_brd_category, loy_channel
	 *   @return	
	 */
	public GridPagingResDto<LoyGetProdPosResDto> getProdPosList(LoyProdSpecReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);
		reqDto.setSVCAlias("lpp");

		return new GridPagingResHelper<LoyGetProdPosResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getProdPosList(reqDto), AnnotationType.CommCode);
	}
	 /*
	  * 1. 메소드명: getProdList
	  * 2. 클래스명: LoyProductService
	  * 3. 작성자명: 이원준
	  * 4. 작성일자: 2016. 12. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		상품 목록 조회
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @programId : PLOY_022
	 *   @table : loy_prod, loy_brd_category, loy_channel
	 *   @return	
	 */
	public GridPagingResDto<LoyGetProdListResDto> getTProdList(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);

//		String prodListData;
//		for(LoyGetProdListResDto prodList: rtnValue.getRows()) {
//			prodListData = prodList.getLpc_mm_cate();
//			if(prodListData != null) {
//				String[] subProdListDataArray = prodListData.split(",");
//				prodList.setMmCate1(subProdListDataArray[0]);
//				prodList.setMmCate2(subProdListDataArray[1]);
//				prodList.setMmCate3(subProdListDataArray[2]);
//			} else {
//				break;
//			}
//		}

		return new GridPagingResHelper<LoyGetProdListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getTProdList(reqDto));
	}
	
	public LoyGetProdListResDto getTProdListYnPop(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);

//		String prodListData;
//		for(LoyGetProdListResDto prodList: rtnValue.getRows()) {
//			prodListData = prodList.getLpc_mm_cate();
//			if(prodListData != null) {
//				String[] subProdListDataArray = prodListData.split(",");
//				prodList.setMmCate1(subProdListDataArray[0]);
//				prodList.setMmCate2(subProdListDataArray[1]);
//				prodList.setMmCate3(subProdListDataArray[2]);
//			} else {
//				break;
//			}
//		}

		return loyProductMapper.getTProdListYnPop(reqDto);
	}
	
    public StatusResDto saveTProdListYnPop(LoyGetProdListReqDto reqDto) {
        LogUtil.param(LoyProductService.class, reqDto);
        StatusResDto rtnVal = new StatusResDto();
        String rid = CommonUtil.newRid();
        reqDto.setRid(rid);
		loyProductMapper.saveTProdListYnPop(reqDto);
		rtnVal.setSuccess(true);
		return rtnVal;
    } 
    
	public GridPagingResDto<LoyGetProdListResDto> getAllowUseProdList(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);

		return new GridPagingResHelper<LoyGetProdListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getAllowUseProdList(reqDto));
	}
	public GridPagingResDto<LoyGetProdListResDto> getAllowNotUseProdList(LoyGetProdListReqDto reqDto) {
		LogUtil.param(LoyProductService.class, reqDto);

		return new GridPagingResHelper<LoyGetProdListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyProductMapper.getAllowNotUseProdList(reqDto));
	}
}
