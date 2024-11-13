package com.icignal.core.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import static com.fasterxml.jackson.databind.DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES;
import static org.modelmapper.convention.MatchingStrategies.STRICT;

public class MapperUtils {

    final static private Logger log = LoggerFactory.getLogger(MapperUtils.class);

    final static private ObjectMapper objectMapper;
    final static private ModelMapper modelMapper;

    static {
        objectMapper = new ObjectMapper();
        objectMapper.configure(FAIL_ON_UNKNOWN_PROPERTIES, false);

        modelMapper = new ModelMapper();
        modelMapper.getConfiguration().setMatchingStrategy(STRICT);
    }

    /**
     * 원본 데이터를 대상 클래스의 Instance 로 변경
     *
     * @param mapper           Value Object Model Mapper
     * @param sourceData       원본 데이터
     * @param destinationClass 대상 클래스
     * @param <S>              원본 클래스 유형
     * @param <D>              대상 클래스 유형
     * @return 변환된 대상 클래스 Instance
     * @author 이기오
     * @since 2019. 10. 04.
     */
    static public <S, D> D convertData(ModelMapper mapper, S sourceData, Class<D> destinationClass) {
        return mapper.map(sourceData, destinationClass);
    }

    /**
     * 원본 데이터를 대상 클래스의 Instance 로 변경
     *
     * @param sourceData       원본 데이터
     * @param destinationClass 대상 클래스
     * @param <S>              원본 클래스 유형
     * @param <D>              대상 클래스 유형
     * @return 변환된 대상 클래스 Instance
     * @author 이기오
     * @since 2019. 10. 04.
     */
    static public <S, D> D convertData(S sourceData, Class<D> destinationClass) {
        return convertData(modelMapper, sourceData, destinationClass);
    }

    /**
     * 원본 데이터 리스트를 대상 클래스의 리스트로 변경
     *
     * @param mapper           Value Object Model Mapper
     * @param sourceDataList   원본 데이터 리스트
     * @param destinationClass 대상 클래스
     * @param <S>              원본 클래스 유형
     * @param <D>              대상 클래스 유형
     * @return 변환된 대상 클래스 데이터 리스트
     * @author 이기오
     * @since 2019. 10. 28.
     */
    static public <S, D> List<D> convertList(ModelMapper mapper, List<S> sourceDataList, Class<D> destinationClass) {
        if (sourceDataList == null || sourceDataList.isEmpty()) {
            return new ArrayList<>();
        }

        return sourceDataList.stream()
                .map(sourceData -> mapper.map(sourceData, destinationClass))
                .collect(Collectors.toList());
    }

    /**
     * 원본 데이터 리스트를 대상 클래스의 리스트로 변경
     *
     * @param sourceDataList   원본 데이터 리스트
     * @param destinationClass 대상 클래스
     * @param <S>              원본 클래스 유형
     * @param <D>              대상 클래스 유형
     * @return 변환된 대상 클래스 데이터 리스트
     * @author 이기오
     * @since 2019. 10. 28.
     */
    static public <S, D> List<D> convertList(List<S> sourceDataList, Class<D> destinationClass) {
        return convertList(modelMapper, sourceDataList, destinationClass);
    }

    /**
     * 원본 데이터 리스트를 Key 를 기준으로 대상 클래스의 Instance Map 으로 변경
     *
     * @param key              Map 에 사옹될 Key
     * @param sourceList       원본 데이터 리스트
     * @param destinationClass 대상 클래스
     * @param <K>              Key 클래스 유형
     * @param <S>              원본 클래스 유형
     * @param <D>              대상 클래스 유형
     * @return 변환된 대상 클래스 Instance Map
     * @author 이기오
     * @since 2019. 10. 04.
     */
    static public <K, S, D> Map<K, D> convertListToMap(Function<? super S, K> key, List<S> sourceList, Class<D> destinationClass) {
        return sourceList.stream()
                .collect(
                        Collectors.toMap(key, sourceVo -> modelMapper.map(sourceVo, destinationClass))
                );
    }

    /**
     * 원본 데이터를 Json 형태로 변경
     *
     * @param sourceData 원본 데이터
     * @param <S>        원본 클래스 유형
     * @return 변환된 Json 형태의 문자열
     * @author 이기오
     * @since 2019. 10. 04.
     */
    static public <S> String convertDataToJson(S sourceData) {
        try {
            return objectMapper.writeValueAsString(sourceData);
        } catch (JsonProcessingException e) {
            log.error("ooo ooo ooo Json Processing Exception : {}", e.getMessage(), e);
        }

        return "";
    }

    static public <S> Map<String, Object> convertDataToMap(S sourceData) {
        return objectMapper.convertValue(sourceData, new TypeReference<Map<String, Object>>() {
        });
    }

    /**
     * Json 형태의 문자열을 대상 클래스의 Instance 로 변경
     *
     * @param data             Json 형태의 원본 데이터
     * @param destinationClass 대상 클래스
     * @param <D>              대상 클래스 유형
     * @return 변환된 대상 클래스 Instance
     * @throws IOException 변환시 발생한 오류
     * @author 이기오
     * @since 2019. 10. 04.
     */
    static public <D> D convertJsonToData(String data, Class<D> destinationClass) throws IOException {
        return objectMapper.readValue(data, destinationClass);
    }

    /**
     * Json 형태의 문자열을 Map 으로 변환
     *
     * @param data Json 형태의 문자열
     * @return 변환된 Map
     * @throws IOException 변환시 발생한 오류
     * @author 이기오
     * @since 2019. 11. 19.
     */
    static public Map<String, Object> convertJsonToMap(String data) throws IOException {
        return objectMapper.readValue(data, new TypeReference<Map<String, Object>>() {
        });
    }

    /**
     * 원본 데이터를 원본 클래스의 Instance 로 깊은 복사
     *
     * @param sourceData  원본 데이터
     * @param sourceClass 원본 클래스
     * @param <S>         원본 클래스 유형
     * @return 복사된 원본 클래스 Instance
     * @throws IOException 복사 시 발생한 오류
     * @author 이기오
     * @since 2019. 10. 04.
     */
    static public <S> S convertDataDeepCopy(S sourceData, Class<S> sourceClass) throws IOException {
        return objectMapper.readValue(objectMapper.writeValueAsString(sourceData), sourceClass);
    }
}