package com.icignal.common.excel.reader;

import com.icignal.common.excel.annotations.ExcelField;
import com.icignal.common.util.BeansUtil;
import com.icignal.core.exception.DataFailException;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.poi.xssf.eventusermodel.XSSFSheetXMLHandler;
import org.apache.poi.xssf.usermodel.XSSFComment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.ReflectionUtils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import java.util.stream.Collectors;

public class ExcelSheetContentsHandler<T> implements XSSFSheetXMLHandler.SheetContentsHandler {

    final static private Logger logger = LoggerFactory.getLogger(ExcelSheetContentsHandler.class);
    final static private String EXCLUDE_ENGLISH_PATTERN = "[^a-zA-Z]";

    final private Integer excelChunkSize;

    final private Integer startLineNum;
    final private Class<T> clazz;
    final private Consumer<List<T>> consumer;
    final private Map<String, ExcelFieldVo> fieldMap;
    final private List<T> dataList = new ArrayList<>();

    private int processRowCount = 0;
    private int omissionRowCount = 0;
    private T instance;
    private boolean addRow = false;
    private boolean addData = true;

    public ExcelSheetContentsHandler(Integer startLineNum, Class<T> clazz, Consumer<List<T>> consumer) {
        this.excelChunkSize = BeansUtil.getApplicationProperty("excel.chunk-size", Integer.class);

        this.startLineNum = startLineNum;
        this.clazz = clazz;
        this.consumer = consumer;

        Field[] fields = this.clazz.getDeclaredFields();
        this.fieldMap = Arrays.stream(fields)
                .filter(f -> f.isAnnotationPresent(ExcelField.class))
                .collect(
                        Collectors.toMap(
                                f -> f.getAnnotation(ExcelField.class).cellReference().toUpperCase(),
                                f -> new ExcelFieldVo(f, f.getAnnotation(ExcelField.class)),
                                (prev, next) -> prev
                        )
                );
    }

    @Override
    public void startRow(int i) {
        // 0 부터 시작하므로 + 1 을 하여 비교.
        if ((i + 1) >= this.startLineNum) {
            this.processRowCount++;
            this.addData = true;
            this.addRow = true;

            try {
                this.instance = this.clazz.getConstructor().newInstance();
            } catch (InstantiationException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
                throw new DataFailException(e, "대상 [" + this.clazz.getName() + "] 클래스에 기본 생성자가 없습니다.");
            }

            Field sequenceField = ReflectionUtils.findField(this.clazz, "sequence");
            if (sequenceField != null) {
                try {
                    sequenceField.setAccessible(true);
                    sequenceField.set(this.instance, (long) this.processRowCount);
                } catch (IllegalAccessException e) {
                    throw new DataFailException(e, "처리 중 오류가 발생하였습니다.");
                }
            }
        }
    }

    @Override
    public void endRow(int i) {
        if (this.addRow && this.addData) {
            this.dataList.add(this.instance);
        }

        if (this.dataList.size() == this.excelChunkSize) {
            this.flushData();
            this.dataList.clear();
        }
    }

    @Override
    public void cell(String address, String data, XSSFComment comment) {
        if (this.addRow && this.addData) {
            try {
                String colName = address.replaceAll(EXCLUDE_ENGLISH_PATTERN, "");

                ExcelFieldVo fieldVo = this.fieldMap.get(colName);
                if (fieldVo != null) {
                    if (fieldVo.getRequired() && (data == null || data.isEmpty())) {
                        this.addData = false;
                        this.omissionRowCount++;
                        return;
                    }

                    Field field = fieldVo.getField();
                    field.setAccessible(true);

                    Class<?> cellType = fieldVo.getCellType();
                    if (Number.class.isAssignableFrom(cellType)) {
                        BigDecimal decimal = new BigDecimal(data);

                        if (cellType == BigDecimal.class) {
                            field.set(this.instance, decimal);
                        }

                        if (cellType == Integer.class) {
                            field.set(this.instance, decimal.intValue());
                        }

                        if (cellType == Long.class) {
                            field.set(this.instance, decimal.longValue());
                        }

                        if (cellType == Float.class) {
                            field.set(this.instance, decimal.floatValue());
                        }

                        if (cellType == Double.class) {
                            field.set(this.instance, decimal.doubleValue());
                        }
                    }

                    if (cellType == String.class) {
                        field.set(this.instance, data);
                    }
                }
            } catch (Exception e) {
                throw new DataFailException(e, "유형에 맞지 않는 엑셀 데이터가 존재합니다.\n데이터를 확인해주세요.");
            }
        }
    }

    @Override
    public void endSheet() {
        if (this.dataList.size() != 0) {
            this.flushData();
            this.dataList.clear();
        }
    }

    public void flushData() {
        this.consumer.accept(this.dataList);
    }

    public Pair<Integer, Integer> getRowCounts() {
        return Pair.of(this.processRowCount, this.omissionRowCount);
    }

    static private class ExcelFieldVo {
        private String cellReference;
        private Class<?> cellType;
        private Boolean isRequired;
        private Field field;

        public ExcelFieldVo(Field field, ExcelField annotation) {
            this.field = field;
            this.cellReference = annotation.cellReference();
            this.cellType = annotation.cellType();
            this.isRequired = annotation.isRequired();
        }

        public String getCellReference() {
            return cellReference;
        }

        public void setCellReference(String cellReference) {
            this.cellReference = cellReference;
        }

        public Class<?> getCellType() {
            return cellType;
        }

        public void setCellType(Class<?> cellType) {
            this.cellType = cellType;
        }

        public Boolean getRequired() {
            return isRequired;
        }

        public void setRequired(Boolean required) {
            isRequired = required;
        }

        public Field getField() {
            return field;
        }

        public void setField(Field field) {
            this.field = field;
        }
    }
}