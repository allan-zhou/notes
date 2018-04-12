# 文件上传

## pom.xml

```xml
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.3.3</version>
</dependency>
<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.6</version>
</dependency>
```

## spring-mvc.xml

```xml
<!-- 配置多媒体文件解析器 -->
<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
    <!-- 设定默认编码 -->
    <property name="defaultEncoding" value="UTF-8"></property>
    <!-- 设定文件上传的最大值2MB， 2*1024*1024 -->
    <property name="maxUploadSize" value="209715200"></property>
    <!--resolveLazily属性启用是为了推迟文件解析，以便在UploadAction 中捕获文件大小异常-->
    <property name="resolveLazily" value="true"/>
</bean>
```

## Reference

- <https://blog.csdn.net/loongshawn/article/details/53423121>