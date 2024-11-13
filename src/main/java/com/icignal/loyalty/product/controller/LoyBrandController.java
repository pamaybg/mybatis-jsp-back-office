package com.icignal.loyalty.product.controller;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.loyalty.product.controller
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-05 오전 9:48
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-05		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyBrandController
 * 2. 클래스명: LoyBrandController
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-05
 */

import com.icignal.auth.helper.AuthHelper;
import com.icignal.common.base.controller.BaseController;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.loyalty.product.dto.request.LoyBrandReqDto;
import com.icignal.loyalty.product.dto.response.LoyBrandListResDto;
import com.icignal.loyalty.product.dto.response.LoyBrandResDto;
import com.icignal.loyalty.product.service.LoyBrandService;
import com.icignal.loyalty.survey.dto.request.LoySurveyListReqDto;
import com.icignal.loyalty.survey.dto.response.LoySurveyListResDto;
import org.slf4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.LoggerFactory;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   브랜드	
 */
@Controller
@RequestMapping("/loyalty/membership/brand")
public class LoyBrandController extends BaseController {

    final static private Logger log = LoggerFactory.getLogger(LoyBrandController.class);

    final private LoyBrandService loyBrandService;
    final private AuthHelper authHelper;

    public LoyBrandController(LoyBrandService loyBrandService, AuthHelper authHelper) {
        this.loyBrandService = loyBrandService;
        this.authHelper = authHelper;
    }

    @PostMapping(value = "/getBrandList.do")
    @ResponseBody public GridPagingResDto<LoyBrandListResDto> getBrandList(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyBrandReqDto reqDto) {
        log.debug("{getBrandList}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loyBrandService.getSurveyList(reqDto);
    }

    @PostMapping(value = "/getBrandDetail.do")
    @ResponseBody public LoyBrandResDto getBrandDetail(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyBrandReqDto reqDto){
        log.debug("{getBrandDetail}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loyBrandService.getBrandDetail(reqDto);
    }

    @PostMapping(value = "/addBrand.do")
    @ResponseBody public StatusResDto addBrand(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyBrandReqDto reqDto){
        log.debug("{addBrand}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loyBrandService.addBrand(reqDto);
    }

    @PostMapping(value = "/editBrand.do")
    @ResponseBody public StatusResDto editBrand(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyBrandReqDto reqDto){
        log.debug("{editBrand}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loyBrandService.editBrand(reqDto);
    }

    @PostMapping(value = "/removeBrand.do")
    @ResponseBody public StatusResDto removeBrand(HttpServletRequest request, HttpServletResponse response, @RequestBody LoyBrandReqDto reqDto){
        log.debug("{editBrand}", reqDto);
        reqDto.setLoginInfo(this.checkLoginSession(request, response));

        return this.loyBrandService.removeBrand(reqDto);
    }

}
