package com.gdit.crud.entity;

import java.util.HashMap;
import java.util.Map;

public class MSG {
//    状态码 100成功 200 失败
    private int code;
//    提示信息
    private String msg;

//    用户返回给浏览器的数据
   Map<String,Object> extend = new HashMap<String,Object>();

    public MSG() {
    }

    public static MSG success(){
        MSG result = new MSG();
        result.setCode(100);
        result.setMsg("处理成功");
        return result;

    }
    public static MSG fail(){
        MSG result = new MSG();
        result.setCode(200);
        result.setMsg("处理失败");
        return result;

    }

    public MSG add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
