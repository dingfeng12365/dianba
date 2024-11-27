package com.dingfeng.dianba;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.dingfeng.dianba.mapper")
public class DianbaApplication {

    public static void main(String[] args) {
        SpringApplication.run(DianbaApplication.class, args);
    }

}
