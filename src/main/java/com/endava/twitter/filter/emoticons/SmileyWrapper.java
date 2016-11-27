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
        emoticons.put("smile", "\uD83D\uDE01");
        emoticons.put("cry", "\uD83D\uDE22");
        emoticons.put("laugh", "\uD83D\uDE06");
        emoticons.put("sad", "\uD83D\uDE1E");
        emoticons.put("tongue", "\uD83D\uDE1D");
        emoticons.put("wink", "\uD83D\uDE09");
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
        value = value.replaceAll(":&#41;", emoticons.get("smile"));
        value = value.replaceAll(":&#39;&#40;", emoticons.get("cry"));
        value = value.replaceAll(":D", emoticons.get("laugh"));
        value = value.replaceAll(":&#40;", emoticons.get("sad"));
        value = value.replaceAll(":P", emoticons.get("tongue"));
        value = value.replaceAll(";&#41;", emoticons.get("wink"));

        return value;
    }
}
