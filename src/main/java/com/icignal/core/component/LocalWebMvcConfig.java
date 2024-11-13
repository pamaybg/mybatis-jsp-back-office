package com.icignal.core.component;/**
 * 1. FileName	: LocalWebMvcConfig.java
 * 2. Package	: systemmanagement
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2021-12-15 오전 8:58
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021-12-15		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LocalWebMvcConfig
 * 2. 클래스명: LocalWebMvcConfig
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2021-12-15
 */

/**
 * PRE
 * 1. 설명
 *      cross domain mapping
 *      @Profile : proerty 연결 설정
 * PRE
 *
 */

import com.icignal.common.util.BeansUtil;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@Profile(value = {"local","dev"})
public class LocalWebMvcConfig  implements WebMvcConfigurer {

    final private String origin = BeansUtil.getApplicationProperty("cross.domain");

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                //.allowCredentials(true)
                //.allowedMethods("*")
                .allowedOrigins(origin); // 노드 서버 주소 지정
    }

}
