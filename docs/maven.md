# Maven 入门

## Maven 是什么

Maven 是一个项目管理和整合工具。Maven 为开发者提供了一套完整的构建生命周期框架。开发团队几乎不用花多少时间就能够自动完成工程的基础构建配置，因为 Maven 使用了一个标准的目录结构和一个默认的构建生命周期。

在有多个开发团队环境的情况下，Maven 能够在很短的时间内使得每项工作都按照标准进行。因为大部分的工程配置操作都非常简单并且可复用，在创建报告、检查、构建和测试自动配置时，Maven 可以让开发者的工作变得更简单。

Maven 能够帮助开发者完成以下工作：

- 构建
- 文档生成
- 报告
- 依赖
- SCMs
- 发布
- 分发
- 邮件列表

总的来说，Maven 简化了工程的构建过程，并对其标准化。它无缝衔接了编译、发布、文档生成、团队合作和其他任务。Maven 提高了重用性，负责了大部分构建相关的任务。

## Maven 环境配置

详见 [maven 环境搭建](./maven-setup.md)

## Maven POM

POM 代表工程对象模型。它是使用 Maven 工作时的基本组建，是一个 xml 文件。它被放在工程根目录下，文件命名为 **pom.xml**  
POM 包含了关于工程和各种配置细节的信息，Maven 使用这些信息构建工程。  
POM 也包含了目标和插件。当执行一个任务或者目标时，Maven 会查找当前目录下的 POM，从其中读取所需要的配置信息，然后执行目标。能够在 POM 中设置的一些配置如下：

- project dependencies
- plugins
- goals
- build profiles
- project version
- developers
- mailing list

在创建 POM 之前，我们首先确定工程组（groupId），及其名称（artifactId）和版本，在仓库中这些属性是工程的唯一标识。

```xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
   http://maven.apache.org/xsd/maven-4.0.0.xsd">
   <modelVersion>4.0.0</modelVersion>

   <groupId>com.companyname.project-group</groupId>
   <artifactId>project</artifactId>
   <version>1.0</version>

</project>
```

- 每个工程应该只有一个 POM 文件。
- 所有的 POM 文件需要 project 元素和三个必须的字段：groupId, artifactId,version。
- 在仓库中的工程标识为 ```groupId:artifactId:version```
- POM.xml 的根元素是 project，它有三个主要的子节点：
  - ```groupId``` : 这是工程组的标识。它在一个组织或者项目中通常是唯一的。例如，一个银行组织 com.company.bank 拥有所有的和银行相关的项目。
  - ```artifactId``` : 这是工程的标识。它通常是工程的名称。例如，消费者银行。groupId 和 artifactId 一起定义了 artifact 在仓库中的位置。
  - ```version``` : 这是工程的版本号。在 artifact 的仓库中，它用来区分不同的版本。

## Maven 构建生命周期

构建生命周期是**一组阶段的序列（sequence of phases）**，每个阶段定义了目标被执行的顺序。这里的阶段是生命周期的一部分。

一个典型的 Maven 构建生命周期是由以下几个阶段的序列组成的：

- prepare-resources : 资源拷贝, 本阶段可以自定义需要拷贝的资源
- compile : 编译, 本阶段完成源代码编译
- package : 打包, 本阶段根据 pom.xml 中描述的打包配置创建 JAR / WAR 包
- install : 安装, 本阶段在本地 / 远程仓库中安装工程包

当 Maven 开始构建工程，会按照所定义的阶段序列的顺序执行每个阶段注册的目标。Maven 有以下三个标准的生命周期：

- clean
- default(or build)
- site

**目标**表示一个特定的、对构建和管理工程有帮助的任务。它可能绑定了 0 个或多个构建阶段。没有绑定任何构建阶段的目标可以在构建生命周期之外被直接调用执行。

执行的顺序依赖于目标和构建阶段被调用的顺序。例如，考虑下面的命令。clean 和 package 参数是构建阶段，而 dependency:copy-dependencies 是一个目标。

```bash
mvn clean dependency:copy-dependencies package
```

这里的 clean 阶段将会被首先执行，然后 dependency:copy-dependencies 目标会被执行，最终 package 阶段被执行。

### Clean 生命周期

当我们执行 mvn post-clean 命令时，Maven 调用 clean 生命周期，它包含以下阶段。

- pre-clean
- clean
- post-clean

Maven 的 clean 目标（clean:clean）绑定到了 clean 生命周期的 clean 阶段。它的 clean:clean 目标通过删除构建目录删除了构建输出。所以当 mvn clean 命令执行时，Maven 删除了构建目录。

### Default (or Build) 生命周期

这是 Maven 的主要生命周期，被用于构建应用。包括23 个阶段。

### Site 生命周期

Maven Site 插件一般用来创建新的报告文档、部署站点等。

阶段：

