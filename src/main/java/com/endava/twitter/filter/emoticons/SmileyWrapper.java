package com.endava.twitter.filter.emoticons;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class SmileyWrapper extends HttpServletRequestWrapper {

    public SmileyWrapper(HttpServletRequest servletRequest) {
        super(servletRequest);
    }

    private static Map<String, String> emoticons = new ConcurrentHashMap<>();

    static {
        emoticons.put("smile", "<img width='20px' src='/resources/emoticons/sm1.png'/>");
        emoticons.put("smile2", "\uD83D\uDE01");
        emoticons.put("cry", "\uD83D\uDE22");
    }

    public String[] getParameterValues(String parameter) {
        String[] values = super.getParameterValues(parameter);
        if (values == null) {
            return null;
        }
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = replaceWithEmoticons(values[i]);
        }
        return encodedValues;
    }

    public String getParameter(String parameter) {
        String value = super.getParameter(parameter);
        if (value == null) {
            return null;
        }
        return replaceWithEmoticons(value);
    }

    public String getHeader(String name) {
        String value = super.getHeader(name);
        if (value == null)
            return null;
        return replaceWithEmoticons(value);
    }

    private String replaceWithEmoticons(String value) {
        value = value.replaceAll(":&#41;", emoticons.get("smile2"));
        value = value.replaceAll(":&#39;&#40;", emoticons.get("cry"));
//        value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
//        value = value.replaceAll("'", "&#39;");
//        value = value.replaceAll("eval\\((.*)\\)", "");
//        value = value.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
//        value = value.replaceAll("script", "");
        return value;
    }
}
