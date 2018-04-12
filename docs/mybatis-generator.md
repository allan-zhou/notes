# mybatis-generator

## 命令行

下载地址：<https://github.com/mybatis/generator/releases>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
  <classPathEntry location="/home/zhoujl/source/java/mybatis-generator/mysql-connector-java-6.0.6.jar" />

  <context id="DB2Tables" targetRuntime="MyBatis3">
    <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
        connectionURL="jdbc:mysql://192.168.1.20:3306/demo"
        userId="root"
        password="123456">
        <!--设置可以获取tables remarks信息-->
        <property name="useInformationSchema" value="true"/>
        <!--设置可以获取remarks信息-->
        <property name="remarks" value="true"/>
    </jdbcConnection>

    <javaTypeResolver >
      <property name="forceBigDecimals" value="false" />
    </javaTypeResolver>

    <!--生成Model类存放位置-->
    <javaModelGenerator targetPackage="me.zhoujl.pojo" targetProject="/home/zhoujl/source/java/mybatis-generator/src">
      <property name="enableSubPackages" value="true" />
      <property name="trimStrings" value="true" />
    </javaModelGenerator>

    <!--生成映射文件存放位置-->
    <sqlMapGenerator targetPackage="me.zhoujl.mapper"  targetProject="/home/zhoujl/source/java/mybatis-generator/src">
      <property name="enableSubPackages" value="true" />
    </sqlMapGenerator>  

    <!--生成Dao类存放位置-->
    <javaClientGenerator type="XMLMAPPER" targetPackage="me.zhoujl.mapper"  targetProject="/home/zhoujl/source/java/mybatis-generator/src">
      <property name="enableSubPackages" value="true" />
    </javaClientGenerator>

    <!--生成对应表及类名-->
    <table schema="demo" tableName="member" domainObjectName="Member"
        enableCountByExample="false"
        enableUpdateByExample="false"
        enableDeleteByExample="false"
        enableSelectByExample="false"
        selectByExampleQueryId="false"
        enableSelectByPrimaryKey="true">
      <generatedKey column="member_id" sqlStatement="MySql" identity="true" />
    </table>

  </context>
</generatorConfiguration>
```

```bash
java -jar mybatis-generator-core-1.3.6.jar -configfile generatorConfig.xml
java -jar mybatis-generator-core-1.3.6.jar -configfile generatorConfig.xml -overwrite
```

## Maven插件

## Reference

- <http://mbg.cndocs.ml/running/runningFromCmdLine.html>
- <https://www.cnblogs.com/yjmyzz/p/4210554.html>