- pre-site
- site
- post-site
- site-deploy

## Maven 构建配置文件

构建配置文件是一组配置的集合，用来设置或者覆盖 Maven 构建的默认配置。使用构建配置文件，可以为不同的环境定制构建过程，例如 Producation 和 Development 环境。

## Maven 仓库

在 Maven 的术语中，**仓库是一个位置（place）**，例如目录，可以存储所有的工程 jar 文件、library jar 文件、插件或任何其他的工程指定的文件。

Maven 仓库有三种类型：

- 本地（local）
- 中央（central）
- 远程（remote）

### 本地仓库

Maven 本地仓库是机器上的一个文件夹。它在你第一次运行任何 maven 命令的时候创建。

Maven 本地仓库保存你的工程的所有依赖（library jar、plugin jar 等）。

Maven 本地仓库默认被创建在 %USER_HOME% 目录下。要修改默认位置，在 ```%M2_HOME%\conf``` 目录中的 Maven 的 ```settings.xml``` 文件中定义另一个路径。

### 中央仓库

Maven 中央仓库是由 Maven 社区提供的仓库，其中包含了大量常用的库。

中央仓库的关键概念：

- 这个仓库由 Maven 社区管理。
- 不需要配置。
- 需要通过网络才能访问。

### 远程仓库

如果 Maven 在中央仓库中也找不到依赖的库文件，它会停止构建过程并输出错误信息到控制台。为避免这种情况，Maven 提供了远程仓库的概念，它是开发人员自己定制仓库，包含了所需要的代码库或者其他工程中用到的 jar 文件。

## Maven 插件

Maven 实际上是一个依赖插件执行的框架，每个任务实际上是由插件完成。Maven 插件通常被用来：

- 创建 jar 文件
- 创建 war 文件
- 编译代码文件
- 代码单元测试
- 创建工程文档
- 创建工程报告

插件通常提供了一个**目标的集合**，并且可以使用下面的语法执行：

```maven
mvn [plugin-name]:[goal-name]
```

常用插件:

- clean : 构建之后清理目标文件。删除目标目录。
- compiler : 编译 Java 源文件。
- surefile : 运行 JUnit 单元测试。创建测试报告。
- jar : 从当前工程中构建 JAR 文件。
- war : 从当前工程中构建 WAR 文件。
- javadoc : 为工程生成 Javadoc。
- antrun : 从构建过程的任意一个阶段中运行一个 ant 任务的集合。

## Maven 创建工程

Maven 使用原型（archetype）插件创建工程。要创建一个简单的 Java 应用，我们将使用 maven-archetype-quickstart 插件。

## Maven 外部依赖

Maven的依赖管理使用的是 **Maven仓库** 的概念。但是如果在远程仓库和中央仓库中，依赖不能被满足，如何解决呢? Maven 使用外部依赖的概念来解决这个问题。

## Maven 工程模版

Maven 使用原型（Archetype）概念为用户提供了大量不同类型的工程模版（614 个）。Maven 使用下面的命令帮助用户快速创建 java 项目。

```bash
mvn archetype:generate
```

## Maven 快照

快照是一个特殊的版本，它表示当前开发的一个副本。与常规版本不同，Maven 为每一次构建从远程仓库中检出一份新的快照版本。  
现在数据服务团队会将每次更新的代码的快照（例如 data-service:1.0-SNAPSHOT）发布到仓库中，来替换旧的快照 jar 文件。

- 快照 vs 版本

对于版本，Maven 一旦下载了指定的版本（例如 data-service:1.0），它将不会尝试从仓库里再次下载一个新的 1.0 版本。想要下载新的代码，数据服务版本需要被升级到 1.1。
对于快照，每次用户接口团队构建他们的项目时，Maven 将自动获取最新的快照（data-service:1.0-SNAPSHOT）。

## Maven 构建自动化

构建自动化定义为一种场景：一旦该工程成功构建完成，其相关的依赖工程即开始构建，目的是为了保证其依赖项目的稳定。

## Maven 依赖管理

Maven 核心特点之一是依赖管理。一旦我们开始处理多模块工程（包含数百个子模块或者子工程）的时候，模块间的依赖关系就变得非常复杂，管理也变得很困难。

- 传递依赖发现

这种情形经常可见，当一个库 A 依赖于其他库 B. 另一工程 C 想要使用库 A, 那么该工程同样也需要使用到库 B。  
Maven 可以避免去搜索所有需要的库资源的这种需求。通过读取工程文件（pom.xml）中的依赖项，Maven 可以找出工程之间的依赖关系。  
我们只需要在每个工程的 pom 文件里去**定义直接的依赖关系**。Maven 则会自动的来接管后续的工作。

## Reference

- <https://www.w3cschool.cn/maven/>
- <http://www.cnblogs.com/xing901022/p/4170248.html>
