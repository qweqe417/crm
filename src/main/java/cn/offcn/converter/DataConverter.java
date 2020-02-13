package cn.offcn.converter;

import org.springframework.core.convert.converter.Converter;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DataConverter implements Converter<String, Date> {

    public Date convert(String source) {

        try{
            SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return  sdf.parse(source);
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public   void  tesy(){

    }

}
