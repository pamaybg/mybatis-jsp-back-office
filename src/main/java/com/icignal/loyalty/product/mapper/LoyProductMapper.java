package com.icignal.loyalty.product.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.common.dto.request.LoyCommonReqDto;
import com.icignal.loyalty.prodgrp.dto.response.LoyProdGrpItemListResDto;
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

/*
 * 1. 클래스명	: LoyProductMapper
 * 2. 파일명	: LoyProductMapper.java
 * 3. 패키지명	: com.icignal.loyalty.product.mapper
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		카테고리, 브렌드, 상품 Mapper
 * </PRE>
 */ 
@Mapper
public interface LoyProductMapper {

	List<LoyCategoryListResDto> getCategoryListPop(LoyCommonReqDto reqDto);

	List<LoyProdListResDto> getProdListPop(LoyCommonReqDto reqDto);

	List<LoyGetProdListResDto> getProdList(LoyGetProdListReqDto reqDto);

	LoyGetProdListResDto getProdDtl(LoyGetProdListReqDto reqDto);

	void setProdDtl(LoySetProdListReqDto reqDto);

	void editProdDtl(LoyEditProdListReqDto reqDto);

	LoyGetProdListResDto getProdChk(LoyGetProdListReqDto reqDto);

	List<LoyGetCategoryListResDto> getCategoryList(LoyGetCategoryListReqDto reqDto);

	LoyGetCategoryListResDto getCategoryDtl(LoyGetCategoryListReqDto reqDto);

	void setCategoryDtl(LoySetCategoryListReqDto reqDto);

	void editCategoryDtl(LoyEditCategoryListReqDto reqDto);

	LoyGetCategoryListResDto getCategoryChk(LoyGetCategoryListReqDto reqDto);

	List<LoyGetProdSpecListResDto> getProdSpecList(LoyProdSpecReqDto reqDto);

	void updateProdSpec(LoyProdSpecReqDto reqDto);

	void insertProdSpec(LoyProdSpecReqDto reqDto);

	void deleteProdSpec(LoyProdSpecReqDto reqDto); //쿼리 없음 LOYProdDAO

	void deleteProd(LoyProdSpecReqDto reqDto);

	List<LoyProductSearchHelpResDto> getProdSearchHelp(LoyProductSearchHelpReqDto param);

	List<LoyProductListResDto> getProductList(LoyProductListReqDto param);

	List<LoyProductListResDto> getProdutCodeId(LoyProductInsertReqDto param);

	void insertProductDetail(LoyProductInsertReqDto param);

	void updateProductDetail(LoyProductInsertReqDto param);

	LoyProductListResDto getProductDetail(LoyProductListReqDto param);

	List<LoyProductDtlTabInfoResDto> getProductPriceList(LoyProductDtlTabInfoReqDto param);

	//날짜 유효성 체크
	List<LoyProductDtlTabInfoResDto> checkProdPriceValidationDate(LoyProductDtlTabInfoReqDto param);
	//날짜 유효성 체크
	List<LoyProductDtlTabInfoResDto> checkProdCodeValidationDate(LoyProductDtlTabInfoReqDto param);

	void insertProductPrice(LoyProductDtlTabInfoReqDto param);

	//삭제 유효성 체크
	List<LoyProductDtlTabInfoResDto> checkDelCodeValidation(LoyProductDtlTabInfoReqDto param);
	//삭제 유효성 체크
	List<LoyProductDtlTabInfoResDto> checkDelPriceValidation(LoyProductDtlTabInfoReqDto param);
	
	void deleteProductPrice(LoyProductDtlTabInfoReqDto param);

	List<LoyProductDtlTabInfoResDto> getProductCodeList(LoyProductDtlTabInfoReqDto param);

	void insertProductCodeDetail(LoyProductDtlTabInfoReqDto param);

	void deleteProductCode(LoyProductDtlTabInfoReqDto param);

	void updateProdStatusCd(LoyProductInsertReqDto param);

	List<LoyProductDtlTabInfoResDto> getProductPriceDtl(LoyProductDtlTabInfoReqDto param);

	void updateProductPrice(LoyProductDtlTabInfoReqDto param);

	List<LoyProductDtlTabInfoResDto> getProductCodeDetail(LoyProductDtlTabInfoReqDto param);

	void updateProductCode(LoyProductDtlTabInfoReqDto param);

	List<LoyProductByBrdDto> getProductByBrd(LoyProductByBrdDto param);

	void tempTableInsert(LoySetProdListReqDto batchUpload);

	void deleteTempTable(LoySetProdListReqDto batchUpload);

	void deleteCategory(LoyCommonReqDto param);

	void deleteProduct(LoyCommonReqDto param);

	List<LoyGetCategoryListResDto> getExcelCategoryList(LoyGetCategoryListReqDto param);
	
	List<LoyGetProdPosResDto> getProdPosList(LoyProdSpecReqDto reqDto);
	
	List<LoyGetProdListResDto> getTProdList(LoyGetProdListReqDto reqDto);

	LoyGetProdListResDto getTProdListYnPop(LoyGetProdListReqDto reqDto);
	
	void saveTProdListYnPop(LoyGetProdListReqDto param);
	
	List<LoyGetProdListResDto> getAllowUseProdList(LoyGetProdListReqDto reqDto);
	
	List<LoyGetProdListResDto> getAllowNotUseProdList(LoyGetProdListReqDto reqDto);

}
