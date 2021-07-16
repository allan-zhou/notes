# java的异常

![java异常](./images/java-throwable.png)


java的异常是class类型，根是throwable.class
分两大类：Error、Exception

Error：是严重的错误，无法捕获。
- OutOfMemoryError: 内存溢出
- StackOverFlowErro：栈溢出

Exception：是运行时错误，可以被捕获。
Exception分两大类，1)RuntimeException及其子类 2)非RuntimeException异常（如：IOException）

java规定：
1. 必须捕获的异常，包括Exception及其子类，但不包括RuntimeException及其子类。成为【Checked Exception】
2. 不需要捕获的异常，包括Error及其子类，RuntimeException及其子类

