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

  <context id="MySQLTables" targetRuntime="MyBatis3" defaultModelType="flat">
    <commentGenerator  type="org.mybatis.generator.internal.CustomeCommentGenerator">
    <property name="javaFileEncoding" value="UTF-8" />  
        <!-- 是否去除自动生成的注释 true：是 ： false:否 -->  
        <property name="suppressAllComments" value="false" />  
        <property name="suppressDate" value="true" />  
    </commentGenerator>

    <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
        connectionURL="jdbc:mysql://192.168.1.20:3306/bc?useSSL=false&amp;tinyInt1isBit=false"
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
    <javaModelGenerator targetPackage="com.yiqishanyuan.blockchain.pojo" targetProject="/home/zhoujl/source/java/arxan/gitlab/sychainapi/src/main/java/">
      <property name="enableSubPackages" value="true" />
      <property name="trimStrings" value="true" />
    </javaModelGenerator>

    <!--生成映射文件存放位置-->
    <sqlMapGenerator targetPackage="com.yiqishanyuan.blockchain.mapper"  targetProject="/home/zhoujl/source/java/arxan/gitlab/sychainapi/src/main/java/">
      <property name="enableSubPackages" value="true" />
    </sqlMapGenerator>  

    <!--生成Dao类存放位置-->
    <javaClientGenerator type="XMLMAPPER" targetPackage="com.yiqishanyuan.blockchain.mapper"  targetProject="/home/zhoujl/source/java/arxan/gitlab/sychainapi/src/main/java/">
      <property name="enableSubPackages" value="true" />
    </javaClientGenerator>

    <!--生成对应表及类名-->
    <table schema="demo" tableName="oc_order_online" domainObjectName="OcOrderOnline" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="oc_order_settlement" domainObjectName="OcOrderSettlement" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="sy_project_money_order" domainObjectName="SyProjectMoneyOrder" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="usr_identities" domainObjectName="UsrIdentities" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="usr_members" domainObjectName="UsrMembers" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="usr_point_log" domainObjectName="UsrPointLog" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="usr_points" domainObjectName="UsrPoints" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
    <table schema="demo" tableName="usr_social_account" domainObjectName="UsrSocialAccount" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
  </context>
</generatorConfiguration>
```

```bash
java -jar mybatis-generator-core-1.3.6.jar -configfile generatorConfig.xml
java -jar mybatis-generator-core-1.3.6.jar -configfile generatorConfig.xml -overwrite
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE generatorConfiguration
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">

<generatorConfiguration>
  <classPathEntry location="/home/zhoujl/source/java/mybatis-generator/mysql-connector-java-8.0.11.jar" />

  <context id="MySQLTables" targetRuntime="MyBatis3" defaultModelType="flat">
    <commentGenerator>
        <property name="suppressAllComments" value="false" />  
        <property name="suppressDate" value="false" />  
    </commentGenerator>

    <jdbcConnection driverClass="com.mysql.cj.jdbc.Driver"
        connectionURL="jdbc:mysql://192.168.1.20:3306/demo?useSSL=false&amp;tinyInt1isBit=false"
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
    <javaModelGenerator targetPackage="com.yiqishanyuan.blockchain.pojo" targetProject="/home/zhoujl/source/java/mybatis-generator/src">
      <property name="enableSubPackages" value="true" />
      <property name="trimStrings" value="true" />
    </javaModelGenerator>

    <!--生成映射文件存放位置-->
    <sqlMapGenerator targetPackage="com.yiqishanyuan.blockchain.mapper"  targetProject="/home/zhoujl/source/java/mybatis-generator/src">
      <property name="enableSubPackages" value="true" />
    </sqlMapGenerator>  

    <!--生成Dao类存放位置-->
    <javaClientGenerator type="XMLMAPPER" targetPackage="com.yiqishanyuan.blockchain.mapper"  targetProject="/home/zhoujl/source/java/mybatis-generator/src">
      <property name="enableSubPackages" value="true" />
    </javaClientGenerator>

    <!--生成对应表及类名-->
    <table schema="demo" tableName="member" domainObjectName="Member" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false" enableSelectByPrimaryKey="true">
    </table>
  </context>
</generatorConfiguration>
```

## Maven插件

## Reference

- <http://mbg.cndocs.ml/running/runningFromCmdLine.html>
- <https://www.cnblogs.com/yjmyzz/p/4210554.html>
- <https://blog.csdn.net/isea533/article/details/42102297>