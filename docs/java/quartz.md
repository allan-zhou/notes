# Quartz 任务调度

Quartz scheduler是一款优秀的Java调度器.

几个概念：

- Scheduler Task – 纯Java类，就是开发人员需要调度的任务。
- Scheduler Job – 通过JobDetail获得执行任务的详细信息，定义执行方式。类似于执行模板，核心方法是execute()。
- Scheduler JobDetail – JobDetail负责存储要调度job的详细信息，task相关数据，包括任务名，任务相关数据等。
- Trigger – 触发器定义任务触发时机。
- Scheduler – 将任务和触发器连接在一起，调用任务执行。


## Reference

- <https://blog.csdn.net/zhangzheng_427/article/details/7221380>
