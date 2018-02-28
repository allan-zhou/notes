# Benchmark Test

基准测试是指通过设计科学的测试方法、测试工具和测试系统，实现对一类测试对象的某项性能指标进行定量的和可对比的测试。

## 三大原则

- 可测量: 是指测试的输入和输出之间是可达的，也就是测试过程是可以实现的，并且测试的结果可以量化表现；  
- 可重复: 是指按照测试过程实现的结果是相同的或处于可接受的置信区间之内，而不受测试的时间、地点和执行者的影响；  
- 可对比: 是指一类测试对象的测试结果具有线性关系，测试结果的大小直接决定性能的高低。

## 基准测试的具体做法

在系统上运行一系列测试程序并把性能计数器的结果保存起来。这些结构称为“性能指标”。  
性能指标通常都保存或归档，并在系统环境的描述中进行注解。比如说，有经验的数据库专业人员会把基准测试的结果以及当时的系统配置和环境一起存入他们的档案。这可以让他们对系统过去和现在的性能表现进行对照比较，确认系统或环境的所有变化。

基准测试通常都是些**功能测试**，即测试系统的某个功能是否达到了预期的要求。有些性能测试工具可以对系统几乎所有的方面（从最常见的操作到最复杂的操作，从小负载到中等负载到大负载）进行测试。

## 性能测试工具（开源）

- Siege
- ab
- wrk

## Siege

## ab

- Apache HTTP 服务器benchmark工具
- 网站：<http://httpd.apache.org/docs/2.4/programs/ab.html>

### ab demo

```bash
# 其中－n表示请求数，－c表示并发数
ab -n 100 -c 10 https://www.baidu.com
```

输入的关键信息解释

```bash
# 并发请求数
Concurrency Level:      10
# 测试持续的时间
Time taken for tests:   0.322 seconds
# 完成的请求数
Complete requests:      100
# 失败的请求数
Failed requests:        0
# 整个场景中的网络传输量
Total transferred:      87200 bytes
# 整个场景中的HTML内容传输量
HTML transferred:       22700 bytes
# 吞吐率，大家最关心的指标之一，相当于 LR 中的每秒事务数，后面括号中的 mean 表示这是一个平均值
Requests per second:    310.96 [#/sec] (mean)
# 用户平均请求等待时间，大家最关心的指标之二，相当于 LR 中的平均事务响应时间，后面括号中的 mean 表示这是一个平均值
Time per request:       32.158 [ms] (mean)
# 服务器平均请求处理时间，大家最关心的指标之三
Time per request:       3.216 [ms] (mean, across all concurrent requests)
# 平均每秒网络上的流量，可以帮助排除是否存在网络流量过大导致响应时间延长的问题
Transfer rate:          264.80 [Kbytes/sec] received
```

## wrk

- HTTP基准测试工具
- 一款采用异步并发模型的HTTP基准测试工具： 不同于 ab、webbench，它采用异步并发模型，能够发送更大且可控的压力；内置 LuaJIT，能够通过 lua 脚本模拟常见的业务行为，模拟更加真实的场景；相比常见的HTTP基准测试工具，占用更少CPU、更少内存 支持 HTTP、 HTTPS，能够动态修改头、修改Body方法等；支持混合场景
- 网站: <https://github.com/wg/wrk>

### wrk demo

```bash
sudo apt install wrk
```

```bash
wrk -t10 -c100 -d10s http://www.baidu.com
```

```bash
Running 10s test @ http://www.baidu.com
  10 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   185.61ms  237.94ms   1.85s    89.64%
    Req/Sec    75.75     28.42   220.00     72.08%
  7525 requests in 10.01s, 110.89MB read
  Socket errors: connect 0, read 54, write 0, timeout 6
Requests/sec:    751.93
Transfer/sec:     11.08MB
```

- 第1行：运行10s进行测试，对应-d参数
- 第2行：用12个threads模拟100个connections，对应-t和-c参数
> 一般线程数不宜过多. 核数的2到4倍足够了. 多了反而因为线程切换过多造成效率降低. 因为 wrk 不是使用每个连接一个线程的模型, 而是通过异步网络 io 提升并发量. 所以网络通信不会阻塞线程执行. 这也是 wrk 可以用很少的线程模拟大量网路连接的原因. 而现在很多性能工具并没有采用这种方式, 而是采用提高线程数来实现高并发. 所以并发量一旦设的很高, 测试机自身压力就很大. 测试效果反而下降.

- 第4行： **Latency**: 可以理解为响应时间, 有平均值, 标准偏差, 最大值, 正负一个标准差占比
- 第5行： **Req/Sec**: 每个线程每秒钟的完成的请求数, 同样有平均值, 标准偏差, 最大值, 正负一个标准差占比
> 一般我们来说我们主要关注平均值和最大值. 标准差如果太大说明样本本身离散程度比较高. 有可能系统性能波动很大.

- 第6行： 10s内共完成的请求数目和读取数据量
- 第7行： 错误统计，上面统计看到有54个读错误，6个超时
- 第8行： 平均每秒完成751个请求
- 第9行： 平均每秒读取11.08M数据量

## Reference

- [百度百科](https://baike.baidu.com/item/%E5%9F%BA%E5%87%86%E6%B5%8B%E8%AF%95)
- [性能测试工具](http://www.ituring.com.cn/article/265172)
- [wrk使用介绍](https://www.cnblogs.com/rainy-shurun/p/5867946.html)
- [ab使用介绍](https://www.jianshu.com/p/43d04d8baaf7)