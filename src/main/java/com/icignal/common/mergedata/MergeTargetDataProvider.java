package com.icignal.common.mergedata;

import com.icignal.common.excel.vo.ExcelCellMergeVo;
import com.icignal.common.mergedata.annotations.MergeData;
import com.icignal.common.mergedata.dto.MergeDataDto;
import com.icignal.core.exception.DataFailException;
import com.icignal.core.util.MapperUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class MergeTargetDataProvider<T> {

    final static private Logger log = LoggerFactory.getLogger(MergeTargetDataProvider.class);

    final private Map<String, MergeDataDto> mergeTargetMap = new HashMap<>();
    final private Map<String, Pair<String, Integer>> keyMap = new HashMap<>();

    final private Class<T> clazz;

    private Integer correctionSize = 0;

    private List<String> keyList;
    private List<T> dataList;

    public MergeTargetDataProvider(Class<T> clazz) {
        this.clazz = clazz;
    }

    public MergeTargetDataProvider(Class<T> clazz, List<T> dataList, List<String> keyList) {
        this.clazz = clazz;
        this.dataList = dataList;
        this.keyList = keyList;
    }

    public MergeTargetDataProvider(Class<T> clazz, List<T> dataList, String... keys) {
        this(clazz, dataList, Arrays.asList(keys));
    }

    public MergeTargetDataProvider(Class<T> clazz, List<T> dataList) {
        this(clazz, dataList, (List<String>) null);

        MergeData mergeData = clazz.getAnnotation(MergeData.class);
        this.keyList = Arrays.asList(mergeData.columns());
    }

    public void setKeyList(List<String> keyList) {
        this.keyList = keyList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public MergeTargetDataProvider<T> convertDataList() {
        int keySize = this.keyList.size();

        int dataSize = this.dataList.size();
        for (int row = 0; row < dataSize; row++) {
            T data = this.dataList.get(row);
            int rowTarget = row + this.correctionSize;

            for (int col = 0; col < keySize; col++) {
                String key = this.keyList.get(col);
                Object value = this.getValue(data, key);

                Pair<String, Integer> keyData;
                if (value == null || "".equals(value)) {
                    keyData = this.findKeyData(rowTarget, col);
                } else {
                    String mergeKey = String.format("%s_%s", rowTarget, value);
                    keyData = Pair.of(mergeKey, col);

                    this.keyMap.put(key, keyData);
                }

                if (keyData != null) {
                    MergeDataDto dto = this.mergeTargetMap.get(keyData.getLeft());
                    if (dto != null) {
                        if (keyData.getRight() != col && dto.getStartRow() == rowTarget) {
                            dto.addEndCol();
                        }

                        if (keyData.getRight() == col && dto.getStartCol() == col) {
                            dto.addEndRow();
                        }
                    } else {
                        this.mergeTargetMap.put(keyData.getLeft(), new MergeDataDto(key, String.valueOf(value), rowTarget, col));
                    }
                }
            }
        }

        this.correctionSize += dataSize;

        return this;
    }

    public List<MergeDataDto> getMergeTargetDataList() {
        log.info("{}", MapperUtils.convertDataToJson(this.mergeTargetMap));

        return this.mergeTargetMap.values()
                .stream()
                .filter(dto -> dto.getEndCol() != 0 || dto.getEndRow() != 0)
                .collect(Collectors.toList());
    }

    public List<ExcelCellMergeVo> convertExcelCellMergeList() {
        return this.convertExcelCellMergeList(0);
    }

    public List<ExcelCellMergeVo> convertExcelCellMergeList(int addRow) {
        List<MergeDataDto> list = this.convertDataList()
                .getMergeTargetDataList();

        return list.stream()
                .map(dto ->
                        ExcelCellMergeVo.builder()
                                .startReference(dto.getStartCol())
                                .endReference((dto.getStartCol() + dto.getEndCol()))
                                .rowNum((dto.getStartRow() + addRow))
                                .mergeRows(dto.getEndRow())
                                .title(dto.getValue())
                                .build()
                )
                .collect(Collectors.toList());
    }

    private Pair<String, Integer> findKeyData(int row, int col) {
        int tempCol = Math.max(col - 1, 0);
        String tempKey = this.keyList.get(tempCol);
        Pair<String, Integer> tempData = this.keyMap.get(tempKey);
        if (tempData != null && this.mergeTargetMap.get(tempData.getLeft()).getStartRow() == row) {
            return tempData;
        }

        for (int i = col; i >= 0; i--) {
            String key = this.keyList.get(i);
            Pair<String, Integer> data = this.keyMap.get(key);

            if (data != null) {
                return data;
            }
        }

        return null;
    }

    private Object getValue(T data, String key) {
        try {
            if (data instanceof Map) {
                return ((Map<?, ?>) data).get(key);
            } else {
                Field f = this.clazz.getDeclaredField(key);
                f.setAccessible(true);
                return f.get(data);
            }
        } catch (Exception e) {
            log.error("항목을 찾을 수 없습니다.", e);
            throw new DataFailException(e, "항목을 찾을 수 없습니다.");
        }
    }

}