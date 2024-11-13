package com.icignal.loyalty.product.service;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.loyalty.product.service
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-05 오전 9:49
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-05		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyBrandService
 * 2. 클래스명: LoyBrandService
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-05
 */

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.loyalty.product.dto.request.LoyBrandReqDto;
import com.icignal.loyalty.product.dto.response.LoyBrandListResDto;
import com.icignal.loyalty.product.dto.response.LoyBrandResDto;
import com.icignal.loyalty.product.mapper.LoyBrandMapper;
import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.dto.response.LoySurveyDetailResDto;
import com.icignal.loyalty.survey.dto.response.LoySurveyListResDto;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   브랜드 Service	
 */
@Service("LoyBrandService")
public class LoyBrandService {

    final private LoyBrandMapper loyBrandMapper;
    final private AuthHelper authHelper;

    public LoyBrandService(LoyBrandMapper loyBrandMapper, AuthHelper authHelper) {
        this.loyBrandMapper = loyBrandMapper;
        this.authHelper = authHelper;
    }

    public GridPagingResDto<LoyBrandListResDto> getSurveyList(LoyBrandReqDto reqDto) {

        return new GridPagingResHelper<LoyBrandListResDto>().newGridPagingResDto(
                reqDto.init(CommonUtil.getInstance().getDBType()),
                this.loyBrandMapper.selectBrandList(reqDto),
                AnnotationHelper.AnnotationType.Nothing);
    }

    public LoyBrandResDto getBrandDetail(LoyBrandReqDto reqDto) {

        return new AnnotationHelper<LoyBrandResDto>(AnnotationHelper.AnnotationType.Nothing,
                this.loyBrandMapper.selectBrandDetail(reqDto)).getItem();
    }

    public StatusResDto addBrand(LoyBrandReqDto reqDto) {
        StatusResDto rtnValue = new StatusResDto();
        this.loyBrandMapper.insertBrand(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
    }

    public StatusResDto editBrand(LoyBrandReqDto reqDto) {
        StatusResDto rtnValue = new StatusResDto();
        this.loyBrandMapper.updateBrand(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
    }

    public StatusResDto removeBrand(LoyBrandReqDto reqDto) {
        StatusResDto rtnValue = new StatusResDto();
        this.loyBrandMapper.deleteBrand(reqDto);
        rtnValue.setSuccess(true);
        return rtnValue;
    }
}
